package entity;

public class User {
  private Long uid;
  private String username;
  private String password;
  private String type;

  public User() {
  }

  public User(Long uid, String username, String password, String type) {
    this.uid = uid;
    this.username = username;
    this.password = password;
    this.type = type;
  }

  public Long getUid() {
    return uid;
  }

  public void setUid(Long uid) {
    this.uid = uid;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }
}
