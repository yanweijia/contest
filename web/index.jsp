<%@ page import="utils.NetUtils" %>
<%@ page import="utils.ConfigUtils" %><%--
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
    <title><%=ConfigUtils.getString("indextitle","大学生计算机应用能力大赛") %></title>
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
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img1.jpg" alt="" title=""/></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img2.jpg" alt="" title="这是第二幅图" /></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img3.jpg" alt="" title=""/></a>
                    <a href="#"><img src="<%=NetUtils.getBasePath(request) %>plug-in/nivo-slider/images/img4.jpg" alt="" title="这是第四幅图" data-thumb="images/img4.jpg" /></a>
                </div>
            </div>
        </div>
        <div class="div-index-message">
            <div class="div-index-left span8">
                <div class="accordion accordionSlider">
                    <ul>
                        <li>
                            <input type="radio" name="select" class="accordion-select" checked />
                            <div class="accordion-title">
                                <span>大赛简介</span>
                            </div>
                            <div class="accordion-content">
                                <p>"大学生计算机应用能力大赛"是由上海市教育委员会、上海市高等学校计算机等级考试委员会和上海市高等学校计算机等级考试命题组举办的上海地区的大学生课外实践竞赛,竞赛官方网站为:<%=NetUtils.getBasePath(request) %></p>
                                <p>自首届竞赛举办以来,坚持“崇尚科学、追求真知、勤奋学习、锐意创新、迎接挑战”的宗旨，在促进青年创新人才成长、深化高校素质教育、推动经济社会发展等方面发挥了积极作用，在社会上产生了广泛而良好的影响</p>
                            </div>
                            <div class="accordion-separator"></div>
                        </li>
                        <li>
                            <input type="radio" name="select" class="accordion-select" />
                            <div class="accordion-title">
                                <span>竞赛时间&amp;参赛对象</span>
                            </div>
                            <div class="accordion-content">
                                <p>学校联络人确认截止：2016年11月15日</p>
                                <p>网上报名：2016年12月01日到2017年1月15日</p>
                                <p>作品提交：2017年03月20日到03月28日</p>
                                <p>报名费汇款期限：2017年03月20日到03月28日</p>
                                <p>初　　赛：2017年04月08日到04月09日</p>
                                <p>决　　赛：2017年04月15日到04月16日</p>
                                <p>颁　　奖：2017年5月

                                <p>
                                    <strong>参赛对象</strong>:上海各高校在校本科学生，以组队方式参加大赛，以学校为单位组织报名、参赛
                                </p>
                            </div>
                            <div class="accordion-separator"></div>
                        </li>
                        <li>
                            <input type="radio" name="select" class="accordion-select" />
                            <div class="accordion-title">
                                <span>作品要求</span>
                            </div>
                            <div class="accordion-content">
                                <p>参赛作品选题必须健康、积极向上，尤其鼓励反映高新技术在各专业中应用的选题，所提交作品应能充分展示当代大学生的计算机应用能力。</p>

                                <strong>注意：</strong>

                                <p>学生在报名参赛时，根据项目的主要技术选择参赛类别。</p>
                                <p>鼓励在竞赛作品中使用国产软件。</p>
                                <p>参赛作品必须是学生在课程学习或自主学习的成果总结，应该由参赛队员独立完成。若引用开源代码和第三方工具，必须在设计说明书中详细说明开源工具来源、工具所完成的功能和参赛队伍开发实现的功能。</p>
                                <p>制作版权问题责任自负。</p>

                            </div>
                            <div class="accordion-separator"></div>
                        </li>
                        <li>
                            <input type="radio" name="select" class="accordion-select" />
                            <div class="accordion-title">
                                <span>作品提交</span>
                            </div>
                            <div class="accordion-content">
                                <p>参赛作品必须为原创作品，作品提交内容包括:</p>
                                <p>作品情况说明表、原创承诺书（承诺书必须由每个参赛队员亲笔签名后转换成电子文档上传）、作品展示视频、系统安装包/可执行文件/可播放文件、源程序代码（源文件）。</p>
                                <p>相关文档可从竞赛网站上下载，提交的文档应按规范命名，具体要求可参见通知，网上报名时将产生参赛编号，用于相关文档的制作。</p>
                            </div>
                            <div class="accordion-separator"></div>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="div-index-notice span4">
                <div class="nav-tabs-navigation">
                    <div class="nav-tabs-wrapper">
                        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                            <li class="active"><a href="#contest-notice" id="noticeNavBar-notice" data-toggle="tab">通知</a></li>
                            <li><a href="#contest-news" id="noticeNavBar-news" data-toggle="tab">新闻</a></li>
                            <li><a href="#contest-info" id="noticeNavBar-info" data-toggle="tab">大赛信息</a></li>
                        </ul>
                    </div>
                </div>
                <div id="notice-tab-content" class="tab-content text-center">
                    <div class="tab-pane active" id="contest-notice">
                        <%--这里放大赛通知--%>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=通知&pageType=mini"/>
                    </div>
                    <div class="tab-pane" id="contest-news">
                        <%--这里放大赛新闻--%>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=新闻&pageType=mini"/>
                    </div>
                    <div class="tab-pane" id="contest-info">
                        <%--这里放大赛信息--%>
                        <jsp:include page="notice/list.jsp?pageNum=1&perPage=8&type=大赛信息&pageType=mini"/>
                    </div>
                </div>
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