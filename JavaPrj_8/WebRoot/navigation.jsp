<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*"%>
<%
	SectionInfoDAO sectioninfo_dao = new SectionInfoDAO();
	//
	Integer page_sid = (Integer) pageContext.getAttribute("page_sid");
	//
	List<NavigationPage> page_list = sectioninfo_dao
			.getNavigationMenuById(page_sid);
	//
	for (int i = page_list.size()-1; i >= 0; i--) {
%>
	<B>>>
	<a href="servletListPage?sid=<%=page_list.get(i).getSid()%>"><%=page_list.get(i).getSname()%></a>
	</B>
<%
	}
	sectioninfo_dao.clearList();
	//out.print(page_list.size());
%>
