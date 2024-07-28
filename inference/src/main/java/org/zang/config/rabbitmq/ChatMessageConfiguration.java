package org.zang.config.rabbitmq;

import static org.zang.convention.enums.RabbitMQEnums.CHAT_MESSAGE;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Configuration
public class ChatMessageConfiguration {

    // 创建 Queue
    @Bean
    public Queue featureGenQueue() {
        return new Queue(CHAT_MESSAGE.getQueue(),
                true,
                false,
                false);
    }

    // 创建 Direct Exchange
    @Bean
    public DirectExchange featureGenExchangeMinio() {
        return new DirectExchange(CHAT_MESSAGE.getExchange(),
                true,
                false);
    }

    // 创建 Binding
    // Exchange：Demo01Message.EXCHANGE
    // Routing key：Demo01Message.ROUTING_KEY
    // Queue：Demo01Message.QUEUE
    @Bean
    public Binding featureGenBinding() {
        return BindingBuilder.bind(featureGenQueue()).to(featureGenExchangeMinio()).with(CHAT_MESSAGE.getRoutingKey());
    }
}
