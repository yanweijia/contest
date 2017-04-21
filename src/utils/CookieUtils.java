package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by weijia on 2017-03-06.
 * Cookies帮助类
 */
public class CookieUtils {

    /**
     * 删除指定Cookie,反正成功或失败
     * @param response 网页response对象
     * @param cookieName 名称
     * @return
     */
    public static boolean delCookie(HttpServletResponse response, String cookieName) {
        return writeCookie(response,cookieName,"",0);
    }

    /**
     * 获取指定Cookie , 无则为null
     * @param request 网页request对象
     * @param cookieName cookie名称
     * @return cookie值,无则为null
     */
    public static String getCookie(HttpServletRequest request, String cookieName){
        Cookie[] cookies = request.getCookies();
        //如果没有cookies返回空
        if(cookies == null)
            return null;
        for(Cookie cookie : cookies){
            if(cookieName.equals(cookie.getName()))
                return cookie.getValue();
        }
        //如果找不到该cookie,返回空
        return null;
    }

    /**
     * 写入cookie到客户端
     * @param response 网页response对象
     * @param cookieName cookie名称
     * @param cookieValue cookie值
     * @param cookieMaxAge_day 最长有效期,按天计算
     * @return 是否写入成功
     */
    public static boolean writeCookie(HttpServletResponse response, String cookieName, String cookieValue, int cookieMaxAge_day){
        if(response==null || cookieName==null || cookieValue==null)
            return false;
        Cookie cookie = new Cookie(cookieName,cookieValue);
        cookie.setMaxAge(cookieMaxAge_day * 24 * 60 * 60);
        response.addCookie(cookie);
        return true;
    }
}
