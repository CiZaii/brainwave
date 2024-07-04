package org.zang.controller.rag;


import java.io.IOException;
import java.util.Collections;

import org.dromara.hutool.core.text.StrUtil;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.zang.aisdk.client.session.OpenAiSession;
import org.zang.aisdk.dto.req.ChatCompletionRequestDTO;

import org.zang.aisdk.dto.req.ChatCompletionResponseDTO;
import org.zang.aisdk.dto.req.MessagesDTO;

import org.zang.aisdk.enums.config.ModelEnum;
import org.zang.convention.prompt.MetadataPrompt;
import org.zang.strategy.chat.content.ChatStrategyContent;

import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * rag
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@RestController
@RequestMapping("/rag")
@Slf4j
@RequiredArgsConstructor
public class RagController {

    private final OpenAiSession openAiSession;

    private final ChatStrategyContent chatStrategyContent;
    @PostMapping("stream_chat")
    public SseEmitter rag(@RequestBody ChatCompletionRequestDTO chatCompletionRequestDTO) throws InterruptedException, JsonProcessingException {

        log.info("当前的请求参数为{}", chatCompletionRequestDTO);

        log.info("测试开始：请等待调用结果");

        return openAiSession.chatCompletions(chatCompletionRequestDTO);

    }

    @PostMapping("/metaDate")
    public ChatCompletionResponseDTO metaDate(@RequestBody ChatCompletionRequestDTO chatCompletionRequestDTO) throws InterruptedException, IOException {
        log.info("当前的请求参数为{}", chatCompletionRequestDTO);
        log.info("测试开始：请等待调用结果");
        String a= "中华全国总工会关于印发《工会参与劳动争议处理办法》的通知总工发〔2023〕23号来源：全总法律工作部各省、自治区、直辖市总工会，各全国产业工会，中央和国家机关工会联合会，全总各部门、各直属单位：《工会参与劳动争议处理办法》已经中华全国总工会第十八届书记处第4次会议审议通过，现印发给你们，请认真贯彻执行。中华全国总工会2023年12月28日工会参与劳动争议处理办法第一章总则第一条为深入贯彻习近平法治思想，坚持和发展新时代“枫桥经验”，进一步规范和加强工会参与劳动争议处理工作，更好履行维护职工合法权益、竭诚服务职工群众基本职责，推动构建和谐劳动关系，根据《中华人民共和国工会法》《中华人民共和国劳动法》《中华人民共和国劳动合同1法》《中华人民共和国劳动争议调解仲裁法》及《中国工会章程》等有关规定，制定本办法。第二条工会参与劳动争议处理，应当坚持中国共产党的领导，坚持以职工为本，坚持立足预防、立足调解、立足法治、立足基层，坚持公平、正义，最大限度将劳动争议矛盾化解在基层，化解在萌芽状态。第三条县级以上总工会应当将工会参与劳动争议处理工作纳入服务职工工作体系，健全工会参与劳动争议处理保障机制，促进工会参与劳动争议处理工作高质量发展。全国总工会法律工作部门负责指导、协调全国工会参与劳动争议处理工作。县级以上地方总工会法律工作部门负责指导、协调并组织实施本地区工会参与劳动争议处理工作。各级工会加强与同级人力资源社会保障、人民法院、人民检察院、司法行政、公安、工商业联合会、企业联合会／企业家协会、律师协会等部门的沟通，推动建立健全劳动争议处理协作联动机制，协力做好劳动争议处理工作。第四条本办法适用于工会参与处理下列劳动争议";
        String b = "[{\\\"公文\\\":[\\\"标题\\\",\\\"动态来源\\\",\\\"文件层级\\\",\\\"发布时间\\\"]}]\"";
        final String format = StrUtil.format(MetadataPrompt.METADATA_PROMPT, a,b);

        chatCompletionRequestDTO.setModel(ModelEnum.THUDM.getCode());
        chatCompletionRequestDTO.setMessages(Collections.singletonList(MessagesDTO.builder().role("user").content(format).build()));

        return  openAiSession.completions(chatCompletionRequestDTO);
        //return chatStrategyContent.chatSSE(ModelEnum.THUDM, chatCompletionRequestDTO);

    }



}
