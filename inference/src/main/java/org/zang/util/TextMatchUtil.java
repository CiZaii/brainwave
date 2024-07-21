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

    public static void main(String[] args) {
        String content = "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知总工发〔2023〕23号来源：全总法律工作部各省、自治区、直辖市总工会，各全国产业工会，中央和国家机关工会联合会，全总各部门、各直属单位：《工会参与劳动争议处理办法》已经中华全国总工会第十八届书记处第4次会议审议通过，现印发给你们，请认真贯彻执行。中华全国总工会2023年12月28日工会参与劳动争议处理办法第一章总则第一条为深入贯彻习近平法治思想，坚持和发展新时代“枫桥经验”，进一步规范和加强工会参与劳动争议处理工作，更好履行维护职工合法权益、竭诚服务职工群众基本职责，推动构建和谐劳动关系，根据《中华人民共和国工会法》《中华人民共和国劳动法》《中华人民共和国劳动合同1法》《中华人民共和国劳动争议调解仲裁法》及《中国工会章程》等有关规定，制定本办法。第二条工会参与劳动争议处理，应当坚持中国共产党的领导，坚持以职工为本，坚持立足预防、立足调解、立足法治、立足基层，坚持公平、正义，最大限度将劳动争议矛盾化解在基层，化解在萌芽状态。第三条县级以上总工会应当将工会参与劳动争议处理工作纳入服务职工工作体系，健全工会参与劳动争议处理保障机制，促进工会参与劳动争议处理工作高质量发展。全国总工会法律工作部门负责指导、协调全国工会参与劳动争议处理工作。县级以上地方总工会法律工作部门负责指导、协调并组织实施本地区工会参与劳动争议处理工作。各级工会加强与同级人力资源社会保障、人民法院、人民检察院、司法行政、公安、工商业联合会、企业联合会／企业家协会、律师协会等部门的沟通，推动建立健全劳动争议处理协作联动机制，协力做好劳动争议处理工作。第四条本办法适用于工会参与处理下列劳动争议";
        Trie trie = buildTree(content);

        String subject = "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知";
        String predicate = "2023年12月28日";

        TextMatchUtil.getIndex(subject, predicate, trie);
    }
    public static Trie buildTree(String content) {
        Trie trie = new Trie();
        for (int i = 0; i < content.length(); i++) {
            for (int j = i + 1; j <= content.length(); j++) {
                trie.insert(content.substring(i, j), i);
            }
        }
        return trie;
    }

    //TODO:这里其实不应该返回 void，我测试情况下看看结果对不对所以才这样做，具体返回什么佬你看看
    public static void getIndex(String zhuyu, String weiyu, Trie trie) {
        //找主语对应的 value 下标
        String subjectValue = zhuyu;
        final int[] subjectIndex = findBestMatchIndex(trie, subjectValue);
        final int i = subjectIndex[0] + subjectIndex[1];
        System.out.println("Subject index: " + subjectIndex[0] + ": " + i + ", Value: " + subjectValue );

        //找到谓语对应的下标
        String valueContent = weiyu;
        final int[] valueIndex = findBestMatchIndexAfterSubject(trie, valueContent, subjectIndex[0]);
        final int i1 = valueIndex[0] + valueIndex[1];
        System.out.println("Predicate: " + weiyu + ", Value: " + valueContent + ", Index: " + valueIndex[0] + ":" + i1);
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