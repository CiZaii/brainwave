package org.zang.convention.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Getter
@AllArgsConstructor
public enum RabbitMQEnums {

    CHAT_MESSAGE("chat-message-queue","chat-message-exchange","chat-message-routing-key");


    private final String Queue;

    private final String Exchange;

    private final String RoutingKey;
}
