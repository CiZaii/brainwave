package org.zang.dto.req.role;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zang.pojo.sys.SysRoleDO;
import org.zang.pojo.sys.SysUserDO;

/**
 * 增添权限
 * brain-wave
 * 2024/7/3 17:00
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@AutoMapper(target = SysRoleDO.class)
public class RoleAddReqDTO {

    private int roleId;
    private String roleName;
    private String roleKey;
}
