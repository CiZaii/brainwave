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
            根据predicates对content进行元数据提取。提取时请注意以下几点：
            1. 精确提取content中与predicates匹配的相关信息。
            2. 返回结果中只包含相关数据，不要有任何不相关的数据。
            3. 确保每个predicate的object字段准确反映在content中的内容。

            返回结果格式如下：
            [
                {
                    "subject": {
                        "type": "公文",
                        "value": "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知"
                    },
                    "predicates": [
                        {
                            "predicate": "标题",
                            "object": "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知"
                        },
                        {
                            "predicate": "动态来源",
                            "object": "全总法律工作部"
                        },
                        {
                            "predicate": "文件层级",
                            "object": "总工发〔2023〕23号"
                        },
                        {
                            "predicate": "发布时间",
                            "object": "2023年12月28日"
                        }
                    ]
                }
            ]

            请根据上述示例提取content中的相关元数据。
            """;


}
