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
    <title>上海市大学生计算机应用能力大赛</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/themes/default/default.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/index.css" type="text/css" />
</head>
<body>
    <div class="header">
        <h1>上海市大学生计算机应用能力大赛</h1>
    </div>

    <div id="wrapper">
        <div class="slider-wrapper theme-default">
            <div id="slider" class="nivoSlider">
                <a href="#"><img class="img-wrap" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img1.jpg" alt="" /></a>
                <a href="#"><img class="img-wrap" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img2.jpg" alt="" title="这是第二幅图" /></a>
                <a href="#"><img class="img-wrap" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img3.jpg" alt="" /></a>
                <a href="#"><img class="img-wrap" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img4.jpg" alt="" title="这是第四幅图" data-thumb="images/img4.jpg" /></a>
            </div>
        </div>
    </div>
</body>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/jquery.nivo.slider.js"></script>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/index.js"></script>
</html>