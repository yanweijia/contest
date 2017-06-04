<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="utils.ConfigUtils" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Gson gson = new Gson();
    Map<String,String> map_img = gson.fromJson(ConfigUtils.getString("slider.imgs",""),Map.class);
    Map<String,String> map_url = gson.fromJson(ConfigUtils.getString("slider.urls",""),Map.class);
    Map<String,String> map_name = gson.fromJson(ConfigUtils.getString("slider.names",""),Map.class);
    pageContext.setAttribute("map_img",map_img);
    pageContext.setAttribute("map_url",map_url);
    pageContext.setAttribute("map_name",map_name);

%>
<div id="sliderConfigDiv">

    <form action="/sliderOperate" method="POST" id="form_sliderConfig" onsubmit="return submitSliderConfig();">
        <h1>sliderConfig:设置首页轮播图片</h1>
        <input type="hidden" name="method" value="update"/>
        <input type="hidden" name="count" value="1" id="slidercount"/>
        <table id="table_sliderConfig">
            <%
                for(int i = 1 ; i <= map_img.size();i++){
            %>
                <tr>
                    <td style="padding:0 10px;">
                        <label for="img<%=i %>">
                            图片地址:<input type="text" name="img<%=i %>" id="img<%=i %>" value="<%=map_img.get("img"+i) %>" minlength="3" required/>
                        </label>
                    </td>
                    <td>
                        <label for="name<%=i %>">
                            图片文字:<input type="text" name="name<%=i %>" id="name<%=i %>" value="<%=map_name.get("name"+i ) %>"/>
                        </label>
                    </td>
                    <td>
                        <label for="url<%=i %>">
                            图片链接地址:<input type="text" name="url<%=i %>" id="url<%=i %>" minlength="1" placeholder="若无填写#" value="<%=map_url.get("url"+i) %>" required/>
                        </label>
                    </td>
                </tr>
            <%
                }
            %>
        </table>
        <div style="float:right;">
            <i class="fa fa-minus fa-lg" onclick="removeLastLine(this);"></i>
            <i class="fa fa-plus fa-lg plus" onclick="addLine();"></i>
        </div>
        <input type="submit" class="btn btn-info" value="提交"/>
    </form>
</div>
<style type="text/css">
    #sliderConfigDiv{
        color:black;
        display:inline-block;/*下面三行css确保宽度div宽度随容器自适应*/
        *display:inline;
        *zoom:1;
    }
    #form_sliderConfig  td{
        padding:0 10px;
    }
    #form_sliderConfig i{
        color:red;
        cursor:pointer;
        font-size:2em;
        margin:10px 10px;
    }
    #form_sliderConfig .plus{
        color:lawngreen;
        width:30px;
        height:30px;
    }
</style>
<script type="text/javascript">


    /**
     * 移除一行
     */
    function removeLastLine(object){
        var count = getCount(); //获取当前表格行数
        if(count == 1){
            alert('再删下去的话首页就没东东啦,不许你删除了!');
        }else {
            $('#table_sliderConfig tr:last').remove();    //移除表单对应元素
        }
    }


    /**
     *  添加一行
     */
    function addLine(){
        var count = getCount(); //获取当前表格行数
        count++;
        if(count >= 7){
            alert('首页滚动动画是不是有点多了?别添加了吧!');
        }else {
            var html = '';
            html += '<tr><td style="padding:0 10px;"><label for="img' + count
                + '">图片地址:<input type="url" name="img' + count
                + '" minlength="3" id="img' + count
                + '" value="" required/></label></td><td><label for="name' + count
                + '">图片文字:<input type="text" name="name' + count
                + '" id="name' + count
                + '" value=""/></label></td><td><label>图片链接地址:<input type="text" name="url' + count
                + '" minlength="1" id="url' + count
                + '" placeholder="若无填写#" value="" required/></label></td></tr>';
            $("#table_sliderConfig").append(html);
        }
    }

    /**
     * 获取当前表格行数
     * @returns {int}
     */
    function getCount(){
        return $('#table_sliderConfig').find("tr").length;
    }


    /**
     * 提交slider配置信息
     * @returns {boolean}
     */
    function submitSliderConfig(){
        var count = getCount();
        $('#slidercount').val(count);
        $.post('/sliderOperate',$('#form_sliderConfig').serialize(),function(data){
            data = eval('(' + data + ')');
            if(data.result){
                alert("修改成功!");
            }else{
                alert(data.reason);
            }
        });
        return false;
    }
</script>