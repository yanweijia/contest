<%@ page import="utils.NetUtils" %>
<%@ page import="utils.ConfigUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-05-15
  Time: 00:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%=request.getParameter("type")==null?"":(request.getParameter("type") + " - ")%>
        <%=ConfigUtils.getString("indextitle","大学生计算机应用能力大赛") %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <jsp:include page="plug-in/paper-kit-style/css.jsp"/>

    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/index.css" type="text/css" />

</head>
<body>
    <%--页面顶部通用导航条--%>
    <jsp:include page="page/header.jsp"/>

    <div class="div-index-content">
        <h3>${param.type}</h3>
        <div class="div-index-message" style="margin-top:30px;">
             <div class="tab-pane" id="contest-news">
                 <%--右上角还可以显示总新闻个数--%>
                 <%--这里放大赛新闻--%>
                 <jsp:include page="notice/list.jsp">
                     <jsp:param name="pageNum" value="${(empty param.pageNum)?1:param.pageNum}"/>
                     <jsp:param name="perPage" value="${(empty param.perPage)?20:param.perPage}"/>
                     <jsp:param name="pageType" value="maxi"/>
                     <jsp:param name="type" value="${(empty param.type)?\"新闻\":param.type}"/>
                 </jsp:include>
                 <%--TODO:如果新闻很多还应该有翻页按钮--%>
             </div>
        </div>
    </div>

    <%--页脚--%>
    <jsp:include page="page/footer.jsp"/>

    <%--header.jsp已经引用过JQuery,不用再次引用--%>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/jquery.nivo.slider.js"></script>

    <%--引用paper-kit风格--%>
    <jsp:include page="plug-in/paper-kit-style/js.jsp"/>

    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/index.js"></script>
</body>
</html>