package com.rabbit.diary.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.rabbit.diary.bean.User;
import com.rabbit.diary.dao.UserMapper;
import com.rabbit.diary.redis.RedisServiceImpl;
import com.rabbit.diary.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.annotation.Annotation;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Autowired
    RedisServiceImpl redisServiceImpl;

    /**
     * 根据用户名获取用户
     * @param userName
     * @return
     */
    @Override
    public User getByUserName(String userName) {
        List<User> users = userMapper.selectList(new QueryWrapper<User>().eq("user_name", userName));
        if(users.size() > 0){
            return users.get(0);
        }
        return null;
    }

    /**
     * 保存用户
     * @param user
     */
    @Override
    public void save(User user) {
        userMapper.insert(user);
    }

    @Override
    public User getByUserId(long loginIdAsLong) {
        return userMapper.selectById(loginIdAsLong);
    }

    @Override
    public void update(User user) {
        LambdaUpdateWrapper<User> lambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        lambdaUpdateWrapper = lambdaUpdateWrapper.set(User::getNickName, user.getNickName())
                .set(User::getBirthday, user.getBirthday())
                .set(User::getGender, user.getGender())
                .set(User::getSignature, user.getSignature())
                .set(User::getUpdateTime, DateUtil.now());

        if(StrUtil.isNotEmpty(user.getFace())){
            lambdaUpdateWrapper = lambdaUpdateWrapper.set(User::getFace,user.getFace());
        }
        lambdaUpdateWrapper.eq(User::getUid, StpUtil.getLoginIdAsLong());
        userMapper.update(null,lambdaUpdateWrapper);
    }


}
