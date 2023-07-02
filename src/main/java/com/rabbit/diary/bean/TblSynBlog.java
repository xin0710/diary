package com.rabbit.diary.bean;


import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;


@TableName("tbl_syn_blog")
@Data
public class TblSynBlog {
    @TableId
    private Long id;
    private String title;
    private Long userId;
    private String blogType;
    private String content;
    private String isDelete;
    private String createDate;
    private String updateDate;

    @TableField(exist = false)
    private String date;

    @TableField(exist = false)
    private String kws;
}
