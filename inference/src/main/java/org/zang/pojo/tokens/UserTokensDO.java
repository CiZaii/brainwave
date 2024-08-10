package org.zang.pojo.tokens;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zang.pojo.BaseDO;

/**
 * 用户token表
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@TableName("user_tokens")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserTokensDO extends BaseDO {

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户当前拥有的token数量
     */
    private Long tokenAmount;

    /**
     * 用户总共获得过的token数量
     */
    private Long totalTokenAmount;
}
