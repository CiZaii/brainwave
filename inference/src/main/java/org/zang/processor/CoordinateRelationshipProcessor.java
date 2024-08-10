package org.zang.processor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dromara.hutool.core.text.StrUtil;
import org.dromara.hutool.core.text.dfa.WordTree;
import org.dromara.streamquery.stream.core.stream.Steam;
import org.springframework.stereotype.Service;
import org.zang.convention.constant.IeTypeConstant;
import org.zang.dto.resp.ie.IeInferItemDTO;
import org.zang.dto.resp.ie.IeInferRelationDTO;
import org.zang.dto.resp.ie.IeInferResultRespDTO;
import org.zang.util.TextMatchUtil;

import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;
import org.zang.util.Trie;

import cn.hutool.core.lang.UUID;

/**
 * 坐标关系处理器
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
public class CoordinateRelationshipProcessor implements IeTypeConstant {

    /**
     * 处理元数据提取之后的坐标关系
     */
    public IeInferResultRespDTO process(String content, List<IePredicateResult> iePredicateResults) {
        final IeInferResultRespDTO ieInferResultRespDTO = new IeInferResultRespDTO();
        // 使用线程安全的集合
        final List<IeInferItemDTO> results = Collections.synchronizedList(ieInferResultRespDTO.getResults());
        final List<IeInferRelationDTO> relations = Collections.synchronizedList(ieInferResultRespDTO.getRelations());

        // 一次性构建 Trie
        Trie trie = TextMatchUtil.buildTree(content,iePredicateResults);

        Steam.of(iePredicateResults).parallel(Boolean.TRUE)
                .forEach(iePredicateResult -> {
                    final IeInferSubject subject = iePredicateResult.getSubject();
                    final int[] subjectIndices = TextMatchUtil.getItemIndex(subject.getValue(), trie);

                    final IeInferItemDTO subjectItem = createInferItem(subject.getValue(), subject.getType(), subjectIndices);
                    results.add(subjectItem);

                    iePredicateResult.getPredicates().forEach(predicate -> {
                        final int[] predicateIndices = TextMatchUtil.getPredicateIndex(subjectIndices[0], predicate.getObject(), trie);
                        final IeInferItemDTO predicateItem = createInferItem(predicate.getObject(), predicate.getPredicate(), predicateIndices);
                        results.add(predicateItem);

                        // 建立关系
                        final IeInferRelationDTO relation = new IeInferRelationDTO(subjectItem.getUuid(), predicateItem.getUuid(), predicate.getPredicate());
                        relations.add(relation);
                    });
                });

        return ieInferResultRespDTO;
    }

    private IeInferItemDTO createInferItem(String text, String schema, int[] indices) {
        final IeInferItemDTO item = new IeInferItemDTO();
        item.setStart(String.valueOf(indices[0]));
        item.setEnd(String.valueOf(indices[1]));
        item.setText(text);
        item.setType((StrUtil.equals(schema, "subject") ? ITEM : PREDICATE));
        item.setSchema(schema);
        item.setUuid(UUID.randomUUID().toString());
        return item;
    }
}
