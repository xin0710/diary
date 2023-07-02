package com.rabbit.diary.bean.core;

import cn.dev33.satoken.exception.NotLoginException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局异常处理
 * 一般来说，全局异常处理只是一种兜底的异常处理策略，也就是说提倡自己处理异常。
 * 但现在其实很多人都喜欢直接在代码中抛异常，全部交给@RestControllerAdvice处理
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

	/**
     * 未登录异常 (直接返回脚本跳转到登录页面)
     * @param
     * @return
     */
    @ExceptionHandler(NotLoginException.class)
    public String handleNotLoginException(NotLoginException bizException) {
        return "<script>location.href='/login'</script>";
    }

    /**
     * 业务异常(需要主动抛出)
     *
     * @param
     * @return
     */
    @ExceptionHandler(com.rabbit.diary.bean.core.BizException.class)
    public com.rabbit.diary.bean.core.Result<com.rabbit.diary.bean.core.ExceptionCodeEnum> handleBizException(com.rabbit.diary.bean.core.BizException bizException) {
        return com.rabbit.diary.bean.core.Result.error(bizException.getError());
    }

    /**
     * 运行时异常
     *
     * @param e
     * @return
     */
    @ExceptionHandler(RuntimeException.class)
    public com.rabbit.diary.bean.core.Result<com.rabbit.diary.bean.core.ExceptionCodeEnum> handleRunTimeException(RuntimeException e) {
        return com.rabbit.diary.bean.core.Result.error(com.rabbit.diary.bean.core.ExceptionCodeEnum.ERROR.setDesc(e.getMessage()));
    }

}
