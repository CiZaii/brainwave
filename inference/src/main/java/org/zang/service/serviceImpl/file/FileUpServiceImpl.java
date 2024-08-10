package org.zang.service.serviceImpl.file;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dromara.streamquery.stream.core.stream.Steam;
import org.dromara.streamquery.stream.plugin.mybatisplus.Database;
import org.dromara.streamquery.stream.plugin.mybatisplus.Many;
import org.dromara.streamquery.stream.plugin.mybatisplus.One;
import org.dromara.x.file.storage.core.FileInfo;
import org.dromara.x.file.storage.core.FileStorageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zang.analysis.PDF2String;
import org.zang.config.TempPathConfig;
import org.zang.convention.constant.FileInitializeStatus;
import org.zang.convention.exception.ServiceException;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.resp.file.FileDetailVO;
import org.zang.layercheck.PDFLayerChecker;
import org.zang.pojo.file.DocumentUnitDO;
import org.zang.pojo.file.FileDetailDO;
import org.zang.service.file.FileUpService;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
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

    private static final Log log = LogFactory.getLog(FileUpServiceImpl.class);
    private final FileStorageService fileStorageService;

    private final PDF2String pdf2String;

    private final Converter converter;


    @Override
    @Transactional
    public Result<Void> upload(MultipartFile file) {

        isDocument(file);

        final FileInfo upload = fileStorageService.of(file).upload();

        initDocument(upload.getId());

        return Results.success();
    }

    @Override
    public Result<String> readPdf(String documentId) {

        final File documentFile = getDocumentFile(documentId);

        if(!PDFLayerChecker.isSingleLayerPDF(documentFile)) {
            throw new ServiceException("当前文件不是单层PDF，无法读取内容");
        }

        final String pdfContent = pdf2String.readPdf(documentFile);

        return Results.success(pdfContent);

    }

    @Override
    @Transactional
    public Result<Void> initDocument(String documentId) {
        if (isInitialize(documentId)) {
            // 后续拦截异常然后  Results.failure()
            throw new ServiceException("当前文件已经初始化无需再次初始化！！！");
        }

        List<String> contentUnit = List.of();
        try {
            contentUnit = pdf2String.readDocument(getDocumentFile(documentId));
        } catch (Exception e) {

            final FileDetailDO fileDetailDO = One.of(FileDetailDO::getId).eq(documentId).query();
            fileDetailDO.setIsInitialize(FileInitializeStatus.INITIALIZATION_FAILED);
            Database.updateById(fileDetailDO);

        }

        final ArrayList<DocumentUnitDO> documentUnitDoS = new ArrayList<>();

        Steam.of(contentUnit).forEachOrderedIdx((content, page) -> {
            final DocumentUnitDO documentUnitDO = new DocumentUnitDO();

            documentUnitDO.setPage(page);
            documentUnitDO.setContent(content);
            documentUnitDO.setFileDetailId(documentId);
            documentUnitDoS.add(documentUnitDO);
        });

        final boolean save = Database.saveBatch(documentUnitDoS);

        if (save) {
            final FileDetailDO fileDetailDO = One.of(FileDetailDO::getId).eq(documentId).query();
            fileDetailDO.setIsInitialize(FileInitializeStatus.INITIALIZED);
            Database.updateById(fileDetailDO);
        }

        return Results.success();
    }

    @Override
    @Transactional
    public Result<Void> deleteByDocumentId(String documentId) {

        final FileDetailDO fileDetailDO = One.of(FileDetailDO::getId).eq(documentId).query();

        final boolean isDelete = fileStorageService.delete(fileDetailDO.getUrl());

        if (isDelete && ObjectUtil.equals(fileDetailDO.getIsInitialize(),FileInitializeStatus.INITIALIZED)) {
            log.info("当前文件已初始化，开始删除文档数据");
            Database.remove(Wrappers.lambdaQuery(DocumentUnitDO.class).eq(DocumentUnitDO::getFileDetailId, documentId));
        }
        return Results.success();
    }

    @Override
    public Result<List<FileDetailVO>> listFileByUser() {

        final boolean isLogin = StpUtil.isLogin();

        if (!isLogin) {
            throw new ServiceException("当前用户暂未登录,无法获取文件信息");
        }

       return Results.success(Many.of(FileDetailDO::getUserId).eq(StpUtil.getLoginIdAsLong()).value(data -> converter.convert(data,FileDetailVO.class)).query());

    }

    private void isDocument(MultipartFile file) {

        // 判断文件后缀只能上传pdf和word
        if (!Objects.requireNonNull(file.getOriginalFilename()).endsWith(".pdf") && !file.getOriginalFilename().endsWith(".doc") && !file.getOriginalFilename().endsWith(".docx")) {
            throw new ServiceException("文件必须为pdf和word格式");
        }
    }

    /**
     * 判断当前文档是否初始化
     * @param documentId 文档ID
     * @return 当前初始化状态
     */
    @Override
    public boolean isInitialize(String documentId) {

        return ObjectUtil.equals(One.of(FileDetailDO::getId).eq(documentId).value(FileDetailDO::getIsInitialize).query(), FileInitializeStatus.INITIALIZED);
    }

    private File getDocumentFile(String documentId) {
        final String s = TempPathConfig.currentPath();

        final FileDetailDO fileDetailDO = One.of(FileDetailDO::getId).eq(documentId)
                // todo 后续要加当前登录用户
                .query();

        FileInfo fileInfo = fileStorageService.getFileInfoByUrl(fileDetailDO.getUrl());

        fileStorageService.download(fileInfo).setProgressListener((progressSize,allSize) ->
                System.out.println(STR."已下载 \{progressSize} 总大小\{allSize}")
        ).file(STR."\{s}/\{fileDetailDO.getFilename()}");

        return new File(STR."\{s}/\{fileDetailDO.getFilename()}");
    }

}
