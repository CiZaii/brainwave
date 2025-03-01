import { computed, reactive, ref } from 'vue';
import { useRoute } from 'vue-router';
import { defineStore } from 'pinia';
import { useLoading } from '@sa/hooks';
import { SetupStoreId } from '@/enum';
import { useRouterPush } from '@/hooks/common/router';
import { fetchGetUserInfo, fetchLogin } from '@/service/api';
import { localStg } from '@/utils/storage';
import { $t } from '@/locales';
import { useRouteStore } from '../route';
import { useTabStore } from '../tab';
import { clearAuthStorage, getToken } from './shared';

export const useAuthStore = defineStore(SetupStoreId.Auth, () => {
  const route = useRoute();
  const routeStore = useRouteStore();
  const tabStore = useTabStore();
  const { toLogin, redirectFromLogin } = useRouterPush(false);
  const { loading: loginLoading, startLoading, endLoading } = useLoading();

  const token = ref(getToken());
  
  const userInfo: Api.Auth.UserInfo = reactive({
    userId: '',
    userName: '',
    roles: [],
    buttons: []
  });

  /** is super role in static route */
  const isStaticSuper = computed(() => {
    const { VITE_AUTH_ROUTE_MODE, VITE_STATIC_SUPER_ROLE } = import.meta.env;

    return VITE_AUTH_ROUTE_MODE === 'static' && userInfo.roles.includes(VITE_STATIC_SUPER_ROLE);
  });

  /** Is login */
  const isLogin = computed(() => Boolean(token.value));
  
  /** Reset auth store */
  async function resetStore() {
    console.log('resetStore')
    // 只要存在token就不用去登录 
    // 
    const authStore = useAuthStore();

    // clearAuthStorage();

    // authStore.$reset();

    if (!route.meta.constant) {
      // await toLogin();
      console.log('==============',isLogin,route.meta.constant)
    } 
    tabStore.cacheTabs();
    routeStore.resetStore();
  }


  const loginParams = (username:String,password:String)=>{
       return {
        "userName": username,
        "passWord": password,
        "saLoginModel": {
          "device": "device_y15nz",
          "isLastingCookie": true,
          "timeout": 10000*24,
          "activeTimeout": 1,
          "extraData": {},
          "token": "token_a8zff",
          "isWriteHeader": true,
          "tokenSignTag": {}
        }
      }
  }
  /**
   * 登录
   *
   * @param userName User name
   * @param password Password
   * @param [redirect=true] Whether to redirect after login. Default is `true`
   */
  async function login(userName: string, password: string, redirect = true) {
    startLoading(); 
    console.log(userName)
    const res = await fetchLogin(loginParams(userName, password));
  
    let {tokenValue} = res.data.data.data;
    console.log(res.data.data.data);
    // 修改登录部分
    const pass = await loginByToken(tokenValue);
    await routeStore.initAuthRoute();
    
    await redirectFromLogin();
    // if (!error) {
    //   const pass = await loginByToken(loginToken);

    //   if (pass) {
    //     await routeStore.initAuthRoute();

    //     if (redirect) {
    //       await redirectFromLogin();
    //     }

    //     if (routeStore.isInitAuthRoute) {
    //       window.$notification?.success({
    //         title: $t('page.login.common.loginSuccess'),
    //         content: $t('page.login.common.welcomeBack', { userName: userInfo.userName }),
    //         duration: 4500
    //       });
    //     }
    //   }
    // } else {
    //   resetStore();
    // }

    endLoading();
  }

  async function loginByToken(loginToken: Api.Auth.LoginToken) {
    // 1. stored in the localStorage, the later requests need it in headers
    localStg.set('token', loginToken);
    localStg.set('refreshToken', loginToken);

    // 2. get user info
    const pass = await getUserInfo();
 
    if (pass) {
      token.value = loginToken.token;

      return true;
    }

    return false;
  }

  async function getUserInfo() {
    const { data: info, error } = await fetchGetUserInfo();

    if (!error) {
      // update store
      Object.assign(userInfo, info);

      return true;
    }

    return false;
  }

  async function initUserInfo() {
    const hasToken = getToken();

    if (hasToken) {
      const pass = await getUserInfo();

      if (!pass) {
        resetStore();
      }
    }
  }

  return {
    token,
    userInfo,
    isStaticSuper,
    isLogin,
    loginLoading,
    resetStore,
    login,
    initUserInfo
  };
});
