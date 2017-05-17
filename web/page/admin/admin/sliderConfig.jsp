<%@ page import="utils.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sliderConfigDiv">

    <form action="/sliderOperate" method="POST" id="form_sliderConfig" onsubmit="return submitSliderConfig();">
        <h1>sliderConfig:设置首页轮播图片</h1>
        <table id="table_sliderConfig">
            <tr>
                <td style="padding:0 10px;">
                    <label for="img1">
                        图片地址:<input type="url" name="img" id="img1" value="" minlength="3" required/>
                    </label>
                </td>
                <td>
                    <label for="name1">
                        图片文字:<input type="text" name="name1" id="name1" value=""/>
                    </label>
                </td>
                <td>
                    <label>
                        图片链接地址:<input type="text" name="url1" id="url1" minlength="1" placeholder="若无填写#" value="" required/>
                    </label>
                </td>
            </tr>
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
        var count = $('#table_sliderConfig').find("tr").length; //获取当前表格行数
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
        var count = $('#table_sliderConfig').find("tr").length; //获取当前表格行数
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
     * 提交slider配置信息
     * @returns {boolean}
     */
    function submitSliderConfig(){
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