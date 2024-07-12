package org.zang.aisdk.client.session;


import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;

import com.fasterxml.jackson.core.JsonProcessingException;

import okhttp3.sse.EventSource;
import okhttp3.sse.EventSourceListener;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/10 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
public interface OpenAiSession {


    /**
     * 问答模型 GPT-3.5/4.0
     *
     * @param chatCompletionRequestDTO 请求信息
     * @return 应答结果
     */
    ChatCompletionResponseDTO completions(ChatCompletionRequestDTO chatCompletionRequestDTO);

    /**
     * 问答模型 GPT-3.5/4.0 & 流式反馈
     *
     * @param apiHostByUser         自定义host
     * @param apiKeyByUser          自定义Key
     * @param chatCompletionRequestDTO 请求信息
     * @param eventSourceListener   实现监听；通过监听的 onEvent 方法接收数据
     * @return 应答结果
     */
    EventSource chatCompletions(String apiHostByUser, String apiKeyByUser, ChatCompletionRequestDTO chatCompletionRequestDTO, EventSourceListener eventSourceListener) throws JsonProcessingException;

    /**
     * 问答模型 GPT-3.5/4.0 & 流式反馈
     *
     * @param chatCompletionRequestDTO 请求信息
     * @param eventSourceListener   实现监听；通过监听的 onEvent 方法接收数据
     * @return 应答结果
     */
    EventSource chatCompletions(ChatCompletionRequestDTO chatCompletionRequestDTO, EventSourceListener eventSourceListener) throws JsonProcessingException;


    /**
     * 问答模型 GPT-3.5/4.0 & 流式反馈 & 一次反馈
     *
     * @param chatCompletionRequestDTO 请求信息
     * @return 应答结果
     */
    SseEmitter chatCompletions(ChatCompletionRequestDTO chatCompletionRequestDTO) throws InterruptedException, JsonProcessingException;

}
