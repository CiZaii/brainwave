package org.zang.dto.req.user;

import org.zang.pojo.sys.SysUserDO;

import cn.dev33.satoken.stp.SaLoginModel;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户登录请求数据
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@AutoMapper(target = SysUserDO.class)

public class UserLoginReqDTO {

    private String userName;

    private String passWord;

    private SaLoginModel saLoginModel;
}
