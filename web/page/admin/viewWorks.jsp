<%@ page import="utils.DateUtils" %>
<%@ page import="utils.NetUtils" %>
<%@ page import="dao.SchoolInfoDao" %>
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
            <input type="text" name="school" id="school" placeholder="支持模糊查询" ${(type ne "管理员")?"readonly":""}
                   value="<%=("管理员".equals(""+session.getAttribute("type")))?(""):(SchoolInfoDao.querySchoolInfo(null,null,(Long)session.getAttribute("uid"),1,1).get(0).getName()) %>"
            />

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
            <input type="button" value="导出Excel" class="btn btn-info" onclick="downloadExcel();"/>
        </div>
        <input type="hidden" name="method" id="submit_method" value=""/>
    </form>
    <table id="table_works" border="1" cellspacing="0" bordercolor="gray">

    </table>
    <div>
        <%--TODO:翻页按钮--%>
    </div>
</div>


<%--这是弹出窗口查看或修改报名表信息的--%>
<div class="modal fade" id="model_previous" tabindex="-1" role="dialog" aria-labelledby="model_previousLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 90%;width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="model_previousLabel">查看/修改报名表</h4>
            </div>
            <div class="modal-body" id="container_work">
                这里放弹出窗口内容,不要乱动!
            </div>
            <div class="modal-footer">
                <div class="right-side">
                    <button type="button" class="btn btn-danger btn-simple" data-dismiss="modal">确定</button>
                </div>
                <div class="divider"></div>
                <div class="left-side">
                    <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
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
    #table_works{
        margin:10px 0;
    }
    #table_works th,td{
        padding:5px 10px;
    }
    #table_works span{
        color:blue;
        cursor:pointer;
    }
</style>
<script type="text/javascript">


    /**
     * 将符合条件的结果输出到excel再进行下载
     */
    function downloadExcel(){
        $('#submit_method').val('download');
        window.open('<%=NetUtils.getBasePath(request) %>viewWorks.action?'+$('#form_viewWorks').serialize());
    }


    /**
     *  验证数据斌显示数据
     */
    function checkBeforeViewWorks(){
        $('#submit_method').val('query');
        $.post('/viewWorks.action',$('#form_viewWorks').serialize(),function(data){
            data = eval('('+data+')');
            if(!data.result){
                alert(data.reason);
            }else{
                //显示查询到数据
                showWorks(data);
            }
        });

        return false;
    }

    /**
     * 显示已经查询到的结果
     * @param json
     */
    function showWorks(json){
        $('#table_works').empty();
        var table_header = '<tr style="text-align:center;"><th>赛季</th><th>作品编号</th><th>所属学校</th><th>作品名称</th><th>参赛类型</th><th>作品分类</th><th>所属学院</th><th>带队教师</th><th>参赛学生</th><th>操作</th></tr>';
        $('#table_works').append(table_header);
        if(json.works.length==0){
            var table_tr = '<tr><td colspan="' + $('#table_works:first').find('th').length + '">筛选结果为空!</td></tr>';
            $('#table_works').append(table_tr);
        }else{
            for(var i = 0 ; i < json.works.length; i++){
                var table_tr = '<tr><td>' + json.works[i].season
                    + '</td><td>' + json.works[i].wid
                    + '</td><td>' + json.works[i].schoolname
                    + '</td><td>' + json.works[i].name
                    + '</td><td>' + json.works[i].majortype
                    + '</td><td>' + json.works[i].category
                    + '</td><td>' + json.works[i].college
                    + '</td><td>' + json.works[i].teachername
                    + '</td><td>' + json.works[i].students
                    + '</td><td>' + '<span data-toggle="modal" data-target="#model_previous" onclick="viewWork(' + json.works[i].wid + ');">查看</span>&nbsp;'
                                    + '<span data-toggle="modal" data-target="#model_previous" onclick="updateWork(' + json.works[i].wid + ');">更新</span>&nbsp;'
                                    + '<span onclick="deleteWork(' + json.works[i].wid + ');">删除</span>'
                    + '</td></tr>';
                $('#table_works').append(table_tr);
            }
        }

    }

    /**
     * 查看报名信息
     * @param wid 报名编号
     */
    function viewWork(wid){
        $('#model_previousLabel').html('查看报名信息');
        $('#container_work').load('<%=NetUtils.getBasePath(request) %>page/admin/enrollment_table.jsp?method=query&wid='+wid);
    }

    /**
     * 更新报名信息
     * @param wid
     */
    function updateWork(wid){
        $('#model_previousLabel').html('更新报名信息');
        $('#container_work').load('<%=NetUtils.getBasePath(request) %>page/admin/enrollment_table.jsp?method=update&wid='+wid);
    }

    function deleteWork(wid){
        if(confirm('确认要删除吗?')){
            $.post('<%=NetUtils.getBasePath(request) %>enroll.action','method=delete&wid='+wid,function(data){
                data = eval('('+data+')');
                if(data.result){
                    alert('删除成功!');
                    checkBeforeViewWorks();
                }else
                    alert(data.reason);
            });
        }
    }

</script>