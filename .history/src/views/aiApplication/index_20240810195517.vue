<template>
         <div class="aiapplication">
                <div class="aiapplication_answer">
                      
                </div>
                <div :class="['aiapplication_question',isShow?'':'hiddens']" >
                      <div :class="['aiapplication_question-logo',isShow?'':'hiddens']">
                                <img src="/favicon.svg" alt="">
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
                                   <div class="grid-item"> <p>✌️</p> 一只小熊泰迪</div>
                                   <div class="grid-item"> <p>✌️</p> 一只小熊泰迪</div>
                            </div>
                            <div class="grid space-x-3">
                                   <div class="grid-item"> <p>✌️</p> 一只小熊泰迪</div>
                                   <div class="grid-item"> <p>✌️</p> 一只小熊泰迪</div>
                                   <div class="grid-item"> <p>✌️</p> 一只小熊泰迪</div>
                            </div>
                      </div>
                      <div :class="['minMode','  space-x-2','flex','justify-start w-[60%]',isShow?'':'hiddens']" >
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']" > <p>✌️</p> 一只小熊泰迪</div>
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']"> <p>✌️</p> 一只小熊泰迪</div>
                                   <div :class="['grid-item','flex',isShow?'hiddens':'']"> <p>✌️</p> 一只小熊泰迪</div>
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
                                  <input placeholder="请输入问答内容" type="text">
                             </div>
                             <div class="aiapplication_question-input-file">
                                <n-icon size="20" color="#000">
                                    <DocumentAttachOutline />
                                </n-icon>
                             </div>
                             <div @click="handleSend" class="aiapplication_question-input-btn">
                                <n-icon size="20" color="#fff">
                                    <SendSharp />
                                </n-icon>
                             </div> 
                      </div>  
                </div>
         </div>
</template>
<script lang="ts" setup>
import { Apps, DocumentAttachOutline,SendSharp } from '@vicons/ionicons5';
import {ref} from 'vue';
let str = '你好，我是最牛逼AI让我们一起度过美好的一天！'
str = str.split('')
const isShow = ref<Boolean>(true);
let textArr = ref<Array<String>>([]);
let count = -1;
let options = [
  {
    label: 'AI大模型',
    key: 'jay gatsby'
  },
]
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
            count = count==((str.length+6)*2)?0:count
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
const handleSend = ()=>{
    isShow.value=false;
}

</script>
<style lang="scss" scoped>
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
        flex: 1;
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
                 height: 100px;
                 width: 100px;
             }
             height: 100px;
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