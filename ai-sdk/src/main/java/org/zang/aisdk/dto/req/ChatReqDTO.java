package org.zang.aisdk.dto.req;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/8 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatReqDTO {

    /**
     * 模型
     */
    private String model;

    /**
     * 是否流式  默认为是
     */
    private Boolean stream = Boolean.TRUE;
}
