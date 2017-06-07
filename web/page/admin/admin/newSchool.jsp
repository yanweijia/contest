<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <h1>
        添加学校
    </h1>
    <form action="<%=NetUtils.getBasePath(request)%>schoolManage.action" id="form_newSchool" onsubmit="return newSchool();">
        <input type="hidden" name="method" value="new"/>
        <label for="schoolName">
            学校名称:
            <input name="schoolName" type="text" id="schoolName" minlength="1" maxlength="30" required/>
        </label>
        <label for="schoolPrinciple">
            学校负责人编号:
            <input name="schoolPrinciple" type="text" id="schoolPrinciple" minlength="1" maxlength="10" required/>
        </label>

        <input type="reset" class="btn btn-info" value="重设"/>
        <input type="submit" class="btn btn-info" value="提交"/>
    </form>
</div>

<script type="text/javascript">


    /**
     * 新建学校
     * @returns {boolean}
     */
    function newSchool(){
        $.post($('#form_newSchool').attr('action'),$('#form_newSchool').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                alert(data.reason);
                $('#schoolName').val('');
                $('#schoolPrinciple').val('');
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>