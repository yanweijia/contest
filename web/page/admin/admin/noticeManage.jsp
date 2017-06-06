<%@ page import="utils.NetUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%--JQuery包,后期集成的时候记得去除--%>
<script type="text/javascript" src="<%=NetUtils.getBasePath(request) %>plug-in/jquery.min.js"></script>

<div class="">
    <h1>新闻管理</h1>
    <form action="<%=NetUtils.getBasePath(request)%>noticeManage.action" id="form_viewNotices" onsubmit="return checkBeforeViewNotices();">
        <label for="noticeTitle">
            新闻标题/作者:
            <input type="text" name="title" id="noticeTitle" placeholder="支持模糊查询"/>
        </label>

        <span style="display:inline-block;">
            <label for="noticeType">新闻类型:
                <select class="select" name="noticeType" id="noticeType">
                    <option value="">所有</option>
                    <option value="新闻">新闻</option>
                    <option value="公告">公告</option>
                    <option value="大赛信息">大赛信息</option>
                </select>
            </label>
        </span>
        <br/>
        <div style="text-align:center;">
            <input type="reset" value="重设" class="btn btn-info"/>
            <input type="submit" value="查询" class="btn btn-info"/>
        </div>
        <input type="hidden" name="method" id="submit_method" value="query"/>
    </form>
    <table id="table_notices" border="1" cellspacing="0" bordercolor="gray">

    </table>
    <div>
        <%--TODO:翻页按钮--%>
    </div>
</div>

<style type="text/css">
    #form_viewNotices{
        display:inline-block;/*下面三行css确保宽度div宽度随容器自适应*/
        *display:inline;
        *zoom:1;
    }
    #table_notices{
        margin:10px 0;
    }
    #table_notices th,td{
        padding:5px 10px;
    }
    #table_notices span{
        color:blue;
        cursor:pointer;
    }
</style>

<script type="text/javascript">
    /**
     *  验证数据并显示数据
     */
    function checkBeforeViewNotices(){
        $('#submit_method').val('query');
        $.post('<%=NetUtils.getBasePath(request)%>noticeManage.action',$('#form_viewNotices').serialize(),function(data){
            data = eval('('+data+')');
            if(!data.result){
                alert(data.reason);
            }else{
                //显示查询到数据
                showNotices(data);
            }
        });

        return false;
    }

    /**
     * 显示已经查询到的结果
     * @param json
     */
    function showNotices(json){
        $('#table_notices').empty();
        var table_header = '<tr style="text-align:center;"><th>新闻编号</th><th>新闻类型</th><th>新闻标题</th><th>新闻作者</th><th>发送时间</th><th>浏览次数</th><th>操作</th>';
        $('#table_notices').append(table_header);
        if(json.notices.length==0){
            var table_tr = '<tr><td colspan="' + $('#table_works:first').find('th').length + '">筛选结果为空!</td></tr>';
            $('#table_notices').append(table_tr);
        }else{
            for(var i = 0 ; i < json.notices.length; i++){
                var table_tr = '<tr><td>' + json.notices[i].nid
                    + '</td><td>' + json.notices[i].type
                    + '</td><td>' + json.notices[i].title
                    + '</td><td>' + json.notices[i].author
                    + '</td><td>' + json.notices[i].posttime
                    + '</td><td>' + json.notices[i].viewCount
                    + '</td><td>' + '<span data-toggle="modal" data-target="#model_previous" onclick="viewNotices(' + json.notices[i].nid + ');">查看</span>&nbsp;'
                    + '<span onclick="deleteNotices(' + json.notices[i].nid + ');">删除</span>'
                    + '</td></tr>';
                $('#table_notices').append(table_tr);
            }
        }
    }

    /**
     * 查看新闻
     * @param nid 新闻编号
     */
    function viewNotices(nid){
        window.open("<%=NetUtils.getBasePath(request)%>viewNotice.action?nid="+nid);
    }

    function deleteNotices(nid){
        if(confirm('确认要删除吗?')){
            $.post('<%=NetUtils.getBasePath(request) %>noticeManage.action','method=delete&nid='+nid,function(data){
                data = eval('('+data+')');
                if(data.result){
                    alert('删除成功!');
                    checkBeforeViewNotices();
                }else
                    alert(data.reason);
            });
        }
    }
</script>