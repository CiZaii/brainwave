package org.zang.aisdk.enums;

import java.util.Map;

import org.dromara.streamquery.stream.core.optional.Opp;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/9 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
public interface ConfigurableEnum<T extends Enum<T>> {


    // 子类需要提供加载配置的方式
    Map<String, String> loadConfiguration();

    // 提供默认值
    String getDefaultValue();

    // 获取码
    String getCode();

    // 获取值的默认方法
    default String getValue() {
        return Opp.of(loadConfiguration().get(getCode())).orElseGet(this::getDefaultValue);
    }
}


