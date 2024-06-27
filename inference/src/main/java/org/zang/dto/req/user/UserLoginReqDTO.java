package org.zang.dto.req.user;

import cn.dev33.satoken.stp.SaLoginModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserLoginReqDTO {

    private String userName;

    private String passWord;

    private SaLoginModel saLoginModel;
}
