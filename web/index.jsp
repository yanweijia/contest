<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-20
  Time: 21:37
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
%>
<html>
<head>
    <title>大学生计算机应用能力大赛</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <jsp:include page="plug-in/paper-kit-style/css.jsp"/>

    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/index.css" type="text/css" />

    <%--引用nivo-slider图片轮播--%>
    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/themes/default/default.css" type="text/css" media="screen" />
</head>
<body>
    <%--页面顶部通用导航条--%>
    <jsp:include page="page/header.jsp"/>

    <div class="content">
        <div id="wrapper">
            <div class="slider-wrapper theme-default">
                <div id="slider" class="nivoSlider">
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img1.jpg" alt="" /></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img2.jpg" alt="" title="这是第二幅图" /></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img3.jpg" alt="" /></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img4.jpg" alt="" title="这是第四幅图" data-thumb="images/img4.jpg" /></a>
                </div>
            </div>
        </div>
    </div>

    <%--页脚--%>
    <jsp:include page="page/footer.jsp"/>

    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/jquery.nivo.slider.js"></script>

    <%--引用paper-kit风格--%>
    <jsp:include page="plug-in/paper-kit-style/js.jsp"/>

    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/index.js"></script>
</body>
</html>