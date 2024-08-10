package org.zang.convention.enums;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Getter
@AllArgsConstructor

public enum HandlerEnums {

    USER_LOGIN("user-login-chain-filter"),
    USER_REGISTER("user-register-chain-filter"),

    MODEL_EXIST("model-enum-chain-filter"),

    ;

    private String name;
}

