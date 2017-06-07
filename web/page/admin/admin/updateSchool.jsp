<%@ page import="utils.NetUtils" %>
<%@ page import="dao.SchoolInfoDao" %>
<%@ page import="entity.SchoolInfo" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-06-06
  Time: 14:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String method=request.getParameter("method");
    String sid_str = request.getParameter("sid");
    SchoolInfo schoolInfo = SchoolInfoDao.getSchoolInfoByID(Integer.parseInt(sid_str));
    pageContext.setAttribute("method",method);
    pageContext.setAttribute("schoolInfo",schoolInfo);
%>
<div>
    <form action="<%=NetUtils.getBasePath(request)%>schoolManage.action" id="form_updateSchool" onsubmit="return updateSchool();">
        <input type="hidden" name="method" value="${method }"/>
        <label for="sid1">
            学校编号:
            <input name="sid" type="text" id="sid1" minlength="1" value="${schoolInfo.sid}" maxlength="30" required readonly/>
        </label>
        <label for="schoolName1">
            学校名称:
            <input name="schoolName" type="text" id="schoolName1" value="${schoolInfo.name}" minlength="1" maxlength="30" required/>
        </label>
        <label for="schoolPrinciple1">
            学校负责人编号:
            <input name="schoolPrinciple" type="text" id="schoolPrinciple1" value="${schoolInfo.uid}" minlength="1" maxlength="10" required/>
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
    function updateSchool(){
        $.post($('#form_updateSchool').attr('action'),$('#form_updateSchool').serialize(),function(data){
            data = eval('('+data+')');
            if(data.result){
                alert(data.reason);
                $('#schoolName1').val('');
                $('#schoolPrinciple1').val('');
            }else{
                alert(data.reason);
            }
        });
        return false;
    }

</script>