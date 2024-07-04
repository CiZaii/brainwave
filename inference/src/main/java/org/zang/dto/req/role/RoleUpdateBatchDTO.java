package org.zang.dto.req.role;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zang.pojo.sys.SysRoleDO;

import java.util.List;

/**
 * brain-wave
 * 2024/7/4 12:55
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@AutoMapper(target = SysRoleDO.class)
public class RoleUpdateBatchDTO {

    private String roleName;
    private List<String> roleKeys;

}
