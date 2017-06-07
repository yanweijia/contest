package servlet.admin;

import com.google.gson.Gson;
import dao.SchoolInfoDao;
import entity.SchoolInfo;
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
 * 学校管理
 * Created by weijia
 */
@WebServlet(name = "schoolManage",value="/schoolManage.action")
public class schoolManage extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(schoolManage.class);
    Map<String,Object> resultMap;
    Gson gson;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        resultMap = new HashMap<>();
        gson = new Gson();

        String method = request.getParameter("method");

        if(method==null || "".equals(method.trim())){
            NetUtils.writeResultToBrowser(out,false,"无法获取参数,请求失败");
            out.close();
            return;
        }

        //新增学校信息
        if("new".equals(method)){
            String schoolName = request.getParameter("schoolName");
            String schoolPrinciple_str = request.getParameter("schoolPrinciple");
            Long schoolPrinciple = schoolPrinciple_str==null?null:Long.parseLong(schoolPrinciple_str);
            SchoolInfo schoolInfo = new SchoolInfo();
            schoolInfo.setName(schoolName);
            schoolInfo.setUid(schoolPrinciple);
            int sid = SchoolInfoDao.newSchoolInfo(schoolInfo);
            if(sid!=0){
                NetUtils.writeResultToBrowser(out,true,"插入成功,学校编号:"+sid);
            }else{
                NetUtils.writeResultToBrowser(out,false,"插入失败!");
            }
            return;
        }

        //删除一个学校
        if("delete".equals(method)){
            String sid_str = request.getParameter("sid");
            Integer sid = sid_str==null?0:Integer.parseInt(sid_str);
            if(SchoolInfoDao.deleteOne(sid)){
                NetUtils.writeResultToBrowser(out,true,"删除编号为"+sid_str+"的学校成功!");
            }else{
                NetUtils.writeResultToBrowser(out,false,"删除编号为"+sid_str+"的学校失败!");
            }
            return;
        }

        //更新一个学校
        if("update".equals(method)){
            String sid_str = request.getParameter("sid");
            Integer sid = sid_str==null?0:Integer.parseInt(sid_str);
            String schoolName = request.getParameter("schoolName");
            String uid = request.getParameter("schoolPrinciple");
            Integer schoolPrincipleUID = uid==null?0:Integer.parseInt(uid);
            if(SchoolInfoDao.updateSchoolInfo(sid,schoolName,schoolPrincipleUID)){
                NetUtils.writeResultToBrowser(out,true,"更新编号为:"+sid_str+"的学校信息成功!");
            }else{
                NetUtils.writeResultToBrowser(out,false,"更新编号为:"+sid_str+"的学校信息失败!");
            }
            return;
        }

        //查询学校信息
        if("query".equals(method)){
            String schoolName = request.getParameter("schoolName");
            List<SchoolInfo> list = SchoolInfoDao.querySchoolInfo(schoolName,20,1);
            resultMap.put("result",true);
            resultMap.put("reason","查询成功!");
            List<Map<String,Object>> myList = new ArrayList<>();
            for(SchoolInfo schoolInfo : list){
                Map<String,Object> tempMap = new HashMap<>();
                tempMap.put("sid",schoolInfo.getSid());
                tempMap.put("schoolname",schoolInfo.getName());
                tempMap.put("principleUid",schoolInfo.getUid());
                myList.add(tempMap);
            }
            resultMap.put("schools",myList);
            out.print(gson.toJson(resultMap,Map.class));
            out.close();
            return;
        }





        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
