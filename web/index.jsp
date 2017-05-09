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

    <div class="div-index-content">
        <%--nivo-slider轮播图片--%>
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
        <div class="div-index-message">
            <div class="div-index-left">
                <p>
                    学校联络人确认截止：2016年11月15日 <br/>
                    网上报名：2016年12月01日到2017年1月15日<br/>
                    <%--作品提交：2017年03月20日到03月28日<br/>--%>
                    <%--报名费汇款期限：2017年03月20日到03月28日<br/>--%>
                    <%--初　　赛：2017年04月08日到04月09日<br/>--%>
                    <%--决　　赛：2017年04月15日到04月16日<br/>--%>
                    <%--颁　　奖：2017年5月--%>
                </p>
            </div>
            <div class="div-index-notice">
                <div class="nav-tabs-navigation">
                    <div class="nav-tabs-wrapper">
                        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                            <li class="active"><a href="#contest-notice" data-toggle="tab">通知</a></li>
                            <li><a href="#contest-news" data-toggle="tab">新闻</a></li>
                            <li><a href="#contest-message" data-toggle="tab">大赛信息</a></li>
                        </ul>
                    </div>
                </div>
                <div id="notice-tab-content" class="tab-content text-center">
                    <div class="tab-pane active" id="contest-notice">
                        <p>这里放大赛通知</p>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=通知&pageType=mini"/>
                    </div>
                    <div class="tab-pane" id="contest-news">
                        <p>这里放大赛新闻</p>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=新闻&pageType=mini"/>
                    </div>
                    <div class="tab-pane" id="contest-message">
                        <p>这里放大赛信息</p>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=大赛信息&pageType=mini"/>
                    </div>
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