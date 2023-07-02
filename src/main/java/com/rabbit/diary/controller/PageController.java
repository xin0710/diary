package com.rabbit.diary.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.stp.StpUtil;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.User;
import com.rabbit.diary.service.BlogService;
import com.rabbit.diary.service.ISysBlogTypeService;
import com.rabbit.diary.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {

    @Autowired
    BlogService blogService;
    @Autowired
    ISysBlogTypeService sysBlogTypeService;

    @Autowired
    UserService userService;

    @RequestMapping("login")
    public String login(){
        return "login";
    }

    @RequestMapping("/")
    @SaCheckLogin
    public ModelAndView index(@RequestParam(required=false) String blogType,@RequestParam(required=false) String date,
                              @RequestParam(required=false) String kws,ModelAndView mav){
        mav.setViewName("index");
        mav.addObject("blogType",blogType);
        mav.addObject("date",date);
        mav.addObject("kws",kws);
        mav.addObject("statistics",blogService.getBlogsStatistics());
        return mav;
    }

    @RequestMapping("diary/add.html")
    @SaCheckLogin
    public ModelAndView addDiary(@RequestParam(required=false) Long id, ModelAndView mav){
        mav.setViewName("diary/add");
        mav.addObject("id",id);
        mav.addObject("types",sysBlogTypeService.selectAll());
        mav.addObject("statistics",blogService.getBlogsStatistics());
        return mav;
    }

    @RequestMapping("diary/user.html")
    @SaCheckLogin
    public ModelAndView user( ModelAndView mav){
        mav.setViewName("diary/user");
        User byUserId = userService.getByUserId(StpUtil.getLoginIdAsLong());
        mav.addObject("user", byUserId);
        mav.addObject("statistics",blogService.getBlogsStatistics());
        return mav;
    }

    @RequestMapping("diary/{id}.html")
    @SaCheckLogin
    public ModelAndView getDiary(@PathVariable Long id, ModelAndView mav){
        TblSynBlog tblSynBlog = blogService.selectOne(id);
        mav.addObject("blog",tblSynBlog);
        mav.addObject("statistics",blogService.getBlogsStatistics());
        mav.setViewName("detail");
        return mav;
    }

    /**
     * 日记分类
     * @param mav
     * @return
     */
    @RequestMapping("diary/blogType.html")
    @SaCheckLogin
    public ModelAndView blogTypePage(ModelAndView mav){
        mav.setViewName("blogType/index");
        mav.addObject("statistics",blogService.getBlogsStatistics());
        return mav;
    }

    /**
     * 日记分类
     * @param id
     * @param mav
     * @return
     */
    @RequestMapping("diary/blogType/add.html")
    @SaCheckLogin
    public ModelAndView blogTypeAdd(@RequestParam(required=false) Long id, ModelAndView mav){
        mav.setViewName("blogType/add");
        mav.addObject("id",id);
        mav.addObject("statistics",blogService.getBlogsStatistics());
        return mav;
    }


}
