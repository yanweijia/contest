<%@ page import="utils.NetUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>用户登录 - 上海市大学生应用能力技术大赛</title>
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" type="text/css" href="<%=NetUtils.getBasePath(request) %>resource/css/login.css" tppabs="css/style.css"/>
    <style>
        body {
            height: 100%;
            background: #8ECFD5;
            overflow: hidden;
        }

        canvas {
            z-index: -1;
            position: absolute;
        }
    </style>
    <script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
    <script src="<%=NetUtils.getBasePath(request) %>resource/js/verificationNumbers.js"></script>
    <script src="<%=NetUtils.getBasePath(request) %>resource/js/login.js"></script>
    <script>
        $(document).ready(function () {
            //粒子背景特效
            $('body').particleground({
                dotColor: '#75bad1',
                lineColor: '#75bad1'
            });
            //验证码
            createCode();
            //测试提交，对接程序删除即可
            $(".submit_btn").click(function () {
                location.href = "javascrpt:;";
            });
        });
    </script>
</head>
<body>
<dl class="admin_login">
    <dt>
        <strong>后台管理系统</strong>
        <em>Management System</em>
    </dt>
    <dd class="user_icon">
        <input type="text" placeholder="账号" class="login_txtbx"/>
    </dd>
    <dd class="pwd_icon">
        <input type="password" placeholder="密码" class="login_txtbx"/>
    </dd>
    <dd class="val_icon">
        <div class="checkcode">
            <input type="text" id="J_codetext" placeholder="验证码" maxlength="4" class="login_txtbx">
            <canvas class="J_codeimg" id="myCanvas" onclick="createCode()">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
        </div>
        <input type="button" value="验证码核验" class="ver_btn" onClick="validate();">
    </dd>
    <dd>
        <input type="button" value="立即登陆" class="submit_btn"/>
    </dd>
    <dd>
        <p>如遇到登录问题,请联系大赛组委会</p>
        <p>
            <a href="<%=NetUtils.getBasePath(request) %>" style="color:white;">返回首页</a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="forgetpassword.jsp" target="_blank" style="color:white;">忘记密码?</a>
        </p>
    </dd>
</dl>
</body>
</html>
