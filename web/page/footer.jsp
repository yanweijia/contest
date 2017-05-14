<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-05-08
  Time: 21:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/footer.css" type="text/css" />

<div class="footer">
    <div class="foot">
        <p class="copyright">
            版权所有© 2009-<script>document.write(new Date().getFullYear())</script> <a href="http://www.shiep.edu.cn/">上海电力学院</a> &nbsp;
            <a href="login.jsp">管理员登录</a><br>
            地址：上海市平凉路2103号上海电力学院教务处老行政楼305室,邮编:200090<br>
            <a href="http://www.miitbeian.gov.cn/" target="_blank">沪ICP备--------号</a>&nbsp;&nbsp;&nbsp;
                Made with <i class="fa fa-heart heart"></i> by <a href="http://www.yanweijia.cn">严唯嘉</a>
        </p>
    </div>
</div>