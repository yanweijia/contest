package utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by weijia on 2017-03-11.
 */
public class NetUtils {


    /**
     * 获取对方真实IP,并非最准确但不会因为反向代理读错<br/>
     * 可参考<a href='http://blog.csdn.net/sgx425021234/article/details/19043459'>在多级反向代理情况下获取用户真实IP</a>
     *
     * @param request
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 获取网站的basePath
     * @param request 请求对象
     * @return basePath
     */
    public static String getBasePath(HttpServletRequest request){
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
        return basePath;
    }

}
