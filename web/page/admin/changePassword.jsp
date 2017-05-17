<%@ page import="utils.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="color:black;">
    <h1>修改密码</h1>
    <form action="/changePassword.action" id="form_changePassword" onsubmit="return checkBeforeChangePW();">
        <table>
            <tr>
                <td>
                    请输入旧密码:
                </td>
                <td>
                    <input type="password" name="oldpw" id="oldpw" placeholder="旧密码" minlength="6" maxlength="16" required/>
                </td>
            </tr>
            <tr>
                <td>
                    请输入新密码:
                </td>
                <td>
                    <input type="password" name="newpw" id="newpw" placeholder="新密码" minlength="6" maxlength="16" required/>
                </td>
            </tr>
            <tr>
                <td>
                    请再输入一遍:
                </td>
                <td>
                    <input type="password" name="repw" id="repw" placeholder="再输一遍" minlength="6" maxlength="16" required/>
                </td>
            </tr>
            <tr style="text-align:center;">
                <td>
                    <input type="reset" value="重填" class="btn btn-info"/>
                </td>
                <td>
                    <input type="submit" value="提交" class="btn btn-info"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<style type="text/css">
    #form_changePassword td{
        padding: 5px 5px;
    }
</style>
<script type="text/javascript">
    function checkBeforeChangePW(){

        if($('#newpw').val() != $('#repw').val()){
            alert('两次输入密码不一致,请重新输入');
            $('#repw').val('');
            $('#repw').focus();
            return false;
        }
        //修改密码请求
        //TODO:后期加上MD5加密后再上传
        $.post('/changePassword.action',$('#form_changePassword').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result)
                alert('修改密码成功!');
            else{
                alert(data.reason);
            }
        });

        return false;
    }
</script>
