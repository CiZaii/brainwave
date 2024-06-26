package org.zang.controller.rag;

import java.io.IOException;
import java.net.URISyntaxException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@RestController
@RequestMapping("/rag")
@Slf4j
@RequiredArgsConstructor
public class RagController {


    @PostMapping("stream_chat")
    public SseEmitter rag(@RequestBody ChatCompletionRequestDTO chatCompletionRequestDTO) throws URISyntaxException, IOException {

        log.info("当前的请求参数为{}", chatCompletionRequestDTO);


        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);





        return emitter;
    }
}
