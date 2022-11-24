package com.Bean;

/**
 * 板块对象类
 */
public class SectionInfo {

	private Integer sid; // 版块编号
	private String sname;// 版块名
	private Integer smasterid;// 版主编号
	private Integer stopiccount;// 帖子数量
	private Integer sparentid;// 父版块编号

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public Integer getSmasterid() {
		return smasterid;
	}

	public void setSmasterid(Integer smasterid) {
		this.smasterid = smasterid;
	}

	public Integer getStopiccount() {
		return stopiccount;
	}

	public void setStopiccount(Integer stopiccount) {
		this.stopiccount = stopiccount;
	}

	public Integer getSparentid() {
		return sparentid;
	}

	public void setSparentid(Integer sparentid) {
		this.sparentid = sparentid;
	}

}
