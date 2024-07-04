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
    private Long tenantId;

    /**
     *  角色名称
     */
    private String roleName;

    /**
     *  角色权限字符串
     */
    private String roleKey;

    /**
     * 权限描述
     */
    private String keyDesc;


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
