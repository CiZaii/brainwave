package org.zang.util;

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
    public static void main(String[] args) throws JsonProcessingException {
        String jsonInput = "{\n" +
                "  \"subject\": {\n" +
                "    \"type\": \"公文标题\",\n" +
                "    \"value\": \"中华全国总工会关于印发《工会参与劳动争议处理办法》的通知\"\n" +
                "  },\n" +
                "  \"predicates\": [\n" +
                "    {\n" +
                "      \"predicate\": \"发布时间\",\n" +
                "      \"values\": [\n" +
                "        {\n" +
                "          \"content\": \"2023年12月28日\"\n" +
                "        }\n" +
                "      ]\n" +
                "    }\n" +
                "  ]\n" +
                "}";

        String content = "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知总工发〔2023〕23号来源：全总法律工作部各省、自治区、直辖市总工会，各全国产业工会，中央和国家机关工会联合会，全总各部门、各直属单位：《工会参与劳动争议处理办法》已经中华全国总工会第十八届书记处第4次会议审议通过，现印发给你们，请认真贯彻执行。中华全国总工会2023年12月28日工会参与劳动争议处理办法第一章总则第一条为深入贯彻习近平法治思想，坚持和发展新时代“枫桥经验”，进一步规范和加强工会参与劳动争议处理工作，更好履行维护职工合法权益、竭诚服务职工群众基本职责，推动构建和谐劳动关系，根据《中华人民共和国工会法》《中华人民共和国劳动法》《中华人民共和国劳动合同1法》《中华人民共和国劳动争议调解仲裁法》及《中国工会章程》等有关规定，制定本办法。第二条工会参与劳动争议处理，应当坚持中国共产党的领导，坚持以职工为本，坚持立足预防、立足调解、立足法治、立足基层，坚持公平、正义，最大限度将劳动争议矛盾化解在基层，化解在萌芽状态。第三条县级以上总工会应当将工会参与劳动争议处理工作纳入服务职工工作体系，健全工会参与劳动争议处理保障机制，促进工会参与劳动争议处理工作高质量发展。全国总工会法律工作部门负责指导、协调全国工会参与劳动争议处理工作。县级以上地方总工会法律工作部门负责指导、协调并组织实施本地区工会参与劳动争议处理工作。各级工会加强与同级人力资源社会保障、人民法院、人民检察院、司法行政、公安、工商业联合会、企业联合会／企业家协会、律师协会等部门的沟通，推动建立健全劳动争议处理协作联动机制，协力做好劳动争议处理工作。第四条本办法适用于工会参与处理下列劳动争议";
        getIndex(jsonInput,content);
    }
    //TODO:这里其实不应该返回 void，我测试情况下看看结果对不对所以才这样做，具体返回什么佬你看看
    public static void getIndex(String jsonInput,String content) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(jsonInput);

        // 建树，树中保存的是所有content 中子串

        Trie trie = new Trie();
        for (int i = 0; i < content.length(); i++) {
            for (int j = i + 1; j <= content.length(); j++) {
                trie.insert(content.substring(i, j), i);
            }
        }
        //找主语对应的 value 下标

        JsonNode subjectNode = rootNode.path("subject");
        String subjectValue = subjectNode.path("value").asText();
        int subjectIndex = findBestMatchIndex(trie, subjectValue);
        System.out.println("Subject index: " + subjectIndex);

        //找到谓语对应的下标
        JsonNode predicates = rootNode.path("predicates");
        for (JsonNode predicateNode : predicates) {
            String predicateName = predicateNode.path("predicate").asText();
            JsonNode valuesNode = predicateNode.path("values");
            for (JsonNode valueNode : valuesNode) {
                String valueContent = valueNode.path("content").asText();
                int valueIndex = findBestMatchIndexAfterSubject(trie, valueContent, subjectIndex, content);
                System.out.println("Predicate: " + predicateName + ", Value: " + valueContent + ", Index: " + valueIndex);
            }
        }

    }
    private static int findBestMatchIndex(Trie trie, String target) {
        int bestIndex = trie.search(target);
        if (bestIndex != -1) {
            return bestIndex;
        }
        int[] longestPrefixMatch = trie.longestPrefixMatch(target);
        return longestPrefixMatch[0];
    }

    private static int findBestMatchIndexAfterSubject(Trie trie, String target, int subjectIndex, String content) {
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
        return bestIndex;
    }
}
