package com.rabbit.diary.util;

import com.rabbit.diary.bean.core.BizException;
import com.rabbit.diary.bean.core.ExceptionCodeEnum;
import lombok.extern.slf4j.Slf4j;

/**
 * 通用校验工具类
 */
@Slf4j
public class VerifyBusinessUtil {

    /**
     * 断言
     * @param judge
     * @param error
     */
    public static void checkArguments(boolean judge,String error){
        if(!judge){
            log.error("{}", error);
            throw new BizException(ExceptionCodeEnum.ERROR_PARAM,error);
        }
    }

}
