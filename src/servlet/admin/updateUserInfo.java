package servlet.admin;

import dao.UserInfoDao;
import entity.UserInfo;
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

/**
 * Created by weijia on 2017-05-16.
 */
@WebServlet(name = "updateUserInfo",value="/updateUserInfo.action")
public class updateUserInfo extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(updateUserInfo.class);
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String idcard = request.getParameter("idcard");
        String sex = request.getParameter("sex");
        String name = request.getParameter("name");
        if(email==null||phone==null||idcard==null||sex==null||name==null){
            NetUtils.writeResultToBrowser(out,false,"无法获取参数,修改用户信息失败");
            out.close();
            return;
        }
        Integer uid = (Integer)session.getAttribute("uid");
        UserInfo userInfo = new UserInfo(uid.longValue(),email,phone,idcard,sex,name);
        if(UserInfoDao.updateUserInfo(userInfo)){
            NetUtils.writeResultToBrowser(out,true,"修改用户信息成功!");
        }else{
            NetUtils.writeResultToBrowser(out,false,"修改用户信息失败,未知错误!");
        }
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
