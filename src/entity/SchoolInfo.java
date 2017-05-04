package entity;

public class SchoolInfo {
  private Long sid;
  private String name;
  private Long uid;

  public SchoolInfo() {
  }

  public SchoolInfo(Long sid, String name, Long uid) {
    this.sid = sid;
    this.name = name;
    this.uid = uid;
  }

  public Long getSid() {
    return sid;
  }

  public void setSid(Long sid) {
    this.sid = sid;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Long getUid() {
    return uid;
  }

  public void setUid(Long uid) {
    this.uid = uid;
  }
}
