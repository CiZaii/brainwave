package org.zang.convention.prompt;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface MetadataPrompt {

    String METADATA_PROMPT = """
            predicates为: {}
            content为: {}
            根据predicates对content进行关系抽取，结果必须以json格式返回 示例如下 { "subject": { "type": "xxxx", "value": "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知" }, "predicates": [ { "predicate": "xxxxx", "object": "工会参与劳动争议处理办法" }, { "predicate": "xxxxxx", "object": "2023年12月28日" } ] }
            """;


}
