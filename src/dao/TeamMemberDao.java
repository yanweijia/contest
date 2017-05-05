package dao;

import db.DBAccess;
import entity.TeamMember;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weijia on 2017-05-04.
 */
public class TeamMemberDao {
    private static final Logger logger = LogManager.getLogger(TeamMemberDao.class);


    /**
     * 插入新队员信息
     * @param wid
     * @param name
     * @param idcard
     * @param college
     * @param major
     * @param grade
     * @param email
     * @param phone
     * @param age
     * @return 刚插入的队员信息自动生成的编号
     */
    public static int newTeamMember(Integer wid,
                                    String name,
                                    String idcard,
                                    String college,
                                    String major,
                                    String grade,
                                    String email,
                                    String phone,
                                    Integer age){
        return newTeamMember(new TeamMember(null,wid!=null?wid.longValue():null,name,idcard,college,major,grade,email,phone,age!=null?age.longValue():null));
    }

    /**
     * 新增队员信息
     * @param teamMember 队员信息
     * @return 刚插入的队员信息的编号
     */
    public static int newTeamMember(TeamMember teamMember){
        DBAccess.insert("TeamMember.newTeamMember",teamMember);
        return Integer.parseInt(""+teamMember.getMid());
    }


    /**
     * 更新队员信息
     * @param mid
     * @param wid
     * @param name
     * @param idcard
     * @param college
     * @param major
     * @param grade
     * @param email
     * @param phone
     * @param age
     * @return 是否成功
     */
    public static boolean updateTeamMember(Integer mid,
                                           Integer wid,
                                           String name,
                                           String idcard,
                                           String college,
                                           String major,
                                           String grade,
                                           String email,
                                           String phone,
                                           Integer age){
        return updateTeamMember(new TeamMember(mid!=null?mid.longValue():null,wid!=null?wid.longValue():null,name,idcard,college,major,grade,email,phone,age!=null?age.longValue():null));
    }

    /**
     * 更新队员
     * @param teamMember 队员信息封装
     * @return
     */
    public static boolean updateTeamMember(TeamMember teamMember){
        return DBAccess.update("TeamMember.updateTeamMember",teamMember)!=0;
    }


    /**
     * 查询符合条件的队员
     * @param mid
     * @param wid
     * @param name
     * @param idcard
     * @param college
     * @param major
     * @param grade
     * @param email
     * @param phone
     * @param age
     * @param perPage
     * @param pageNum
     * @return
     */
    public static List<TeamMember> queryTeamMember(Integer mid,
                                                   Integer wid,
                                                   String name,
                                                   String idcard,
                                                   String college,
                                                   String major,
                                                   String grade,
                                                   String email,
                                                   String phone,
                                                   Integer age,
                                                   Integer perPage,
                                                   Integer pageNum){
        return queryTeamMember(new TeamMember(mid!=null?mid.longValue():null,wid!=null?wid.longValue():null,name,idcard,college,major,grade,email,phone,age!=null?age.longValue():null),perPage,pageNum);
    }

    /**
     * 查询符合条件的队员信息
     * @param teamMember 队员信息
     * @param perPage 结果每页个数
     * @param pageNum 当前页号
     * @return
     */
    public static List<TeamMember> queryTeamMember(TeamMember teamMember,Integer perPage,Integer pageNum){
        Map<String,Object> map = new HashMap<>();
        map.put("teamMember",teamMember);
        map.put("perPage",perPage);
        map.put("pageNum",pageNum);
        return DBAccess.selectList("TeamMember.queryTeamMember",map);
    }

    /**
     * 删除一个队员
     * @param mid 队员编号
     * @return
     */
    public static boolean deleteOne(int mid){
        List<Integer> list = new ArrayList<>();
        list.add(mid);
        return deleteBatch(list);
    }

    /**
     * 批量删除成员
     * @param list List<Integer> 队员列表
     * @return
     */
    public static boolean deleteBatch(List<Integer> list){
        return DBAccess.delete("TeamMember.deleteBatch",list)!=0;
    }
}
