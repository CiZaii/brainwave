package org.zang.service.serviceImpl.rag;

import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import org.dromara.hutool.core.text.StrUtil;
import org.springframework.stereotype.Service;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.aisdk.dto.req.MessagesDTO;
import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.prompt.MetadataPrompt;
import org.zang.dto.req.chat.ChatMetadataRequestDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;
import org.zang.processor.CoordinateRelationshipProcessor;
import org.zang.processor.IePredicateResult;
import org.zang.service.rag.RagChatService;
import org.zang.strategy.chat.content.ChatStrategyContent;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import cn.hutool.core.date.DateUtil;
import lombok.RequiredArgsConstructor;


/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
@RequiredArgsConstructor
public class RagChatServiceImpl implements RagChatService {

    private final OpenAiSession openAiSession;

    private final CoordinateRelationshipProcessor coordinateRelationshipProcessor;

    private final ChatStrategyContent chatStrategyContent;

    @Override
    public IeInferResultRespDTO extractMetaData(ChatMetadataRequestDTO chatMetadataRequestDTO) {

        Long start = DateUtil.current();

        // 获取所抽取语料
        final String content = chatMetadataRequestDTO.getContent();
        // 元数据信息
        final String predicates = chatMetadataRequestDTO.getPredicates();

        final String format = StrUtil.format(MetadataPrompt.METADATA_PROMPT, content,predicates);

        chatMetadataRequestDTO.setModelFlag(ModelEnum.QWEN2_7B.getCode());

        final ChatCompletionRequestDTO chatCompletionRequestDTO = ChatCompletionRequestDTO.builder()
                .maxTokens(4096)
                .model(chatMetadataRequestDTO.getModelFlag())
                .messages(Collections.singletonList(MessagesDTO.builder().role("user").content(format).build()))
                .build();

        final ChatCompletionResponseDTO metaDeta = chatStrategyContent.chat(Objects.requireNonNull(ModelEnum.getModelEnum(chatMetadataRequestDTO.getModelFlag())), chatCompletionRequestDTO);

        final String content1 = metaDeta.getChoices().get(0).getMessage().getContent();

        final String resultJson = content1.replaceAll("\n", "");

        Gson gson = new Gson();

        // 获取 JSON 数组
        JsonArray resultArray = JsonParser.parseString(resultJson).getAsJsonArray();

        // 将 JSON 数组转换为 List<IePredicateResult>
        Type listType = new TypeToken<List<IePredicateResult>>() {}.getType();
        List<IePredicateResult> iePredicateResult = gson.fromJson(resultArray, listType);

        final IeInferResultRespDTO process = coordinateRelationshipProcessor.process(content, iePredicateResult);

        Long end = DateUtil.current();

        process.setTime((end - start) / 1000.0);

        process.setIePredicateResults(iePredicateResult);

        return process;

    }
}
