package org.zang.service.rag;

import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.dto.req.chat.ChatMetadataRequestDTO;
import org.zang.dto.req.chat.LLMMetadataRequestDTO;
import org.zang.dto.req.qa.DocumentQARequestDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface RagChatService {

    /**
     * 元数据提取
     * @param chatMetadataRequestDTO 所抽取语料与元数据
     * @return 抽取结果
     */
    IeInferResultRespDTO extractMetaData(ChatMetadataRequestDTO chatMetadataRequestDTO);

    String documentQa(DocumentQARequestDTO documentQARequestDTO);

    String llmExtractMetaData(LLMMetadataRequestDTO chatCompletionRequestDTO);

    IeInferResultRespDTO extractMetaDataByDocument(String documentId);
}
