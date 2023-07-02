package com.rabbit.diary.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.rabbit.diary.bean.User;
import com.rabbit.diary.dao.UserMapper;
import com.rabbit.diary.redis.RedisServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    UserMapper userMapper;

    @Autowired
    RedisServiceImpl redisServiceImpl;

    @RequestMapping("hello")
    public String hello(){
        return "hello Diary";
    }

    @RequestMapping("setUid")
    public String setUid(int id){
        redisServiceImpl.setIncr("userId",id);
        return "Success";
    }

    @RequestMapping("addUser")
    public String addUser(){
        User user = new User();

        Long userId = redisServiceImpl.getIncr("userId");
        if(userId == null){
            redisServiceImpl.setIncr("userId",0);
            userId = redisServiceImpl.getIncr("userId");
        }

        user.setUserName("admin" + userId);

        //不允许用户名重复
        QueryWrapper<User> qw = new QueryWrapper<>();
        qw.eq("user_name",user.getUserName());
        User user1 = userMapper.selectOne(qw);
        if(user1 != null){
            return "用户名重复！";
        }

        String salt = "diary188";

        user.setUid(userId);
        user.setPassword(SecureUtil.md5("1" + salt));
        user.setCreateTime(DateUtil.now());
        user.setUpdateTime(DateUtil.now());
        user.setBirthday("19980101");
        user.setEmail("655555@xx.com");
        user.setEmailBindTime(DateUtil.now());
        user.setFace("1.jpg");
        user.setGender(1);
        user.setMobile("139xxxxxxxx");
        user.setSignature("即将放飞梦想的有志青年");
        user.setNickName("开心猫猫");

        userMapper.insert(user);
        return "success";
    }

    /*public static void main(String[] args) {
        System.out.println(IdUtil.fastSimpleUUID());
    }*/
}
