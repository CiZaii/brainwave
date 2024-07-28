package org.zang.pojo.file;

import org.zang.pojo.BaseDO;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@TableName("document_unit")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DocumentUnitDO extends BaseDO {

    /**
     * 文件id
     */
    private String id;

    /**
     * 文档ID
     */
    private String fileDetailId;

    /**
     * 页码
     */
    private Integer page;

    /**
     * 当前页内容
     */
    private String content;
}
