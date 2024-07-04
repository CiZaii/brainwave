package org.zang;

import org.dromara.streamquery.stream.plugin.mybatisplus.engine.annotation.EnableMybatisPlusPlugin;
import org.dromara.x.file.storage.spring.EnableFileStorage;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.dtflys.forest.springboot.annotation.ForestScan;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/24 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
//TIP 要<b>运行</b>代码，请按 <shortcut actionId="Run"/> 或
// 点击装订区域中的 <icon src="AllIcons.Actions.Execute"/> 图标。
@SpringBootApplication
@EnableMybatisPlusPlugin(basePackages = "org.zang.pojo.**")
@EnableFileStorage
@ForestScan(basePackages = "org.zang")
public class InferenceApplication {

    public static void main(String[] args) {
        SpringApplication.run(InferenceApplication.class, args);
    }
}