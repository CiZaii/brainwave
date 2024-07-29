package org.zang.dto.req.qa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 文档问答请求DTO
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DocumentQARequestDTO {

    /**
     * 问题
     */
    private String question;

    /**
     * 文档ID
     */
    private String documentId;

    /**
     * 模型标识
     */
    private String modelFlag;


}
