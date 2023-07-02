package com.rabbit.diary.bean;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


@TableName("user_base")
@Data
public class User {
    @TableId
    private Long uid;
    private Integer userRole;
    private Integer registerSource;
    private String userName;
    private String password;
    private String nickName;
    private Integer gender;
    private String birthday;
    private String signature;
    private String mobile;
    private String mobileBindTime;
    private String email;
    private String emailBindTime;
    private String face;
    private String face200;
    private String srcface;
    private String createTime;
    private String updateTime;


}
