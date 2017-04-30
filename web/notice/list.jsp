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
    type   新闻类型,可选值:新闻 公告 大赛信息  不传显示所有新闻
    pageType 显示类型,两种 分别是:mini(精简版,默认) maxi(包含作者)
  示例:
    list.jsp?pageNum=1&perPage=8&type=新闻&pageType=maxi
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String str_pageNum = request.getParameter("pageNum");
    String str_perPage = request.getParameter("perPage");
    String type = request.getParameter("type");
    String pageType = request.getParameter("pageType");
    if(type == null)
        type = "";  //默认查询所有新闻
    if(pageType == null){
        pageType = "mini";
    }
    pageContext.setAttribute("type",type);
    pageContext.setAttribute("pageType",pageType);
    int pageNum=1,perPage=8;
    if(str_pageNum!=null && str_perPage !=null){
        pageNum = Integer.parseInt(str_pageNum);
        perPage = Integer.parseInt(str_perPage);
    }
    List<Notice> list = NoticeDao.getNoticeByPage(pageNum,perPage,type);
    pageContext.setAttribute("noticeList",list);
%>

<div class="noticeList" style="width:100%;">
    <ul style="width:90%;">
        <c:forEach var="notice" items="${noticeList}" varStatus="status">
            <li class="notice_li">
                <div class="notice_div_right">
                    <c:if test="${fn:contains(pageType, 'maxi')}">
                        <span class="notice_author">
                                ${notice.author}
                        </span>
                    </c:if>

                    <span class="notice_date">
                            ${fn:substring(notice.posttime, 0, 10)}
                    </span>
                </div>
                <div class="notice_title">
                    <a href="viewNotice.jsp?nid=${notice.nid}" target="_blank">${notice.title}
                    </a>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<style>
    .notice_div_right{
        float:right;
    }
    .notice_author{
        vertical-align: center;
        width:100px;
        display:inline-block;
        padding-right: 30px;
        text-align:left;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
    .notice_date{
        display:inline-block;
        float:right;
    }
    .notice_li{
        height:30px;
    }
    .notice_title{
        <%=pageType.equals("maxi")?"width:600px;":"width:200px;"%>
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
</style>