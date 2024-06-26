package org.zang.pojo.chat;

import java.io.Serial;
import java.io.Serializable;

import org.jetbrains.annotations.NotNull;
import java.io.Serializable;

import org.jetbrains.annotations.NotNull;
import org.zang.pojo.BaseDO;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 用户对话回话表
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * @Copyright 博客：https://eliauku.gitee.io/  ||  per aspera and astra <br/>
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("chat_conversations")
public class ChatConversationsDO extends BaseDO implements Serializable {

    @Serial
    private static final long serialVersionUID = -3046594605063881325L;
    /**
     * 对话ID，主键
     */

    private Integer conversationId;
    /**
     * 用户ID，关联sys_user表
     */
    private Integer userId;
    /**
     * 对话标题
     */
    private String title;
    /**
     * 创建人
     */
    private Integer createBy;
    /**
     * 更新人
     */
    private Integer updateBy;

}
