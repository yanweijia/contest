package servlet.admin;


import com.google.gson.Gson;
import dao.SchoolInfoDao;
import dao.TeamMemberDao;
import dao.WorksDao;
import entity.TeamMember;
import entity.Works;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.CodeUtils;
import utils.DateUtils;
import utils.NetUtils;
import utils.POIUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-18.
 */
@WebServlet(name = "viewWorks",value="/viewWorks.action")
public class viewWorks extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(viewWorks.class);
    HttpSession session;
    PrintWriter out;
    Map<String,Object> resultMap;
    Gson gson;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
        resultMap = new HashMap<>();
        gson = new Gson();
        String method = request.getParameter("method");
        if(method==null){
            out = response.getWriter();
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,查询失败!");
            out.close();
            return;
        }

        String season = request.getParameter("season");
        String school = request.getParameter("school");
        String name = request.getParameter("name");
        String[] majorType = request.getParameterValues("majorType");
        String[] category = request.getParameterValues("category");


        String str_perPage = request.getParameter("perPage");
        String str_pageNum = request.getParameter("pageNum");
        Integer perPage = str_perPage!=null?Integer.parseInt(str_perPage):100;
        Integer pageNum = str_pageNum!=null?Integer.parseInt(str_pageNum):1;

        //模糊查询
        List<Works> list = WorksDao.queryWorksListBy(season,school,name,majorType,category,perPage,pageNum);
        resultMap.put("result",true);
        resultMap.put("matchCount",list.size());





        if ("download".equals(method)){
            downloadExcel(response, list);
            logger.info("下载作品list");
            return;
        }

        out = response.getWriter(); //这句话不能在download方法之前写,因为如果获取了out再用response.getOutPutStream()方法会造成无法输出到客户端的现象,错误原因:ERR_INVALID_RESPONSE
        if("query".equals(method)) {
            query(response,list, perPage, pageNum);
            logger.info("查询作品list");
            return;
        }


        NetUtils.writeResultToBrowser(out,false,"未获取到参数,无法进行请求(查询或下载)");
        out.close();
        logger.info("未获取到参数,没法做出响应.");



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    /**
     * 从数据库查询符合结果的数据并以json格式输出
     * @param list 查询结果list
     * @param perPage
     * @param pageNum
     */
    private void query(HttpServletResponse response,List<Works> list,Integer perPage,Integer pageNum){
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //手动分页,并确保不超过list长度
        if(list.size()!=0){
            Integer fromIndex = (pageNum-1)*perPage>(list.size()-1)?(list.size()-1):(pageNum-1)*perPage;
            Integer toIndex = pageNum*perPage>(list.size()-1)?(list.size()-1):pageNum*perPage;
            list = list.subList(fromIndex,toIndex);
        }
        List<Map<String,Object>> myList = new ArrayList<>();
        for(Works work:list){

            //获取参赛学生名称
            TeamMember teamMember = new TeamMember();
            teamMember.setWid(work.getWid());
            String students = "";
            List<TeamMember> teamMemberList = TeamMemberDao.queryTeamMember(teamMember,3,1);
            for(TeamMember temp:teamMemberList){
                students += " " + temp.getName();
            }

            Map<String,Object> tempMap = new HashMap<>();
            tempMap.put("season",work.getSeason().substring(0,4));
            tempMap.put("wid",work.getWid());
            //学校名称
            tempMap.put("schoolname",SchoolInfoDao.getSchoolInfoByID(work.getSid().intValue()).getName());
            tempMap.put("name",work.getName());
            tempMap.put("majortype",work.getMajortype());
            tempMap.put("category",work.getCategory());
            tempMap.put("college",work.getCollege());
            tempMap.put("teachername",work.getTeachername());
            tempMap.put("students",students);
            myList.add(tempMap);
        }
        resultMap.put("works",myList);
        out.print(gson.toJson(resultMap,Map.class));

        out.close();
    }

    /**
     * 从数据库中查找到相应的文件然后以Excel的形式输出到浏览器.
     * @param response
     * @param list
     */
    private void downloadExcel(HttpServletResponse response,List<Works> list){

//        response.setContentLength();// 写明要下载的文件的大小,无法估计,所以不写.浏览器下载时不会提示文件大小.
        response.setHeader("Content-Disposition", "attachment;filename="
                + CodeUtils.URLEncode("大赛作品信息导出_") + DateUtils.getDateTime() + ".xls");// 设置在下载框默认显示的文件名,如果是中文名称的话需要URL编码
        response.setContentType("application/x-msdownload");// 指明response的返回对象是文件流
        String[] header = {"赛季","作品编号","所属学校","作品名称","参赛类型","作品分类","所属学院","带队教师","教师电话",
                            "队员姓名","身份证号","学院","专业","年级","邮箱","手机","年龄",
                            "队员姓名","身份证号","学院","专业","年级","邮箱","手机","年龄",
                            "队员姓名","身份证号","学院","专业","年级","邮箱","手机","年龄"};
        List<Object[]> content = new ArrayList<>();
        for(Works works : list){
            List<Object> item = new ArrayList<>();
            item.add(works.getSeason().substring(0,4));
            item.add(works.getWid());
            //把sid换为name
            item.add(SchoolInfoDao.getSchoolInfoByID(works.getSid().intValue()).getName());
            item.add(works.getName());
            item.add(works.getMajortype());
            item.add(works.getCategory());
            item.add(works.getCollege());
            item.add(works.getTeachername());
            item.add(works.getTeacherphone());

            //将队员信息也导入到excel里面
            TeamMember teamMember = new TeamMember();
            teamMember.setWid(works.getWid());
            List<TeamMember> teamMemberList = TeamMemberDao.queryTeamMember(teamMember,3,1);
            for(TeamMember temp:teamMemberList){
                item.add(temp.getName());
                item.add(temp.getIdcard());
                item.add(temp.getCollege());
                item.add(temp.getMajor());
                item.add(temp.getGrade());
                item.add(temp.getEmail());
                item.add(temp.getPhone());
                item.add(temp.getAge());
            }
            content.add(item.toArray());
        }

        //开始下载到输出流
        try {
            POIUtils.writeToExcel("报名信息筛选",response.getOutputStream(),header,content);
        } catch (IOException e) {
            NetUtils.writeResultToBrowser(out,false,"下载失败");
        }
    }
}
