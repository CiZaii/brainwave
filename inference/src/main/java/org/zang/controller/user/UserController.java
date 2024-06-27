package org.zang.controller.user;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zang.convention.result.Result;
import org.zang.dto.req.user.UserLoginReqDTO;
import org.zang.service.user.UserService;

import cn.dev33.satoken.stp.SaTokenInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */

@RestController
@RequestMapping("/user")
@Slf4j
@RequiredArgsConstructor
public class UserController {

    private UserService userService;

    @PostMapping("/login")
    public Result<SaTokenInfo> login (@RequestBody UserLoginReqDTO userLoginReqDTO) {

        return userService.login(userLoginReqDTO);
    }





}
