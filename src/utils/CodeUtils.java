package utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by weijia on 2017-03-02.
 * 加密解密工具类
 */
public class CodeUtils {


    /**
     * 对字符串进行Base64编码,使用UTF-8 ,如果失败,返回code
     * @param code 待编码的字符串
     * @return 编码后字符串
     */
    public static String Base64Encode(String code){
        byte[] b = null;
        String s = null;
        try {
            b = code.getBytes("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            Logger logger = LogManager.getLogger(CodeUtils.class);
            logger.error("Base64Encode失败,原code为:" + code);
            return code;
        }
        if (b != null) {
            s = new BASE64Encoder().encode(b);
        }
        return s;
    }


    /**
     * 对字符串进行Base64解码,使用UTF-8
     * @param code 待解码的字符串
     * @return 解码后的字符串
     */
    public static String Base64Decode(String code){
        byte[] b = null;
        String result = null;
        if (code != null) {
            BASE64Decoder decoder = new BASE64Decoder();
            try {
                b = decoder.decodeBuffer(code);
                result = new String(b, "UTF-8");
            } catch (Exception e) {
                e.printStackTrace();
                Logger logger = LogManager.getLogger(CodeUtils.class);
                logger.error("Base64Decode失败,原code为:" + code);
                return code;
            }
        }
        return result;
    }


    /**
     * 对字符串进行URL编码, 使用UTF-8 ;
     * @param code 待编码的字符串
     * @return URL编码后的结果,若加密出错,返回结果为传进来的参数
     */
    public static String URLEncode(String code){
        String result = code;
        try {
            result = URLEncoder.encode(code,"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            Logger logger = LogManager.getLogger(CodeUtils.class);
            logger.error("URLEncode出错(UTF-8),内容为:"+code);
        }
        return result;
    }

    /**
     * 对字符串进行URL解码, 使用UTF-8
     * @param code 待解码的字符串
     * @return URL解码后的结果,若解码出错,返回结果为传进来的参数
     */
    public static String URLDecode(String code){
        String result = code;
        try {
            result = URLDecoder.decode(code, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            Logger logger = LogManager.getLogger(CodeUtils.class);
            logger.error("URLDecode出错(UTF-8),内容为:"+code);
        }
        return result;
    }





    /**
     * 取字符串的MD5摘要 32位小写
     * @param code 待加密的字符串
     * @return MD5加密后的字符串 32位小写
     */
    public static String encryptByMD5(String code){
        try {
            // 得到一个信息摘要器
            MessageDigest digest = MessageDigest.getInstance("md5");
            byte[] result = digest.digest(code.getBytes());
            StringBuffer buffer = new StringBuffer();
            // 把没一个byte 做一个与运算 0xff;
            for (byte b : result) {
                // 与运算
                int number = b & 0xff;// 加盐
                String str = Integer.toHexString(number);
                if (str.length() == 1) {
                    buffer.append("0");
                }
                buffer.append(str);
            }
            // 标准的md5加密后的结果
            return buffer.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            Logger logger = LogManager.getLogger(CodeUtils.class);
            logger.error("MD5加密出错,原code为:"+code);
            return "";
        }
    }
}
