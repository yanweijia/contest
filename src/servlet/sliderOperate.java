package servlet;

import com.google.gson.Gson;
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
 */
@WebServlet(name = "sliderOperate",value="/sliderOperate")
public class sliderOperate extends HttpServlet {
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
        if("管理员".equals("" + request.getSession().getAttribute("userType"))){
            //TODO:具体的修改代码


            map.put("result",true);
            map.put("reason","修改成功");
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
        Map<String,Object> map = new HashMap<>();
        Integer sliderCount = ConfigUtils.getInteger("slider.count",4);
        map.put("count", sliderCount);
        for(int i = 1 ; i <= sliderCount ; i++){
            map.put("img" + i , ConfigUtils.getString("slider.img." + i , "plug-in/nivo-slider/images/img" + i + ".jpg"));
            String url = ConfigUtils.getString("slider.url." + i , "#");
            url = url.equals("")?"#":url;
            map.put("url" + i , url);
            map.put("name" + i , ConfigUtils.getString("slider.name." + i , ""));
        }
        out.println(gson.toJson(map,Map.class));
        out.close();
    }
}
