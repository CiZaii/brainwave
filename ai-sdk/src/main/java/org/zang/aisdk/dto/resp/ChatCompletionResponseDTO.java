package org.zang.aisdk.dto.resp;


import java.io.Serializable;
import java.util.List;


import org.zang.aisdk.domain.chat.ChatChoice;
import org.zang.aisdk.domain.chat.Usage;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/9 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatCompletionResponseDTO implements Serializable {


    private static final long serialVersionUID = 4045866371327350695L;
    /**
     * ID
     */
    private String id;
    /**
     * 对象
     */
    private String object;
    /**
     * 模型
     */
    private String model;
    /**
     * 对话
     */
    private List<ChatChoice> choices;
    /**
     * 创建
     */
    private long created;
    /**
     * 耗材
     */
    private Usage usage;
    /**
     * 该指纹代表模型运行时使用的后端配置。
     * https://platform.openai.com/docs/api-reference/chat
     */
    @JsonProperty("system_fingerprint")
    private String systemFingerprint;
}
