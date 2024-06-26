package org.zang.controller;

import org.dromara.streamquery.stream.plugin.mybatisplus.Database;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zang.mybatis.core.convention.result.Result;
import org.zang.mybatis.core.convention.result.Results;
import org.zang.pojo.sys.SysUserDO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */

@RestController
@RequestMapping("/user")
@Slf4j
@RequiredArgsConstructor
public class UserController {


    @PostMapping("/save")
    public Result<SysUserDO> save(@RequestBody SysUserDO sysUserDO) {
        final boolean save = Database.save(sysUserDO);

        return Results.success(sysUserDO);
    }


}
