<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-20
  Time: 21:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--TODO:用过滤器判断用户是否拥有发送notice的权限--%>



<%--下面这些引用是umeditor--%>
<script type="text/javascript" charset="utf-8" src="<%=NetUtils.getBasePath(request) %>plug-in/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=NetUtils.getBasePath(request) %>plug-in/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="<%=NetUtils.getBasePath(request) %>plug-in/ueditor/lang/zh-cn/zh-cn.js"></script>


<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/base64.js"></script>   <%--base64加密--%>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/post.js"></script>
<link href="<%=NetUtils.getBasePath(request) %>resource/css/post.css" rel="stylesheet" type="text/css" />


<%--TODO: JQuery包,后期集成的时候记得去除--%>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>

<div class="noticeBackground">
    <fieldset class="fieldset">
        <legend class="legend"> 发布新闻 </legend>
        <span style='display:inline-block;margin-top:15px;'>
            <label class="label" for="noticeTitle">新闻标题:</label>
            <input class="input" type="text" name="noticeTitle" id="noticeTitle" placeholder="请输入新闻标题" required="required" autofocus="autofocus" maxlength="50" minlength="4"/>
        </span>
        <span style='display:inline-block;'>
            <label class="label" for="noticeAuthor">作者:</label>
            <input class="input" type="text" name="noticeAuthor" id="noticeAuthor" placeholder="管理员" required="required" autofocus="autofocus" maxlength="30" minlength="0"/>
        </span>

        <span style='display:inline-block;'>
            <label class="label" for="noticeType">新闻类型:</label>
            <select class="select" name="noticeType" id="noticeType">
                <option>新闻</option>
                <option>公告</option>
                <option>大赛信息</option>
            </select>
        </span>
        <span>
        <label class="label" style='display:block;padding-bottom:5px;'>新闻内容:</label>
        </span>

        <script type="text/plain" id="noticeContent" style="width:100%;height:200px;">
            <p>请输入新闻内容</p>
        </script>
        <script type="text/javascript">
            var ueditor = UE.getEditor('noticeContent', { initialFrameWidth: null });  //实例化编辑器,宽度自适应
        </script>

    </fieldset>
    <input type="button" class="submit" value="发 布" onclick="checkAndSubmit();"/>
</div>


<%--用来提交信息的隐藏表单--%>
<form id="postNoticeForm" action="<%=NetUtils.getBasePath(request)%>postNotice.action" method="POST" target="_blank"style=" display:none"></form>
