package com.page;

/**
 *	帖子列表页面类
 */
public class ListPage {
	
	private  String title;
	private String author;
	private Integer replycount;
	private Integer tid;
	private boolean tisTop;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Integer getReplycount() {
		return replycount;
	}
	public void setReplycount(Integer replycount) {
		this.replycount = replycount;
	}
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public boolean getTisTop() {
		return tisTop;
	}

	public void setTisTop(boolean tisTop) {
		this.tisTop = tisTop;
	}

}

