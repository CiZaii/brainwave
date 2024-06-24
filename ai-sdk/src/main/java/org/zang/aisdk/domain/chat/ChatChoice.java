package org.zang.aisdk.domain.chat;

import java.io.Serializable;


import org.zang.aisdk.dto.req.MessagesDTO;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/9 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
public class ChatChoice implements Serializable {

    private long index;
    /** stream = true 请求参数里返回的属性是 delta */
    @JsonProperty("delta")
    private MessagesDTO delta;
    /** stream = false 请求参数里返回的属性是 delta */
    @JsonProperty("message")
    private MessagesDTO message;
    @JsonProperty("finish_reason")
    private String finishReason;

}
