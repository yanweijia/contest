package filter.security;

/**
 * Created by weijia on 2017-03-11.
 */

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.NetUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AntiSqlInjectionFilter implements Filter {

    public void destroy() {
    }

    public void init(FilterConfig arg0) throws ServletException {
    }

    public void doFilter(ServletRequest args0, ServletResponse args1,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req=(HttpServletRequest)args0;
        HttpServletResponse res=(HttpServletResponse)args1;
        //获得所有请求参数名
        Enumeration params = req.getParameterNames();
        String sql = "";
        while (params.hasMoreElements()) {
            //得到参数名
            String name = params.nextElement().toString();
            //System.out.println("name===========================" + name + "--");
            //得到参数对应值
            String[] value = req.getParameterValues(name);
            for (int i = 0; i < value.length; i++) {
                sql = sql + value[i];
            }
        }
        //System.out.println("============================SQL"+sql);
        //有sql关键字，跳转到error.html
        if (sqlValidate(sql)) {
            Logger logger = LogManager.getLogger(this);
            String ip = NetUtils.getIpAddr(req);
            String requestURI = req.getRequestURI();
            String method = req.getMethod();
            String pathInfo = req.getPathInfo();
            String queryString = req.getQueryString();
            String scheme = req.getScheme();
            logger.warn("sql注入风险:" +
                    "请求IP：" + ip
                    +" 请求URI：" + requestURI
                    + " 请求方法:" + method
                    + " 参数信息:" + queryString
                    + " 路径信息:" + pathInfo);
            //重定向页面到错误页面
            //req.getRequestDispatcher("error.jsp").forward(req,res);
            throw new IOException("您发送请求中的参数中含有非法字符");
        } else {
            chain.doFilter(args0,args1);
        }
    }

    //效验是否可能有sql注入
    protected static boolean sqlValidate(String str) {
        str = str.toLowerCase();//统一转为小写
        Pattern pattern = Pattern.compile(GetRegexString());
        Matcher matcher = pattern.matcher(str);
        return matcher.matches();
    }
    /// <summary>
    /// 获取正则表达式
    /// </summary>
    /// <returns></returns>
    private static String GetRegexString()
    {
        //构造SQL的注入关键字符
        String[] strBadChar =
                {
                        "select\\s",
                        //"from\\s",
                        "insert\\s",
                        "delete\\s",
                        "update\\s",
                        "drop\\s",
                        "truncate\\s",
                        "exec\\s",
                        "count\\(",
                        "declare\\s",
                        "asc\\(",
                        "mid\\(",
                        "char\\(",
                        "net user",
                        "xp_cmdshell",
                        "/add\\s",
                        "information_schema.columns",
                        "table_schema",
                        "grant\\s",
                        "like'",
                        "net user",
                        "truncate",
                        "exec master.dbo.xp_cmdshell",
                        "net localgroup administrators"
                };

        //构造正则表达式
        String str_Regex = ".*(";
        for (int i = 0; i < strBadChar.length- 1; i++)
        {
            str_Regex += strBadChar[i] + "|";
        }
        str_Regex += strBadChar[strBadChar.length - 1] + ").*";

        return str_Regex;
    }
}