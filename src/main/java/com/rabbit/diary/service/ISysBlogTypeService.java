package com.rabbit.diary.service;

import com.rabbit.diary.bean.SysBlogType;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rabbit.diary.bean.TblSynBlog;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 鑫
 * @since 2023-04-17
 */
public interface ISysBlogTypeService extends IService<SysBlogType> {

    List<SysBlogType> selectAll();

    SysBlogType selectOne(Integer id);

    void delete(Integer id);
}
