package org.zang.service.user;

import java.util.List;

import org.zang.convention.result.Result;
import org.zang.dto.req.user.UserLoginReqDTO;
import org.zang.dto.req.user.UserRegisterReqDTO;

import cn.dev33.satoken.stp.SaTokenInfo;
import org.zang.dto.req.user.UserUpdatePasswordReqDTO;
import org.zang.dto.resp.user.UserInfoRespDTO;

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

    /**
     * 用户注册
     */
    Result<Void> register(UserRegisterReqDTO registerReqDTO);

    /**
     * 判断用户名是否存在
     */
    Boolean hasUsername(String userName);

    Result<Void> updatePassword(UserUpdatePasswordReqDTO userUpdatePasswordReqDTO);

    /*
    * 用户登出
    */
    Boolean logout();

    /**
     * 获取用户当前的角色
     */
    List<String> getRole(Long userId);

    /**
     * 获取用户信息
     * @param loginIdAsLong 用户ID
     * @return 用户信息
     */
    Result<UserInfoRespDTO> userInfo(long loginIdAsLong);
}
