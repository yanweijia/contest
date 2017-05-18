package dao;

import db.DBAccess;
import entity.UserInfo;
import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 */
public class UserInfoDao {
    private static final Logger logger = LogManager.getLogger(UserInfoDao.class);


    /**
     * 查询用户信息
     * @param userInfo 用户信息,对应项为空则不赋值
     * @param perPage 结果每页个数
     * @param pageNum 结果第几页
     * @return
     */
    public static List<UserInfo> queryUserInfo(UserInfo userInfo,Integer perPage,Integer pageNum){
        List<UserInfo> list = null;
        Map<String,Object> map = new HashMap<>();
        map.put("userInfo",userInfo);
        map.put("perPage",perPage);
        map.put("pageNum",pageNum);
        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        list = sqlSession.selectList("UserInfo.queryUserInfo",map);
        sqlSession.close();
        return list;
    }



//    /**没必要写,直接删除user表,对应会被删除
//     * 删除一个用户信息
//     * @param uid
//     * @return
//     */
//    public static boolean deleteUserInfo(int uid){
//        return DBAccess.delete("UserInfo.deleteOne",uid)!=0;
//    }

    /**
     * 更新用户信息
     * @param uid
     * @param email
     * @param phone
     * @param idcard
     * @param sex
     * @param name
     * @return
     */
    public static boolean updateUserInfo(Integer uid,
                                         String email,
                                         String phone,
                                         String idcard,
                                         String sex,
                                         String name){
        return updateUserInfo(new UserInfo(uid.longValue(),email,phone,idcard,sex,name));
    }


    /**
     * 更新用户信息
     * @param userInfo
     * @return
     */
    public static boolean updateUserInfo(UserInfo userInfo){
        int effectedRows = 0;
        effectedRows = DBAccess.update("UserInfo.updateUserInfo",userInfo);
        return effectedRows!=0;
    }

    /**
     * 新增一条用户信息
     * @param uid
     * @param email
     * @param phone
     * @param idcard
     * @param sex
     * @param name
     * @return
     */
    public static boolean newUserInfo(Integer uid,
                                      String email,
                                      String phone,
                                      String idcard,
                                      String sex,
                                      String name){
        return newUserInfo(new UserInfo(uid.longValue(),email,phone,idcard,sex,name));
    }


    /**
     * 插入新的用户信息
     * @param userInfo
     * @return
     */
    public static boolean newUserInfo(UserInfo userInfo){
        int effectedRows = 0;
        effectedRows = DBAccess.insert("UserInfo.newUserInfo",userInfo);
        return effectedRows!=0;
    }


}
