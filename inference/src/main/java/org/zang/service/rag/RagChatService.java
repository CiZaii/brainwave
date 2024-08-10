package org.zang.service.rag;

import java.io.IOException;
import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;
import org.zang.aisdk.dto.resp.ChatCompletionResponseDTO;
import org.zang.dto.req.chat.ChatMetadataRequestDTO;
import org.zang.dto.req.chat.LLMMetadataRequestDTO;
import org.zang.dto.req.qa.DocumentQARequestDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;
import org.zang.dto.resp.rag.ModelRespDTO;

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

    /**
     * 文档问答
     * @param documentQARequestDTO 文档问答请求参数
     * @return 文档问答结果
     */
    SseEmitter documentQa(DocumentQARequestDTO documentQARequestDTO) throws IOException;

    /**
     * 自动生成元数据提取
     * @param chatCompletionRequestDTO 请求参数
     * @return ChatCompletionResponseDTO 抽取结果
     */
    String llmExtractMetaData(LLMMetadataRequestDTO chatCompletionRequestDTO);

    /**
     * 抽取文档内容
     * @param documentId 请求参数
     *
     * @return ChatCompletionResponseDTO 抽取结果
     */
    IeInferResultRespDTO extractMetaDataByDocument(String documentId);

    /**
     * 获取所有模型
     * @return
     */
    List<ModelRespDTO> models();
}
