package entity;

public class UserInfo {
  private Long uid;
  private String email;
  private String phone;
  private String idcard;
  private String sex;
  private String name;

  public UserInfo() {
  }

  public UserInfo(Long uid, String email, String phone, String idcard, String sex, String name) {
    this.uid = uid;
    this.email = email;
    this.phone = phone;
    this.idcard = idcard;
    this.sex = sex;
    this.name = name;
  }

  public Long getUid() {
    return uid;
  }

  public void setUid(Long uid) {
    this.uid = uid;
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

  public String getIdcard() {
    return idcard;
  }

  public void setIdcard(String idcard) {
    this.idcard = idcard;
  }

  public String getSex() {
    return sex;
  }

  public void setSex(String sex) {
    this.sex = sex;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}
