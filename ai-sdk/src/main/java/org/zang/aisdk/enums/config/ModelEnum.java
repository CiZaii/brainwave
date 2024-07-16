package org.zang.aisdk.enums.config;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Getter
@AllArgsConstructor
public enum ModelEnum {
    THUDM("THUDM/glm-4-9b-chat","siliconCloudChatStrategyImpl"),
    QWEN2_7B("Qwen/Qwen2-7B-Instruct","siliconCloudChatStrategyImpl"),
    /** gpt-3.5-turbo */
    GPT_3_5_TURBO("gpt-3.5-turbo",""),
    /** GPT4.0 */
    GPT_4("gpt-4",""),
    GPT_4o("gpt-4o",""),
    /** GPT4.0 超长上下文 */
    GPT_4_32K("gpt-4-32k",""),
    ;
    private String code;
    private String strategy;

    public static ModelEnum getModelEnum(String code){
        for (ModelEnum modelEnum : ModelEnum.values()) {
            if (modelEnum.getCode().equals(code)){
                return modelEnum;
            }
        }
        return null;
    }
}
