package filter.security.xss;

/**
 * Created by weijia on 2017-03-06.
 * Xss过滤器,自动可疑跨站脚本进行过滤
 */

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class XssFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException{
        XssHttpServletRequestWrapper xssRequest = new XssHttpServletRequestWrapper((HttpServletRequest) request);
        chain.doFilter(xssRequest, response);
    }

    public void destroy() {
    }
}