package org.zang.service.role;

import cn.dev33.satoken.stp.SaTokenInfo;
import org.zang.convention.result.Result;
import org.zang.dto.req.role.RoleAddReqDTO;
import org.zang.dto.req.role.RoleInfoDTO;
import org.zang.dto.req.role.RoleUpdateReqDTO;
import org.zang.dto.req.role.RoleUserReqDTO;
import org.zang.dto.req.user.UserLoginReqDTO;

import java.util.List;

/**
 * brain-wave
 * 2024/7/3 16:51
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public interface RoleService {

    // 角色管理
    Result<Void> addRole(RoleAddReqDTO roleAddReqDTO);

    Result<Void> deleteRole(Long roleId);

    Result<Void> updateRole(RoleUpdateReqDTO roleUpdateReqDTO);

    Result<RoleInfoDTO> getRoleInfo(Long roleId);


    // 角色-用户关联
    Result<Void> assignRoleToUser(RoleUserReqDTO roleUserReqDTO);

    Result<Void> removeRoleFromUser(RoleUserReqDTO roleUserReqDTO);


}
