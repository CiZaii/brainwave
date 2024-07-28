package org.zang.controller.file;

import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.zang.convention.result.Result;
import org.zang.service.file.FileUpService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 文件管理
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */

@RestController
@RequestMapping("/file")
@Slf4j
@RequiredArgsConstructor
public class FileUpController {




    private final FileUpService fileUpService;

    /**
     * 上传文件
     */
    @PostMapping("/uploadDocumentation")
    public Result<Void> upload(@RequestParam("documentation") MultipartFile file) {
        return fileUpService.upload(file);
    }

}
