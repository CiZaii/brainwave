package org.zang.service.serviceImpl.user;

import static org.zang.convention.errorcode.BaseErrorCode.NEW_PASSWORD_EQUAL_ERROR;
import static org.zang.convention.errorcode.BaseErrorCode.NEW_PASSWORD_NULL_ERROR;
import static org.zang.convention.errorcode.BaseErrorCode.PASSWORD_VERIFY_ERROR;
import static org.zang.convention.errorcode.BaseErrorCode.USER_NAME_NULL;

import java.util.List;

import cn.dev33.satoken.util.SaResult;
import org.dromara.streamquery.stream.core.optional.Opp;
import org.dromara.streamquery.stream.plugin.mybatisplus.Database;
import org.dromara.streamquery.stream.plugin.mybatisplus.One;
import org.redisson.api.RBloomFilter;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.zang.convention.constant.RedisCacheConstant;
import org.zang.convention.enums.UserErrorCodeEnum;
import org.zang.convention.exception.ClientException;
import org.zang.convention.exception.ServiceException;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.user.UserLoginReqDTO;
import org.zang.dto.req.user.UserRegisterReqDTO;
import org.zang.dto.req.user.UserUpdatePasswordReqDTO;
import org.zang.pojo.sys.SysUserDO;
import org.zang.service.user.UserService;

import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService, RedisCacheConstant {

    private final RedissonClient redissonClient;

    private final Converter converter;

    private final RBloomFilter<String> userRegisterCachePenetrationBloomFilter;

    @Override
    public Result<SaTokenInfo> login(UserLoginReqDTO userLoginReqDTO) {

        final String userName = userLoginReqDTO.getUserName();

        final SysUserDO sysUserDO = One.of(SysUserDO::getUserName).eq(userName).query();

        // 用户名不存在
        Opp.of(sysUserDO).orElseThrow(() -> new ServiceException(USER_NAME_NULL));
        // 密码验证
        if (!BCrypt.checkpw(userLoginReqDTO.getPassWord(), sysUserDO.getPassWord())){
            throw new ServiceException(PASSWORD_VERIFY_ERROR);
        }

        StpUtil.login(sysUserDO.getUserId(),userLoginReqDTO.getSaLoginModel());

        final SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

        return Results.success(tokenInfo);

    }

    @Override
    public Result<Void> register(UserRegisterReqDTO registerReqDTO) {

        if (hasUsername(registerReqDTO.getUserName())) {
            throw new ClientException(UserErrorCodeEnum.USER_NAME_EXIST);
        }

        RLock lock = redissonClient.getLock(LOCK_USER_REGISTER_KEY + registerReqDTO.getUserName());

        if (!lock.tryLock()) {
            throw new ClientException(UserErrorCodeEnum.USER_NAME_EXIST);
        }

        try {
            final String passWord = BCrypt.hashpw(registerReqDTO.getPassWord());
            registerReqDTO.setPassWord(passWord);
            final boolean save = Database.save(converter.convert(registerReqDTO,SysUserDO.class));
            if ( !save ) {
                throw new ClientException(UserErrorCodeEnum.USER_SAVE_ERROR);
            }

            userRegisterCachePenetrationBloomFilter.add(registerReqDTO.getUserName());
        } catch (DuplicateKeyException ex) {
            throw new ClientException(UserErrorCodeEnum.USER_EXIST);
        } finally {
            lock.unlock();
        }

        return Results.success();
    }

    @Override
    public Boolean hasUsername(String userName) {

        return userRegisterCachePenetrationBloomFilter.contains(userName);
    }

    @Override
    public Result<Void> updatePassword(UserUpdatePasswordReqDTO userUpdatePasswordReqDTO) {
        // 用户不存在
        if (!hasUsername(userUpdatePasswordReqDTO.getUserName())){
            throw new ServiceException(USER_NAME_NULL);
        }

        Opp.ofStr(userUpdatePasswordReqDTO.getOldPassWord()).ifPresent(newPassword -> {
            final String olePassWord = One.of(SysUserDO::getUserId).eq(StpUtil.getLoginIdAsLong()).value(SysUserDO::getPassWord).query();
            if (!BCrypt.checkpw(userUpdatePasswordReqDTO.getOldPassWord(), olePassWord)) {
                throw new ServiceException(NEW_PASSWORD_EQUAL_ERROR);
            }
        }).orElseThrow(() -> new ServiceException(NEW_PASSWORD_NULL_ERROR));
        // 更新密码
        final String newPassWord = BCrypt.hashpw(userUpdatePasswordReqDTO.getNewPassword());
        userUpdatePasswordReqDTO.setNewPassword(newPassWord);
        userUpdatePasswordReqDTO.setUserId(StpUtil.getLoginIdAsLong());
        final boolean save = Database.updateById(converter.convert(userUpdatePasswordReqDTO,SysUserDO.class));
        if (!save) {
            throw  new ClientException(UserErrorCodeEnum.USER_SAVE_ERROR);
        }

        return Results.success();
    }

    @Override
    public Boolean logout() {
        try {
            StpUtil.logout();
            return true;
        } catch (Exception e) {
//
            return false;
        }
    }

    /**
     * 获取用户当前的角色
     */
    @Override
    public List<String> getRole() {
        return List.of();
    }
}
