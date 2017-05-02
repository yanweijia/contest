<%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-04-20
  Time: 21:37
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String rootPath = application.getRealPath( "/" );
  String rootPath2 = request.getContextPath();
%>
<html>
  <head>
    <title>上海市大学生应用技术能力大赛官网</title>
  </head>
  <body>
  <jsp:include page="notice/list.jsp?pageNum=1"/>
  </body>
</html>
