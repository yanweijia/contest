<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.Notice" %>
<%@ page import="dao.NoticeDao" %>
<%@ page import="utils.NetUtils" %>
<%@ page import="utils.ConfigUtils" %>
<%--
    根据传递进来的参数nid来显示指定新闻.
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-23
  Time: 1:20
--%>
<%
    String noticeID = request.getParameter("nid");
    int nid = 0;
    if (noticeID == null) {
        out.println("错误:无法获取新闻编号.");
        return;
    }
    try {
        nid = Integer.parseInt(noticeID);
    } catch (Exception e) {
        out.println("错误:无法识别新闻编号!");
        return;
    }

    Notice notice = NoticeDao.getNoticeByID(nid);
    if (notice == null) {
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


<html>
<head>
    <title><%=noticeTitle %> - <%=ConfigUtils.getString("websiteName", "大学生计算机应用能力大赛") %>
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <jsp:include page="/plug-in/paper-kit-style/css.jsp"/>

    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/index.css" type="text/css"/>
    <link href="<%=NetUtils.getBasePath(request) %>resource/css/viewNotice.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%--页面顶部通用导航条--%>
<jsp:include page="/page/header.jsp"/>

<div class="div-index-content">
    <div>
        <h3 class='notice-title center' style="font-weight:bold;">
            <%=noticeTitle %>
        </h3>

        <p class="notice-metas center">
        <span class='notice-type inline'>
            分类：<%=type %>
        </span>&nbsp;
            <span class='notice-posttime inline'>
            发布时间：<%=postTime.substring(0, 16) %>
        </span>&nbsp;
            <span class='notice-author inline'>
            发布人：<%=noticeAuthor %>
        </span>&nbsp;
            <span class='notice-count inline'>
            浏览次数：<%=viewCount %>
        </span>
        </p>
        <hr class='hr-gray'/>
        <div class='notice-content'>
            <%=content %>
        </div>
    </div>

</div>

<%--页脚--%>
<jsp:include page="/page/footer.jsp"/>

<%--header.jsp已经引用过JQuery,不用再次引用--%>
<script type="text/javascript"
        src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/jquery.nivo.slider.js"></script>

<%--引用paper-kit风格--%>
<jsp:include page="/plug-in/paper-kit-style/js.jsp"/>

<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/index.js"></script>
</body>
</html>