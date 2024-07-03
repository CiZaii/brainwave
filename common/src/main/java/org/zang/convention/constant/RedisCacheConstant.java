package org.zang.convention.constant;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface RedisCacheConstant {

    /**
     * 用户注册分布式锁
     */
    String LOCK_USER_REGISTER_KEY = "short-link:lock_user-register:";

    /**
     * 用户登录缓存标识
     */
    String USER_LOGIN_KEY = "short-link:login:";

    /**
     * 角色权限添加
     */
    String LOCK_ROLE_ADD_KEY = "short-link:lock_role_add";
}