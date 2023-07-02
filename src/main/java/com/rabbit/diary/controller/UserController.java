package com.rabbit.diary.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.rabbit.diary.bean.User;
import com.rabbit.diary.bean.core.BizException;
import com.rabbit.diary.bean.core.ExceptionCodeEnum;
import com.rabbit.diary.bean.core.Result;
import com.rabbit.diary.redis.RedisServiceImpl;
import com.rabbit.diary.service.UserService;
import com.rabbit.diary.util.VerifyBusinessUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    RedisServiceImpl redisServiceImpl;

    String salt = "diary188";

    @RequestMapping("register")
    public Result register(@RequestBody User user){
        VerifyBusinessUtil.checkArguments(!StrUtil.isEmpty(user.getUserName()),"用户名不允许为空!");
        VerifyBusinessUtil.checkArguments(!StrUtil.isEmpty(user.getPassword()),"密码不允许为空!");
        VerifyBusinessUtil.checkArguments(userService.getByUserName(user.getUserName()) == null,"用户名"+user.getUserName()+"重复!");

        //拼装userBean
        user.setUid(redisServiceImpl.getIncr("userId")); //redis自增ID
        user.setPassword(SecureUtil.md5(user.getPassword() + salt));
        user.setCreateTime(DateUtil.now());
        user.setUpdateTime(DateUtil.now());
        userService.save(user);
        return Result.success();
    }

    @RequestMapping("login")
    public Result login(@RequestBody User user){
        User user1 = userService.getByUserName(user.getUserName());
        if(user1 == null){
            throw new BizException(ExceptionCodeEnum.ERROR_PARAM.setDesc("不存在的用户名：" + user.getUserName()));
        }
        String password = SecureUtil.md5(user.getPassword() + salt);
        if(!user1.getPassword().equals(password)){
            throw new BizException(ExceptionCodeEnum.ERROR_PARAM.setDesc("账号和密码不匹配：" + user.getUserName()));
        }
        /**登录维持ID* */
        StpUtil.login(user1.getUid(),"PC");
        return Result.success();
    }

    @RequestMapping("update")
    public Result update(@RequestBody User user){
        userService.update(user);
        return Result.success();
    }

    @RequestMapping("get")
    public User get(){
        return userService.getByUserId(StpUtil.getLoginIdAsLong());
    }

}
