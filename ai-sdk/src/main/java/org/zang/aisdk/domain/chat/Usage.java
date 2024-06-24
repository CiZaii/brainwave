package org.zang.aisdk.domain.chat;


import java.io.Serializable;

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
@AllArgsConstructor
@NoArgsConstructor
public class Usage implements Serializable {


    private static final long serialVersionUID = -3836723796084684313L;
    /** 提示令牌 */
    @JsonProperty("prompt_tokens")
    private long promptTokens;
    /** 完成令牌 */
    @JsonProperty("completion_tokens")
    private long completionTokens;
    /** 总量令牌 */
    @JsonProperty("total_tokens")
    private long totalTokens;
}
