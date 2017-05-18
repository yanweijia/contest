package servlet.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by weijia on 2017-05-08.
 */
@WebServlet(name = "admin",value = "/admin.action")
public class admin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String type = (String)session.getAttribute("type");
        //为了调试方便,发布时请将1=1所在if语句去除.
//        if(1==1) {
//            request.getRequestDispatcher("/WEB-INF/admin/admin.jsp").forward(request, response);
//            return;
//        }
        if(type!=null){
            if(type.equals("管理员")){
                request.getRequestDispatcher("/WEB-INF/admin/admin.jsp").forward(request,response);
            }else if(type.equals("学校负责人")){
                request.getRequestDispatcher("/WEB-INF/admin/principal.jsp").forward(request,response);
            }else{
                //普通用户
                request.getRequestDispatcher("/WEB-INF/admin/normalUser.jsp").forward(request,response);
            }
        }else{
            //未登录的情况
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
