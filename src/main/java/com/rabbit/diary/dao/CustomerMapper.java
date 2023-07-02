package com.rabbit.diary.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rabbit.diary.bean.Customer;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper extends BaseMapper<Customer> {
}
