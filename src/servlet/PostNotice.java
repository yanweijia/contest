package servlet;

import com.google.gson.Gson;
import dao.NoticeDao;
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
 * Created by weijia on 2017-04-21.
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

        Map<String,Object> map = new HashMap<>();
        Gson gson = new Gson();

        String noticeTitle = request.getParameter("noticeTitle");
        String noticeAuthor = request.getParameter("noticeAuthor");
        String noticeContent = request.getParameter("noticeContent");
        String noticeType = request.getParameter("noticeType");
        if(noticeTitle == null){
            logger.info("未获取到参数,发送失败");
            map.put("result",false);
            map.put("reason","未获取到参数,发送失败");
            out.println(gson.toJson(map,Map.class));
            out.flush();
            return;
        }


        //TODO:判断用户是否拥有发送notice的权限.在过滤器判断即可


        //发布新闻
        int noticeID = NoticeDao.newNotice(noticeAuthor,noticeTitle,noticeType,noticeContent);
        //判断noticeID值
        if(noticeID == 0){
            logger.error("发布新闻失败,具体URL为" + request.getRequestURI()+request.getQueryString());
            String reason = "发布新闻失败!";
            map.put("result",false);
            map.put("reason",reason);
            out.println(gson.toJson(map,Map.class));
            return;
        }
        map.put("result",true);
        map.put("reason","新闻发送成功");
        out.println(gson.toJson(map,Map.class));
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
