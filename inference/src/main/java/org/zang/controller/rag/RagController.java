package org.zang.controller.rag;


import java.io.IOException;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;

import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;

import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.chat.ChatMetadataRequestDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;
import org.zang.service.rag.RagChatService;

import com.docapis.core.DocApi;
import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 问答模块
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@RestController
@RequestMapping("/rag")
@Slf4j
@RequiredArgsConstructor
public class RagController {

    private final OpenAiSession openAiSession;

    private final RagChatService ragChatService;


    /**
     * 测试rag
     * @param chatCompletionRequestDTO 请求参数
     * @return SseEmitter
     * @throws InterruptedException
     * @throws JsonProcessingException
     */
    @PostMapping("stream_chat")
    public SseEmitter rag(@RequestBody ChatCompletionRequestDTO chatCompletionRequestDTO) throws InterruptedException, JsonProcessingException {

        log.info("当前的请求参数为{}", chatCompletionRequestDTO);

        log.info("测试开始：请等待调用结果");

        return openAiSession.chatCompletions(chatCompletionRequestDTO);

    }

    /**
     * 元数据提取
     * @param chatMetadataRequestDTO 请求参数
     *
     * @return ChatCompletionResponseDTO 抽取结果
     */
    @PostMapping("/extractMetaData")
    public Result<IeInferResultRespDTO> extractMetaData(@RequestBody ChatMetadataRequestDTO chatMetadataRequestDTO) {
        log.info("当前的请求参数为{}", chatMetadataRequestDTO);
        log.info("测试开始：请等待调用结果");

        return Results.success(ragChatService.extractMetaData(chatMetadataRequestDTO));

        //return chatStrategyContent.chatSSE(ModelEnum.THUDM, chatCompletionRequestDTO);

    }



}
