<%@ page import="utils.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="color:black;">

    <form action="/websiteConfig.action" id="form_websiteConfig" method="POST" onsubmit="return submitWebsiteConfig();">
        <table>
            <th colspan="2">
                <h1>后台网站设置</h1>
            </th>
            <tr>
                <td>
                    网站名称:
                </td>
                <td>
                    <input type="text" name="websiteName" minlength="2" maxlength="50" placeholder="请输入网站名称" required="required"/>
                </td>
            </tr>
            <tr>
                <td>
                    报名接口开关:
                </td>
                <td>
                    <label for="enrollSwitch1">
                        <input type="radio" name="enrollSwitch" id="enrollSwitch1" value="open" checked="checked"/>开
                    </label>
                    <label for="enrollSwitch2">
                        <input type="radio" name="enrollSwitch" id="enrollSwitch2" value="close" />关
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    网站访问开关:
                </td>
                <td>
                    <label for="webSwitch1">
                        <input type="radio" name="webSwitch" id="webSwitch1" value="open" checked="checked"/>开
                    </label>
                    <label for="webSwitch2">
                        <input type="radio" name="webSwitch" id="webSwitch2" value="close" />关
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    <input type="submit" value="确定修改"/>
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        /**
         * 修改用户网站配置
         * @returns {boolean}
         */
        function submitWebsiteConfig(){
            $.post('/websiteConfig.action',$('#form_websiteConfig').serialize(),function(data){
                data = eval('('+data+')');
                if(data!=null || data.trim()!=''){
                    if(data.result){
                        alert("修改成功!");
                    }else{
                        alert(data.reason);
                    }
                }else{
                    alert("修改失败,服务器故障,无法获取修改结果.");
                }
            });
            return false;
        }
    </script>
</div>
