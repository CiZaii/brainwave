package org.zang.processor;

import java.util.List;

import lombok.Data;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
public class IePredicateResult {

    /**
     * 实体
     */
    private IeInferSubject subject;

    /**
     * 关系
     */
    private List<IePredicatesVO> predicates;
}
