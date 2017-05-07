<%@ page import="utils.NetUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<title>404 Error! 页面未找到</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>errorPage/css/404style.css">
</head>
<body background="<%=NetUtils.getBasePath(request) %>errorPage/images/404bg.png">
<div class="wrap">
	<h1>上海市大学生计算机应用能力大赛</h1>
	<div class="banner">
		<img src="<%=NetUtils.getBasePath(request) %>errorPage/images/404banner.png" alt="" style="height:80%"/>
	</div>
	<div class="page">
		<h2>页面不小心被我们弄丢了. . .</h2>
	</div>
	<div class="footer">
		<p>Design by <a href="http://www.yanweijia.cn">严唯嘉</a></p>
	</div>
</div>
</body>
</html>
