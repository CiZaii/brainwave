package org.zang.dto.req.role;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zang.pojo.sys.SysRoleDO;
import org.zang.pojo.sys.SysUserRoleDO;

/**
 * 关联用户和角色
 * brain-wave
 * 2024/7/3 17:03
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@AutoMapper(target = SysUserRoleDO.class)
public class RoleUserReqDTO {
    private Long roleId;
    private Long userId;
}
