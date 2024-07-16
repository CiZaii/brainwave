package org.zang.dto.resp.ie;

import java.util.List;

import org.zang.processor.IePredicateResult;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 最终返回值包装类
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class IeInferResultRespDTO {

    /**
     * 推理时间
     */
    private Double time;

    /**
     * 进行推理语料
     */
    private String content;

    /**
     * 推理结果实体
     */
    private List<IeInferItemDTO> results;

    /**
     * 推理结果关系
     */
    private List<IeInferRelationDTO> relations;

    /**
     * 算法返回结果
     */
    private List<IePredicateResult> iePredicateResults;
}
