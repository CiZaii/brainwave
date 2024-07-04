package org.zang.convention.exception;

import org.zang.convention.errorcode.BaseErrorCode;
import org.zang.convention.errorcode.IErrorCode;

/**
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
public class ChatException  extends AbstractException{

    public ChatException(IErrorCode errorCode) {
        this(null, null, errorCode);
    }

    public ChatException(String message) {
        this(message, null, BaseErrorCode.CHAT_ERROR);
    }

    public ChatException(String message, IErrorCode errorCode) {
        this(message, null, errorCode);
    }


    public ChatException(String message, Throwable throwable, IErrorCode errorCode) {
        super(message, throwable, errorCode);
    }

    @Override
    public String toString() {
        return "ChatException{" +
                "code='" + errorCode + "'," +
                "message='" + errorMessage + "'" +
                '}';
    }
}
