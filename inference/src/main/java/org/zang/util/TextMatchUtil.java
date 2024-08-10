package org.zang.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.zang.processor.IeInferSubject;
import org.zang.processor.IePredicateResult;
import org.zang.processor.IePredicatesVO;

/**
 * brain-wave
 * 2024/7/8 22:54
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class TextMatchUtil {

    public static Trie buildTree(String content, List<IePredicateResult> iePredicateResults) {
        // 初始化最大值和最小值
        int max = Integer.MIN_VALUE;
        int min = Integer.MAX_VALUE;

        for (IePredicateResult result : iePredicateResults) {
            // 计算 subject 的 value 和 type 的长度
            IeInferSubject subject = result.getSubject();
            int subjectValueLength = subject.getValue().length();
            int subjectTypeLength = subject.getType().length();

            max = Math.max(max, subjectValueLength);
            max = Math.max(max, subjectTypeLength);
            min = Math.min(min, subjectValueLength);
            min = Math.min(min, subjectTypeLength);

            // 计算每个 predicate 的长度
            for (IePredicatesVO predicate : result.getPredicates()) {
                int predicateLength = predicate.getPredicate().length();
                max = Math.max(max, predicateLength);
                min = Math.min(min, predicateLength);

                if (predicate.getObject() != null) {
                    int objectLength = predicate.getObject().length();
                    max = Math.max(max, objectLength);
                    min = Math.min(min, objectLength);
                }
            }
        }

        // 使用计算得到的 max 和 min 构建 Trie 树
        return buildTree(content, max, min);
    }
    public static Trie buildTree(String content, int max, int min) {
        Trie trie = new Trie();
        int contentLength = content.length();

        for (int i = 0; i < contentLength; i++) {
            int maxLength = Math.min(i + max, contentLength); // 确保 j 不超过 content 的长度
            for (int j = i + min; j <= maxLength; j++) {
                trie.insert(content.substring(i, j), i);
            }
        }
        return trie;
    }

    //TODO:这里其实不应该返回 void，我测试情况下看看结果对不对所以才这样做，具体返回什么佬你看看
    public static int[] getPredicateIndex(int itemIndex, String weiyu, Trie trie) {
        //找到谓语对应的下标
        final int[] valueIndex = findBestMatchIndexAfterSubject(trie, weiyu, itemIndex);
        final int i1 = valueIndex[0] + valueIndex[1];
        return new int[]{valueIndex[0], i1};
    }

    public static int[] getItemIndex(String zhuyu, Trie trie) {
        //找主语对应的 value 下标
        final int[] subjectIndex = findBestMatchIndex(trie, zhuyu);
        final int i = subjectIndex[0] + subjectIndex[1];
        return new int[]{subjectIndex[0], i};
    }

    private static int[] findBestMatchIndex(Trie trie, String target) {
        List<Integer> bestIndices = trie.search(target);
        if (bestIndices.isEmpty()) {
            return trie.longestPrefixMatch(target);
        }
        return new int[]{bestIndices.get(bestIndices.size() - 1), target.length()}; // 返回最后一个下标和匹配长度
    }
    // 调整了最前匹配的思路

    private static int[] findBestMatchIndexAfterSubject(Trie trie, String target, int subjectIndex) {
        int[] longestPrefixMatch = trie.longestPrefixMatch(target);
        int bestIndex = longestPrefixMatch[0];
        for (int index : trie.search(target)) {
            if (index > subjectIndex) {
                bestIndex = index;
                break;
            }
        }
        return bestIndex == -1 ? longestPrefixMatch : new int[]{bestIndex, target.length()};
    }

    public static void a(List<String> targetSentences, String text) {
        // 存储每个目标句子的开始和结束位置
        Map<String, List<int[]>> sentencePositions = new HashMap<>();

        for (String targetSentence : targetSentences) {
            List<int[]> positions = findPositions(text, targetSentence);
            sentencePositions.put(targetSentence, positions);
        }

        // 输出结果
        for (String sentence : targetSentences) {
            List<int[]> positions = sentencePositions.get(sentence);
            if (positions != null && !positions.isEmpty()) {
                for (int[] pos : positions) {
                    System.out.println("目标句子 \"" + sentence + "\" 的开始位置: " + pos[0] + "，结束位置: " + pos[1]);
                }
            } else {
                System.out.println("目标句子 \"" + sentence + "\" 在文本中未找到");
            }
        }
    }

    /**
     * 查找目标句子在文本中的所有位置。
     *
     * @param text          原文本
     * @param targetSentence 目标句子
     * @return 目标句子在文本中的所有开始和结束位置
     */
    private static List<int[]> findPositions(String text, String targetSentence) {
        List<int[]> positions = new ArrayList<>();
        int index = text.indexOf(targetSentence);
        while (index >= 0) {
            positions.add(new int[]{index, index + targetSentence.length()});
            index = text.indexOf(targetSentence, index + 1);
        }
        return positions;
    }
}