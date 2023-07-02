package com.rabbit.diary.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.rabbit.diary.bean.SysBlogType;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.dao.SysBlogTypeMapper;
import com.rabbit.diary.service.ISysBlogTypeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 鑫
 * @since 2023-04-17
 */
@Service
public class SysBlogTypeServiceImpl extends ServiceImpl<SysBlogTypeMapper, SysBlogType> implements ISysBlogTypeService {

    @Autowired
    SysBlogTypeMapper sysBlogTypeMapper;

    @Override
    public List<SysBlogType> selectAll() {
        QueryWrapper<SysBlogType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", StpUtil.getLoginId());
        return sysBlogTypeMapper.selectList(queryWrapper);
    }

    @Override
    public SysBlogType selectOne(Integer id) {
        QueryWrapper<SysBlogType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        queryWrapper.eq("user_id", StpUtil.getLoginId());
        return sysBlogTypeMapper.selectOne(queryWrapper);
    }

    @Override
    public void delete(Integer id) {
        sysBlogTypeMapper.deleteById(id);
    }
}
