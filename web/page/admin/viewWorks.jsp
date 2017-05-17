<%@ page import="utils.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="color:black;">
    <h1>作品浏览&amp;导出</h1>
    <form action="/viewWorks.action" id="form_viewWorks" onsubmit="return checkBeforeViewWorks();">

        <label for="season">
            赛季:
            <input type="text" name="season" id="season" placeholder="参赛年份"/>
        </label>
        <label for="school">
            学校名称:
            <input type="text" name="school" id="school" placeholder="支持模糊查询"/>
        </label>
        <label for="name">
            作品名称:
            <input type="text" name="name" id="name" placeholder="支持模糊查询"/>
        </label>
        <span style="display:inline-block;">
            <strong>参赛类型:</strong>
            <label for="majorType1" class="checkOption">
                <input type="checkbox" name="majorType" id="majorType1" value="文科"/>文科
            </label>
            <label for="majorType2" class="checkOption">
                <input type="checkbox" name="majorType" id="majorType2" value="非文科"/>非文科
            </label>
        </span>
        <span style="display:inline-block;">
            <strong>作品分类:</strong>
            <label for="category1" class="checkOption">
                <input type="checkbox" name="category" id="category1" value="数据库应用系统"/>数据库应用系统
            </label>
            <label for="category2" class="checkOption">
                <input type="checkbox" name="category" id="category2" value="Web网站设计"/>Web网站设计
            </label>
            <label for="category3" class="checkOption">
                <input type="checkbox" name="category" id="category3" value="多媒体制作"/>多媒体制作
            </label>
            <label for="category4" class="checkOption">
                <input type="checkbox" name="category" id="category4" value="微课程或课件"/>微课程或课件
            </label>
            <label for="category5" class="checkOption">
                <input type="checkbox" name="category" id="category5" value="程序设计应用"/>程序设计应用
            </label>
            <label for="category6" class="checkOption">
                <input type="checkbox" name="category" id="category6" value="企业合作项目"/>企业合作项目
            </label>
            <label for="category7" class="checkOption">
                <input type="checkbox" name="category" id="category7" value="软件服务外包"/>软件服务外包
            </label>
            <label for="category8" class="checkOption">
                <input type="checkbox" name="category" id="category8" value="智慧城市"/>智慧城市
            </label>
        </span>
        <br/>
        <div style="text-align:center;">
            <input type="reset" value="重设" class="btn btn-info"/>
            <input type="submit" value="查询" class="btn btn-info"/>
        </div>
    </form>
</div>
<style type="text/css">
    #form_viewWorks{
        display:inline-block;/*下面三行css确保宽度div宽度随容器自适应*/
        *display:inline;
        *zoom:1;
    }
    .checkOption{
        color:gray;
    }
</style>
<script type="text/javascript">
    function checkBeforeViewWorks(){
        $.post('/viewWorks.action',$('#form_viewWorks').serialize(),function(data){
            data = eval('('+data+')');
            if(!data.result){
                alert(data.reason);
            }else{
                //TODO:查询到数据
            }
        });

        return false;
    }
</script>