package org.zang.convention.prompt;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface MetadataPrompt {

    String METADATA_PROMPT = """
            
            
            任务指令：
            对给定的文本内容进行关系抽取。请根据提供的谓词列表精确提取文本中的相关信息。

            输入数据：
            谓词列表 predicates为: {}
            文本内容 content为: {}
            操作指南：
            精准匹配：仔细阅读文本内容，根据谓词列表中的每一个谓词，精确匹配并提取文本中对应的信息。
            结果过滤：确保提取结果仅包含与谓词直接相关的信息，避免包含任何不相关的数据。
            结果准确性：对于每一个谓词，检查其 object 字段是否与文本内容中实际的信息完全一致。
            注意事项：
            对于文本中可能存在的模糊或多义性信息，采取合理的解释策略，确保提取结果的一致性和准确性。
            如果文本内容中没有直接的信息匹配某个谓词，请明确指出该谓词在文本中没有对应的信息。

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

    String DOCUMENT_QA_PROMPT = """
                文档数据为:
                {}
                根据以上给出的内容来回答我下边的问题
                返回结果要按条来说，并且要告诉我是根据哪页回答出来的结果的格式如下
            [
                {
                    "pageNumber": 这里是第几页,
                    "referenceSentence": "这里是根据哪句话回答的语料内容",
                    "answer": "回答的答案是"
                },
                {
                    "pageNumber": 这里是第几页,
                    "referenceSentence": "这里是根据哪句话回答的语料内容。",
                    "answer": "回答的答案是"
                },
                {
                    "pageNumber": 这里是第几页,
                    "referenceSentence": "这里是根据哪句话回答的语料内容。",
                    "answer": "回答的答案是"
                }
            ]
            """;


}
