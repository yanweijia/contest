package servlet.admin;

import com.google.gson.Gson;
import dao.SchoolInfoDao;
import dao.UserDao;
import entity.SchoolInfo;
import entity.User;
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
 * 用户管理
 * Created by weijia
 */
@WebServlet(name = "userManage",value="/userManage.action")
public class userManage extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(userManage.class);
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

        //新增用户信息
        if("new".equals(method)){
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String type = request.getParameter("type");
            int uid = UserDao.newUser(userName,password,type);
            if(uid!=0){
                NetUtils.writeResultToBrowser(out,true,"插入成功,用户编号:"+uid);
            }else{
                NetUtils.writeResultToBrowser(out,false,"插入失败!");
            }
            return;
        }

        //删除一个用户
        if("delete".equals(method)){
            String uid_str = request.getParameter("uid");
            Integer uid = uid_str==null?0:Integer.parseInt(uid_str);
            if(UserDao.deleteOne(uid)){
                NetUtils.writeResultToBrowser(out,true,"删除编号为"+uid_str+"的用户成功!");
            }else{
                NetUtils.writeResultToBrowser(out,false,"删除编号为"+uid_str+"的用户失败!");
            }
            return;
        }

        //更新一个用户
        if("update".equals(method)){
            String uid_str = request.getParameter("uid");
            Integer uid = uid_str==null?0:Integer.parseInt(uid_str);
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String type = request.getParameter("type");


            if(UserDao.updatePassword(uid,password)&&UserDao.updateUsername(uid,userName)&&UserDao.updateUserType(uid,type)){
                NetUtils.writeResultToBrowser(out,true,"更新编号为:"+uid_str+"的用户信息成功!");
            }else{
                NetUtils.writeResultToBrowser(out,false,"更新编号为:"+uid_str+"的用户信息失败!");
            }
            return;
        }

        //查询学校信息
        if("query".equals(method)){
            String username = request.getParameter("userName");
            String type = request.getParameter("type");
            User user = new User();
            user.setType(type);
            user.setUsername(username);
            List<User> list = UserDao.queryUsers(user,20,1);
            resultMap.put("result",true);
            resultMap.put("reason","查询成功");
            List<Map<String,Object>> myList = new ArrayList<>();
            for(User tempUser:list){
                Map<String,Object> tempMap = new HashMap<>();
                tempMap.put("uid",tempUser.getUid());
                tempMap.put("username",tempUser.getUsername());
                tempMap.put("password",tempUser.getPassword());
                tempMap.put("type",tempUser.getType());
                myList.add(tempMap);
            }
            resultMap.put("users",myList);
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
