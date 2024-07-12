package org.zang.strategy.chat;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.aisdk.enums.config.ModelEnum;

import com.fasterxml.jackson.core.JsonProcessingException;


/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface ChatStrategy {

    SseEmitter chatCompletions(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO) throws JsonProcessingException;

    ChatCompletionResponseDTO chat(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO);
}
