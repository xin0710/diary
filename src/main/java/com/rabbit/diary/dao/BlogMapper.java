package com.rabbit.diary.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rabbit.diary.bean.TblSynBlog;
import com.rabbit.diary.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

@Mapper
public interface BlogMapper extends BaseMapper<TblSynBlog> {

    @Update("update tbl_syn_blog set is_delete = '1' where id = #{id}")
    void deleteByIdLogic(Long id);

    List<Map<String,String>> getBlogsStatistics(Long userId);
}
