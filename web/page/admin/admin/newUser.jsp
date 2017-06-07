<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <h1>
        添加用户
    </h1>
    <form action="<%=NetUtils.getBasePath(request)%>userManage.action" id="form_newUser" onsubmit="return newUser();">
        <input type="hidden" name="method" value="new"/>
        <label for="userName">
            用户账号:
            <input name="userName" type="text" id="userName" minlength="4" maxlength="30" required/>
        </label>
        <label for="password">
            用户密码:
            <input name="password" type="password" id="password" minlength="1" maxlength="10" required/>
        </label>
        <select name="type">
            <option value="管理员">管理员</option>
            <option value="学校负责人" selected>学校负责人</option>
            <option value="普通用户">普通用户</option>
        </select>
        <input type="reset" class="btn btn-info" value="重设"/>
        <input type="submit" class="btn btn-info" value="提交"/>
    </form>
</div>

<script type="text/javascript">


    /**
     * 新建用户
     * @returns {boolean}
     */
    function newUser(){
        $.post($('#form_newUser').attr('action'),$('#form_newUser').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                alert(data.reason);
                $('#userName').val('');
                $('#password').val('');
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>