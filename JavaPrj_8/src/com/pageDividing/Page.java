package com.pageDividing;

import java.util.List;

/**
 * 分页Bean，一个非持久化的组件
 * @author ldy
 *
 */
public class Page<T>  {

    private int total;//信息总数
    private int pageNo;//当前页
    private int size;//每页信息条数
    private List<T> rows;//每一页的信息存放的列表

    @Override
    public String toString() {
        return "Page{" +
                "total=" + total +
                ", pageNo=" + pageNo +
                ", size=" + size +
                ", rows=" + rows +
                '}';
    }

    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public int getPageNo() {
        return pageNo;
    }
    public void setPageNo(int page) {
        this.pageNo = page;
    }
    public int getSize() {
        return size;
    }
    public void setSize(int size) {
        this.size = size;
    }
    public List<T> getRows() {
        return rows;
    }
    public void setRows(List<T> rows) {
        this.rows = rows;
    }

}