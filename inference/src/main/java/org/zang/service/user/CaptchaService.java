package org.zang.service.user;

import org.zang.convention.result.Result;
import org.zang.dto.req.user.ImageCaptchaReqDTO;

import cloud.tianai.captcha.spring.vo.CaptchaResponse;
import cloud.tianai.captcha.spring.vo.ImageCaptchaVO;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public interface CaptchaService {

    /**
     * 生成验证码
     * @param type 验证码类型
     * @return 验证码
     */
    Result<CaptchaResponse<ImageCaptchaVO>> genCaptcha(String type);

    /**
     * 验证验证码
     * @param imageCaptchaReqDTO 验证码参数
     * @return 是否验证成功
     */
    Result<?> checkCaptcha(ImageCaptchaReqDTO imageCaptchaReqDTO);
}
