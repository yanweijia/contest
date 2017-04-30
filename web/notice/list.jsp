<%@ page import="entity.Notice" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.NoticeDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-26
  Time: 0:31
  参数说明:
    pageNum 页号 整型
    perPage 每页新闻个数 整型
    type   新闻类型,可选值:新闻 公告 大赛信息
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String str_pageNum = request.getParameter("pageNum");
    String str_perPage = request.getParameter("perPage");
    String type = request.getParameter("type");
    int pageNum=1,perPage=8;
    if(str_pageNum!=null && str_perPage !=null){
        pageNum = Integer.parseInt(str_pageNum);
        perPage = Integer.parseInt(str_perPage);
    }
    List<Notice> list = NoticeDao.getNoticeByPage(pageNum,perPage);
    pageContext.setAttribute("noticeList",list);
%>

<div class="noticeList" style="width:100%;">
    <table>

    </table>


    <ul style="width:90%;">
        <c:forEach var="notice" items="${noticeList}" varStatus="status">
        <li class="notice_li">
            <span class="notice_date">
                    ${fn:substring(notice.posttime, 0, 10)}
            </span>
            <div class="notice_title">
                <a href="viewNotice.jsp?nid=${notice.nid}" target="_blank">${notice.title}
                </a>
            </div>
        </li>
        </c:forEach>
    </ul>
</div>
<style>
    .notice_date{
        display:block;
        float:right;
    }
    .notice_li{
        height:30px;
        overflow:hidden;
    }
    .notice_title{
        width:200px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
</style>