package com.rabbit.diary.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author 鑫
 * @since 2023-04-17
 */
@Data
  @EqualsAndHashCode(callSuper = false)
    @TableName("sys_blog_type")
public class SysBlogType implements Serializable {


      @TableId(value = "id", type = IdType.AUTO)
      private Integer id;

    @TableField("type_name")
    private String typeName;

    @TableField("create_date")
    private String createDate;

    @TableField("user_id")
    private Integer userId;


}
