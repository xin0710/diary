package com.rabbit.diary.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.User;
import com.rabbit.diary.dao.BlogMapper;
import com.rabbit.diary.dao.UserMapper;
import com.rabbit.diary.redis.RedisServiceImpl;
import com.rabbit.diary.service.BlogService;
import com.rabbit.diary.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BlogServiceImpl implements BlogService {

    @Autowired
    BlogMapper blogMapper;

    @Autowired
    RedisServiceImpl redisServiceImpl;


    /**
     * 保存
     * @param blog
     */
    @Override
    public void save(TblSynBlog blog) {
        blogMapper.insert(blog);
    }

    @Override
    public Page<TblSynBlog> selectPage(Page<TblSynBlog> pageBean, TblSynBlog blog) {
        QueryWrapper<TblSynBlog> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("update_date");
        //只允许查看自己发布的日记
        queryWrapper.eq("user_id", StpUtil.getLoginId());
        queryWrapper.eq("is_delete", "0");

        if(StrUtil.isNotEmpty(blog.getBlogType())){
            queryWrapper.eq("blog_type",blog.getBlogType());
        }

        //按照具体日期来查
        if(StrUtil.isNotEmpty(blog.getDate())){
            queryWrapper.eq("date_format(str_to_date(create_date,'%Y-%m-%d %H:%i:%s'),'%Y-%m-%d')",blog.getDate());
        }

        //按照关键字来查
        if(StrUtil.isNotEmpty(blog.getKws())){
            queryWrapper.like("title",blog.getKws() );
            queryWrapper.or().like("content",blog.getKws());

        }

        return blogMapper.selectPage(pageBean,queryWrapper);
    }

    @Override
    public TblSynBlog selectOne(Long id) {
        /**
         * 根据id和用户ID查询日志
         */
        QueryWrapper<TblSynBlog> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        queryWrapper.eq("user_id", StpUtil.getLoginId());

        return blogMapper.selectOne(queryWrapper);
    }

    @Override
    public void updateById(TblSynBlog tblSynBlog) {
        blogMapper.updateById(tblSynBlog);
    }

    @Override
    public void delete(Long id) {
        blogMapper.deleteByIdLogic(id);
    }

    @Override
    public List<Map<String, String>> getBlogsStatistics() {
        return blogMapper.getBlogsStatistics(StpUtil.getLoginIdAsLong());
    }


}
