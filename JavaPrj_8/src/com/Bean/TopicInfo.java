package com.Bean;

import java.util.Date;

/**
 * 帖子对象类
 */
public class TopicInfo {
	private Integer tid;			// 帖子编号
	private Integer tsid;			// 所在版块编号
	private Integer tuid;			// 发帖用户编号
	private String ttopic;			// 帖子标题
	private String tcontents;		// 帖子内容
	private Integer treplycount;	// 回复数量
	private Integer tclickcount; 	// 点击数量
	private Date tpublishtime;		// 发帖时间
	private Date tmodifytime; 		// 修改时间

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public Integer getTsid() {
		return tsid;
	}

	public void setTsid(Integer tsid) {
		this.tsid = tsid;
	}

	public Integer getTuid() {
		return tuid;
	}

	public void setTuid(Integer tuid) {
		this.tuid = tuid;
	}

	public String getTtopic() {
		return ttopic;
	}

	public void setTtopic(String ttopic) {
		this.ttopic = ttopic;
	}

	public String getTcontents() {
		return tcontents;
	}

	public void setTcontents(String tcontents) {
		this.tcontents = tcontents;
	}

	public Integer getTreplycount() {
		return treplycount;
	}

	public void setTreplycount(Integer treplycount) {
		this.treplycount = treplycount;
	}

	public Integer getTclickcount() {
		return tclickcount;
	}

	public void setTclickcount(Integer tclickcount) {
		this.tclickcount = tclickcount;
	}

	public Date getTpublishtime() {
		return tpublishtime;
	}

	public void setTpublishtime(Date tpublishtime) {
		this.tpublishtime = tpublishtime;
	}

	public Date getTmodifytime() {
		return tmodifytime;
	}

	public void setTmodifytime(Date tmodifytime) {
		this.tmodifytime = tmodifytime;
	}
}
