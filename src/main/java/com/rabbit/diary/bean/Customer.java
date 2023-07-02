package com.rabbit.diary.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Customer {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String name;
    private String idno;
    private String isDel;
}
