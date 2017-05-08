<%@ page import="utils.NetUtils" %><%--
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
                <span class="header-title">
                    大学生计算机应用能力大赛
                </span>
            <div class="navbar-header" style="float:right;">
                <a href="<%=NetUtils.getBasePath(request) %>"><button class="btn btn-neutral">首　页</button></a>
                <a href="#"><button class="btn btn-neutral">大赛信息</button></a>
                <a href="#"><button class="btn btn-neutral">新　闻</button></a>
                <a href="#"><button class="btn btn-neutral">大赛通知</button></a>
                <a href="#"><button class="btn btn-neutral" data-toggle="modal" data-target="#model_previous">历届作品</button></a>
            </div>
        </div>
    </nav>
    <div class="modal fade" id="model_previous" tabindex="-1" role="dialog" aria-labelledby="model_previousLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="model_previousLabel">这是提示标题</h4>
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