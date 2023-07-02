package com.rabbit.diary.controller;


import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbit.diary.bean.SysBlogType;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.core.BizException;
import com.rabbit.diary.bean.core.ExceptionCodeEnum;
import com.rabbit.diary.bean.core.Result;
import com.rabbit.diary.service.BlogService;
import com.rabbit.diary.service.ISysBlogTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 鑫
 * @since 2023-04-17
 */
@RestController
@RequestMapping("/sys-blog-type")
@SaCheckLogin
public class SysBlogTypeController {

    @Autowired
    ISysBlogTypeService sysBlogTypeService;

    @Autowired
    BlogService blogService;

    @RequestMapping("/selectAll")
    public List<SysBlogType> selectAll(){
        return sysBlogTypeService.selectAll();
    }

    /**
     * 新增或者修改
     * @return
     */
    @RequestMapping("/add")
    @SaCheckLogin
    public Result add(@RequestBody SysBlogType sysBlogType){

        //新增
        if(StrUtil.isBlankIfStr(sysBlogType.getId())){
            //拼装BlogBean
            sysBlogType.setCreateDate(DateUtil.now());
            sysBlogType.setUserId(StpUtil.getLoginIdAsInt());
            sysBlogTypeService.save(sysBlogType);
        }else{
            //修改
            SysBlogType sysBlogType2 = sysBlogTypeService.selectOne(sysBlogType.getId());
            BeanUtil.copyProperties(sysBlogType,sysBlogType2);
            sysBlogTypeService.updateById(sysBlogType2);
        }


        return Result.success();
    }

    @RequestMapping("/get")
    @SaCheckLogin
    public SysBlogType get(@RequestParam Integer id ){
        SysBlogType sysBlogType = sysBlogTypeService.selectOne(id);
        return sysBlogType;
    }

    @RequestMapping("/delete")
    @SaCheckLogin
    public Result delete(@RequestParam Integer id ){
        //检查是否是自己创建类型
        SysBlogType sysBlogType = sysBlogTypeService.selectOne(id);
        Integer userId = sysBlogType.getUserId();
        if(!userId.equals(StpUtil.getLoginIdAsInt()) ){
            throw new BizException(ExceptionCodeEnum.ERROR_PARAM.setDesc("您无法删除他人的日记类型！"));
        }
        //检查是否有该类型的日记，如果有，则不允许删除
        Integer sysBlogTypeId = sysBlogType.getId();
        Page<TblSynBlog> pageBean = new Page<>(1,10);
        TblSynBlog blog = new TblSynBlog();
        blog.setBlogType(String.valueOf(sysBlogTypeId));
        Page<TblSynBlog> page = blogService.selectPage(pageBean,blog);
        if(page.getTotal() > 0){
            throw new BizException(ExceptionCodeEnum.ERROR_PARAM.setDesc("该类别下还有"+page.getTotal()+"篇日记，不允许删除！"));
        }
        sysBlogTypeService.delete(id);
        return Result.success();
    }

}

