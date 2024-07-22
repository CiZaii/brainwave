package org.zang.dto.resp.ie;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 实体
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class IeInferItemDTO {

    /**
     * 元数据
     */
    private String schema;

    /**
     * 文本
     */
    private String text;

    /**
     * 开始位置
     */
    private String start;

    /**
     * 结束坐标
     */
    private String end;

    /**
     * 类型
     * @see org.zang.constant.IeType
     */
    private String type;

    /**
     * 唯一UUID
     */
    private String uuid;


}
