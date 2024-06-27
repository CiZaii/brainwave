package org.zang.service.user;

import org.zang.convention.result.Result;
import org.zang.dto.req.user.UserLoginReqDTO;

import cn.dev33.satoken.stp.SaTokenInfo;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface UserService {

    /**
     * 用户登录
     */
    Result<SaTokenInfo> login(UserLoginReqDTO userLoginReqDTO);

}
