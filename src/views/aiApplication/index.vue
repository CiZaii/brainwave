<template>
         <div class="aiapplication">
                <div ref="AnSwerScrollRef" :class="['aiapplication_answer',isShow?'':'active']">
                    <QuestionAnswer ref="AnswerRef"></QuestionAnswer>
                </div>
                <div :class="['aiapplication_question',isShow?'':'hiddens']" >
                      <div :class="['aiapplication_question-logo',isShow?'':'hiddens']">
                                <img src="/logo.svg" alt="">
                      </div>
                      <div :class="['aiapplication_question-title',isShow?'':'hiddens']"  >
                           <div >
                                <em v-for="item in textArr" :key="item">
                                     {{item}}
                                </em>
                                <p class="end"></p>
                           </div>
                            <div>你可以尝试下面的示例...</div>
                      </div>
                      <div :class="['aiapplication_question-list',isShow?'':'hiddens']"  >
                            <div class="grid space-x-3">
                                   <div class="grid-item"> <p>🎨</p> 多地重奖奥运冠军：孙佳俊等获奖60万</div>
                                   <div class="grid-item"> <p>🎗️</p> 网球裙快成了打工人的新班服</div>
                            </div> 
                            <div class="grid space-x-3">
                                   <div class="grid-item"> <p>🤖</p> 人工智能大会</div>
                                   <div class="grid-item"> <p>😁</p> 全红婵家门口变成小吃一条街了</div>
                                   <div class="grid-item"> <p>🎉</p> 韩国将申办2036年夏季奥运会热</div>
                            </div>
                      </div>
                      <div :class="['minMode','  space-x-2','flex','justify-start w-[60%]',isShow?'':'hiddens']" >
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']" > <p>🤖</p> 人工智能大会</div>
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']"> <p>🎉</p> 农夫山泉永远属于中国</div>
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']"> <p>💡</p> 韩国将申办2036年夏季奥运会热</div>
                      </div>
                      <div class="aiapplication_question-input">
                             <div class="aiapplication_question-input-mode">
                                <n-dropdown
                                    placement="bottom"
                                    trigger="click" 
                                    :options="options"
                                    @select="handleSelect"
                                    >
                                     <div class="flex items-center space-x-3">
                                        <n-icon size="20" color="#000">
                                            <Apps />
                                        </n-icon> 
                                        <p>Ai大模型</p>
                                     </div>
                                    </n-dropdown>
                             
                             </div>
                             <div class="aiapplication_question-input-text">
                                  <input v-model="SearchText" placeholder="请输入问答内容" type="text">
                             </div>
                             <div class="aiapplication_question-input-file">
                                <n-icon size="20" color="#000">
                                    <Attach />
                                </n-icon>
                             </div>
                             <div @click="handleSend" class="aiapplication_question-input-btn">
                                <n-icon v-if="!isLoading" size="20" color="#fff">
                                    <SendSharp />
                                </n-icon>
                                <n-icon v-else size="20" color="#fff">
                                    <EllipseOutline />
                                </n-icon>
                             </div> 
                      </div>  
                </div>
         </div>
</template>
<script lang="ts" setup>
import { defineAsyncComponent,nextTick } from 'vue';
import { Apps, EllipseOutline,SendSharp,Attach } from '@vicons/ionicons5';
import {str,options} from './config';
import {scrollTo,clearTimes,sleepFun} from '@/utils/scrollAnmi';
import {fetchEventSource} from '@microsoft/fetch-event-source';
import {ref} from 'vue'; 
import { localStg } from '@/utils/storage';
const QuestionAnswer = defineAsyncComponent(()=>import('./component/questionAnswer.vue'));
const AnswerRef = ref<any>(null); 
const SearchText =ref<String>('');
const AnSwerScrollRef  = ref<any>(null)
const isShow = ref<Boolean>(true);
const isLoading = ref(false)
let textArr = ref<Array<String>>([]);
let count = -1; 
/**
 * 文字动画
 */
const StreamAminText = ()=>{
      setInterval(()=>{ 
        count++; 
        if(count<str.length){ 
            textArr.value.push(str[count])  
        }else if(count>=str.length+10 && count<=(str.length+10)*2){
            textArr.value.pop();
            count = count==((str.length+6)*2)?-1:count
        } 
      },150)

}
StreamAminText();
/**
 * 选择模型
 */
const handleSelect = ()=>{

} 
/**
 * 发送
 */
const handleSend = async ()=>{
      if(isLoading.value){
         return false; 
      }
     AnswerRef.value.addAnswerList([
      {
        "content": SearchText.value,
        'isEnd':false,
        'isUser':true,
        "usage": {
            "promptTokens": 0,
            "completionTokens": 0,
            "totalTokens": 0
        }
      },
      {
            "content": "正在解答...",
            'isEnd':false,
          'isUser':false,
            "usage": {
                "promptTokens": 0,
                "completionTokens": 0,
                "totalTokens": 0
            }
        } 
     ],()=>{
      updateScroll();
     })  
    await sleepFun(1000);
    isShow.value=false;  
    const token = localStg.get('token'); 
    let {signal} = new AbortController();
    isLoading.value=true;
    await fetchEventSource('/api/rag/documentQa', {
        method: 'POST',
        headers: {
           'Content-Type': 'application/json',
           "token-ai":`Bearer ${token}`, 
           'Accept': '*/*' 
        },
        openWhenHidden: true,
        body: JSON.stringify({
          "question": SearchText.value,
          "modelFlag": "Qwen/Qwen2-7B-Instruct"
        }),
        onmessage: ({data}) => { 
          let content = JSON.parse(data);  
          console.log(content)
          AnswerRef.value.ChangeEndAnswer(content);
          updateScroll();
          if(content.finishReason=='stop'){  
          clearTimes();
          isLoading.value=false;
          } 
        },
        onerror: (error) => { 
        },
        signal: signal
      })

}
const updateScroll = ()=>{
  let OldHeight = AnSwerScrollRef.value.scrollHeight;
  scrollTo(AnSwerScrollRef.value,OldHeight,10,200);
}
</script>
<style lang="scss" scoped>
 @mixin scrollbar($size: 7px, $color: rgba(0, 0, 0, 0.5)) {
  scrollbar-width: thin;
  scrollbar-color: $color transparent;

  &::-webkit-scrollbar-thumb {
    background-color: $color;
    border-radius: $size;
  }
  &::-webkit-scrollbar-thumb:hover {
    background-color: $color;
    border-radius: $size;
  }
  &::-webkit-scrollbar {
    width: $size;
    height: $size;
  }
  &::-webkit-scrollbar-track-piece {
    background-color: rgba(0, 0, 0, 0);
    border-radius: 0;
  }
}
.aiapplication{
     width: 100%;
     height: 100%;
     background:url('../../assets/imgs/bg2.png') no-repeat;
     background-position: 0;
     background-size: 100%;
     background-color: #f5f7ff;
     display: flex;
     flex-direction: column;
     &_answer{ 
        height: 100px;
        overflow-y: scroll;
        transition: all .8s ease-in-out .5s;
        @include scrollbar(1px,#ccc);
        &.active{
            height: calc(100% - 200px);
        }
     } 
     
     &_question{
         height: 700px; 
         display: flex;
         align-items: center; 
         flex-direction: column;   
          overflow: hidden;
        transition: all 1.2s ease-in-out .5s;
        &.hiddens{ 
            height: 200px;
        }
        .minMode{
             
            display: flex;
            align-items: center; 
            justify-content: flex-start !important;     
            transition: all 0.8s ease-in-out 0s; 
            &.hiddens{ 
              
                height: 50px; 
            }
            padding-left: 1rem;
            .grid-item{ 
                height: 30px; 
                box-shadow: 0 2px 4px 1px #4b4b590a; 
                border-radius: 20px;
                background: transparent;
                border: 1px solid rgba(0, 0, 0, .06);
                color: #1c1f23;
                font-weight: 100; 
                 padding: 0 .5rem;
                 font-size: 12px;
                 display: flex;
                 justify-content: center;
                 align-items: center;
                 cursor: pointer;
                 transform: translateX(0);
                 opacity: 1;
                 transition: all .4s ease-in-out 1s;
                 visibility: visible;
                 &.hiddens{
                   transform: translateX(-100px);
                   opacity: 0; 
                   visibility: hidden;
                 }
                 &:nth-of-type(1){
                      transition-delay: 1s ;
                 }
                 &:nth-of-type(2){
                      transition-delay: 1.05s ;
                 }
                 &:nth-of-type(3){
                      transition-delay: 1.1s ;
                 }
                 &:nth-of-type(4){
                    transition-delay: 1.15s ;
                 }
                 &:nth-of-type(5){
                    transition-delay: 1.2s ;
                 }
                 &>p{
                     font-size: 15px;
                 }
                 &:hover{
                    border: 1px solid #6468e7 !important;
                    transition-delay: 0s ;
                 }
               
             }
        }
         &-logo{
            
             img{
                 height: 200px;
                 width: 200px;
             }
             height: 200px;
            overflow: hidden;
             transition: all 1.2s ease-in-out 0s;
             &.hiddens{ 
                   height: 0px;
                   opacity: 0;
             }
         }
         &-title{
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column; 
             margin: 1.5rem 0;  
             height: 100px;
             overflow: hidden;
             transition: all .9s ease-in-out .3s;
             &.hiddens{ 
                   height: 0px;
                   opacity: 0;
             }
             &>div:nth-of-type(1){
                   color: #1c1f23;
                   font-weight: 700;
                   font-size: 40px;  
                   height: 50px;
                   display: flex;
                   align-items: center;
                   .end{
                        width: 2px;
                        height: 100%;
                        background-color: #1c1f23;
                        animation: endAnmi 1.3s ease-in infinite;
                        opacity: 0;
                    }
                   &>em{
                     display: inline-block;
                    
                     opacity: 0;
                     animation: ShowText .3s ease-in-out forwards;
                   }
             }
             &>div:nth-of-type(2){
                   margin-top: 1rem;
                   color: #1c1f23; 
                   font-size: 14px;  
             }
         }
         &-list{
        margin-bottom: 2rem;
        height: 100px;
             overflow: hidden;
             transition: all .9s ease-in-out .6s;
             &.hiddens{ 
                   height: 0px;
                   opacity: 0;
             }
         .grid{
             display: flex;
             justify-content: center;
             margin-bottom: 1rem;
             &-item{
                height: 40px;
                background: linear-gradient(133deg, #e9e9fe,#e3e8fe);
                box-shadow: 0 2px 4px 1px #4b4b590a; 
                border-radius: 10px;
                border: 2px solid #fff;
                 border-radius: 5px;
                 padding: 0 .8rem;
                 font-size: 14px;
                 display: flex;
                 justify-content: center;
                 align-items: center;
                 cursor: pointer;
                 transform: translateY(30px);
                 opacity: 0;
                 animation:  initTranslateAmni .2s ease-in-out forwards;
                 &:nth-of-type(1){
                      animation-delay: .65s;
                 }
                 &:nth-of-type(2){
                      animation-delay: 0.7s;
                 }
                 &:nth-of-type(3){
                      animation-delay: .75s;
                 }
                 &:nth-of-type(4){
                      animation-delay: .8s;
                 }
                 &:nth-of-type(5){
                      animation-delay: .85s; 
                 }
                 &>p{
                     font-size: 20px;
                 }
               
             }
         }
       }
         &-input{ 
             display: flex;
             align-items: center;
             width: 0;
             opacity: 0;
             margin: 0 auto;
             padding: .5rem .5rem;
             border-radius: 40px;
             background: #fff;
             border: 1px solid var(--s-color-border-tertiary, rgba(0, 0, 0, .08));
             transition: all .2s ease-in 0s; 
             animation: initAnmis .6s  ease-out forwards;
             animation-delay: 1s; 
             &:hover{
                 border: 1px solid #8a55fe;
             } 
             &-mode{
                display: flex;
                align-items: center;
                margin-left: .5rem;
                cursor: pointer;
             }
             &-text{
                 flex: 1;
                 padding: 0 1rem;
                 box-sizing: border-box;
                  input{
                     width: 100%;
                     outline-style: none;
                     background-color: transparent;
                     
                  }
                }
                &-file{ 
                    display: flex;
                    align-items: center;
                     padding: .3rem;
                     border-radius: 5px;
                     position: relative;
                     margin-right: 1rem;
                     cursor: pointer;
                     &::before{
                         content: '';
                         position: absolute;
                         right: calc(-40% - 2px);
                         top: 0;
                         height: 100%;
                         width: 1px; 
                         background-color: #ccc;
                     }
                }
                &-btn{
                    background:linear-gradient(180deg, #6468e7 0%, #8a55fe 100%);
                    border-radius: 5px 40px 40px 5px;   
                    padding: .6rem .8rem;  
                    margin-left: 1rem;
                    display: flex;
                    cursor: pointer;
               }
            }
           
     }
}
@keyframes endAnmi {
     to{
         opacity: 1;
     }
}
@keyframes ShowText {
     to{ 
        opacity: 1; 
     }
}
@keyframes initAnmis {
     to{
     
        opacity: 1;
        width: 60%;
     }
}
@keyframes initTranslateX {
     to{
       transform: translateX(0);
       opacity: 1;
     }
}
 
@keyframes initTranslateAmni {
     to{
       transform: translateY(0);
       opacity: 1;
     }
}
</style>