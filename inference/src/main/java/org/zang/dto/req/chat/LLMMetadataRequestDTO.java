package org.zang.dto.req.chat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LLMMetadataRequestDTO {

    /**
     * 文件id
     */
    private String documentId;

    /**
     * 语料
     */
    private String content;

    /**
     * 模型标识
     */
    private String modelFlag;

}
