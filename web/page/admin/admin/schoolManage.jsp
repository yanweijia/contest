<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <h1>
        学校信息查询
    </h1>
    <form action="<%=NetUtils.getBasePath(request)%>schoolManage.action" id="form_schoolManage" onsubmit="return querySchool();">
        <input type="hidden" name="method" value="query"/>
        <label for="schoolName">
            学校名称:
            <input name="schoolName" type="text" id="schoolName" maxlength="30"/>
        </label>
        <input type="submit" class="btn btn-info" value="查询"/>
    </form>
    <table id="table_schools" border="1" cellspacing="0" bordercolor="gray">

    </table>
</div>

<%--这是弹出窗口查看或修改学校信息--%>
<div class="modal fade" id="model_previous" tabindex="-1" role="dialog" aria-labelledby="model_previousLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 90%;width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="model_previousLabel">查看/修改学校信息</h4>
            </div>
            <div class="modal-body" id="container_schoolManage">
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
    #form_schoolManage{
        display:inline-block;/*下面三行css确保宽度div宽度随容器自适应*/
        *display:inline;
        *zoom:1;
    }
    #table_schools{
        margin:10px 0;
    }
    #table_schools th,td{
        padding:5px 10px;
    }
    #table_schools span{
        color:blue;
        cursor:pointer;
    }
</style>
<script type="text/javascript">

    /**
     * 显示学校信息
     */
    function showSchools(json){
        $('#table_schools').empty();
        var table_header = '<tr style="text-align:center;"><th>学校编号</th><th>学校名称</th><th>负责人编号</th><th>操作</th></tr>';
        $('#table_schools').append(table_header);
        if(json.schools.length==0){
            var table_tr = '<tr><td colspan="' + $('#table_schools:first').find('th').length + '">筛选结果为空!</td></tr>';
            $('#table_schools').append(table_tr);
        }else{
            for(var i = 0 ; i < json.schools.length; i++){
                var table_tr = '<tr><td>' + json.schools[i].sid
                    + '</td><td>' + json.schools[i].schoolname
                    + '</td><td>' + json.schools[i].principleUid
                    + '</td><td>' + '<span data-toggle="modal" data-target="#model_previous" onclick="updateSchoolInfo(' + json.schools[i].sid + ');">更新</span>&nbsp;'
                    + '<span onclick="deleteSchool(' + json.schools[i].sid + ');">删除</span>'
                    + '</td></tr>';
                $('#table_schools').append(table_tr);
            }
        }
    }


    /**
     * 修改学校信息
     */
    function updateSchoolInfo(sid){
        $('#model_previousLabel').html('更新学校信息');
        $('#container_schoolManage').load('<%=NetUtils.getBasePath(request) %>page/admin/admin/updateSchool.jsp?method=update&sid='+sid);
    }

    /**
     *  删除学校信息
     */
    function deleteSchool(sid){
        if(confirm('确认要删除吗?')){
            $.post('<%=NetUtils.getBasePath(request) %>schoolManage.action','method=delete&sid='+sid,function(data){
                data = eval('('+data+')');
                if(data.result){
                    alert('删除成功!');
                    querySchool();
                }else
                    alert(data.reason);
            });
        }
    }

    /**
     * 查询学校信息
     * @returns {boolean}
     */
    function querySchool(){
        $.post($('#form_schoolManage').attr('action'),$('#form_schoolManage').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                showSchools(data);
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>