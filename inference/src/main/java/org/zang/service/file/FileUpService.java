package org.zang.service.file;

import org.springframework.web.multipart.MultipartFile;
import org.zang.convention.result.Result;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface FileUpService {

    Result<Void> upload(MultipartFile file);
}
