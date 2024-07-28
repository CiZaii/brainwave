package org.zang.config;

import java.io.File;

import org.dromara.hutool.core.util.SystemUtil;
import org.dromara.hutool.extra.management.OsInfo;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import cn.hutool.core.lang.Singleton;
import cn.hutool.core.util.StrUtil;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Component
public class TempPathConfig implements InitializingBean {
    @Value("${temp.path.windows}")
    private String windows;

    @Value("${temp.path.linux}")
    private String linux;

    @Value("${temp.path.macos}")
    private String macos;

    private static String windowsPath;
    private static String linuxPath;
    private static String macosPath;

    public static String currentPath() {
        String osName = Singleton.get(OsInfo.class).getName();
        String path;

        if (StrUtil.containsIgnoreCase(osName, "windows")) {
            path = windowsPath;
        } else if (StrUtil.containsIgnoreCase(osName, "linux")) {
            path = linuxPath;
        } else {
            path = macosPath;
        }

        // Ensure the directory exists
        File directory = new File(path);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (!created) {
                throw new RuntimeException("Failed to create directory: " + path);
            }
        }

        return path;
    }

    public static String currentArchivePath() {
        return currentPath() + File.separator + "archive";
    }

    public static String currentBatchPath() {
        return currentPath() + File.separator + "batch";
    }

    public static String getWindowsPath() {
        return windowsPath;
    }

    public static void setWindowsPath(String windowsPath) {
        TempPathConfig.windowsPath = windowsPath;
    }

    public static String getLinuxPath() {
        return linuxPath;
    }

    public static void setLinuxPath(String linuxPath) {
        TempPathConfig.linuxPath = linuxPath;
    }

    public static String getMacosPath() {
        return macosPath;
    }

    public static void setMacosPath(String macosPath) {
        TempPathConfig.macosPath = macosPath;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        windowsPath = windows;
        linuxPath = linux;
        macosPath = macos;
    }
}

