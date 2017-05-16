<%@ page import="utils.NetUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>(管理员)后台管理 - 上海市大学生应用能力技术大赛</title>
    <meta name="author" content="weijia"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
        body{margin:0;padding:0;overflow-x:hidden;}
        html, body{height:100%;}
        img{border:none;}
        *{font-family:'微软雅黑';font-size:12px;color:#626262;}
        dl,dt,dd{display:block;margin:0;}
        a{text-decoration:none;}

        #bg{background-image:url(/resource/image/admin/dotted.png);}
        .pageContainer{width:100%;height:100%;margin:auto;}
        .container{height:100%;overflow: hidden;}
        /*left*/
        .leftsidebar_box{float:left;width:20%;max-width:160px;height:100% !important;background-color:#3992d0;}
        .line{height:2px;width:100%;}
        .leftsidebar_box dt{padding-left:40px;padding-right:10px;background-repeat:no-repeat;background-position:10px center;color:#f5f5f5;font-size:14px;position:relative;line-height:48px;cursor:pointer;}
        .leftsidebar_box dd{background-color:#317eb4;padding-left:40px;}
        .leftsidebar_box dd a{color:#f5f5f5;line-height:20px;}
        .leftsidebar_box dt img{position:absolute;right:10px;top:20px;}
        .leftsidebar_box dl dd:last-child{padding-bottom:10px;}
    </style>
</head>
<body id="bg">
<div class="pageContainer">
    <div class="leftsidebar_box">
        <div class="line"></div>
        <dl class="system_log">
            <dt>系统记录<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">充值记录</a></dd>
            <dd><a href="#">短信充值记录</a></dd>
            <dd><a href="#">消费记录</a></dd>
            <dd><a href="#">操作记录</a></dd>
        </dl>

        <dl class="custom">
            <dt>客户管理<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">客户管理</a></dd>
            <dd><a href="#">试用/成交客户管理</a></dd>
            <dd><a href="#">未成交客户管理</a></dd>
            <dd><a href="#">即将到期客户管理</a></dd>
        </dl>

        <dl class="channel">
            <dt>渠道管理<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">渠道主页</a></dd>
            <dd><a href="#">渠道标准管理</a></dd>
            <dd><a href="#">系统通知</a></dd>
            <dd><a href="#">渠道商管理</a></dd>
            <dd><a href="#">渠道商链接</a></dd>
        </dl>

        <dl class="app">
            <dt>APP管理<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">App运营商管理</a></dd>
            <dd><a href="#">开放接口管理</a></dd>
            <dd><a href="#">接口类型管理</a></dd>
        </dl>

        <dl class="cloud">
            <dt>大数据云平台<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">平台运营商管理</a></dd>
        </dl>

        <dl class="syetem_management">
            <dt>系统管理<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">后台用户管理</a></dd>
            <dd><a href="#">角色管理</a></dd>
            <dd><a href="#">客户类型管理</a></dd>
            <dd><a href="#">栏目管理</a></dd>
            <dd><a href="#">微官网模板组管理</a></dd>
            <dd><a href="#">商城模板管理</a></dd>
            <dd><a href="#">微功能管理</a></dd>
            <dd><a href="#">修改用户密码</a></dd>
        </dl>

        <dl class="source">
            <dt>素材库管理<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">图片库</a></dd>
            <dd><a href="#">链接库</a></dd>
            <dd><a href="#">推广管理</a></dd>
        </dl>

        <dl class="statistics">
            <dt>统计分析<img src="/resource/image/admin/select_xl01.png"></dt>
            <dd class="first_dd"><a href="#">客户统计</a></dd>
        </dl>

    </div>
    <div class="container">
        这里放动态的内容
    </div>
</div>

<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
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
