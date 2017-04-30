package dao;

import db.DBManager;
import entity.Notice;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import utils.CodeUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by weijia on 2017-04-22.
 */
public class NoticeDao {
    private static final Logger logger = LogManager.getLogger(NoticeDao.class);


    /**
     * 插入一条新闻
     * @param author 新闻作者
     * @param title 新闻标题
     * @param type 新闻类型
     * @param content 新闻内容
     * @return 刚插入的新闻编号,为0表示插入失败.
     */
    public static int newNotice(String author, String title, String type, String content){
        int noticeID = 0;
        Timestamp posttime = new Timestamp(System.currentTimeMillis());
        String sql = "INSERT INTO notice(author,posttime,title,type,content)VALUES(?,?,?,?,?)";
        Connection conn = DBManager.getConnection();
        int effectedRows = 0;
        PreparedStatement cmd = null;
        ResultSet rs = null;
        //传入参数则可以获取到自增长的nid
        try {
            cmd = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            cmd.setString(1,author);
            cmd.setTimestamp(2,posttime);
            cmd.setString(3,title);
            cmd.setString(4,type);
            cmd.setString(5,content);
            effectedRows = cmd.executeUpdate();
            rs = cmd.getGeneratedKeys(); //获取结果
            if(rs.next())
                noticeID = rs.getInt(1);//取得nid

            //如果插入失败,返回false
            if(effectedRows == 0 || noticeID == 0){
                conn.rollback();    //回滚
                return noticeID;
            }
            conn.commit();
        } catch (SQLException e) {
            logger.error("发布新闻失败!",e);
        }
        DBManager.closeAll(rs,cmd,conn);
        return noticeID;
    }

    /**
     * 删除指定编号的新闻
     * @param noticeID 新闻编号
     * @return 操作是否成功
     */
    public static boolean deleteNotice(int noticeID){
        String sql = "DELETE FROM notice WHERE nid=?";
        int effectedRows = DBManager.update(sql,noticeID);
        return effectedRows != 0;
    }


    /**
     * 获取指定编号的新闻
     * @param noticeID 新闻编号
     * @return 新闻实体类
     */
    public static Notice getNoticeByID(int noticeID){
        Notice notice = null;
        String sql = "SELECT * FROM notice WHERE nid=?";
        Connection conn = DBManager.getConnection();
        PreparedStatement cmd = null;
        ResultSet rs = null;
        try{
            cmd = conn.prepareStatement(sql);
            cmd.setLong(1,noticeID);
            rs = cmd.executeQuery();
            if(!rs.next()){
                return null;
            }
            String noticeAuthor = rs.getString("author");
            Timestamp postTime = rs.getTimestamp("posttime");
            int viewCount = rs.getInt("viewCount");
            String noticeTitle = rs.getString("title");
            String noticeType = rs.getString("type");
            String noticeContent = CodeUtils.Base64Decode(rs.getString("content"));

            //生成一个新的实例
            notice = new Notice(noticeID,noticeAuthor,postTime,viewCount,noticeTitle,noticeType,noticeContent);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        DBManager.closeAll(rs,cmd,conn);

        //更新浏览次数
        sql = "UPDATE notice SET viewCount=viewCount+1 WHERE nid=?";
        DBManager.update(sql,noticeID);
        return notice;
    }


    /**
     * 根据页号获取新闻
     * @param pageNum 页号,从1开始
     * @param perPage 每页新闻数
     * @param type 新闻类型
     * @return 符合要求的新闻集合
     */
    public static List<Notice> getNoticeByPage(int pageNum,int perPage,String type){
        return queryNotice("",pageNum,perPage,type);
    }


    /**
     * 根据关键词搜索获取新闻内容
     * @param key 关键词
     * @param pageNum 页号,从1开始
     * @param perPage 每页新闻个数
     * @param type 新闻类型
     * @return 结果
     */
    public static List<Notice> queryNotice(String key,int pageNum,int perPage,String type){
        List<Notice> list = new ArrayList<Notice>();
        if(type==null || type.equals(""))  type = "";
        String sql = "SELECT * FROM notice WHERE (title LIKE '%" + key + "%' OR content LIKE '%" + key + "%')" +
                " AND type LIKE '%" + type + "%' LIMIT " + ((pageNum-1) * perPage) + "," + perPage;
        Connection conn = DBManager.getConnection();
        ResultSet rs = null;
        try{
            rs = DBManager.query(conn,sql);
            while(rs.next()){
                Notice notice = new Notice();
                notice.setNid(rs.getLong("nid"));
                notice.setAuthor(rs.getString("author"));
                notice.setPosttime(rs.getTimestamp("posttime"));
                notice.setViewcount(rs.getLong("viewCount"));
                notice.setTitle(rs.getString("title"));
                notice.setType(rs.getString("type"));
                notice.setContent(rs.getString("content"));
                list.add(notice);
            }
        }catch(SQLException e){
            logger.error("错误",e);
        }
        return list;
    }

    /**
     * 获取新闻总个数
     * @return 总新闻数目
     */
    public static int getNoticeCount(){
        int noticeCount = 0;
        String sql = "SELECT COUNT(*) FROM notice";
        Connection conn = DBManager.getConnection();
        ResultSet rs = DBManager.query(conn,sql);
        try{
            if(rs.next())
                noticeCount = rs.getInt(1);
        }catch(SQLException e){
            e.printStackTrace();
        }
        DBManager.closeAll(rs,null,conn);
        return noticeCount;
    }


    /**
     * 修改(再次编写)新闻
     * @param notice 新闻实例
     * @return 是否修改成功
     */
    public static boolean updateNotice(Notice notice){
        int effectedRows = 0;
        String sql = "UPDATE notice SET author=?,posttime=?,title=?,type=?,content=? WHERE nid=?";
        effectedRows = DBManager.update(sql,notice.getAuthor(),notice.getPosttime(),notice.getTitle(),notice.getType(),notice.getContent(),notice.getNid());
        return effectedRows != 0;
    }

}
