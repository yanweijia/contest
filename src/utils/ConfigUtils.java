package utils;


import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


/**
 * Created by weijia on 2017-03-22.
 */
public class ConfigUtils {

    private static final Logger logger = LogManager.getLogger(ConfigUtils.class);
    private static PropertiesConfiguration config = null;

    private ConfigUtils() {
    }

    static {
        try {
            //初始化配置
            config = new PropertiesConfiguration("config.properties");
            //文件修改之后自动加载
            config.setReloadingStrategy(new FileChangedReloadingStrategy());
            //配置文件自动保存
            config.setAutoSave(true);
        } catch (ConfigurationException e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * 获取String参数
     *
     * @param key
     * @return
     */
    public static String getString(String key,String defaultValue) {
        return config.getString(key, defaultValue);
    }

    /**
     * 获取String数组参数
     *
     * @param key
     * @return
     */
    public static String[] getStringArray(String key) {
        return config.getStringArray(key);
    }

    /**
     * 获取Integer参数
     *
     * @param key
     * @return
     */
    public static Integer getInteger(String key,int defaultValue) {
        return config.getInteger(key, defaultValue);
    }

    /**
     * 获取Double参数
     *
     * @param key
     * @return
     */
    public static Double getDouble(String key,double defaultValue) {
        return config.getDouble(key, defaultValue);
    }

    /**
     * 获取Long参数
     *
     * @param key
     * @return
     */
    public static Long getLong(String key,long defaultValue) {
        return config.getLong(key, defaultValue);
    }

    /**
     * 新增或修改参数
     *
     * @param key
     * @param value
     */
    public static void setProperty(String key, Object value) {
        config.setProperty(key, value);
    }

}