package org.zang.dto.resp.ie;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 关系
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class IeInferRelationDTO {

    /**
     * 起始坐标
     */
    private String start;

    /**
     * 结束坐标
     */
    private String end;

    /**
     * 关系
     */
    private String relation;

}
