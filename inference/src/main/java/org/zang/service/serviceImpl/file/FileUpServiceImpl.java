package org.zang.service.serviceImpl.file;

import org.dromara.streamquery.stream.plugin.mybatisplus.Database;
import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.FileStorageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.pojo.file.FileDetailDO;
import org.zang.service.file.FileUpService;

import cn.dev33.satoken.stp.StpUtil;
import io.github.linpeilie.Converter;
import lombok.RequiredArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
@RequiredArgsConstructor
public class FileUpServiceImpl implements FileUpService {

    private final FileStorageService fileStorageService;


    @Override
    public Result<Void> upload(MultipartFile file) {

        final FileInfo upload = fileStorageService.of(file).upload();

        Database.save(createFileDO(upload));

        return Results.success();
    }

    private FileDetailDO createFileDO(FileInfo fileInfo) {
        final FileDetailDO fileDetailDO = new FileDetailDO();

        fileDetailDO.setUrl(fileInfo.getUrl());
        fileDetailDO.setSize(fileInfo.getSize());
        fileDetailDO.setFilename(fileInfo.getFilename());
        fileDetailDO.setOriginalFilename(fileInfo.getOriginalFilename());
        fileDetailDO.setBasePath(fileInfo.getBasePath());
        fileDetailDO.setPath(fileInfo.getPath());
        fileDetailDO.setExt(fileInfo.getExt());
        fileDetailDO.setContentType(fileInfo.getThContentType());
        fileDetailDO.setPlatform(fileInfo.getPlatform());
        //fileDetailDO.setUserId(StpUtil.getLoginIdAsLong());

        return fileDetailDO;
    }
}
