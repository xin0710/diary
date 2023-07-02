package com.rabbit.diary.bean.core;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * 统一封账响应结果
 * @author Administrator
 *
 */
@RestControllerAdvice
public class CommonResponseDataAdvice implements ResponseBodyAdvice<Object> {


    @Override
    public boolean supports(MethodParameter methodParameter, Class<? extends HttpMessageConverter<?>> aClass) {
        // 标注了@RestController，且类及方法上都没有标注@IgnoreCosmoResult的方法才进行包装
    	return methodParameter.getDeclaringClass().isAnnotationPresent(RestController.class)
                && !methodParameter.getDeclaringClass().isAnnotationPresent(com.rabbit.diary.bean.core.IgnoreCosmoResult.class)
                && !methodParameter.getMethod().isAnnotationPresent(com.rabbit.diary.bean.core.IgnoreCosmoResult.class);
    }

    @Override
    public Object beforeBodyWrite(Object o,
                                  MethodParameter methodParameter,
                                  MediaType mediaType,
                                  Class<? extends HttpMessageConverter<?>> aClass,
                                  ServerHttpRequest serverHttpRequest,
                                  ServerHttpResponse serverHttpResponse) {
    	// 已经包装过的，不再重复包装
        if (o instanceof com.rabbit.diary.bean.core.Result) {
            return o;
        }
        // 改一行代码即可：把Object返回值用Result封装
        return com.rabbit.diary.bean.core.Result.success(o);
    }
}