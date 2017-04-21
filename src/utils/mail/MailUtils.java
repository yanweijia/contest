package utils.mail;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.ConfigUtils;
import utils.mail.bean.Mail;
import utils.mail.bean.MailUtil;

import javax.mail.MessagingException;
import javax.mail.Session;
import java.io.IOException;

/**
 * Created by weijia on 2017-03-28.
 * 所有邮件均采用UTF-8编码,请注意转换格式
 * 参考<a href="http://www.cnblogs.com/HigginCui/p/5764509.html">
 *     点击转到博客</a>
 */
public class MailUtils {
    private static Logger logger = LogManager.getLogger(MailUtils.class);


    /**
     * 发送邮件,发送账号采用config.properties中的配置
     * @param sendTo 接收人
     * @param subject 邮件主题
     * @param content 邮件内容
     * @return
     */
    public static boolean sendMail(String sendTo,String subject,String content){

        String smtpServer = ConfigUtils.getString("mail.host","");
        String username = ConfigUtils.getString("mail.username","");
        String password = ConfigUtils.getString("mail.password","");
        String from = ConfigUtils.getString("mail.sendFrom","");

        return sendMail(smtpServer,username,password,from,sendTo,subject,content);
    }

    /**
     * 发送邮件
     * @param smtpServer 邮件发送服务器
     * @param username 认证用户名
     * @param password 认证密码
     * @param from 发送自
     * @param to 发送目的(接收人)
     * @param subject 邮件主题
     * @param content 邮件内容
     * @return
     */
    public static boolean sendMail(String smtpServer,
                                   String username,
                                   String password,
                                   String from,
                                   String to,
                                   String subject,
                                   String content){
        Session session = MailUtil.createSession(smtpServer,username,password);
        Mail mail = new Mail(from,to,subject,content);
        //发送
        try {
            MailUtil.send(session,mail);
            return true;
        } catch (MessagingException e) {
            logger.error("发送邮件失败,邮件类异常或无网络连接",e);
        } catch (IOException e) {
            logger.error("发送邮件失败,IO异常",e);
        }
        return false;
    }
}
