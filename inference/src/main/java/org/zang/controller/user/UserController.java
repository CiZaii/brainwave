package org.zang.controller.user;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zang.convention.errorcode.BaseErrorCode;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.user.UserLoginReqDTO;
import org.zang.dto.req.user.UserRegisterReqDTO;
import org.zang.dto.req.user.UserUpdatePasswordReqDTO;
import org.zang.service.user.UserService;

import cn.dev33.satoken.stp.SaTokenInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


/**
 * 用户
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */

@RestController
@RequestMapping("/user")
@Slf4j
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/login")
    public Result<SaTokenInfo> login (@RequestBody UserLoginReqDTO userLoginReqDTO) {

        return userService.login(userLoginReqDTO);
    }

    @PostMapping("/register")
    public Result<Void> register (@RequestBody UserRegisterReqDTO registerReqDTO) {

        return userService.register(registerReqDTO);
    }

    @GetMapping("/has-username")
    public Result<Boolean> hasUsername(@RequestParam("userName") String userName) {
        return Results.success(userService.hasUsername(userName));
    }

    @GetMapping("/logout")
    public Result<Void> logout () {
        Boolean result = userService.logout();
        if (result) {
            return Results.success();
        } else {
            // TODO 这里没有登出失败的 Error_code，我用了CLIENT_ERROR
            return Results.failure(String.valueOf(BaseErrorCode.CLIENT_ERROR), "用户登出失败");
        }
    }

    @PostMapping("/update-password")
    public Result<Void> updatePassword(@RequestBody UserUpdatePasswordReqDTO userUpdatePasswordReqDTO) {
        return userService.updatePassword(userUpdatePasswordReqDTO);
    }




}
