package servlet;

import com.google.gson.Gson;
import com.sun.deploy.net.HttpRequest;
import dao.TeamMemberDao;
import dao.WorksDao;
import db.DBAccess;
import entity.TeamMember;
import entity.Works;
import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.NetUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 * 提交报名信息,method分为new和update
 */
@WebServlet(name = "Enroll",value="/enroll.action")
public class Enroll extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(Enroll.class);

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String,Object> map = new HashMap<>();
        Gson gson = new Gson();
        PrintWriter out = response.getWriter();

        String method = request.getParameter("method"); //获取操作类型(新报名/更新报名表)
        if(method == null){
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,提交/更新 报名表失败!");
            return;
        }

        //从参数构建报名信息
        Works works = readWorks(request);
        List<TeamMember> teamMembersList = readTeamMembers(request);

        //新提交作品
        if("new".equals(method)){
            //在提交前还可以在service里设置逻辑:查询作品所属信息被篡改等情况

            //sql的事务一致性,保证作品信息和队员信息同时提交,或者同时不更改.
            SqlSession sqlSession = null;
            try{
                sqlSession = DBAccess.getSqlSession();
                int wid = WorksDao.newWorks(works,sqlSession);
                for(TeamMember teamMember:teamMembersList){
                    teamMember.setWid((long)wid);
                TeamMemberDao.newTeamMember(teamMember,sqlSession);
            }
                sqlSession.commit();
            }catch(Exception e){
                sqlSession.rollback();
                NetUtils.writeResultToBrowser(out,false,"提交报名信息失败,详细信息:" + e.getMessage());
                sqlSession.close();
                return;
            }
            NetUtils.writeResultToBrowser(out,true,"报名信息提交成功!");
            return;
        }

        //更新作品信息
        if("update".equals(method)){
            //sql的事务一致性,保证作品信息和队员信息同时更新,或者同时不更改.
            SqlSession sqlSession = null;
            try{
                sqlSession = DBAccess.getSqlSession();
                WorksDao.updateWorks(works,sqlSession);
                for(TeamMember teamMember:teamMembersList){
                    TeamMemberDao.updateTeamMember(teamMember,sqlSession);
                }
                sqlSession.commit();
            }catch(Exception e){
                sqlSession.rollback();
                NetUtils.writeResultToBrowser(out,false,"更新报名信息失败,详细信息:" + e.getMessage());
                sqlSession.close();
                return;
            }
            NetUtils.writeResultToBrowser(out,true,"更新作品信息成功!");
            return;
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }


    /**
     * 从参数读取TeamMembers
     * @param request
     * @return List<TeamMember>
     */
    private static List<TeamMember> readTeamMembers(HttpServletRequest request){
        List<TeamMember> list = new ArrayList<>();

        Long wid = Long.parseLong(request.getParameter("wid"));

        for(int i = 1 ; i <= 3 ; i++){
            if(request.getParameter("studentChecked" + i) != null) {
                Long studentMid = Long.parseLong(request.getParameter("studentMid" + i));
                String studentName = request.getParameter("studentName" + i);
                String studentIDCard = request.getParameter("studentIDCard" + i);
                String studentGrade = request.getParameter("studentGrade" + i);
                Long studentAge = Long.parseLong(request.getParameter("studentAge" + i));
                String studentCollege = request.getParameter("studentCollege" + i);
                String studentMajor = request.getParameter("studentMajor" + i);
                String studentEmail = request.getParameter("studentEmail" + i);
                String studentPhone = request.getParameter("studentPhone" + i);

                TeamMember teamMember1 = new TeamMember(studentMid, wid, studentName, studentIDCard, studentCollege, studentMajor, studentGrade, studentEmail, studentPhone, studentAge);
                list.add(teamMember1);
            }
        }
        return list;
    }


    /**
     * 从参数读取Works
     * @param request request请求
     * @return
     */
    private static Works readWorks(HttpServletRequest request){
        Map<String,String> map = new HashMap<>();
        map.put("sql","数据库应用系统");
        map.put("web","Web网站设计");
        map.put("media","多媒体制作");
        map.put("class","微课程或课件");
        map.put("program","程序设计应用");
        map.put("company","企业合作项目");
        map.put("software","软件服务外包");
        map.put("city","智慧城市");

        //获取数据,转换类型
        String season = request.getParameter("season");
        Long wid = Long.parseLong(request.getParameter("wid"));
        String name = request.getParameter("name");
        Long sid = Long.parseLong(request.getParameter("sid"));
//        String schoolname = request.getParameter("schoolname");
        String college = request.getParameter("college");
        String majorType = request.getParameter("majorType").equals("BA")?"文科":"非文科";
        String category = map.get(request.getParameter("category"));
        String teacherName = request.getParameter("teacherName");
        String teacherPhone = request.getParameter("teacherPhone");

        Works works = new Works(wid,sid,season,name,college,majorType,category,teacherName,teacherPhone);
        return works;
    }
}
