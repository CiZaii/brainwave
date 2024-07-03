package org.zang.pojo.sys;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.zang.pojo.BaseDO;

import java.util.Date;

/**
 * brain-wave
 * 2024/7/3 16:22
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("sys_role")
public class SysRoleDO extends BaseDO {
    /**
     *  租户编号
     */
    @TableId(value = "role_id")
    private Long roleId;

    /**
     *  租户编号
     */
    private String tenantId;

    /**
     *  角色名称
     */
    private String roleName;

    /**
     *  角色权限字符串
     */
    private String roleKey;

    /**
     *  显示顺序
     */
    private Long roleSort;

    /**
     *  数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）
     */
    private String dataScope;

    /**
     *  菜单树选择项是否关联显示
     */
    private boolean menuCheckStr;

    /**
     *  部门树选择项是否关联显示
     */
    private boolean deptCheckStri;

    /**
     *  角色状态（0 正常 1 停用）
     */
    private String status;

    /**
     *  删除标志（0 代表存在 2 代表删除）
     */
    private String delFlag;

    /**
     *  创建部门
     */
    private Long createDept;

    /**
     *  创建者
     */
    private Long createBy;


    /**
     *  更新者
     */
    private Long updateBy;


    /**
     *  备注
     */
    private String remark;

}
