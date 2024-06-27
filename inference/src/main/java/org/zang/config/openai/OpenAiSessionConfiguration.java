package org.zang.config.openai;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.client.session.OpenAiSessionFactory;
import org.zang.aisdk.client.session.defaults.DefaultOpenAiSessionFactory;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Configuration
@RequiredArgsConstructor
public class OpenAiSessionConfiguration {

    private final HostSettings hostSettings;

    @Bean
    public OpenAiSession openAiSession() {
        org.zang.aisdk.client.session.Configuration configuration = new org.zang.aisdk.client.session.Configuration();
        configuration.setApiHost(hostSettings.host);
        configuration.setApiKey(hostSettings.key);
        // 2. 会话工厂
        OpenAiSessionFactory factory = new DefaultOpenAiSessionFactory(configuration);
        // 3. 开启会话
        return factory.openSession();
    }
    @Setter
    @Getter
    @Component
    @ConfigurationProperties(prefix = "ai")
    public static class HostSettings {

        private String host;
        private String key;

    }

}
