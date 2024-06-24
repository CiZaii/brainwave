package org.zang.aisdk.client;


import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.req.ChatCompletionResponseDTO;

import io.reactivex.Single;
import retrofit2.http.Body;
import retrofit2.http.POST;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/8 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
public interface LLMClient {

    String V1_COMPLETIONS = "/v1/chat/completions";

    String V3_COMPLETIONS = "v3/chat/completions";
    /**
     * 问答模型；默认 GPT-3.5
     *
     * @param chatCompletionRequest 请求信息
     * @return 应答结果
     */
    @POST(V1_COMPLETIONS)
    Single<ChatCompletionResponseDTO> completions(@Body ChatCompletionRequestDTO chatCompletionRequest);



}
