package org.zang.aisdk.interceptor;


import java.io.IOException;

import org.dromara.hutool.http.meta.ContentType;
import org.dromara.hutool.http.meta.HeaderName;
import org.jetbrains.annotations.NotNull;

import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/8 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
public class OpenAiInterceptor implements Interceptor {

    /** OpenAi apiKey 需要在官网申请 */
    private final String apiKeyBySystem;
    /** 访问授权接口的认证 Token */

    public OpenAiInterceptor(String apiKeyBySystem) {
        this.apiKeyBySystem = apiKeyBySystem;
    }

    @NotNull
    @Override
    public Response intercept(Chain chain) throws IOException {
        // 1. 获取原始 Request
        Request original = chain.request();

        // 2. 读取 apiKey；优先使用自己传递的 apiKey
        String apiKeyByUser = original.header("apiKey");
        String apiKey = null == apiKeyByUser ? apiKeyBySystem : apiKeyByUser;

        // 3. 构建 Request
        Request request = original.newBuilder()
                .url(original.url())
                .header(HeaderName.AUTHORIZATION.getValue(), "Bearer " + apiKey)
                .header(HeaderName.CONTENT_TYPE.getValue(), ContentType.JSON.getValue())
                .method(original.method(), original.body())
                .build();

        // 4. 返回执行结果
        return chain.proceed(request);
    }

}
