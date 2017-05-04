package entity;

public class TeamMember {
  private Long mid;
  private Long wid;
  private String name;
  private String idcard;
  private String college;
  private String major;
  private String grade;
  private String email;
  private String phone;
  private Long age;

  public TeamMember() {
  }

  public TeamMember(Long mid, Long wid, String name, String idcard, String college, String major, String grade, String email, String phone, Long age) {
    this.mid = mid;
    this.wid = wid;
    this.name = name;
    this.idcard = idcard;
    this.college = college;
    this.major = major;
    this.grade = grade;
    this.email = email;
    this.phone = phone;
    this.age = age;
  }

  public Long getMid() {
    return mid;
  }

  public void setMid(Long mid) {
    this.mid = mid;
  }

  public Long getWid() {
    return wid;
  }

  public void setWid(Long wid) {
    this.wid = wid;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getIdcard() {
    return idcard;
  }

  public void setIdcard(String idcard) {
    this.idcard = idcard;
  }

  public String getCollege() {
    return college;
  }

  public void setCollege(String college) {
    this.college = college;
  }

  public String getMajor() {
    return major;
  }

  public void setMajor(String major) {
    this.major = major;
  }

  public String getGrade() {
    return grade;
  }

  public void setGrade(String grade) {
    this.grade = grade;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public Long getAge() {
    return age;
  }

  public void setAge(Long age) {
    this.age = age;
  }
}
