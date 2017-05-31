package dao;

import db.DBAccess;
import entity.SchoolInfo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 */
public class SchoolInfoDao {
    private static final Logger logger = LogManager.getLogger(SchoolInfoDao.class);


    /**
     * 获取学校信息,通过学校编号
     * @param sid
     * @return
     */
    public static SchoolInfo getSchoolInfoByID(Integer sid){
        Map<String,Object> map = new HashMap<>();
        map.put("sid",sid);
        List<SchoolInfo> list =  DBAccess.selectList("SchoolInfo.querySchoolInfo",map);
        if(list.size()!=0){
            return list.get(0);
        }else {
            return new SchoolInfo();
        }
    }

    /**
     * 根据条件获取学校信息
     * @param name 学校名称,可空,支持模糊查询
     * @param perPage 每页结果个数
     * @param pageNum 当前页数
     * @return
     */
    public static List<SchoolInfo> querySchoolInfo(String name,
                                                   Integer perPage,
                                                   Integer pageNum){
        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        map.put("perPage",perPage);
        map.put("pageNum",pageNum);
        return DBAccess.selectList("SchoolInfo.querySchoolInfo",map);
    }


    /**
     * 根据条件获取学校信息
     * @param sid 学校编号,可空
     * @param name 学校名称,可空,支持模糊
     * @param uid 学校负责人编号,可空
     * @param perPage 每页结果个数
     * @param pageNum 当前页数
     * @return
     */
    public static List<SchoolInfo> querySchoolInfo(Long sid,String name,Long uid,Integer perPage,Integer pageNum){
        Map<String,Object> map = new HashMap<>();
        map.put("sid",sid);
        map.put("name",name);
        map.put("uid",uid);
        map.put("perPage",perPage);
        map.put("pageNum",pageNum);
        return DBAccess.selectList("SchoolInfo.querySchoolInfo",map);
    }

    /**
     * 更新学校信息
     * @param sid 学校编号
     * @param name 学校新名称,可空
     * @param uid 学校负责人编号
     * @return
     */
    public static boolean updateSchoolInfo(Integer sid,
                                           String name,
                                           Integer uid){
        return updateSchoolInfo(new SchoolInfo(sid.longValue(),name,uid!=null?uid.longValue():null));
    }

    /**
     * 更新学校信息
     * @param schoolInfo 学校信息的封装
     * @return
     */
    public static boolean updateSchoolInfo(SchoolInfo schoolInfo){
        return DBAccess.update("SchoolInfo.updateSchoolInfo",schoolInfo)!=0;
    }

    /**
     * 删除一个学校信息
     * @param sid
     * @return
     */
    public static boolean deleteOne(int sid){
        List<Integer> list = new ArrayList<>();
        list.add(sid);
        return deleteBatch(list);
    }

    /**
     * 批量删除学校信息
     * @param list
     * @return
     */
    public static boolean deleteBatch(List<Integer> list){
        return DBAccess.delete("SchoolInfo.deleteBatch",list)!=0;
    }

    /**
     * 插入学校信息
     * @param name 学校名称
     * @param uid 学校负责人编号,可空
     * @return 刚插入的学校编号
     */
    public static int newSchoolInfo(String name,
                                        Integer uid){
        return newSchoolInfo(new SchoolInfo(null,name,uid!=null?uid.longValue():null));
    }

    /**
     * 插入学校信息
     * @param schoolInfo 学校信息
     * @return 刚插入的学校编号
     */
    public static int newSchoolInfo(SchoolInfo schoolInfo){
        DBAccess.insert("SchoolInfo.newSchoolInfo",schoolInfo);
        return Integer.parseInt("" + schoolInfo.getSid());
    }
}
