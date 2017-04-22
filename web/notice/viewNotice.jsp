<%@ page import="entity.Notice" %>
<%@ page import="dao.NoticeDao" %><%--
    根据传递进来的参数nid来显示指定新闻.
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-23
  Time: 1:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String noticeID = request.getParameter("nid");
    int nid = 0;
    if(noticeID == null){
        out.println("错误:无法获取新闻编号.");
        return;
    }
    try{nid = Integer.parseInt(noticeID);}catch(Exception e){out.println("错误:无法识别新闻编号!");return;}

    Notice notice = NoticeDao.getNoticeByID(nid);
    if(notice == null){
        out.println("您要查看的新闻不存在或已被删除!");
        return;
    }
    String noticeAuthor = notice.getAuthor();
    String postTime = notice.getPosttime().toString();
    long viewCount = notice.getViewcount();
    String noticeTitle = notice.getTitle();
    String type = notice.getType();
    String content = notice.getContent();
%>

