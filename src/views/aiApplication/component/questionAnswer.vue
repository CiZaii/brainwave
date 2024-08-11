<template>
      <div class="question">
            <div class="question-list">
                <TransitionGroup name="list" tag="ul">
                    <div   
                    :class="['answer-item',item.isUser?'right':'left']"
                    v-for="(item,index) in AnswerList"
                    :key="index"
                    >
                         <div>
                              <div :class="[item.isEnd?'':'loading']">
                                <div v-if="!item.isEnd" :class="[item.isEnd?'':'loading','loadingbox']"  ></div>
                                <img v-if="item.isUser" src="/user.svg" alt="">
                                <img v-else src="/logo.svg" alt="">
                               
                              </div>
                        </div>
                        <div> 
                          <div class="rightAnswer"> 
                            <p>{{item.content}}</p>
                            <p v-if="item.usage.totalTokens && !item.isUser">以上内容由AI大模型生成，请仔细甄别 「tokens: {{item.usage.totalTokens}}, depleteTokens: {{item.usage.completionTokens}} 个tokens」</p>
                          </div></div>
                  </div> 
                </TransitionGroup> 
            </div>
      </div>
</template>
<!-- 交互  问答头像问答 问答loading 边框旋转 结果结束之后 便会方块边框 -->
 <script lang="ts" setup>
 import {ref} from 'vue';
 interface AnswerType{
             "content":String,
              "finishReason":String,
              "usage": {
                  "promptTokens": number,
                  "completionTokens": number,
                  "totalTokens": number
              }
             isEnd:Boolean,
             isUser:Boolean,
 }
let AnswerList = ref<Array<AnswerType>>([
  
])
/**
 * 添加问答内容
 */
const addAnswerList = (item:Array<AnswerType>,fn)=>{
    if(item.length<2){
         return false;
    }
    AnswerList.value.push(...item);
    fn();
}
/**
 * 修改问答状态
 */
 const ChangeEndAnswer = (item:Array<AnswerType>)=>{ 
       AnswerList.value[AnswerList.value.length-1] =  {
          ...item,
          isEnd:item?.finishReason=='stop'
       };
}
 
defineExpose({
    addAnswerList,
    ChangeEndAnswer
})
 </script>
<style lang="scss" scoped>
.list-enter-active,
.list-leave-active {
  transition: all 0.5s ease;
}
.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
 .question{
     width: 60%; 
     margin:0 auto;
     &-list{
         
           display: flex;
           flex-direction: column;
           .answer-item{
              display: flex;
              margin-bottom: 2rem;
              &.left{
                &>div:nth-of-type(1){ 
                &>div{
                    &.loading{
                        border-radius: 50%;   
                    }
                    transition: all .3s ease-in-out 0s;
                    border-radius: 10px; 
                    width: 40px;
                    padding: .1rem;
                    box-sizing: border-box;
                    background-color: #e2e8f0;
                    position: relative;
                    .loadingbox{
                         position: absolute;
                         left: 0;
                         top: 0;
                         border-radius: 50%;
                         border: 2px solid #6415ff;
                         border-bottom-color:transparent ;
                         border-top-color:transparent ;
                         width: 100%;
                         height: 100%;
                         transform: rotate(45deg);
                         &.loading{
                              animation: loadingAnmi .8s linear infinite; 
                         }
                    }
                    } 
                  &>img{
                      width: 100%;
                  }
                 }  
              }
              &.right{
                justify-content: flex-end;
                &>div:nth-of-type(1){
                     order: 2;
                }
                .rightAnswer{
                    background:linear-gradient(90deg, rgba(86, 114, 247, 0.1) 0%, rgba(86, 114, 247, 0.02) 100%);;
                    color: #141414; 
                }
              }
             &>div:nth-of-type(1){ 
                &>div{
                    border-radius: 10px; 
                    width: 40px;
                    padding: .1rem ;
                    box-sizing: border-box;
                    background-color: #e2e8f0;
                    } 
                  &>img{
                      width: 100%;
                  }
                  &+div{
                     max-width: 60%; 
                     padding:.1rem 1rem;
                     box-sizing: border-box;
                     &>div{ 
                         background: linear-gradient(133deg, #fafbff 0%, #ffffff 28%, #ffffff 100%);
                         box-shadow: 0 2px 4px 1px #4b4b590a;
                         padding: 1rem 2rem;
                         border-radius: 10px; 
                         color: #475569;  
                         font-size: 14px;
                         &>p:nth-of-type(2){
                            font-size: 12px;
                            color: #555555;
                            margin-top: 1rem; 
                         }
                     }
                  }
             } 
           } 
     }
 }
 @keyframes loadingAnmi {
      to{
         transform: rotate(405deg);
      }
 }
</style>