package com.pageDividing;

import com.Bean.SectionInfo;
import com.dao.ReplyInfoDAO;
import com.dao.SectionInfoDAO;
import com.dao.TopicInfoDAO;
import com.page.DetailPage;
import com.page.ListPage;

import java.util.ArrayList;
import java.util.List;


/**
 * @author ldy
 * 创建分页标签处理类DivPageDAO
 * service层 –将Dao从数据库中拿到的数据封装到page对象
 */

public class DivPageDAO {

    /**
     * @param tid 主题编号
     * @param pageNo 传入页号
     * @param pageSize 传入页面大小
     * @return Page<DetailPage>结果集
     *
     * 根据传入的tid为该主题的replyList构造相应第pageNo页的Page<DetailPage>结果集
     */
    public Page<DetailPage> CreatDetailPageInfoTid(Integer tid, Integer pageNo, Integer pageSize) {

        Page<DetailPage> pm = new Page<DetailPage>();
        List<DetailPage> replyList = null;

        //确认传入tid不为空
        if (tid != null) {
            ReplyInfoDAO replyInfoDAO = new ReplyInfoDAO();
            replyList = replyInfoDAO.getReplyInfoAndUserInfoById(tid);

            //总页数赋值
            if (replyList.size() % pageSize == 0) {
                pm.setTotal(replyList.size() / pageSize);
            } else {
                pm.setTotal(replyList.size() / pageSize + 1);
            }

            //页号赋值
            pm.setPageNo(pageNo);

            if(pageNo!=0) {
                //计算第pageNo页的结果集
                List<DetailPage> res = new ArrayList<DetailPage>();
                for (int i = (pageNo - 1) * pageSize; i < pageSize * pageNo; i++) {
                    if (i < replyList.size())
                        res.add(replyList.get(i));
                    System.out.println(i);
                }

                //当前页信息存放的列表赋值
                pm.setSize(res.size());

                //当前页信息存放的列表赋值
                pm.setRows(res);
            }
        }

        //测试
        //System.out.println(replyList.size());
        //System.out.println(replyList.get(replyList.size()-1).getTitle());
        System.out.println(pm.toString());
        return pm;
    }

    /**
     *
     * @param tid 主题编号
     * @return 回复reply的数量
     */
    public Integer getReplyCountInfoTid(Integer tid) {

        Integer count = 0;

        //确认传入tid不为空
        if (tid != null) {
            ReplyInfoDAO replyInfoDAO = new ReplyInfoDAO();
            List<DetailPage> replyList = replyInfoDAO.getReplyInfoAndUserInfoById(tid);
            count=replyList.size();
        }
        return count;
    }

    /**
     * @param sid 板块编号
     * @param pageNo 传入页号
     * @param pageSize 传入页面大小
     * @return Page<DetailPage>结果集
     *
     * 根据传入的tid为该主题的replyList构造相应第pageNo页的Page<DetailPage>结果集
     */
    public Page<ListPage> CreatListPageInfoSid(Integer sid, Integer pageNo, Integer pageSize) {

        Page<ListPage> pm = new Page<ListPage>();
        List<ListPage> topicList = null;

        //确认传入tid不为空
        if (sid != null) {
            TopicInfoDAO topicInfoDAO = new TopicInfoDAO();
            topicList = topicInfoDAO.getTopicInfoById(sid);

            //总页数赋值
            if (topicList.size() % pageSize == 0) {
                pm.setTotal(topicList.size() / pageSize);
            } else {
                pm.setTotal(topicList.size() / pageSize + 1);
            }

            //页号赋值
            pm.setPageNo(pageNo);

            if(pageNo!=0) {
                //计算第pageNo页的结果集
                List<ListPage> res = new ArrayList<ListPage>();
                for (int i = (pageNo - 1) * pageSize; i < pageSize * pageNo; i++) {
                    if (i < topicList.size())
                        res.add(topicList.get(i));
                    System.out.println(i);
                }

                //当前页信息存放的列表赋值
                pm.setSize(res.size());

                //当前页信息存放的列表赋值
                pm.setRows(res);
            }
        }

        System.out.println(pm.toString());
        return pm;
    }

    /**
     *
     * @param sid 主题编号
     * @return 板块下主题topic的数量
     */
    public Integer getTopicCountInfoSid(Integer sid) {

        Integer count = 0;

        //确认传入tid不为空
        if (sid != null) {
            TopicInfoDAO topicInfoDAO = new TopicInfoDAO();
            List<ListPage> topicList = topicInfoDAO.getTopicInfoById(sid);
            count=topicList.size();
        }
        return count;
    }
    /**
     * @param sid 板块编号
     * @param pageNo 传入页号
     * @param pageSize 传入页面大小
     * @return Page<SectionInfo>结果集
     *
     * 根据传入的tid为该主题的replyList构造相应第pageNo页的Page<DetailPage>结果集
     */
    public Page<SectionInfo> CreatSectionInfoPageInfoSid(Integer sid, Integer pageNo, Integer pageSize) {

        Page<SectionInfo> pm = new Page<SectionInfo>();
        List<SectionInfo> sectionList = null;

        //确认传入tid不为空
        if (sid != null) {
            SectionInfoDAO sectionInfoDAO = new SectionInfoDAO();
            sectionList = sectionInfoDAO.getSectionById(sid);

            //总页数赋值
            if (sectionList.size() % pageSize == 0) {
                pm.setTotal(sectionList.size() / pageSize);
            } else {
                pm.setTotal(sectionList.size() / pageSize + 1);
            }

            //页号赋值
            pm.setPageNo(pageNo);

            if(pageNo!=0) {
                //计算第pageNo页的结果集
                List<SectionInfo> res = new ArrayList<SectionInfo>();
                for (int i = (pageNo - 1) * pageSize; i < pageSize * pageNo; i++) {
                    if (i < sectionList.size())
                        res.add(sectionList.get(i));
                    System.out.println(i);
                }

                //当前页信息存放的列表赋值
                pm.setSize(res.size());

                //当前页信息存放的列表赋值
                pm.setRows(res);
            }
        }

        System.out.println(pm.toString());
        return pm;
    }

    /**
     *
     * @param sid 板块编号
     * @return 父板块下子版块section的数量
     */
    public Integer getSectionCountInfoSid(Integer sid) {

        Integer count = 0;

        //确认传入tid不为空
        if (sid != null) {
            SectionInfoDAO sectionInfoDAO = new SectionInfoDAO();
            List<SectionInfo> sectionList = sectionInfoDAO.getSectionById(sid);
            count=sectionList.size();
        }
        return count;
    }


}


