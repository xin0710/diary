package com.rabbit.diary.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rabbit.diary.bean.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}
