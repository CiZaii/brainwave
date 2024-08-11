
import { request } from '../request';

/**
 * Login
 *
 * @param userName User name
 * @param password Password
 */
export function documentQa(data:Object) {
  return request<Api.Auth.LoginToken>({
    url: '/rag/documentQa',
    method: 'post',
    data,
    responseType:'stream',
    headers:{ 
         "Authorization":`Bearer token_a8zff`
    }
  });
}