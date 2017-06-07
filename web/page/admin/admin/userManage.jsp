<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <h1>
        用户信息查询
    </h1>
    <form action="<%=NetUtils.getBasePath(request)%>userManage.action" id="form_userManage" onsubmit="return queryUser();">
        <input type="hidden" name="method" value="query"/>
        <label for="userName">
            用户账号:
            <input name="userName" type="text" id="userName" maxlength="30"/>
        </label>
        <label for="type">
            用户类型:
            <select name="type" id="type">
                <option value="">所有</option>
                <option value="管理员">管理员</option>
                <option value="学校负责人">学校负责人</option>
                <option value="普通用户">普通用户</option>
            </select>
        </label>
        <input type="submit" class="btn btn-info" value="查询"/>
    </form>
    <table id="table_users" border="1" cellspacing="0" bordercolor="gray">

    </table>
</div>

<%--这是弹出窗口查看或修改用户信息--%>
<div class="modal fade" id="model_previous" tabindex="-1" role="dialog" aria-labelledby="model_previousLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 90%;width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="model_previousLabel">查看/修改学校信息</h4>
            </div>
            <div class="modal-body" id="container_userManage">
                这里放弹出窗口内容,不要乱动!
            </div>
            <div class="modal-footer">
                <%--<div class="right-side">--%>
                    <%--<button type="button" class="btn btn-danger btn-simple" data-dismiss="modal">确定</button>--%>
                <%--</div>--%>
                <%--<div class="divider"></div>--%>
                <%--<div class="left-side">--%>
                    <%--<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">取消</button>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>
<style type="text/css">
    #form_userManage{
        display:inline-block;/*下面三行css确保宽度div宽度随容器自适应*/
        *display:inline;
        *zoom:1;
    }
    #table_users{
        margin:10px 0;
    }
    #table_users th,td{
        padding:5px 10px;
    }
    #table_users span{
        color:blue;
        cursor:pointer;
    }
</style>
<script type="text/javascript">

    /**
     * 显示学校信息
     */
    function showUsers(json){
        $('#table_users').empty();
        var table_header = '<tr style="text-align:center;"><th>用户编号</th><th>用户账号</th><th>用户密码</th><th>用户类型</th><th>性别</th><th>昵称</th><th>电话</th><th>操作</th></tr>';
        $('#table_users').append(table_header);
        if(json.users.length==0){
            var table_tr = '<tr><td colspan="' + $('#table_users:first').find('th').length + '">筛选结果为空!</td></tr>';
            $('#table_users').append(table_tr);
        }else{
            for(var i = 0 ; i < json.users.length; i++){
                var table_tr = '<tr><td>' + json.users[i].uid
                    + '</td><td>' + json.users[i].username
                    + '</td><td>' + json.users[i].password
                    + '</td><td>' + json.users[i].type
                    + '</td><td>' + json.users[i].sex
                    + '</td><td>' + json.users[i].name
                    + '</td><td>' + json.users[i].phone
                    + '</td><td>' + '<span data-toggle="modal" data-target="#model_previous" onclick="updateUserInfo(' + json.users[i].uid + ');">更新</span>&nbsp;'
                    + '<span onclick="deleteUser(' + json.users[i].uid + ');">删除</span>'
                    + '</td></tr>';
                $('#table_users').append(table_tr);
            }
        }
    }


    /**
     * 修改用户信息
     */
    function updateUserInfo(uid){
        $('#model_previousLabel').html('更新学校信息');
        $('#container_userManage').load('<%=NetUtils.getBasePath(request) %>page/admin/admin/updateUser.jsp?method=update&uid='+uid);
    }

    /**
     *  删除用户信息
     */
    function deleteUser(uid){
        if(confirm('确认要删除吗?')){
            $.post('<%=NetUtils.getBasePath(request) %>userManage.action','method=delete&uid='+uid,function(data){
                data = eval('('+data+')');
                if(data.result){
                    alert('删除成功!');
                    queryUser();
                }else
                    alert(data.reason);
            });
        }
    }

    /**
     * 查询用户信息
     * @returns {boolean}
     */
    function queryUser(){
        $.post($('#form_userManage').attr('action'),$('#form_userManage').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                showUsers(data);
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>