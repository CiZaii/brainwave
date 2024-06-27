package org.zang.controller.rag;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Collections;
import java.util.concurrent.CompletableFuture;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;

import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
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

    @PostMapping("stream_chat")
    public SseEmitter rag(@RequestBody ChatCompletionRequestDTO chatCompletionRequestDTO) throws InterruptedException, JsonProcessingException {

        log.info("当前的请求参数为{}", chatCompletionRequestDTO);

        log.info("测试开始：请等待调用结果");

        return openAiSession.chatCompletions(chatCompletionRequestDTO);

    }



}
