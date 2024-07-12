package org.zang.aisdk.client.session.defaults;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.dromara.hutool.http.meta.ContentType;
import org.dromara.hutool.json.JSONUtil;

import org.dromara.streamquery.stream.core.optional.Opp;
import org.jetbrains.annotations.NotNull;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.client.LLMClient;
import org.zang.aisdk.client.session.Configuration;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.domain.chat.ChatChoice;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.aisdk.dto.req.MessagesDTO;
import org.zang.aisdk.records.Role;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import okhttp3.MediaType;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.sse.EventSource;
import okhttp3.sse.EventSourceListener;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/10 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public class DefaultOpenAiSession implements OpenAiSession {

    private static final ExecutorService VIRTUAL_THREAD_EXECUTOR = Executors.newSingleThreadExecutor();

    /**
     * 配置信息
     */
    private final Configuration configuration;

    /**
     * OpenAI 接口
     */
    private final LLMClient llmClient;
    /**
     * 工厂事件
     */
    private final EventSource.Factory factory;

    public DefaultOpenAiSession(Configuration configuration) {
        this.configuration = configuration;
        this.llmClient = configuration.getOpenAiApi();
        this.factory = configuration.createRequestFactory();
    }

    @Override
    public ChatCompletionResponseDTO completions(ChatCompletionRequestDTO chatCompletionRequestDTO) {
        return this.llmClient.completions(chatCompletionRequestDTO).blockingGet();
    }

    @Override
    public EventSource chatCompletions(String apiHostByUser, String apiKeyByUser, ChatCompletionRequestDTO chatCompletionRequest, EventSourceListener eventSourceListener) throws JsonProcessingException {
        // 核心参数校验；不对用户的传参做更改，只返回错误信息。
        if (!chatCompletionRequest.isStream()) {
            throw new RuntimeException("illegal parameter stream is false!");
        }

        // 动态设置 Host、Key，便于用户传递自己的信息
        String apiHost = Opp.ofStr(apiHostByUser).isEqual(Role.NULL) ? configuration.getApiHost() : apiHostByUser;
        String apiKey = Opp.ofStr(apiKeyByUser).isEqual(Role.NULL) ? configuration.getApiKey() : apiKeyByUser;

        // 构建请求信息
        Request request = new Request.Builder()
                // url: https://api.openai.com/v1/chat/completions - 通过 IOpenAiApi 配置的 POST 接口，用这样的方式从统一的地方获取配置信息
                .url(apiHost.concat(LLMClient.V1_COMPLETIONS))
                .addHeader("apikey", apiKey)
                // 封装请求参数信息，如果使用了 Fastjson 也可以替换 ObjectMapper 转换对象
                .post(RequestBody.create(MediaType.parse(ContentType.JSON.getValue()), new ObjectMapper().writeValueAsString(chatCompletionRequest)))
                .build();

        // 返回结果信息；EventSource 对象可以取消应答
        return factory.newEventSource(request, eventSourceListener);
    }

    @Override
    public EventSource chatCompletions(ChatCompletionRequestDTO chatCompletionRequestDTO, EventSourceListener eventSourceListener) throws JsonProcessingException {
        return chatCompletions(Role.NULL, Role.NULL, chatCompletionRequestDTO, eventSourceListener);
    }

    @Override
    public SseEmitter chatCompletions(ChatCompletionRequestDTO chatCompletionRequestDTO)  {

        final SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE);

        // 使用虚拟线程执行异步任务
        CompletableFuture<String> future = new CompletableFuture<>();

        // 开始异步任务
        VIRTUAL_THREAD_EXECUTOR.submit(() -> {

            try {
                chatCompletions(chatCompletionRequestDTO, new EventSourceListener() {
                    @Override
                    public void onEvent(@NotNull EventSource eventSource, String id, String type, @NotNull String data) {
                        if ("[DONE]".equalsIgnoreCase(data)) {

                            onClosed(eventSource);
                            // TODO 后续处理逻辑
                        }

                        ChatCompletionResponseDTO chatCompletionResponse = JSONUtil.toBean(data, ChatCompletionResponseDTO.class);
                        List<ChatChoice> choices = chatCompletionResponse.getChoices();
                        for (ChatChoice chatChoice : choices) {
                            MessagesDTO delta = chatChoice.getDelta();
                            if (Role.ASSISTANT.equals(delta.getRole())) {
                                continue;
                            } 

                            // 应答完成
                            String finishReason = chatChoice.getFinishReason();
                            if ("stop".equalsIgnoreCase(finishReason)) {
                                onClosed(eventSource);
                                return;
                            }

                            // 发送信息
                            try {
                                sseEmitter.send(data);
                            } catch (Exception e) {
                                future.completeExceptionally(new RuntimeException("Request closed before completion"));
                            }
                        }
                    }

                    @Override
                    public void onClosed(@NotNull EventSource eventSource) {
                        // 结束逻辑处理
                    }

                    @Override
                    public void onFailure(@NotNull EventSource eventSource, Throwable t, Response response) {
                        future.completeExceptionally(new RuntimeException("Request closed before completion"));
                    }
                });
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        });

        return sseEmitter;
    }
}
