package com.Bean;

import java.util.Date;

/**
 * 普通用户对象类
 */
public class UserInfo {
	private Integer uid;			//用户id
	private String uname;			//用户名
	private String upassword;		//用户密码
	private Boolean usex;			//用户性别
	private String uface;			//用户头像路径
	private Date uregtime;			//用户注册时间
	private Integer utype;			//用户类型
	private boolean uActive = true;	//用户状态，true正常，false封禁，默认true

	public Integer getUtype() {
		return utype;
	}
	public void setUtype(Integer utype) {
		this.utype = utype;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpassword() {
		return upassword;
	}
	public void setUpassword(String upassword) {
		this.upassword = upassword;
	}
	public Boolean getUsex() {
		return usex;
	}
	public void setUsex(Boolean usex) {
		this.usex = usex;
	}
	public String getUface() {
		return uface;
	}
	public void setUface(String uface) {
		this.uface = uface;
	}
	public Date getUregtime() {
		return uregtime;
	}
	public void setUregtime(Date uregtime) {
		this.uregtime = uregtime;
	}

	public boolean isuActive()
	{
		return uActive;
	}

	public void setuActive(boolean uActive)
	{
		this.uActive = uActive;
	}
}

