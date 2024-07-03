package org.zang.dto.req.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * author:Ben
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserUpdatePasswordReqDTO {
    private String userName;

    private String oldPassWord;

    private String newPassword;
}
