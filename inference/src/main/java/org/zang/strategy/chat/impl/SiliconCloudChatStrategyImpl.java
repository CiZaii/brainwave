package org.zang.strategy.chat.impl;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.dromara.hutool.json.JSONUtil;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.domain.chat.ChatChoice;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.req.ChatCompletionResponseDTO;
import org.zang.aisdk.dto.req.MessagesDTO;
import org.zang.aisdk.enums.config.ModelEnum;

import com.fasterxml.jackson.core.JsonProcessingException;

import cn.hutool.core.bean.BeanUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Response;
import okhttp3.sse.EventSource;
import okhttp3.sse.EventSourceListener;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service("siliconCloudChatStrategyImpl")
@Slf4j
@RequiredArgsConstructor
public class SiliconCloudChatStrategyImpl extends AbstractChatStrategyImpl{

    private final OpenAiSession openAiSession;

    private static final ExecutorService VIRTUAL_THREAD_EXECUTOR = Executors.newSingleThreadExecutor();
    public SseEmitter chatCompletions(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO) throws JsonProcessingException {

        final SseEmitter sseEmitter = new SseEmitter();

        CompletableFuture<String> future = new CompletableFuture<>();

        VIRTUAL_THREAD_EXECUTOR.execute(() -> {
            try {
                openAiSession.chatCompletions(chatCompletionRequestDTO, new EventSourceListener() {
                    @Override
                    public void onEvent(EventSource eventSource, String id, String type, String data) {
                        if ("[DONE]".equalsIgnoreCase(data)) {
                            onClosed(eventSource);
                            completeEmitter(sseEmitter);
                            return;
                        }

                        try {
                            if (data.startsWith("data: ")) {
                                data = data.substring(6);
                            }

                            ChatCompletionResponseDTO chatCompletionResponse = JSONUtil.toBean(data, ChatCompletionResponseDTO.class);
                            List<ChatChoice> choices = chatCompletionResponse.getChoices();
                            for (ChatChoice chatChoice : choices) {
                                MessagesDTO delta = chatChoice.getDelta();
                                if (delta.getRole() != null && "assistant".equalsIgnoreCase(delta.getRole())) {
                                    continue;
                                }

                                String finishReason = chatChoice.getFinishReason();
                                if ("stop".equalsIgnoreCase(finishReason)) {
                                    onClosed(eventSource);
                                    completeEmitter(sseEmitter);
                                    return;
                                }

                                sendToEmitter(sseEmitter, data);
                            }
                        } catch (Exception e) {
                            future.completeExceptionally(new RuntimeException("Error processing data", e));
                            completeEmitterWithError(sseEmitter, e);
                        }
                    }

                    @Override
                    public void onClosed(EventSource eventSource) {
                        future.complete("Stream closed");
                        completeEmitter(sseEmitter);
                    }

                    @Override
                    public void onFailure(@NotNull EventSource eventSource, Throwable t, Response response) {
                        future.completeExceptionally(new RuntimeException("Request closed before completion", t));
                        completeEmitterWithError(sseEmitter, t);
                    }
                });
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        });

        return sseEmitter;
    }

    // Ensure thread-safe completion of SseEmitter
    private synchronized void completeEmitter(SseEmitter sseEmitter) {
        try {
            sseEmitter.complete();
        } catch (IllegalStateException e) {
            // Emitter already completed, ignore
        }
    }

    private synchronized void completeEmitterWithError(SseEmitter sseEmitter, Throwable t) {
        try {
            sseEmitter.completeWithError(t);
        } catch (IllegalStateException e) {
            // Emitter already completed, ignore
        }
    }

    private synchronized void sendToEmitter(SseEmitter sseEmitter, String data) {
        try {
            sseEmitter.send(data);
        } catch (IllegalStateException e) {
            // Emitter already completed, ignore
        } catch (Exception e) {
            completeEmitterWithError(sseEmitter, e);
        }
    }
}
