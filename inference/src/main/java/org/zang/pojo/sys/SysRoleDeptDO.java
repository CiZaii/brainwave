package org.zang.pojo.sys;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.zang.pojo.BaseDO;

/**
 * brain-wave
 * 2024/7/3 16:22
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("sys_role_dept")
public class SysRoleDeptDO extends BaseDO {

//    /**
//     *  角色ID
//     */
//    @TableId(value = "role_id")
    private Long roleId;

//    /**
//     *  部门ID
//     */
//    @TableId(value = "dept_id")
    private Long deptId;
}
