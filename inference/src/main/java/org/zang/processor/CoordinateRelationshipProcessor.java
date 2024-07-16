package org.zang.processor;

import java.util.List;

import org.dromara.streamquery.stream.core.stream.Steam;
import org.springframework.stereotype.Service;
import org.zang.dto.resp.ie.IeInferResultRespDTO;

/**
 * 坐标关系处理器
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
public class CoordinateRelationshipProcessor {

    /**
     * 处理元数据提取之后的坐标关系
     */
    public IeInferResultRespDTO process(String content, List<IePredicateResult> iePredicateResults) {

        Steam.of(iePredicateResults)
                .parallel(Boolean.TRUE)
                .forEach(iePredicateResult -> {
                    // 处理坐标关系
                    final IeInferSubject subject = iePredicateResult.getSubject();
                    final List<IePredicatesVO> predicates = iePredicateResult.getPredicates();


                });
        return null;
    }
}
