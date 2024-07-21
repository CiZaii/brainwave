package org.zang.processor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dromara.hutool.core.text.dfa.WordTree;
import org.dromara.streamquery.stream.core.stream.Steam;
import org.springframework.stereotype.Service;
import org.zang.dto.resp.ie.IeInferItemDTO;
import org.zang.dto.resp.ie.IeInferRelationDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;
import org.zang.util.TextMatchUtil;

import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;
import org.zang.util.Trie;

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

        final IeInferResultRespDTO ieInferResultRespDTO = new IeInferResultRespDTO();
        // 实体对象
        final List<IeInferItemDTO> results = ieInferResultRespDTO.getResults();
        // 关系对象
        final List<IeInferRelationDTO> relations = ieInferResultRespDTO.getRelations();

        JiebaSegmenter segmenter = new JiebaSegmenter();
        // 这里先提前初始化一颗树，之后把这棵树传进去会减少初始化次数，只会在匹配谓语错误的时候重新生成树
        Trie trie = TextMatchUtil.buildTree(content);
        // 目标句子列表
        List<String> targetSentences = new ArrayList<>();

        Steam.of(iePredicateResults)
                .parallel(Boolean.FALSE)
                .forEach(iePredicateResult -> {
                    // 处理坐标关系
                    final IeInferSubject subject = iePredicateResult.getSubject();
                    targetSentences.add(subject.getValue());
                    final List<IePredicatesVO> predicates = iePredicateResult.getPredicates();

                    predicates.stream().forEach(predicate -> {
                        TextMatchUtil.getIndex(subject.getValue(),predicate.getObject(),trie);
                        targetSentences.add(predicate.getObject());
                    });
                    TextMatchUtil.a(targetSentences,content);

                });

        return null;
    }
}
