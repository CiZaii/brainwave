package org.zang.aisdk.dto.req;


import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/8 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@NoArgsConstructor
@Data
@AllArgsConstructor
@Builder
public class MessagesDTO implements Serializable {


    private static final long serialVersionUID = -99290914154445688L;
    /**
     * 角色
     */
    private String role;

    /**
     * 内容
     */
    private String content;


    private String name;
}
