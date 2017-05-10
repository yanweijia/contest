package test;

import dao.SchoolInfoDao;
import dao.UserDao;
import dao.WorksDao;
import entity.SchoolInfo;
import entity.Works;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by weijia on 2017-05-04.
 */
public class test {
    private static final Logger logger = LogManager.getLogger(test.class);
    public static void main(String[] args){
        String a = "a";
        Integer b = null;
        logger.trace("123");
        logger.debug("456");
        logger.info("789");
        try{
            b = Integer.parseInt(a);
        }catch(Exception e){
            logger.error("parse出错了",e);
        }

        logger.warn("131415");
    }
}
