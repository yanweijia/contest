<%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-20
  Time: 21:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>

<%--下面这些引用是umeditor--%>
<link href="<%=basePath %>plug-in/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">

<%--TODO:防止JQuery重复添加--%>
<script type="text/javascript" src="<%=basePath %>plug-in/umeditor/third-party/jquery.min.js"></script>

<script type="text/javascript" charset="utf-8" src="<%=basePath %>plug-in/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath %>plug-in/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plug-in/umeditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="<%=basePath %>js/base64.js"></script>   <%--base64加密--%>


<link href="<%=basePath %>notice/post.css" rel="stylesheet" type="text/css" />
<form id="orderForm" action="<%=basePath%>postNotice" method="get">

    <fieldset>
        <legend> 发布新闻 </legend>
        <span style='display:inline-block;margin-top:15px;'>
            <label for="noticeTitle">新闻标题:</label>
            <input type="text" name="noticeTitle" id="noticeTitle" placeholder="请输入新闻标题" required="required" autofocus="autofocus" maxlength="50" minlength="4"/>
        </span>
            <span style='display:inline-block;'>
            <label for="noticeAuthor">作者:</label>
            <input type="text" name="noticeAuthor" id="noticeAuthor" placeholder="请输入新闻标题" required="required" autofocus="autofocus" maxlength="30" minlength="0"/>
        </span>

        <span style='display:inline-block;'>
            <label for="noticeType">新闻类型:</label>
            <select name="noticeType" id="noticeType">
                <option>新闻</option>
                <option>公告</option>
                <option>大赛信息</option>
            </select>
        </span>
        <span>
        <label style='display:block;padding-bottom:5px;'>新闻内容:</label>
        </span>

        <script type="text/plain" id="noticeContent" style="width:100%;height:200px;">
            <p>请输入新闻内容</p>
        </script>
        <script type="text/javascript">
            var um = UM.getEditor('noticeContent', { initialFrameWidth: null });  //实例化编辑器,宽度自适应
        </script>

        <%--TODO:上传相关附件--%>
    </fieldset>



    <input type="submit" value="发 布" />

</form>
