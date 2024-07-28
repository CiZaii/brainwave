package org.zang.pojo.chat;

import java.io.Serial;
import java.io.Serializable;

import org.zang.pojo.BaseDO;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 对话消息表
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("chat_messages")
public class ChatMessagesDO extends BaseDO implements Serializable {

    @Serial
    private static final long serialVersionUID = -2772634516670566529L;
    /**
     * 对话ID，主键
     */
    private Integer messageId;
    /**
     * 用户ID，关联sys_user表
     */
    private Integer userId;
    /**
     * 消息内容
     */
    private String content;
    /**
     * 消息角色，user或assistant
     */
    private String role;
    /**
     * 使用的AI模型名称
     */
    private String model;
    /**
     * AI响应时间，单位秒
     */
    private Double responseTime;
    /**
     * 消耗的token数量
     */
    private Integer tokensUsed;
    /**
     * 对话id
     */
    private Integer conversationId;
}
