package com.Bean;

import java.util.Date;

/**
 * 跟帖对象类
 */
public class ReplyInfo{
	private Integer rid;			// 跟帖编号
	private Integer rtid;			// 回复的主帖编号
	private Integer rsid; 			// 跟帖所在版块编号
	private Integer ruid; 			// 跟帖人编号
	private String rtopic; 			// 跟帖主题
	private String rcontents; 		// 跟帖内容
	private Date rpublishtime; 		// 跟帖时间
	private Date rmodifytime; 		// 修改时间
	
	public Integer getRid() {
		return rid;
	}
	public void setRid(Integer rid) {
		this.rid = rid;
	}
	public Integer getRtid() {
		return rtid;
	}
	public void setRtid(Integer rtid) {
		this.rtid = rtid;
	}
	public Integer getRsid() {
		return rsid;
	}
	public void setRsid(Integer rsid) {
		this.rsid = rsid;
	}
	public Integer getRuid() {
		return ruid;
	}
	public void setRuid(Integer ruid) {
		this.ruid = ruid;
	}
	public String getRtopic() {
		return rtopic;
	}
	public void setRtopic(String rtopic) {
		this.rtopic = rtopic;
	}
	public String getRcontents() {
		return rcontents;
	}
	public void setRcontents(String rcontents) {
		this.rcontents = rcontents;
	}
	public Date getRpublishtime() {
		return rpublishtime;
	}
	public void setRpublishtime(Date rpublishtime) {
		this.rpublishtime = rpublishtime;
	}
	public Date getRmodifytime() {
		return rmodifytime;
	}
	public void setRmodifytime(Date rmodifytime) {
		this.rmodifytime = rmodifytime;
	}
}
