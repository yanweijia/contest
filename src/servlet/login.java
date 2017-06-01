package servlet;
import dao.UserDao;
import entity.User;
import utils.NetUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 登录页面,返回数据为json 格式为 {"result":boolean,"reason":"出错原因"}
 * Created by weijia on 2017-05-15.
 */
@WebServlet(name = "login",value="/login.action")
public class login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String method = request.getParameter("method");
        if("logout".equals(method)){
            session.removeAttribute("valid");
            session.removeAttribute("uid");
            session.removeAttribute("type");
            session.removeAttribute("username");
            NetUtils.writeResultToBrowser(out,true,"登出成功!");
        }else{
            String username,password;
            username = request.getParameter("username");
            username = username==null?"":username;  //防止username获取为null
            password = request.getParameter("password");
            password = password==null?"":password;  //防止password为null
            User user = UserDao.getUserByUidOrUsername(null,username);

            if(user==null){
                NetUtils.writeResultToBrowser(out,false,"登录失败,未传参或不存在该用户!");
                out.close();
                return;
            }

            if(password.equals(user.getPassword())){
                //登录成功
                session.setAttribute("valid",true);
                session.setAttribute("uid",Long.parseLong(""+user.getUid()));
                session.setAttribute("type",user.getType());
                session.setAttribute("username",user.getUsername());
                NetUtils.writeResultToBrowser(out,true,"登录成功!");
            }else{
                //登录失败
                NetUtils.writeResultToBrowser(out,false,"登录失败,未输入用户名密码或不匹配!");
            }
        }
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
