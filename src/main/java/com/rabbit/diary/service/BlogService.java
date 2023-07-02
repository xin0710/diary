package com.rabbit.diary.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.User;

import java.util.List;
import java.util.Map;

public interface BlogService {

    void save(TblSynBlog tblSynBlog);

    Page<TblSynBlog> selectPage(Page<TblSynBlog> pageBean, TblSynBlog blog);

    TblSynBlog selectOne(Long id);

    void updateById(TblSynBlog tblSynBlog);

    void delete(Long id);

    List<Map<String, String>> getBlogsStatistics();
}
