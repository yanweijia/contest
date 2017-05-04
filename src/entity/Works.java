package entity;

public class Works {
  private Long wid;
  private Long sid;
  private String season;
  private String name;
  private String college;
  private String majortype;
  private String category;
  private String teachername;
  private String teacherphone;

  public Works() {
  }

  public Works(Long wid, Long sid, String season, String name, String college, String majortype, String category, String teachername, String teacherphone) {
    this.wid = wid;
    this.sid = sid;
    this.season = season;
    this.name = name;
    this.college = college;
    this.majortype = majortype;
    this.category = category;
    this.teachername = teachername;
    this.teacherphone = teacherphone;
  }

  public Long getWid() {
    return wid;
  }

  public void setWid(Long wid) {
    this.wid = wid;
  }

  public Long getSid() {
    return sid;
  }

  public void setSid(Long sid) {
    this.sid = sid;
  }

  public String getSeason() {
    return season;
  }

  public void setSeason(String season) {
    this.season = season;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getCollege() {
    return college;
  }

  public void setCollege(String college) {
    this.college = college;
  }

  public String getMajortype() {
    return majortype;
  }

  public void setMajortype(String majortype) {
    this.majortype = majortype;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getTeachername() {
    return teachername;
  }

  public void setTeachername(String teachername) {
    this.teachername = teachername;
  }

  public String getTeacherphone() {
    return teacherphone;
  }

  public void setTeacherphone(String teacherphone) {
    this.teacherphone = teacherphone;
  }
}
