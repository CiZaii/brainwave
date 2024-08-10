package org.zang.handler.rag;

import org.dromara.streamquery.stream.core.optional.Opp;
import org.springframework.stereotype.Component;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.exception.ChatException;
import org.zang.convention.exception.ServiceException;

import org.zang.handler.filter.RagModelChainFilter;

import static org.zang.convention.errorcode.BaseErrorCode.CHAT_MODEL_NULL_ERROR;


/**
 * Rag模型校验处理器
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Component()
public class RagModelChainHandler implements RagModelChainFilter<ChatCompletionRequestDTO> {

    /**
     * 执行责任链逻辑
     *
     * @param requestParam 责任链执行入参
     */
    @Override
    public void handler(ChatCompletionRequestDTO requestParam) {

        final ModelEnum modelEnum = ModelEnum.getModelEnum(requestParam.getModel());

        if (Opp.of(modelEnum).isEmpty()) {
            throw new ChatException(CHAT_MODEL_NULL_ERROR);
        }
    }

    @Override
    public int getOrder() {
        return 0;
    }
}
