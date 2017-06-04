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
        System.out.println("\\,".replaceAll(",","\\\\,"));
    }
}
