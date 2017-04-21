package db;

import org.apache.commons.dbcp2.BasicDataSourceFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

/**
 * Created by weijia on 2017-03-14.
 * 数据库连接池
 * 原理: <a href='http://www.cnblogs.com/wang-meng/p/5463020.html'>点击转到博客</a>
 * 参考: <a href='http://blog.csdn.net/jj88888/article/details/41519589'>点击转到博客</a>
 */
public class DBManager {
    private static final String configFile = "dbcp.properties";
    private static Properties properties = new Properties();
    private static DataSource dataSource;
    private static final Logger logger = LogManager.getLogger(DBManager.class);
    //加载DBCP配置文件
    static{
        try{
            properties.load(DBManager.class.getClassLoader().getResourceAsStream(configFile));
        }catch(IOException e){
            logger.error("properties加载出错",e);
        }

        try{
            dataSource = BasicDataSourceFactory.createDataSource(properties);
        }catch(Exception e){
            logger.error("BasicDataSourceFactory创建出错",e);
        }
    }

    /**
     * 从连接池中获取一个链接,默认Connection的AutoCommit设置为false
     * @return
     */
    public static final Connection getConnection(){
        Connection connection = null;
        try{
            connection = dataSource.getConnection();
        }catch(SQLException e){
            logger.error("获取Connection时出错",e);
        }
        try {
            connection.setAutoCommit(false);
        } catch (Exception e) {
            logger.error("Connection设置AutoCommit为false时出错",e);
        }
        return connection;
    }

    /**
     * 归还资源
     * @param rs ResultSet,可空
     * @param stmt Statement,可空
     * @param conn Connection连接对象,可空
     */
    public static void closeAll(ResultSet rs, Statement stmt, Connection conn){
        try {
            if(rs!=null && !rs.isClosed())
                rs.close();
        } catch (SQLException e) {
            logger.error("关闭ResultSet出错",e);
        }
        try {
            if(stmt!=null && !stmt.isClosed())
                stmt.close();
        }catch (SQLException e) {
            logger.error("关闭Statement出错",e);
        }

        try {
            if(conn!=null && !conn.isClosed())
                conn.close();//关闭
        }catch (SQLException e) {
            logger.error("关闭Connection出错",e);
        }
    }
    /**
     * 更新数据库
     * @param sql 待执行的sql语句
     * @param values 对应预编译sql语句中的值
     * @return 受影响的行数,若未0则证明sql执行失败.
     */
    public static int update(String sql,Object... values){
        int effectedRows = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try{
            pstmt = conn.prepareStatement(sql);
            for(int i = 0;i < values.length ; i++){
                pstmt.setObject(i+1,values[i]);
            }
            effectedRows = pstmt.executeUpdate();
            logger.info("执行的sql语句为:"+pstmt.toString());
            conn.commit();
        } catch (SQLException e) {
            logger.error("SQL语句执行出错.语句为"+pstmt!=null?pstmt.toString():sql + " 错误信息为:" + e.getMessage());
            e.printStackTrace();
        }
        DBManager.closeAll(null,pstmt,conn);
        return effectedRows;
    }

    /**
     * 执行查询,<strong>注意:在查询后请手动关闭Result和Connection</strong>
     * @param conn 用DBManager.getConnection()来获取一个对象再传入进来,用于在ResultSet读取完成后进行close
     * @param sql 待执行的sql语句
     * @return 查询后的ResultSet,若为空证明查询失败.
     */
    public static ResultSet query(Connection conn, String sql){
        ResultSet rs = null;
        try{
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
        } catch (SQLException e) {
            logger.error("执行查询失败,sql语句为:" + sql,e);
        }

        return rs;
    }




}
