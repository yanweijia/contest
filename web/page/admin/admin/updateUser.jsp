<%@ page import="utils.NetUtils" %>
<%@ page import="dao.SchoolInfoDao" %>
<%@ page import="entity.SchoolInfo" %>
<%@ page import="dao.UserDao" %>
<%@ page import="entity.User" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String method=request.getParameter("method");
    String uid_str = request.getParameter("uid");
    User user = UserDao.getUserByUidOrUsername(Integer.parseInt(uid_str),null);
    pageContext.setAttribute("method",method);
    pageContext.setAttribute("user",user);
%>
<div>
    <form action="<%=NetUtils.getBasePath(request)%>userManage.action" id="form_updateUser" onsubmit="return updateUser();">
        <input type="hidden" name="method" value="${method }"/>
        <label for="uid">
            用户编号:
            <input name="uid" type="text" id="uid" minlength="1" value="${user.uid}" maxlength="30" required readonly/>
        </label>
        <label for="username">
            用户账户:
            <input name="username" type="text" id="username" value="${user.username}" minlength="1" maxlength="30" required/>
        </label>
        <label for="password">
            用户密码:
            <input name="password" type="text" id="password" value="${user.password}" minlength="1" maxlength="10" required/>
        </label>
        <label for="type">
            用户类型:
            <select name="type" id="type">
                <option value="管理员" ${(user.type eq "管理员") ? "selected":""}>管理员</option>
                <option value="学校负责人" ${(user.type eq "学校负责人") ? "selected":""}>学校负责人</option>
                <option value="普通用户" ${(user.type eq "普通用户") ? "selected":""}>普通用户</option>
            </select>
        </label>

        <input type="reset" class="btn btn-info" value="重设"/>
        <input type="submit" class="btn btn-info" value="提交"/>
    </form>
</div>

<script type="text/javascript">


    /**
     * 修改学校信息
     * @returns {boolean}
     */
    function updateUser(){
        $.post($('#form_updateUser').attr('action'),$('#form_updateUser').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                alert(data.reason);
                $('#uid').val('');
                $('#username').val('');
                $('#password').val('');
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>