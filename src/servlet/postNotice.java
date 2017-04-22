package servlet;

import dao.NoticeDao;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.CodeUtils;
import utils.ConfigUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by weijia on 2017-04-21.
 */
@WebServlet("/postNotice")
public class postNotice extends HttpServlet {
    private static final Logger logger = LogManager.getLogger(postNotice.class);
    // 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = ConfigUtils.getString("noticeAttachDir","notice/upload/attach");
    // 上传配置
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 10; // 10MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 50; // 50MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置响应内容类型
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        String noticeTitle = null , noticeAuthor = null , noticeContent = null , noticeType = null;

        //(检测是否为多媒体上传)
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            out.println("表单类型错误,必须为multipart");
            out.flush();
        }

        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);
        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String uploadPath = getServletContext().getRealPath("./")
                + File.separatorChar + UPLOAD_DIRECTORY;//Tomcat版本不同获取的realpath后面可能有/无 文件夹分隔符'/'
        logger.info("附件保存目录为:" + uploadPath);
        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段(表单中文件)
                    if (!item.isFormField()) {
                        FileItem noticeAttach = null;  //读取logo图片的值
                        noticeAttach = item;
                        // 保存文件到硬盘
                        try {
                            String filePath = uploadPath + File.separator + item.getName();
                            File storeFile = new File(filePath);
                            // 在控制台输出文件的上传路径
                            //System.out.println(filePath);
                            noticeAttach.write(storeFile);
                        } catch (Exception e) {
                            String reason = "文件写入硬盘失败!";
                            logger.error(reason,e);
                            out.println(reason);
                            return;
                        }
                    }else{
                        //获取表单中非文件的值
                        String formname = item.getFieldName();// 获取form中的名字
                        logger.info(formname + " " + item.getString("UTF-8"));
                        if(formname.equals("noticeTitle"))
                            noticeTitle = item.getString("UTF-8");
                        if(formname.equals("noticeContent"))
                            noticeContent = item.getString("UTF-8");
                        if(formname.equals("noticeType"))
                            noticeType = item.getString("UTF-8");
                        if(formname.equals("noticeAuthor"))
                            noticeAuthor = item.getString("UTF-8");
                    }
                }
            }
        } catch (Exception e) {
            logger.error("文件写入硬盘异常,请求url为"+request.getRequestURI(),e);
        }


        //发布新闻
        int noticeID = NoticeDao.newNotice(noticeAuthor,noticeTitle,noticeType,noticeContent);
        //判断noticeID值
        if(noticeID == 0){
            logger.error("发布新闻失败,具体URL为" + request.getRequestURI()+request.getQueryString());
            String reason = "发布新闻失败!";
            out.println(reason);
            return;
        }
        out.println("新闻发送成功");
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
