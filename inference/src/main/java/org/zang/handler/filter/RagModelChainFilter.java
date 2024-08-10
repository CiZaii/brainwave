package org.zang.handler.filter;

import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.convention.enums.HandlerEnums;
import org.zang.handler.AbstractChainHandler;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface RagModelChainFilter<T extends ChatCompletionRequestDTO> extends AbstractChainHandler<ChatCompletionRequestDTO> {

    @Override
    default String mark() {
        return HandlerEnums.MODEL_EXIST.getName();
    }
}
