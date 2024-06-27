package org.zang.service.serviceImpl;

import java.util.Collections;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.commons.lang3.StringUtils;
import org.dromara.hutool.core.convert.Convert;
import org.springframework.stereotype.Service;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.dto.req.ImageCaptchaReqDTO;
import org.zang.service.user.CaptchaService;

import cloud.tianai.captcha.common.constant.CaptchaTypeConstant;
import cloud.tianai.captcha.common.response.ApiResponse;
import cloud.tianai.captcha.spring.application.ImageCaptchaApplication;
import cloud.tianai.captcha.spring.vo.CaptchaResponse;
import cloud.tianai.captcha.spring.vo.ImageCaptchaVO;
import lombok.RequiredArgsConstructor;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
@RequiredArgsConstructor
public class CaptchaServiceImpl implements CaptchaService {

    private final ImageCaptchaApplication imageCaptchaApplication;
    @Override
    public Result<CaptchaResponse<ImageCaptchaVO>> genCaptcha(String type) {
        if (StringUtils.isBlank(type)) {
            type = CaptchaTypeConstant.WORD_IMAGE_CLICK;
        }
        return Results.success(imageCaptchaApplication.generateCaptcha(type));
    }

    @Override
    public Result<?> checkCaptcha(ImageCaptchaReqDTO imageCaptchaReqDTO) {
        ApiResponse<?> response = imageCaptchaApplication.matching(imageCaptchaReqDTO.getId(), imageCaptchaReqDTO.getData());
        if (response.isSuccess()) {
            return Results.success(Collections.singletonMap("id", imageCaptchaReqDTO.getId()));
        }
        return Result.builder().code(Convert.toStr(response.getCode())).data(response.getData()).message(response.getMsg()).build();
    }
}
