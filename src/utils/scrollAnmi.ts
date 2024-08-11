
/**
 * 滚动条动画
 * @param target 
 * @param to 
 * @param duration 
 */ 
let tims = null
export function scrollTo(target:Element,to:Number, duration:Number,type:number) { 
    let newHeight = to-target.clientHeight;
    let limit = type?type: newHeight - target.scrollTop;  
   
    const animateScroll = () => {
        tims = setInterval(()=>{ 
            if(tims){
               target.scrollTop=target.scrollHeight;    
            } 
        },15)
       
    };
   
    // 启动动画
    animateScroll();
  }
export const clearTimes = ()=>{
    clearInterval(tims)
    tims=null;
}
 export function sleepFun(time:Number){
        return new Promise((resolve,inject)=>{
                 setTimeout(()=>{
                    resolve()
                 },300)
        })
 } 