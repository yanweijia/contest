<%@ page import="utils.DateUtils" %>
<%@ page import="entity.UserInfo" %>
<%@ page import="dao.UserInfoDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserInfo userInfo = new UserInfo();
    userInfo.setUid((Long)session.getAttribute("uid"));
    userInfo = UserInfoDao.queryUserInfo(userInfo,1,1).get(0);
    pageContext.setAttribute("userInfo",userInfo);
%>
<div style="color:black;">
    <%--打开的页面的时候默认用户本来的信息--%>
    <h1>修改个人信息</h1>
    <form action="/updateUserInfo.action" id="form_updateUserInfo" onsubmit="return checkBeforeUpdateInfo();">
        <table>
            <tr>
                <td>
                    <strong>邮箱:</strong>
                </td>
                <td>
                    <input type="email" name="email" minlength="5" maxlength="30" placeholder="电子邮箱" value="${userInfo.email}" required/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>联系电话:</strong>
                </td>
                <td>
                    <input type="tel" name="phone" minlength="5" maxlength="14" value="${userInfo.phone}" placeholder="移动电话号码" required/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>身份证:</strong>
                </td>
                <td>
                    <input type="text" name="idcard" id="idcard" minlength="18" maxlength="18" value="${userInfo.idcard}" placeholder="身份证号" required/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>性别:</strong>
                </td>
                <td>
                    <select name="sex">
                        <option value="男" ${(userInfo.sex eq "男")?"selected":""}>男</option>
                        <option value="女" ${(userInfo.sex eq "女")?"selected":""}>女</option>
                        <option value="未知" ${(userInfo.sex eq "未知")?"selected":""}>未知</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>姓名:</strong>
                </td>
                <td>
                    <input type="text" name="name" minlength="1" maxlength="15" value="${userInfo.name}" placeholder="您的姓名" required/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" class="btn btn-info" value="确认修改"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<style type="text/css">
    #form_updateUserInfo td{
        padding: 5px 5px;
    }
</style>
<script type="text/javascript">

    /**
     *  更新个人信息.
     */
    function checkBeforeUpdateInfo(){
        var result = isCardNo($('#idcard').val());
        if(!result.result){
            alert(result.tip);
            $('#idcard').focus();
            return false;
        }else{
            //提交表单
            $.post('/updateUserInfo.action',$('#form_updateUserInfo').serialize(),function(data){
                data = eval('('+data+')');
                if(data.result)
                    alert('更新信息成功!');
                else
                    alert(data.reason);
            });
        }
        return false;
    }
    /**
     * 验证身份证,支持15 18位身份证验证
     * 修改自:http://www.cnblogs.com/lzrabbit/archive/2011/10/23/2221643.html
     * @param code
     * @returns {{result: boolean, tip: string}}
     */
    function isCardNo(code) {
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var result={"result":true,"tip":"校验成功"};

        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            result={"result":false,"tip":"身份证号格式错误"}
        }

        else if(!city[code.substr(0,2)]){
            result={"result":false,"tip":"地址编码错误"}
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    result={"result":false,"tip":"校验位错误"}
                }
            }
        }
        return result;
    }
</script>
