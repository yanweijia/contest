package servlet.admin;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.ConfigUtils;
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
@WebServlet(name = "websiteConfig",value="/websiteConfig.action")
public class websiteConfig extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(websiteConfig.class);
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        if(!"管理员".equals("" + session.getAttribute("type"))){
            NetUtils.writeResultToBrowser(out,false,"您没有权限修改!");
            out.close();
            logger.info("有人试图修改网站配置文件,但未成功!");
            return;
        }
        String websiteName = request.getParameter("websiteName");
        boolean enrollSwitch = "open".equals("" + request.getParameter("enrollSwitch"))?true:false;
        boolean webSwitch = "open".equals("" + request.getParameter("webSwitch"))?true:false;
        if(websiteName == null || "".equals(websiteName.trim()))
            websiteName = "大学生计算机应用能力大赛";
        ConfigUtils.setProperty("websiteName",websiteName);
        ConfigUtils.setProperty("enrollSitch",enrollSwitch);
        ConfigUtils.setProperty("webSwitch",webSwitch);
        NetUtils.writeResultToBrowser(out,true,"修改成功!");
        out.close();
        logger.info("管理员修改了网站配置文件.");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
