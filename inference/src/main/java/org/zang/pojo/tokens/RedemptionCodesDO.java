package org.zang.pojo.tokens;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zang.pojo.BaseDO;

/**
 * 兑换码表
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@TableName("redemption_codes")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RedemptionCodesDO extends BaseDO {

    /**
     * 兑换码
     */
    private String code;

    /**
     * 兑换码对应的token数量
     */
    private Long tokenAmount;

    /**
     * 兑换码是否已被兑换
     */
    private Boolean isRedeemed = Boolean.FALSE;

}
