package servlet;

import com.google.gson.Gson;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
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
            map.put("result",false);
            map.put("reason","未获取到参数,提交/更新 报名表失败!");
            out.println(gson.toJson(map,Map.class));
            out.flush();
            return;
        }
        //TODO:转换类型
        String season = request.getParameter("season");
        String wid = request.getParameter("wid");
        String name = request.getParameter("name");
        String sid = request.getParameter("sid");
        String schoolname = request.getParameter("schoolname");
        String college = request.getParameter("college");
        String majorType = request.getParameter("majorType");
        String category = request.getParameter("category");
        String teacherName = request.getParameter("teacherName");
        String teacherPhone = request.getParameter("teacherPhone");





        String studentMid1 = request.getParameter("studentMid1");
        String studentName1 = request.getParameter("studentName1");
        String studentIDCard1 = request.getParameter("studentIDCard1");
        String studentGrade1 = request.getParameter("studentGrade1");
        String studentAge1 = request.getParameter("studentAge1");
        String studentCollege1 = request.getParameter("studentCollege1");
        String studentMajor1 = request.getParameter("studentMajor1");
        String studentEmail1 = request.getParameter("studentEmail1");
        String studentPhone1 = request.getParameter("stduentPhone1");

        if(request.getParameter("studentChecked2") != null){

        }
        if(request.getParameter("studentChecked3") != null){

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
