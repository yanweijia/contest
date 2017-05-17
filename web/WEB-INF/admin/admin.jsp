<%@ page import="utils.NetUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>(管理员)后台管理 - 上海市大学生应用能力技术大赛</title>
    <meta name="author" content="weijia"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include page="/plug-in/paper-kit-style/css.jsp"/>
    <link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/admin.css" type="text/css" />
</head>
<body id="bg">
<div class="admin_bar">
    <a href="<%=NetUtils.getBasePath(request )%>" style="margin-left:20px;">返回首页</a>
    <span style="margin-left:30px;">欢迎您:${(empty username)?"神秘人":username}(${(empty type)?"未知用户类型":type})</span>
    <span class="adminbar_logout" onclick="logout();">退出</span>
</div>
<div class="pageContainer">
    <div class="leftsidebar_box">
        <div class="line"></div>
        <br/>
        <dl class="">
            <dt onclick="loadContent('page/admin/welcome.jsp')">欢迎页面<img src=""></dt>
        </dl>

        <dl class="">
            <dt>网站设置<img src=""></dt>
            <dd class="first_dd"><a href="#" onclick="loadContent('page/admin/admin/sliderConfig.jsp')">首页slider维护</a></dd>
            <dd><a href="#" onclick="loadContent('page/admin/admin/websiteConfig.jsp');">网站配置</a></dd>
        </dl>

        <dl class="">
            <dt>学校管理<img src=""></dt>
            <dd class="first_dd"><a href="#">学校查询</a></dd>
            <dd><a href="#">新增学校</a></dd>
            <dd><a href="#">更新学校信息</a></dd>
            <dd><a href="#">学校负责人指定</a></dd>
        </dl>

        <dl class="">
            <dt>用户管理<img src=""></dt>
            <dd class="first_dd"><a href="#">用户查询</a></dd>
            <dd><a href="#">新增用户</a></dd>
            <dd><a href="#">用户信息维护</a></dd>
        </dl>

        <dl class="">
            <dt>作品管理<img src=""></dt>
            <dd class="first_dd"><a href="#" onclick="loadContent('page/admin/viewWorks.jsp')">作品浏览&amp;导出</a></dd>
            <dd><a href="#" onclick="loadContent('page/admin/enrollment_table.jsp')">新增作品</a></dd>
        </dl>

        <dl class="">
            <dt>我的账户<img src=""></dt>
            <dd class="first_dd"><a href="#" onclick="loadContent('page/admin/updateUserInfo.jsp')">信息维护</a></dd>
            <dd><a href="#" onclick="loadContent('page/admin/changePassword.jsp')">修改用户密码</a></dd>
        </dl>

    </div>
    <div class="mycontainer" id="container">
        <jsp:include page="/page/admin/welcome.jsp"/>
    </div>
</div>

<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
<%--引用paper-kit风格--%>
<jsp:include page="/plug-in/paper-kit-style/js.jsp"/>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/admin.js"></script>
<script type="text/javascript">
    $(".leftsidebar_box dt").css({"background-color":"#3992d0"});
    $(".leftsidebar_box dt img").attr("src","/resource/image/admin/select_xl01.png");
    $(function(){
        $(".leftsidebar_box dd").hide();
        $(".leftsidebar_box dt").click(function(){
            $(".leftsidebar_box dt").css({"background-color":"#3992d0"})
            $(this).css({"background-color": "#317eb4"});
            $(this).parent().find('dd').removeClass("menu_chioce");
            $(".leftsidebar_box dt img").attr("src","/resource/image/admin/select_xl01.png");
            $(this).parent().find('img').attr("src","/resource/image/admin/select_xl.png");
            $(".menu_chioce").slideUp();
            $(this).parent().find('dd').slideToggle();
            $(this).parent().find('dd').addClass("menu_chioce");
        });
    })
</script>
</body>
</html>
