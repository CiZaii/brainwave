package org.zang.strategy.chat.content;

import java.io.IOException;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.exception.ChatException;
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

    public SseEmitter chatSSE(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO) throws IOException {

        final String modelName = model.getCode();
        final String strategy = model.getStrategy();

        log.info("当前使用的模型为{}", modelName);

        if (ObjectUtil.isEmpty(modelChatStrategyMap.get(strategy))) {
            log.error("不存在对应的策略，当前想使用的模型为『{}』" , modelName);
            throw new ChatException("不存在对应的策略，当前想使用的模型为『" + modelName + "』");
        }

        return modelChatStrategyMap.get(strategy).chatCompletions(model, chatCompletionRequestDTO);
    }

    public ChatCompletionResponseDTO chat(ModelEnum model, ChatCompletionRequestDTO chatCompletionRequestDTO) {

        final String modelName = model.getCode();
        final String strategy = model.getStrategy();

        log.info("当前使用的模型为{}", modelName);

        if (ObjectUtil.isEmpty(modelChatStrategyMap.get(strategy))) {
            log.error("不存在对应的策略，当前想使用的模型为『{}』" , modelName);
            throw new ChatException("不存在对应的策略，当前想使用的模型为『" + modelName + "』");
        }

        return modelChatStrategyMap.get(strategy).chat(model, chatCompletionRequestDTO);
    }
}
