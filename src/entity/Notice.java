package entity;

import java.sql.Timestamp;

public class Notice {
  private long nid;
  private String author;
  private java.sql.Timestamp posttime;
  private long viewcount;
  private String title;
  private String type;
  private String content;

  public Notice(long nid, String author, Timestamp posttime, long viewcount, String title, String type, String content) {
    this.nid = nid;
    this.author = author;
    this.posttime = posttime;
    this.viewcount = viewcount;
    this.title = title;
    this.type = type;
    this.content = content;
  }

  public long getNid() {
    return nid;
  }

  public void setNid(long nid) {
    this.nid = nid;
  }

  public String getAuthor() {
    return author;
  }

  public void setAuthor(String author) {
    this.author = author;
  }

  public java.sql.Timestamp getPosttime() {
    return posttime;
  }

  public void setPosttime(java.sql.Timestamp posttime) {
    this.posttime = posttime;
  }

  public long getViewcount() {
    return viewcount;
  }

  public void setViewcount(long viewcount) {
    this.viewcount = viewcount;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }
}
