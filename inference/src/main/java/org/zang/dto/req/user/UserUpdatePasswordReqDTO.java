package org.zang.dto.req.user;

import org.zang.pojo.sys.SysUserDO;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Ben
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@AutoMapper(target = SysUserDO.class)
public class UserUpdatePasswordReqDTO {

    private Long userId;

    private String userName;

    private String oldPassWord;

    private String newPassword;
}
