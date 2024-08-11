<script setup lang="ts">
import { computed, reactive } from 'vue';
import { $t } from '@/locales';
import { loginModuleRecord } from '@/constants/app';
import { useRouterPush } from '@/hooks/common/router';
import { useFormRules, useNaiveForm } from '@/hooks/common/form';
import { useAuthStore } from '@/store/modules/auth';

defineOptions({
  name: 'PwdLogin'
});

const authStore = useAuthStore();
const { toggleLoginModule } = useRouterPush();
const { formRef, validate } = useNaiveForm();

interface FormModel {
  userName: string;
  password: string;
}

const model: FormModel = reactive({
  userName: 'zangzang',
  password: 'zangzang'
}); 


async function handleSubmit() { 
   
  await authStore.login(model.userName, model.password);
} 
</script>

<template>
  <div class="flex items-center flex-center absolute z-10 w-full pb-5">
    <div class="text-light-50 flex flex-col w-500px mr-[25%] space-y-8">
      <h1 class="text-[2rem] flex items-center font-bold">
        Gitee平台2024年最牛逼的言启AI中台🤖
      </h1>
      <h1 class="text-[1.5rem]">
        <p class="inline ">这是一个AI的时代</p>
        <p class="inline text-gray-500">,给予了每个人创造价值的可能性</p>
        <p class="inline text-gray-500">人工智能的发展</p>
        <p class="inline text-gray-500">它将与人类携手共进，人工智能的未来充满</p>
        <p class="inline">无限可能</p>
      </h1>
      <div class="flex items-center space-x-3 mtop">
        <span class="rounded-[4px] bg-gray-800 p-2">搭建自己的AI程序 ✨</span>
        <span class="rounded-[4px] bg-gray-800 p-2">部署自己的AI模型 🎉 </span>
        <span class="rounded-[4px] bg-gray-800 p-2">使用自己的AI应用 ✌️</span>
      </div>
    </div>
    <div class="flex flex-col w-400px space-y-5  ">
      <div class="text-light-50 text-[1.23rem] font-100">
        <p class="text-[2rem]">感谢你选择了我们🎆</p>
        <p>欢迎登录！</p>
      </div>
      <div>
        <NInput v-model:value="model.userName" placeholder="请输入用户名" />
        </div>
      <div>
        <NInput v-model:value="model.password" placeholder="请输入密码" />
      </div>
      <div
       @click="handleSubmit"
        class="w-[300px] bg-light-50 px-4 py-2 border border-width-[1px] outline-transparent border-gray-700 rounded-[19px] font-bold  text-gray-800 text-center cursor-pointer">
        登录
      </div>
      <div class="text-blue-500">注册新用户</div>
    </div> 
  </div>
</template>

<style scoped>
.mtop {
  margin-top: 4rem !important;
}
</style>
