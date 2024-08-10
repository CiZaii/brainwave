package org.zang.aisdk.dto.req;


import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import java.util.Map;


import org.zang.aisdk.enums.config.ModelEnum;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/9 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@Builder
@Slf4j
@JsonInclude(JsonInclude.Include.NON_NULL)
@NoArgsConstructor
@AllArgsConstructor
public class ChatCompletionRequestDTO implements Serializable {


    @Serial
    private static final long serialVersionUID = 4673604805983641138L;
    /** 默认模型 */
    private String model = ModelEnum.QWEN2_7B.getCode();
    /** 问题描述 */
    private List<MessagesDTO> messages;
    /** 控制温度【随机性】；0到2之间。较高的值(如0.8)将使输出更加随机，而较低的值(如0.2)将使输出更加集中和确定 */
    private double temperature = 0.7;
    /** 多样性控制；使用温度采样的替代方法称为核心采样，其中模型考虑具有top_p概率质量的令牌的结果。因此，0.1 意味着只考虑包含前 10% 概率质量的代币 */
    @JsonProperty("top_p")
    private Double topP = 0.7d;
    /** 为每个提示生成的完成次数 */
    private Integer n = 1;
    /** 是否为流式输出；就是一蹦一蹦的，出来结果 */
    private boolean stream = false;
    /** 停止输出标识 */
    private List<String> stop;
    /** 输出字符串限制；0 ~ 4096 */
    @JsonProperty("max_tokens")
    private Integer maxTokens = 2048;
    /** 频率惩罚；降低模型重复同一行的可能性 */
    @JsonProperty("frequency_penalty")
    private double frequencyPenalty = 0;
    /** 存在惩罚；增强模型谈论新话题的可能性 */
    @JsonProperty("presence_penalty")
    private double presencePenalty = 0;
    /** 生成多个调用结果，只显示最佳的。这样会更多的消耗你的 api token */
    @JsonProperty("logit_bias")
    private Map logitBias;
    /** 调用标识，避免重复调用 */
    private String user;



}
