package filter;

import javax.servlet.*;
import java.io.IOException;

/**
 * 网页编码过滤器
 * 参考<a href='http://blog.csdn.net/friendan/article/details/9090105'>点击查看博客</a>
 */
public class CharacterEncodingFilter implements Filter {
    String encodingString="UTF-8";
    @Override
    public void destroy() {
        encodingString="";
    }

    @Override
    public void doFilter(ServletRequest arg0, ServletResponse arg1,FilterChain arg2)
            throws IOException, ServletException {
        if(encodingString!=null){
            //注意MyEclipse的版本不同，方法doFilter的参数有可能不同，
            //设置字符编码，认准其类型为ServletRequest即可
            // 我用的是MyEclipse10
            arg0.setCharacterEncoding(encodingString);
            arg1.setCharacterEncoding(encodingString);
        }
        arg2.doFilter(arg0, arg1);
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        //注意MyEclipse的版本不同，方法init的参数有可能不同
        //这里的参数为arg0
        // 我用的是MyEclipse10
        //从配置文件中取编码
        this.encodingString=arg0.getInitParameter("encoding").trim();
        if(encodingString==null){
            encodingString="UTF-8";
        }
    }
}