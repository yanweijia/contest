<%@ page import="utils.NetUtils" %><%--
  Created by IntelliJ IDEA.
  User: weijia
  Date: 2017-05-02
  Time: 16:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<%=NetUtils.getBasePath(request) %>resource/css/enrollment.css" >


<%--JQuery包,后期集成的时候记得去除--%>
<%--<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>--%>


<form id="form_enrollment" name="form_enrollment" action="<%=NetUtils.getBasePath(request) %>enroll.action" method="GET" style="max-width:700px;" onsubmit="return checkBeforeSubmit();"> <%--测试先用GET提交数据--%>
    <input type="hidden" name="method" value="<%="new" %>" required readonly/>
    <input type="hidden" name="season" value="2017" required readonly/>
    <table border="1" cellspacing="0px" bordercolor="gray" id="table_enrollment">
        <colgroup>
            <col style="width:20%;"/>
            <col style="width:16%;"/>
            <col style="width:25%;"/>
            <col style="width:14%;"/>
            <col style="width:25%;"/>
        </colgroup>
        <tbody>
            <tr style=";height:40px" class="firstRow">
                <td>
                    注册信息<span style="color:red;">*</span>
                </td>
                <td  style="text-align:right;">
                    报名号
                </td>
                <td colspan="3" style="">
                    <input type="text" name="wid" id="input_wid" value="170230" minlength="1" maxlength="10" required readonly/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td rowspan="2" style="">
                    基本信息<span style="color:red;">*</span>
                </td>
                <td style="text-align:right;">
                    作品名称
                </td>
                <td style="">
                    <input  type="text" name="name" id="input_name" required maxlength="30" minlength="1"/>
                </td>
                <td style="text-align:right;">
                    所属学校
                </td>
                <td>
                    <input type="hidden" name="sid" value="1"/>
                    <input type="text" name="schoolname" id="input_school" value="上海电力学院" required readonly />
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    所属学院
                </td>
                <td style="">
                    <input type="text" name="college" id="input_college" required maxlength="30" minlength="2" />
                </td>
                <td style="text-align:right;">
                    专业类别
                </td>
                <td style="">
                    <label for="input_majorType_BA" class="inline-block">
                        <input type="radio" name="majorType" value="BA" id="input_majorType_BA" checked />
                        文科
                    </label>
                    <label for="input_majorType_BSc" class="inline-block">
                        <input type="radio" name="majorType" value="BSc" id="input_majorType_BSc" />
                        非文科
                    </label>
                </td>
            </tr>
            <tr style=";height:40px">
                <td colspan="2" rowspan="2" style="text-align:center;">
                    参赛作品类型<span style="color:red;">*</span>
                </td>
                <td colspan="3" rowspan="2">
                    <label for="input_category_sql" class="inline-block">
                        <input type="radio" name="category" value="sql" id="input_category_sql" checked/>
                        数据库应用系统
                    </label>
                    <label for="input_category_web" class="inline-block">
                        <input type="radio" name="category" value="web" id="input_category_web" />
                        Web网站设计
                    </label>
                    <label for="input_category_media" class="inline-block">
                        <input type="radio" name="category" value="media" id="input_category_media" />
                        多媒体制作
                    </label>
                    <label for="input_category_class" class="inline-block">
                        <input type="radio" name="category" value="web" id="input_category_class" />
                        微课程或课件
                    </label>
                    <label for="input_category_program" class="inline-block">
                        <input type="radio" name="category" value="program" id="input_category_program" />
                        程序设计应用
                    </label>
                    <label for="input_category_company" class="inline-block">
                        <input type="radio" name="category" value="company" id="input_category_company" />
                        企业合作项目
                    </label>
                    <label for="input_category_software" class="inline-block">
                        <input type="radio" name="category" value="software" id="input_category_software" />
                        软件服务外包
                    </label>
                    <label for="input_category_city" class="inline-block">
                        <input type="radio" name="category" value="city" id="input_category_city" />
                        智慧城市
                    </label>
                </td>
            </tr>
            <tr style=";height:40px"></tr>
            <tr style=";height:40px">
                <td style="">
                    带队教师信息<span style="color:red;">*</span>
                </td>
                <td style="text-align:right;">
                    姓名
                </td>
                <td style="">
                    <input type="text" name="teacherName" id="input_teacherName" maxlength="15" minlength="1" required />
                </td>
                <td style="text-align:right;">
                    联系电话
                </td>
                <td style="">
                    <input type="text" name="teacherPhone" id="input_teacherPhone" maxlength="11" minlength="11" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td colspan="5">
                    注: 参赛队员1-3名,文科类同学若准备参加全国竞赛选吧,则五笔填写3名参赛队员信息以及带队老师信息
                </td>
            </tr>

            <tr style=";height:40px">
                <td rowspan="4" style="">
                    参赛队员信息<span style="color:red;">*</span>
                    <label for="input_studentChecked2" style="display:none;">
                        <input type="checkbox" name="studentChecked1" id="input_studentChecked1" value="studentChecked1" checked="checked"/>
                        队员2
                    </label>
                    <input type="hidden" name="studentMid1" id="input_studentMid1" value="0" placeholder="参赛队员编号,当更新报名表的时候可以借此字段将参赛队员信息更新到数据库中" required/>
                </td>
                <td style="text-align:right;">
                    姓名
                </td>
                <td style="">
                    <input type="text" name="studentName1" id="input_studentName1" maxlength="15" minlength="1" required/>
                </td>
                <td style="text-align:right;">
                    身份证
                </td>
                <td style="">
                    <input type="text" name="studentIDCard1" id="input_studentIDCard1" minlength="18" maxlength="18" onchange="autoCalcAge(this)" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    年级
                </td>
                <td style="">
                    <select name="studentGrade1" id="select_studentGrade1">
                        <option value="1">大一</option>
                        <option value="2">大二</option>
                        <option value="3">大三</option>
                        <option value="4">大四</option>
                    </select>
                </td>
                <td style="text-align:right;">
                    年龄
                </td>
                <td style="">
                    <input type="text" name="studentAge1" id="input_studentAge1" maxlength="2" minlength="2" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    院系
                </td>
                <td style="">
                    <input type="text" name="studentCollege1" id="input_studentCollege1" minlength="2" maxlength="15" required/>
                </td>
                <td style="text-align:right;">
                    专业
                </td>
                <td style="">
                    <input type="text" name="studentMajor1" id="input_studentMajor1" minlength="2" maxlength="30" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    电子邮箱
                </td>
                <td style="">
                    <input type="email" name="studentEmail1" id="input_studentEmail1" minlength="5" maxlength="50" required/>
                </td>
                <td style="text-align:right;">
                    联系电话
                </td>
                <td style="">
                    <input type="tel" name="studentPhone1" id="input_studentPhone1" minlength="11" maxlength="11" required/>
                </td>
            </tr>


            <tr style=";height:40px">
                <td rowspan="4" style="">
                    参赛队员2信息
                    <br/>
                    <label for="input_studentChecked2">
                        <input type="checkbox" name="studentChecked2" id="input_studentChecked2" value="studentChecked2" student="student2" onchange="pickTeamMember(this)"/>
                        队员2
                    </label>
                    <input type="hidden" name="studentMid2" id="input_studentMid2" value="0" placeholder="参赛队员编号,当更新报名表的时候可以借此字段将参赛队员信息更新到数据库中" required/>
                </td>
                <td style="text-align:right;">
                    姓名
                </td>
                <td style="">
                    <input type="text" name="studentName2" id="input_studentName2" maxlength="15" minlength="1" class="student2" required/>
                </td>
                <td style="text-align:right;">
                    身份证
                </td>
                <td style="">
                    <input type="text" name="studentIDCard2" id="input_studentIDCard2" minlength="18" maxlength="18" onchange="autoCalcAge(this)" class="student2" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    年级
                </td>
                <td style="">
                    <select name="studentGrade2" id="select_studentGrade2" class="student2" required>
                        <option value="1">大一</option>
                        <option value="2">大二</option>
                        <option value="3">大三</option>
                        <option value="4">大四</option>
                    </select>
                </td>
                <td style="text-align:right;">
                    年龄
                </td>
                <td style="">
                    <input type="text" name="studentAge2" id="input_studentAge2" maxlength="2" minlength="2" class="student2" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    院系
                </td>
                <td style="">
                    <input type="text" name="studentCollege2" id="input_studentCollege2" minlength="2" maxlength="15" class="student2" required/>
                </td>
                <td style="text-align:right;">
                    专业
                </td>
                <td style="">
                    <input type="text" name="studentMajor2" id="input_studentMajor2" minlength="2" maxlength="30" class="student2" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    电子邮箱
                </td>
                <td style="">
                    <input type="email" name="studentEmail2" id="input_studentEmail2" minlength="5" maxlength="50" class="student2" required/>
                </td>
                <td style="text-align:right;">
                    联系电话
                </td>
                <td style="">
                    <input type="tel" name="studentPhone2" id="input_studentPhone2" minlength="11" maxlength="11" class="student2" required/>
                </td>
            </tr>


            <tr style=";height:40px">
                <td rowspan="4" style="">
                    参赛队员3信息
                    <br/>
                    <label for="input_studentChecked3">
                        <input type="checkbox" name="studentChecked3" id="input_studentChecked3" value="studentChecked3" student="student3" onchange="pickTeamMember(this)"/>
                        队员3
                    </label>
                    <input type="hidden" name="studentMid3" id="input_studentMid3" value="0" placeholder="参赛队员编号,当更新报名表的时候可以借此字段将参赛队员信息更新到数据库中" required/>
                </td>
                <td style="text-align:right;">
                    姓名
                </td>
                <td style="">
                    <input type="text" name="studentName3" id="input_studentName3" maxlength="15" minlength="1" class="student3" required/>
                </td>
                <td style="text-align:right;">
                    身份证
                </td>
                <td style="">
                    <input type="text" name="studentIDCard3" id="input_studentIDCard3" minlength="18" maxlength="18" onchange="autoCalcAge(this)" class="student3" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    年级
                </td>
                <td style="">
                    <select name="studentGrade3" id="select_studentGrade3" class="student3" required>
                        <option value="1">大一</option>
                        <option value="2">大二</option>
                        <option value="3">大三</option>
                        <option value="4">大四</option>
                    </select>
                </td>
                <td style="text-align:right;">
                    年龄
                </td>
                <td style="">
                    <input type="text" name="studentAge3" id="input_studentAge3" maxlength="2" minlength="2" class="student3" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    院系
                </td>
                <td style="">
                    <input type="text" name="studentCollege3" id="input_studentCollege3" minlength="2" maxlength="15" class="student3" required/>
                </td>
                <td style="text-align:right;">
                    专业
                </td>
                <td style="">
                    <input type="text" name="studentMajor3" id="input_studentMajor3" minlength="2" maxlength="30" class="student3" required/>
                </td>
            </tr>
            <tr style=";height:40px">
                <td style="text-align:right;">
                    电子邮箱
                </td>
                <td style="">
                    <input type="email" name="studentEmail3" id="input_studentEmail3" minlength="5" maxlength="50" class="student3" required/>
                </td>
                <td style="text-align:right;">
                    联系电话
                </td>
                <td style="">
                    <input type="tel" name="studentPhone3" id="input_studentPhone3" minlength="11" maxlength="11" class="student3" required/>
                </td>
            </tr>
        </tbody>
    </table>
    <div style="width:100%;align-content: center;">

        <span style="width:50%;"><input type="submit" class="submitbtn btn btn-info" value="提交" /></span>

        <span style="width:50%;"><input type="button" class="resetbtn btn btn-info" value="重填" onclick="form_enrollment.reset();" /></span>
    </div>

</form>

<%--表单验证js--%>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>resource/js/enrollment.js"></script>