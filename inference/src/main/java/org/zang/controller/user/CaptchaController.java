package org.zang.controller.user;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zang.convention.result.Result;
import org.zang.dto.req.user.ImageCaptchaReqDTO;
import org.zang.service.user.CaptchaService;

import cloud.tianai.captcha.spring.vo.CaptchaResponse;
import cloud.tianai.captcha.spring.vo.ImageCaptchaVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/27 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */

@RestController
@RequestMapping("/captcha")
@Slf4j
@RequiredArgsConstructor
public class CaptchaController {

    private final CaptchaService captchaService;

    @RequestMapping("/gen")
    @ResponseBody
    public Result<CaptchaResponse<ImageCaptchaVO>> genCaptcha(@RequestParam(value = "type", required = false)String type) {
        return captchaService.genCaptcha(type);
    }

    @PostMapping("/check")
    @ResponseBody
    public Result<?> checkCaptcha(@RequestBody ImageCaptchaReqDTO imageCaptchaReqDTO) {
        return captchaService.checkCaptcha(imageCaptchaReqDTO);
    }


}
