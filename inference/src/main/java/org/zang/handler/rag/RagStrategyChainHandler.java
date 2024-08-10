package org.zang.handler.rag;

import cn.hutool.core.util.ObjectUtil;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.exception.ChatException;
import org.zang.handler.filter.RagModelChainFilter;
import org.zang.strategy.chat.ChatStrategy;

import java.util.Map;
import java.util.Objects;

import static org.zang.convention.errorcode.BaseErrorCode.CHAT_MODEL_NOT_SUPPORT_ERROR;

/**
 * Rag策略校验处理器
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Component
@Slf4j
public class RagStrategyChainHandler implements RagModelChainFilter<ChatCompletionRequestDTO> {

    @Resource
    private Map<String, ChatStrategy> modelChatStrategyMap;
    /**
     * 执行责任链逻辑
     *
     * @param requestParam 责任链执行入参
     */
    @Override
    public void handler(ChatCompletionRequestDTO requestParam) {

        final ModelEnum model = ModelEnum.getModelEnum(requestParam.getModel());

        final String modelName = Objects.requireNonNull(model).getCode();
        final String strategy = model.getStrategy();


        log.info("当前使用的模型为{}", modelName);

        if (ObjectUtil.isEmpty(modelChatStrategyMap.get(strategy))) {
            log.error("不存在对应的策略，当前想使用的模型为『{}』" , modelName);
            throw new ChatException(CHAT_MODEL_NOT_SUPPORT_ERROR);
        }
    }

    @Override
    public int getOrder() {
        return 1;
    }
}
