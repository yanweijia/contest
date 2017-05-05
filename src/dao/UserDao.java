package dao;

import db.DBAccess;
import entity.User;
import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 */
public class UserDao {
    private static final Logger logger = LogManager.getLogger(UserDao.class);


    /**
     * 根据用户类型查询符合条件的用户
     * @param type 用户类型
     * @param perPage 每页个数
     * @param pageNum 当前页数
     * @return
     */
    public static List<User> queryUsers(String type,Integer perPage,Integer pageNum){
        User user = new User();
        user.setType(type);
        return queryUsers(user,perPage,pageNum);
    }

    /**
     * 查询符合条件的用户
     * @param user 用户信息
     * @param perPage 每页用户个数
     * @param pageNum 当前页数
     * @return
     */
    public static List<User> queryUsers(User user,Integer perPage,Integer pageNum){
        List<User> list = null;
        Map<String,Object> map = new HashMap<>();
        map.put("user",user);
        map.put("perPage",perPage);
        map.put("pageNum",pageNum);
        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        list = sqlSession.selectList("User.queryUsers",map);
        sqlSession.close();
        return list;
    }

    /**
     * 获取用户个数
     * @param userType 要统计的用户类型,可空,如传null则查询所有
     * @return 符合条件的用户个数
     */
    public static int getCount(String userType){
        int resultCount = 0;
        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        resultCount = sqlSession.insert("User.getCount", userType);
        sqlSession.close();
        return resultCount;
    }

    /**
     * 修改用户类型
     * @param uid
     * @param type
     * @return
     */
    public static boolean updateUserType(int uid,String type){
        User user = new User();
        user.setUid((long)uid);
        user.setType(type);
        return updateUser(user);
    }

    /**
     * 更新用户名
     * @param uid 用户编号
     * @param newUsername 新用户名
     * @return
     */
    public static boolean updateUsername(int uid,String newUsername){
        User user = new User();
        user.setUid((long)uid);
        user.setUsername(newUsername);
        return updateUser(user);
    }


    /**
     * 更新用户密码
     * @param uid
     * @param newPW MD5(密码)加密后的值,32位小写
     * @return
     */
    public static boolean updatePassword(int uid,String newPW){
        User user = new User();
        user.setUid((long)uid);
        user.setPassword(newPW);
        return updateUser(user);
    }



    /**
     * 更新用户账号
     * @param user 用户账号信息
     * @return
     */
    private static boolean updateUser(User user){
        int effectedRows = 0;
        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        effectedRows = sqlSession.insert("User.updateUser", user);
        sqlSession.commit();
        sqlSession.close();
        return effectedRows!=0;
    }

    /**
     * 批量删除用户
     * @param uidList  List<Integer> 用户编号列表
     * @return
     */
    public static boolean deleteBatch(List<Integer> uidList){
        return DBAccess.delete("User.deleteBatch",uidList)!=0;
    }

    /**
     * 删除一个用户
     * @param uid
     * @return
     */
    public static boolean deleteOne(int uid){
        int effectedRows = 0;
        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        effectedRows = sqlSession.insert("User.deleteOne", uid);
        sqlSession.commit();
        sqlSession.close();
        return effectedRows!=0;
    }


    /**
     * 新增用户
     * @param user 用户账号信息
     * @return
     */
    public static int newUser(User user){
        int effectedRows = 0;
        if(user!=null) {
            SqlSession sqlSession = null;
            sqlSession = DBAccess.getSqlSession();
            effectedRows = sqlSession.insert("User.newUser", user);
            sqlSession.commit();
            sqlSession.close();
        }
        return Integer.parseInt(""+user.getUid());
    }

    /**
     * 新增用户
     * @param username
     * @param password
     * @param type
     * @return
     */
    public static int newUser(String username,String password,String type){
        User user = new User(null,username,password,type);
        return newUser(user);
    }

}
