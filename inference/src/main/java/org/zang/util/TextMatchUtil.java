package org.zang.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * brain-wave
 * 2024/7/8 22:54
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class TextMatchUtil {

    //TODO:这里其实不应该返回 void，我测试情况下看看结果对不对所以才这样做，具体返回什么佬你看看
    public static void getIndex(String zhuyu, String weiyu, String content) {

        // 建树，树中保存的是所有content 中子串

        Trie trie = new Trie();
        for (int i = 0; i < content.length(); i++) {
            for (int j = i + 1; j <= content.length(); j++) {
                trie.insert(content.substring(i, j), i);
            }
        }
        //找主语对应的 value 下标

        String subjectValue = zhuyu;
        final int[] subjectIndex = findBestMatchIndex(trie, subjectValue);
        final int i = subjectIndex[0] + subjectIndex[1];
        System.out.println("Subject index: " + subjectIndex[0] +": " + i + ", Value: " + subjectValue + ", Content: " + content);

        //找到谓语对应的下标

        String valueContent = weiyu;
        final int[] valueIndex = findBestMatchIndexAfterSubject(trie, valueContent, subjectIndex[0], content);
        final int i1 = valueIndex[0] + valueIndex[1];
        System.out.println("Predicate: " + weiyu + ", Value: " + valueContent + ", Index: " + valueIndex[0]  + ":" + i1);

    }
    private static int[] findBestMatchIndex(Trie trie, String target) {
        int bestIndex = trie.search(target);
        if (bestIndex != -1) {
            return new int[]{-1,-1};
        }
        return trie.longestPrefixMatch(target);

    }

    public static void a(List<String> targetSentences, String text){
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

    private static int[] findBestMatchIndexAfterSubject(Trie trie, String target, int subjectIndex, String content) {
        int[] longestPrefixMatch = trie.longestPrefixMatch(target);
        int bestIndex = longestPrefixMatch[0];
        while (bestIndex != -1 && bestIndex <= subjectIndex) {
            content = content.substring(bestIndex + 1);
            trie = new Trie();
            for (int i = 0; i < content.length(); i++) {
                for (int j = i + 1; j <= content.length(); j++) {
                    trie.insert(content.substring(i, j), i);
                }
            }
            longestPrefixMatch = trie.longestPrefixMatch(target);
            bestIndex = longestPrefixMatch[0];
        }
        return longestPrefixMatch;
    }

}
