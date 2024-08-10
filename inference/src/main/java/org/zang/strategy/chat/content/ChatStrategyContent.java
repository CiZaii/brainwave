package org.zang.strategy.chat.content;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.enums.HandlerEnums;
import org.zang.convention.exception.ChatException;
import org.zang.dto.req.qa.DocumentQARequestDTO;
import org.zang.handler.context.AbstractChainContext;
import org.zang.handler.filter.RagModelChainFilter;
import org.zang.strategy.chat.ChatStrategy;

import com.fasterxml.jackson.core.JsonProcessingException;

import cn.hutool.core.util.ObjectUtil;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ChatStrategyContent {

    @Resource
    private Map<String, ChatStrategy> modelChatStrategyMap;

    private final AbstractChainContext<ChatCompletionRequestDTO> requestDTORagModelChainFilter;

    public SseEmitter chatSSE(ChatCompletionRequestDTO chatCompletionRequestDTO) throws IOException {

        requestDTORagModelChainFilter.handler(HandlerEnums.MODEL_EXIST.getName(), chatCompletionRequestDTO);

        final ModelEnum model = ModelEnum.getModelEnum(chatCompletionRequestDTO.getModel());

        final String strategy = Objects.requireNonNull(model).getStrategy();

        return modelChatStrategyMap.get(strategy).chatCompletions(model, chatCompletionRequestDTO);
    }

    public ChatCompletionResponseDTO chat(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO) {

        requestDTORagModelChainFilter.handler(HandlerEnums.MODEL_EXIST.getName(), chatCompletionRequestDTO);

        final String strategy = model.getStrategy();

        return modelChatStrategyMap.get(strategy).chat(model, chatCompletionRequestDTO);
    }
}
