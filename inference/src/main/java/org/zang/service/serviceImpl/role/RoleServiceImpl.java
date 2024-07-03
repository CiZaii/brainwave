package org.zang.service.serviceImpl.role;

import org.zang.convention.result.Result;
import org.zang.dto.req.role.RoleAddReqDTO;
import org.zang.dto.req.role.RoleInfoDTO;
import org.zang.dto.req.role.RoleUpdateReqDTO;
import org.zang.dto.req.role.RoleUserReqDTO;
import org.zang.service.role.RoleService;

import java.util.List;

/**
 * brain-wave
 * 2024/7/3 16:51
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class RoleServiceImpl implements RoleService {
    @Override
    public Result<Void> addRole(RoleAddReqDTO roleAddReqDTO) {
        return null;
    }

    @Override
    public Result<Void> deleteRole(Long roleId) {
        return null;
    }

    @Override
    public Result<Void> updateRole(RoleUpdateReqDTO roleUpdateReqDTO) {
        return null;
    }

    @Override
    public Result<RoleInfoDTO> getRoleInfo(Long roleId) {
        return null;
    }



    @Override
    public Result<Void> assignRoleToUser(RoleUserReqDTO roleUserReqDTO) {
        return null;
    }

    @Override
    public Result<Void> removeRoleFromUser(RoleUserReqDTO roleUserReqDTO) {
        return null;
    }
}
