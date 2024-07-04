package org.zang.service.serviceImpl.role;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;
import org.dromara.streamquery.stream.core.optional.Opp;
import org.dromara.streamquery.stream.plugin.mybatisplus.Database;
import org.dromara.streamquery.stream.plugin.mybatisplus.One;
import org.redisson.api.RBloomFilter;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.zang.convention.enums.UserErrorCodeEnum;
import org.zang.convention.exception.ClientException;
import org.zang.convention.exception.ServiceException;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.role.*;
import org.zang.pojo.sys.SysRoleDO;

import org.zang.service.role.RoleService;

import java.util.Collections;


import static org.zang.convention.constant.RedisCacheConstant.LOCK_ROLE_ADD_KEY;
import static org.zang.convention.errorcode.BaseErrorCode.USER_NAME_NULL;

/**
 * brain-wave
 * 2024/7/3 16:51
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@RequiredArgsConstructor
@Service
public class RoleServiceImpl implements RoleService {

    private final RedissonClient redissonClient;

    private final Converter converter;

    private final RBloomFilter<String> roleRegisterCachePenetrationBloomFilter;


    @Override
    public Result<Void> addRole(RoleAddReqDTO roleAddReqDTO) {
        if(hasRoleName(roleAddReqDTO.getRoleName())){
            // TODO:这里是不是应该加一个 Role 相关的 BaseErrorCode，我这里沿用了 User 的，不太敢在代码结构上作修改
            throw new ClientException(UserErrorCodeEnum.USER_NAME_EXIST);
        }
        RLock lock = redissonClient.getLock(LOCK_ROLE_ADD_KEY+roleAddReqDTO.getRoleName());
        if(!lock.tryLock()){
            throw new ClientException(UserErrorCodeEnum.USER_NAME_EXIST);
        }
        try {

            final boolean save = Database.save(converter.convert(roleAddReqDTO, SysRoleDO.class));
            if (!save) {
                throw new ClientException(UserErrorCodeEnum.USER_SAVE_ERROR);
            }
            roleRegisterCachePenetrationBloomFilter.add(roleAddReqDTO.getRoleName());
        }catch (DuplicateKeyException ex){
            throw new ClientException(UserErrorCodeEnum.USER_NAME_EXIST);
        }finally {
            lock.unlock();
        }

        return Results.success();
    }

    @Override
    public Boolean hasRoleName(String roleName) {
            //改成从数据库里查
        return Opp.of(One.of(SysRoleDO::getRoleName).eq(roleName).query()).isEmpty();

    }

    @Override
    public Result<Void> deleteRole(Long roleId) {
        final SysRoleDO sysRoleDO = One.of(SysRoleDO::getRoleId).eq(roleId).query();
        Opp.of(sysRoleDO).orElseThrow(()->new ServiceException(USER_NAME_NULL));
        try {
            // TODO 这个我不是很会用
            boolean deleteSuccess = Database.removeById(sysRoleDO);
            if (!deleteSuccess) {
                // TODO 这里我尝试往UserErrorCodeEnum增加一个 USER_DELETE_ERROR 的状态码
                throw new ClientException(UserErrorCodeEnum.USER_DELETE_ERROT);
            }
        }catch (Exception e){
            throw new ClientException(UserErrorCodeEnum.USER_DELETE_ERROT);
        }
        return Results.success();
    }

    @Override
    public Result<Void> updateRole(RoleUpdateReqDTO roleUpdateReqDTO) {
        final SysRoleDO sysRoleDO = One.of(SysRoleDO::getRoleId).eq(roleUpdateReqDTO.getRoleId()).query();
        Opp.of(sysRoleDO).orElseThrow(()-> new ServiceException(USER_NAME_NULL));

        try {
            sysRoleDO.setRoleName(roleUpdateReqDTO.getRoleName());
            sysRoleDO.setRoleKey(roleUpdateReqDTO.getRoleKey());

            boolean updateSuccess = Database.update(sysRoleDO, Wrappers.lambdaQuery(SysRoleDO.class).eq(SysRoleDO::getRoleId, roleUpdateReqDTO.getRoleId()));
            if(!updateSuccess){
                throw new ClientException(UserErrorCodeEnum.USER_UPDATE_ERROR);
            }
        }catch (Exception e){
            throw new ClientException(UserErrorCodeEnum.USER_UPDATE_ERROR);
        }

        return Results.success();
    }

    @Override
    public Result<Void> updateRole(RoleUpdateBatchDTO roleUpdateBatchDTO) {
        // 先把这个名字下的所有行删除，我想不到更好的办法作比对修改
        boolean remove = Database.removeByMap(Collections.singletonMap("role_name",roleUpdateBatchDTO.getRoleName()),RoleUpdateBatchDTO.class);
        if (!remove) {
            throw new ServiceException(USER_NAME_NULL);
        }
        try{
            for (String roleKey : roleUpdateBatchDTO.getRoleKeys()) {
                // TODO: 这里是往 DB 里插入一个行数据，一个权限就新增一行数据
                // TODO：这里插入的时候 convert 里面我用了RoleAddReqDTO，用他关联了SysRoleDO，
                //  这里的 role_id 我是随便填的，不知道这样行不行，我看佬你User 那里的 DTO 都没有@TableId这个注解，然后我这里也没加
                final boolean save = Database.save(converter.convert(new RoleAddReqDTO(0, roleUpdateBatchDTO.getRoleName(), roleKey), SysRoleDO.class));
                if ( !save ) {
                    throw new ClientException(UserErrorCodeEnum.USER_SAVE_ERROR);
                }
            }
        }catch (Exception e){
            throw new ClientException(UserErrorCodeEnum.USER_UPDATE_ERROR);
        }

        return Results.success();
    }

    @Override
    public Result<RoleInfoDTO> getRoleInfo(Long roleId) {
        final SysRoleDO sysRoleDO = One.of(SysRoleDO::getRoleId).eq(roleId).query();
        Opp.of(sysRoleDO).orElseThrow(()-> new ServiceException(USER_NAME_NULL));

        RoleInfoDTO roleInfoDTO = converter.convert(sysRoleDO, RoleInfoDTO.class);
        return Results.success(roleInfoDTO);
    }



    @Override
    public Result<Void> assignRoleToUser(RoleUserReqDTO roleUserReqDTO) {
        //TODO 这两个连表的我不太会写

        return null;
    }

    @Override
    public Result<Void> removeRoleFromUser(RoleUserReqDTO roleUserReqDTO) {
        return null;
    }
}
