package dao;

import db.DBAccess;
import entity.Works;
import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 */
public class WorksDao {
    private static final Logger logger = LogManager.getLogger(WorksDao.class);


    /**
     * 根据传递进来的参数来查询符合条件的List,不想匹配的字段直接传null即可
     * @param wid 作品编号
     * @param sid 所属学校编号
     * @param season 所属赛季
     * @param name 作品名称,模糊匹配
     * @param college 作品所属学院,模糊匹配
     * @param majorType 专业类型:ENUM('文科', '非文科')
     * @param category 作品类型:ENUM('数据库应用系统', 'Web网站设计', '多媒体制作', '微课程或课件', '程序设计应用', '企业合作项目', '软件服务外包', '智慧城市')
     * @param teacherName 老师姓名
     * @param teacherPhone 老师电话
     * @param perPage 每页新闻个数
     * @param pageNum 查询的页面
     * @return
     */
    public static List<Works> queryWorksList(Integer wid,
                                             Integer sid,
                                             String season,
                                             String name,
                                             String college,
                                             String majorType,
                                             String category,
                                             String teacherName,
                                             String teacherPhone,
                                             Integer perPage,
                                             Integer pageNum) {
        Works works = new Works(wid != null ? wid.longValue() : null, sid != null ? sid.longValue() : null, season, name, college, majorType, category, teacherName, teacherPhone);
        return queryWorksList(works,perPage,pageNum);
    }

    /**
     * 查询符合条件的Works
     *
     * @return
     */
    public static List<Works> queryWorksList(Works works,Integer perPage,Integer pageNum) {
        List<Works> worksList = new ArrayList<>();
        SqlSession sqlSession = null;
        try {
            sqlSession = DBAccess.getSqlSession();
            // 通过sqlSession执行SQL语句
            Map<String,Object> map = new HashMap<>();
            map.put("works",works);
            map.put("perPage",perPage);
            map.put("pageNum",pageNum);
            worksList = sqlSession.selectList("Works.queryWorksList", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return worksList;
    }


    /**
     * 根据比赛作品名称查询
     *
     * @param name 作品名称
     * @return
     */
    public static List<Works> queryWorksByName(String name,Integer perPage,Integer pageNum) {
        Works works = new Works();
        works.setName(name);
        return queryWorksList(works,perPage,pageNum);
    }


    /**
     * 根据sid和season获取查询结果
     *
     * @param sid    学校编号
     * @param season 作品所属赛季
     * @return
     */
    public static List<Works> queryWorksBySidAndSeason(int sid, String season,Integer perPage,Integer pageNum) {
        Works works = new Works();
        works.setSid((long) sid);
        works.setSeason(season);
        return queryWorksList(works,perPage,pageNum);
    }


    /**
     * 根据sid获取查询结果
     *
     * @param sid 学校编号
     * @return
     */
    public static List<Works> queryWorksBySID(int sid,Integer perPage,Integer pageNum) {
        return queryWorksBySidAndSeason(sid, null,perPage,pageNum);
    }

    /**
     * 批量删除Works
     * @param list List<Integer>类型,Works的wid编号集合
     * @return 受影响的行数
     */
    public static int deleteBatch(List<Integer> list){
        if(list==null){
            list = new ArrayList<>();
        }
        int result = 0;
        SqlSession sqlSession = null;
        try {
            sqlSession = DBAccess.getSqlSession();
            result = sqlSession.delete("Works.deleteBatch", list);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        logger.debug("删除了 " + result + " 个数据");
        return result;
    }

    /**
     * 删除一个Works
     * @param wid 编号
     * @return 受影响的行数
     */
    public static int deleteOne(int wid){
        List<Integer> list = new ArrayList<>();
        list.add(wid);
        return deleteBatch(list);
    }

    /**
     * 根据赛季和学校编号获取作品个数,无则传null
     * @param season 赛季,可空,默认所有
     * @param sid 学校编号,可空,默认所有
     * @return 个数
     */
    public static int getCountBySeasonAndSid(String season,Integer sid){
        int result = 0;
        Map<String,Object> map = new HashMap<>();
        map.put("season",season);
        map.put("sid",sid);

        SqlSession sqlSession = null;
        sqlSession = DBAccess.getSqlSession();
        result = sqlSession.selectOne("Works.getCount",map);
        sqlSession.close();
        logger.debug("查询season为"+season+"且sid为"+sid+"的结果总共有"+result);
        return result;
    }


    /**
     * 插入一条新Works
     * @param works 作品信息
     * @return 插入的新works编号
     */
    public static int newWorks(Works works){
        int effectedRows = 0;
        if(works!=null){
            SqlSession sqlSession = null;
            sqlSession = DBAccess.getSqlSession();
            effectedRows = sqlSession.insert("Works.newWorks",works);
            sqlSession.commit();
            sqlSession.close();
        }
        return Integer.parseInt(""+works.getWid());
    }

    /**
     * 插入一条新Works
     * @param works 作品信息
     * @param sqlSession sqlSession,可以主要插入作品信息和队员信息时可以有事务一致性.
     * @return 插入的新works编号
     */
    public static int newWorks(Works works,SqlSession sqlSession){
        if(works!=null){
            sqlSession.insert("Works.newWorks",works);
        }
        return Integer.parseInt(""+works.getWid());
    }


    /**
     * 插入一条新Works
     * @param sid 学校编号
     * @param season 赛季
     * @param name 作品名称
     * @param college 作品所属学院
     * @param majorType 专业类别
     * @param category 作品类别ENUM('数据库应用系统', 'Web网站设计', '多媒体制作', '微课程或课件', '程序设计应用', '企业合作项目', '软件服务外包', '智慧城市')
     * @param teacherName 老师姓名
     * @param teacherPhone 老师电话
     * @return
     */
    public static int newWorks(Integer sid,
                                   String season,
                                   String name,
                                   String college,
                                   String majorType,
                                   String category,
                                   String teacherName,
                                   String teacherPhone){
        Works works = new Works(null,sid!=null?sid.longValue():null,season,name,college,majorType,category,teacherName,teacherPhone);
        return newWorks(works);
    }


    /**
     * 更新Works
     * @param works 作品信息
     * @return 是否更新成功
     */
    public static boolean updateWorks(Works works){
        int effectedRows = 0;
        if(works!=null){
            SqlSession sqlSession = null;
            sqlSession = DBAccess.getSqlSession();
            effectedRows = sqlSession.update("Works.updateWorks",works);
            sqlSession.commit();
            sqlSession.close();
        }
        return effectedRows!=0;
    }

    /**
     * 更新Works
     * @param works 作品信息
     * @param sqlSession  sqlSession,可以主要插入作品信息和队员信息时可以有事务一致性.
     * @return 是否更新成功
     */
    public static boolean updateWorks(Works works,SqlSession sqlSession){
        return sqlSession.update("Works.updateWorks",works) != 0;
    }

    /**
     * 更新Works
     * @param wid
     * @param sid
     * @param season
     * @param name
     * @param college
     * @param majorType
     * @param category
     * @param teacherName
     * @param teacherPhone
     * @return 是否成功
     */
    public static boolean updateWorks(Integer wid,
                                      Integer sid,
                                      String season,
                                      String name,
                                      String college,
                                      String majorType,
                                      String category,
                                      String teacherName,
                                      String teacherPhone){
        Works works = new Works(wid!=null?wid.longValue():null,sid!=null?sid.longValue():null,season,name,college,majorType,category,teacherName,teacherPhone);
        return updateWorks(works);
    }

}