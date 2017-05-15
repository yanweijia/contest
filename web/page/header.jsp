<%@ page import="utils.NetUtils" %>
<%@ page import="utils.DateUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-05-08
  Time: 21:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/header.css" type="text/css" />
<div id="navbar" class="header">
    <nav class="navbar navbar-ct-primary navigation-bar" role="navigation">
        <div class="header-content">
            <div class="titleNav">
                <a href="<%=NetUtils.getBasePath(request)%>">
                    <span class="header-title">
                        大学生计算机应用能力大赛
                    </span>
                </a>
                <div class="navbar-header">
                    <a href="<%=NetUtils.getBasePath(request) %>"><button class="btn btn-neutral navBtn">首　页</button></a>
                    <a href="<%=NetUtils.getBasePath(request) %>notice.jsp?type=大赛信息"><button class="btn btn-neutral navBtn">大赛信息</button></a>
                    <a href="<%=NetUtils.getBasePath(request) %>notice.jsp?type=新闻"><button class="btn btn-neutral navBtn">新　闻</button></a>
                    <a href="<%=NetUtils.getBasePath(request) %>notice.jsp?type=通知"><button class="btn btn-neutral navBtn">大赛通知</button></a>
                    <a href="#"><button class="btn btn-neutral navBtn" data-toggle="modal" data-target="#model_previous">历届作品</button></a>
                </div>
            </div>
            <div class="help-bar">
                <span class="color-white"><%=DateUtils.getDate() %> &nbsp; <%=DateUtils.getDayOfWeek() %></span>
                <div class="help-bar-form">
                    <%--这里表单登录在onsubmit的函数中实现,不用表单自己的方法提交,表单仅用来验证数据--%>
                    <form id="form_login" class="header-form" action="<%=NetUtils.getBasePath(request) %>login.action" onsubmit="return checkBeforeLogin();">
                        <label for="form_username">
                            用户名:
                            <input type="text" class="min-input" minlength="4" maxlength="30" size="13" required="required" name="username" id="form_username"/>
                        </label>
                        <label for="form_password">
                            密 码:
                            <input type="password" class="min-input" minlength="4" maxlength="16" size="13" required="required" name="password" id="form_password"/>
                        </label>
                        <span class="btn-group">
                            <input type="submit" class="button" value="登录"/>
                            <a href="<%=NetUtils.getBasePath(request) %>register.jsp"><input type="button" class="button" value="注册"/></a>
                        </span>
                    </form>
                </div>
            </div>
        </div>
    </nav>
    <div class="modal fade" id="model_previous" tabindex="-1" role="dialog" aria-labelledby="model_previousLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="model_previousLabel">历届作品-提示</h4>
                </div>
                <div class="modal-body">
                    没有历届作品可以展示,真尴尬!
                </div>
                <div class="modal-footer">
                    <div class="right-side">
                        <button type="button" class="btn btn-danger btn-simple" data-dismiss="modal">确定</button>
                    </div>
                    <div class="divider"></div>
                    <div class="left-side">
                        <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/header.js"></script>