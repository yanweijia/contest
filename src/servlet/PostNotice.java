package servlet;

import com.google.gson.Gson;
import dao.NoticeDao;
import dao.UserDao;
import entity.User;
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
import java.util.Map;

/**
 * Created by weijia on 2017-04-21.
 * 发布新闻
 * 返回值为JSON类型
 *  {result:boolean
 *  reason:String}
 */
@WebServlet(name="PostNotice",value="/postNotice.action")
public class PostNotice extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(PostNotice.class);

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置响应内容类型
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();


        //获取用户编号
        Integer uid = (Integer)session.getAttribute("uid");

        if(uid==null || uid==0){
            NetUtils.writeResultToBrowser(out,false,"用户未登录,无法发布新闻");
            return;
        }
        //判断用户是否拥有发送notice的权限.在过滤器判断即可
        if(!"管理员".equals(UserDao.getUserType(uid))){
            NetUtils.writeResultToBrowser(out,false,"您没有发送新闻的权限,仅限系统管理员发送,发送失败!");
            return;
        }

        String noticeTitle = request.getParameter("noticeTitle");
        String noticeAuthor = request.getParameter("noticeAuthor");
        String noticeContent = request.getParameter("noticeContent");
        String noticeType = request.getParameter("noticeType");
        if(noticeTitle == null){
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,发送失败");
            return;
        }





        //发布新闻
        int noticeID = NoticeDao.newNotice(noticeAuthor,noticeTitle,noticeType,noticeContent);
        //判断noticeID值
        if(noticeID == 0){
            logger.error("发布新闻失败,具体URL为" + request.getRequestURI()+request.getQueryString());
            NetUtils.writeResultToBrowser(out,false,"未获取到参数,发送失败");
            return;
        }
        NetUtils.writeResultToBrowser(out,true,"发布成功!");
        return;
    }




    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
