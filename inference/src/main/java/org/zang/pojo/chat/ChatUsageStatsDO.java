package org.zang.pojo.chat;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

import org.jetbrains.annotations.NotNull;
import org.zang.pojo.BaseDO;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 用户使用统计
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("chat_usage_stats")

public class ChatUsageStatsDO extends BaseDO implements Serializable {


    @Serial
    private static final long serialVersionUID = -905150697107677518L;

    /**
     * 统计ID，主键
     */

    private Integer statId;
    /**
     * 用户ID，关联sys_user表
     */
    private Integer userId;
    /**
     * 统计日期
     */

    private Date date;
    /**
     * 使用的AI模型名称
     */
    private String model;
    /**
     * 当日该模型总对话数
     */
    private Integer totalConversations;
    /**
     * 当日该模型总消息数
     */
    private Integer totalMessages;
    /**
     * 当日该模型总消耗token数
     */
    private Integer totalTokens;
    /**
     * 当日该模型总响应时间，单位秒
     */
    private Double totalResponseTime;
}
