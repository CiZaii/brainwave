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
    THUDM("THUDM/glm-4-9b-chat","siliconCloudChatStrategyImpl","glm-4-9b-chat"),
    QWEN2_7B("Qwen/Qwen2-7B-Instruct","123","Qwen2-7B-Instruct"),
    ;
    private final String code;
    private final String strategy;
    private final String name;

    public static ModelEnum getModelEnum(String code){
        for (ModelEnum modelEnum : ModelEnum.values()) {
            if (modelEnum.getCode().equals(code)){
                return modelEnum;
            }
        }
        return null;
    }
}
