package servlet.admin;

import com.google.gson.Gson;
import dao.NoticeDao;
import dao.UserInfoDao;
import entity.Notice;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-16.
 */
@WebServlet(name = "noticeManage",value="/noticeManage.action")
public class noticeManage extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(noticeManage.class);
    Map<String,Object> resultMap;
    Gson gson;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        resultMap = new HashMap<>();
        gson = new Gson();

        String method = request.getParameter("method");

        if(method==null || "".equals(method.trim())){
            NetUtils.writeResultToBrowser(out,false,"无法获取参数,请求失败");
            out.close();
            return;
        }

        if("delete".equals(method)){
            String nid = request.getParameter("nid");
            nid = (nid==null||"".equals(nid))?"0":nid;
            if(NoticeDao.deleteNotice(Integer.parseInt(nid)))
                NetUtils.writeResultToBrowser(out,true,"删除成功");
            else
                NetUtils.writeResultToBrowser(out,false,"删除失败!未知原因.");
            out.close();
            return;
        }



        if("query".equals(method)) {
            String key = request.getParameter("noticeTitle");
            String noticeType = request.getParameter("noticeType");
            List<Notice> list = NoticeDao.queryNotice(key, 1, 20, noticeType);
            resultMap.put("result",true);
            resultMap.put("matchCount",list.size());
            List<Map<String,Object>> myList = new ArrayList<>();
            for(Notice notice:list){
                Map<String,Object> map = new HashMap<>();
                map.put("nid",notice.getNid());
                map.put("type",notice.getType());
                map.put("title",notice.getTitle());
                map.put("author",notice.getAuthor());
                map.put("posttime",notice.getPosttime());
                map.put("viewCount",notice.getViewcount());
                myList.add(map);
            }
            resultMap.put("notices",myList);
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
