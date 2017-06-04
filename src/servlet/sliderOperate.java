package servlet;

import com.google.gson.Gson;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.ConfigUtils;

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
 * Created by weijia on 2017-05-09.
 * 获取slider的json信息或者更新slider的相关信息
 * 调用:
 *      /sliderOperate?method=get     获取json
 *      /sliderOperate?method=update  更新信息
 *              格式为count=4 & url1= & name1= & img1= & url2= .....
 */
@WebServlet(name = "sliderOperate",value="/sliderOperate")
public class sliderOperate extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(sliderOperate.class);
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String method = request.getParameter("method");
        if("update".equals(method)){
            updateSliderInfo(request,out);
        }else{
            getSliderJson(out);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    /**
     * 修改slider信息
     * @param request 网页上下文
     * @param out
     */
    private static void updateSliderInfo(HttpServletRequest request,PrintWriter out){
        Gson gson = new Gson();
        Map<String,Object> map = new HashMap<>();
        request.getSession().setAttribute("userType","管理员");
        if("管理员".equals("" + request.getSession().getAttribute("userType"))){
            //具体的修改代码
            String count_str = request.getParameter("count");
            count_str = (count_str==null|| "".equals(count_str))?"0":count_str;
            Integer count = Integer.parseInt(count_str);
            if(count!=0){
                Map<String,String> names = new HashMap<>();
                Map<String,String> urls = new HashMap<>();
                Map<String,String> imgs = new HashMap<>();
                for(int i = 0 ; i < count ; i++){
                    names.put("name" + (i+1),request.getParameter("name" + (i+1)));
                    urls.put("url" + (i+1),request.getParameter("url" + (i+1)));
                    imgs.put("img" + (i+1),request.getParameter("img" + (i+1)));
                }
                //写入配置文件.
                ConfigUtils.setProperty("slider.count",count);
                ConfigUtils.setProperty("slider.names",gson.toJson(names,Map.class).replaceAll(",","\\\\,"));
                ConfigUtils.setProperty("slider.urls",gson.toJson(urls,Map.class).replaceAll(",","\\\\,").replaceAll("＃","#"));
                ConfigUtils.setProperty("slider.imgs",gson.toJson(imgs,Map.class).replaceAll(",","\\\\,"));
                map.put("result",true);
                map.put("reason","修改成功");
            }else{
                map.put("result",false);
                map.put("reason","未获到参数,修改失败!");
            }







        }else{
            map.put("result",false);
            map.put("reason","很抱歉,您没有权限更新轮播图片slider");
        }
        out.println(gson.toJson(map,Map.class));
        out.close();
    }


    /**
     * 获取Slider的json数据封装
     * @param out
     */
    private static void getSliderJson(PrintWriter out) {
        Gson gson = new Gson();
        Map<String,Object> resultMap = new HashMap<>();
        Map<String,String> map_names,map_urls,map_imgs;
        Integer sliderCount = ConfigUtils.getInteger("slider.count",4);

//        查看是否能正确获取
//        logger.info(ConfigUtils.getString("slider.names",""));
//        logger.info(ConfigUtils.getString("slider.urls",""));
//        logger.info(ConfigUtils.getString("slider.imgs",""));

        map_names = gson.fromJson(ConfigUtils.getString("slider.names","{}"),Map.class);
        map_urls = gson.fromJson(ConfigUtils.getString("slider.urls","{}"),Map.class);
        map_imgs = gson.fromJson(ConfigUtils.getString("slider.imgs","{}"),Map.class);

        for(int i = 1 ; i <= sliderCount ; i++){
            resultMap.put("img" + i ,map_imgs.get("img"+i));
            resultMap.put("url" + i , map_urls.get("url"+i));
            resultMap.put("name" + i , map_names.get("name"+i));
        }

        resultMap.put("count", sliderCount);
        out.println(gson.toJson(resultMap,Map.class));
        out.close();
    }
}
