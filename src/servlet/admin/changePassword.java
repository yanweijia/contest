package servlet.admin;

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
 * Created by weijia on 2017-05-17.
 * 修改密码Servlet 返回数据JSON类型,格式如下:
 *              {"result":boolean,"reason":"修改成功/错误原因"}
 */
@WebServlet(name = "changePassword",value="/changePassword.action")
public class changePassword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Integer uid = (Integer)session.getAttribute("uid");
        String username = (String)session.getAttribute("username");

        User user = UserDao.getUserByUidOrUsername(uid,username);
        String oldpw = request.getParameter("oldpw");
        String newpw = request.getParameter("newpw");
        if(oldpw==null || newpw==null){
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,修改密码失败!");
            return;
        }
        if(user!=null && user.getPassword().equals(oldpw)){
            if(UserDao.updatePassword(uid,newpw))
                NetUtils.writeResultToBrowser(out,true,"修改密码成功!");
            else
                NetUtils.writeResultToBrowser(out,false,"修改密码失败,数据库错误或无此人信息!");
            return;
        }
        NetUtils.writeResultToBrowser(out,false,"异常错误!");
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
