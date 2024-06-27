package org.zang.service.serviceImpl.user;

import static org.zang.convention.errorcode.BaseErrorCode.PASSWORD_VERIFY_ERROR;
import static org.zang.convention.errorcode.BaseErrorCode.USER_NAME_NULL;

import org.dromara.streamquery.stream.core.optional.Opp;
import org.dromara.streamquery.stream.plugin.mybatisplus.One;
import org.springframework.stereotype.Service;
import org.zang.convention.exception.ServiceException;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.user.UserLoginReqDTO;
import org.zang.pojo.sys.SysUserDO;
import org.zang.service.user.UserService;

import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import lombok.RequiredArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {

    @Override
    public Result<SaTokenInfo> login(UserLoginReqDTO userLoginReqDTO) {

        final String userName = userLoginReqDTO.getUserName();

        final SysUserDO sysUserDO = One.of(SysUserDO::getUserName).eq(userName).query();

        // 用户名不存在
        Opp.of(sysUserDO).orElseThrow(() -> new ServiceException(USER_NAME_NULL));
        // 密码验证
        if (!BCrypt.checkpw(userLoginReqDTO.getPassWord(), sysUserDO.getPassword())){
            throw new ServiceException(PASSWORD_VERIFY_ERROR);
        }

        StpUtil.login(sysUserDO.getUserId(),userLoginReqDTO.getSaLoginModel());

        final SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

        return Results.success(tokenInfo);

    }
}
