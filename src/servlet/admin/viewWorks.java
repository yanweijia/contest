package servlet.admin;


import com.google.gson.Gson;
import dao.WorksDao;
import entity.Works;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.NetUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-18.
 */
@WebServlet(name = "viewWorks",value="/viewWorks.action")
public class viewWorks extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(viewWorks.class);
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Map<String,Object> resultMap = new HashMap<>();
        Gson gson = new Gson();



        String season = request.getParameter("season");
        String school = request.getParameter("school");
        String name = request.getParameter("name");
        String[] majorType = request.getParameterValues("majorType");
        String[] category = request.getParameterValues("category");


        String str_perPage = request.getParameter("perPage");
        String str_pageNum = request.getParameter("pageNum");
        Integer perPage = str_perPage!=null?Integer.parseInt(str_perPage):100;
        Integer pageNum = str_pageNum!=null?Integer.parseInt(str_pageNum):1;


        if(season==null||school==null||name==null){
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,查询失败!");
            out.close();
            return;
        }
        //模糊查询
        List<Works> list = WorksDao.queryWorksListBy(season,school,name,majorType,category,perPage,pageNum);
        resultMap.put("result",true);
        resultMap.put("matchCount",list.size());

        //手动分页,并确保不超过list长度
        Integer fromIndex = (pageNum-1)*perPage>(list.size()-1)?(list.size()-1):(pageNum-1)*perPage;
        Integer toIndex = pageNum*perPage>(list.size()-1)?(list.size()-1):pageNum*perPage;
        resultMap.put("works",list.subList(fromIndex,toIndex).toArray());

        out.print(gson.toJson(resultMap,Map.class));

        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
