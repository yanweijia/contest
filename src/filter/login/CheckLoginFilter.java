package filter.login;

import org.apache.logging.log4j.LogManager;
import utils.ConfigUtils;
import utils.CookieUtils;
import utils.NetUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by weijia on 2017-05-14
 * 检测用户是否已经登录,主要匹配需要用户权限的页面
 */
public class CheckLoginFilter implements Filter {
    private boolean needredirect = true;

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();
        needredirect = true;
        //session不是新session
        if(!session.isNew()){
            Boolean valid = new Boolean("" + session.getAttribute("valid"));
            if(!valid)//用户未登录
                redirectLogin(request,response);
            else
                needredirect = false;
        }

        //session是新session
        String uid = CookieUtils.getCookie(request,"uid");
        String access_token = CookieUtils.getCookie(request,"access_token");
        if(uid == null)
            redirectLogin(request,response); //请求登录

        int uuid = 0;
        if(uid!=null)
            try {
                uuid = Integer.parseInt(uid);
            }catch(Exception e){
                LogManager.getLogger().error("uid从String转int失败,uid为"+uid,e);
            }
        filterChain.doFilter(servletRequest,servletResponse);
    }

    private void redirectLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(needredirect) {
            response.sendRedirect(NetUtils.getBasePath(request) + "login.jsp");
            needredirect = false;
        }
    }

    @Override
    public void destroy() {
    }
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
}
