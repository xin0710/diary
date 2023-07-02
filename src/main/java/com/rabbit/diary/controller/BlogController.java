package com.rabbit.diary.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.core.Result;
import com.rabbit.diary.redis.RedisServiceImpl;
import com.rabbit.diary.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/blog")
public class BlogController {

    @Autowired
    BlogService blogService;

    @Autowired
    RedisServiceImpl redisServiceImpl;

    @RequestMapping("/delete")
    @SaCheckLogin
    public Result delete(@RequestParam Long id ){
        blogService.delete(id);
        return Result.success();
    }

    @RequestMapping("/get")
    @SaCheckLogin
    public TblSynBlog get(@RequestParam Long id ){
        TblSynBlog blog = blogService.selectOne(id);
        return blog;
    }

    @RequestMapping("/select")
    @SaCheckLogin
    public Page<TblSynBlog> select(@RequestBody TblSynBlog blog,
                                   @RequestParam Integer pageIndex, @RequestParam Integer size){
        Page<TblSynBlog> pageBean = new Page<>(pageIndex,size);
        Page<TblSynBlog> page = blogService.selectPage(pageBean,blog);
        return page;
    }

    /**
     * 新增或者修改
     * @param blog
     * @return
     */
    @RequestMapping("/add")
    @SaCheckLogin
    public Result add(@RequestBody TblSynBlog blog){

        //新增
        if(StrUtil.isBlankIfStr(blog.getId())){
            //拼装BlogBean
            blog.setId(redisServiceImpl.getIncr("BlogId")); //redis自增ID
            blog.setCreateDate(DateUtil.now());
            blog.setUserId(StpUtil.getLoginIdAsLong());
            blog.setUpdateDate(DateUtil.now());
            blogService.save(blog);
        }else{
            //修改
            TblSynBlog tblSynBlog = blogService.selectOne(blog.getId());
            BeanUtil.copyProperties(blog,tblSynBlog);
            tblSynBlog.setUpdateDate(DateUtil.now());
            blogService.updateById(tblSynBlog);
        }


        return Result.success();
    }




}