package org.zang.config.security;

import cn.dev33.satoken.interceptor.SaInterceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * brain-wave
 * 2024/7/3 16:22
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
@Configuration
public class SecurityConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new SaInterceptor(handle-> {
            // 登录校验 -- 拦截所有路由，并排除/user/doLogin 用于开放登录

            //SaRouter.match("/**", "/user/register", r -> StpUtil.checkLogin());
            // 角色校验 -- 拦截以 admin 开头的路由，必须具备 admin 角色或者 super-admin 角色才可以通过认证
            //SaRouter.match("/admin/**", r -> StpUtil.checkRoleOr("admin", "super-admin"));
        })).addPathPatterns("/**");
    }
}
