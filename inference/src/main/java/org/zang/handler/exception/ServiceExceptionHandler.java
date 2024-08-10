package org.zang.handler.exception;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.zang.convention.exception.ServiceException;
import org.zang.convention.result.Result;
import org.zang.convention.result.Results;
import org.zang.service.serviceImpl.file.FileUpServiceImpl;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@RestControllerAdvice
@Slf4j
public class ServiceExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> validationException(MethodArgumentNotValidException e) {
        BindingResult bindingResult = e.getBindingResult();
        if (bindingResult.hasErrors()) {
            List<ObjectError> allErrors = bindingResult.getAllErrors();
            List<String> messages = new ArrayList<>();
            allErrors.forEach(p->{
                FieldError fieldError = (FieldError) p;
                log.error("参数格式错误：参数对象：{}；字段：{}；错误原因:{}", fieldError.getObjectName(), fieldError.getField(), fieldError.getDefaultMessage());
                messages.add(fieldError.getDefaultMessage());
            });
            final String join = StringUtils.join(messages, ",");
            return Results.failure(new ServiceException(join));
        }
        return Results.failure(new ServiceException("参数格式错误"));
    }

    @ExceptionHandler(ServiceException.class)
    public Result<Void> serviceException(ServiceException e) {
        log.error(e.getMessage(), e);
        return Results.failure(e);
    }


}
