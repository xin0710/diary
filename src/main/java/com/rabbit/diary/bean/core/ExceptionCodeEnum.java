package com.rabbit.diary.bean.core;

/**
 * 通用异常枚举
 * @author Administrator
 *
 */
public enum ExceptionCodeEnum {
	SUCCESS("0000","返回成功!"),
	ERROR("1111","与服务方通讯失败，请联系管理员!"),
	NEED_LOGIN("9999", "用户未登录!"),
	ERROR_PARAM("1000", "参数送错了!"),
	EMPTY_PARAM("2000", "参数为空!"),
	;
	
	private String code;
	private String desc;
	
	
	
	private ExceptionCodeEnum(String code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	

	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDesc() {
		return desc;
	}
	
	//为了封装自定义信息，做特殊处理
	public ExceptionCodeEnum setDesc(String desc) {
		this.desc = desc;
		return this;
	}
	
	
}
