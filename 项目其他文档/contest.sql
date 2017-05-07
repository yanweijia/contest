--创建数据库
CREATE DATABASE `contest` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--创建新闻表
CREATE TABLE `contest`.`notice`(  
  `nid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '新闻编号',
  `author` VARCHAR(20) DEFAULT '管理员'  COMMENT '发布人(作者)',
  `posttime` DATETIME NOT NULL COMMENT '发布时间',
  `viewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `title` VARCHAR(50) NOT NULL COMMENT '新闻标题',
  `type` ENUM('新闻','公告','大赛信息') NOT NULL DEFAULT '新闻'  COMMENT '新闻类型',
  `content` TEXT NOT NULL COMMENT '新闻内容',
  PRIMARY KEY (`nid`)
) ENGINE=INNODB CHARSET=utf8
AUTO_INCREMENT=1;

--用户账户表
CREATE TABLE `contest`.`user`(  
  `uid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` VARCHAR(20) NOT NULL COMMENT '用户名',
  `password` VARCHAR(32) NOT NULL COMMENT '用户密码,MD5加密',
  `type` ENUM('管理员','学校负责人','普通用户') NOT NULL DEFAULT '普通用户'  COMMENT '用户类型',
  PRIMARY KEY (`uid`),
  UNIQUE INDEX `UNIQUE` (`username`)
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_unicode_ci
COMMENT='用户账号表';

--用户信息表
CREATE TABLE `contest`.`user_info`(  
  `uid` INT UNSIGNED NOT NULL COMMENT '用户编号',
  `email` VARCHAR(50) COMMENT '用户邮箱',
  `phone` VARCHAR(11) COMMENT '联系电话',
  `idcard` VARCHAR(18) COMMENT '身份证号',
  `sex` ENUM('男','女','未知') NOT NULL DEFAULT '未知'  COMMENT '性别',
  `name` VARCHAR(20) COMMENT '姓名',
  PRIMARY KEY (`uid`),
  FOREIGN KEY (`uid`) REFERENCES `contest`.`user`(`uid`) ON UPDATE NO ACTION ON DELETE CASCADE
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_unicode_ci
COMMENT='用户信息表';



--学校信息表
CREATE TABLE `contest`.`school_info`(  
  `sid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学校编号',
  `name` VARCHAR(50) NOT NULL DEFAULT '未知学校名'  COMMENT '学校名',
  `uid` INT UNSIGNED COMMENT '学校负责人编号',
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `unique_id` (`uid`),
  UNIQUE INDEX `unique_name` (`name`),
  FOREIGN KEY (`uid`) REFERENCES `contest`.`user`(`uid`) ON UPDATE NO ACTION ON DELETE SET NULL
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_unicode_ci
COMMENT='学校信息表';


--作品信息表
CREATE TABLE `contest`.`works`(  
  `wid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '作品编号(报名号,自动分配)',
  `sid` INT UNSIGNED COMMENT '所属学校编号',
  `season` YEAR NOT NULL COMMENT '参赛批次(赛季,年)',
  `name` VARCHAR(50) NOT NULL COMMENT '作品名称',
  `college` VARCHAR(30) COMMENT '作品所属(该校哪个)学院',
  `majorType` ENUM('文科','非文科') NOT NULL DEFAULT '文科'  COMMENT '专业类别',
  `category` ENUM('数据库应用系统','Web网站设计','多媒体制作','微课程或课件','程序设计应用','企业合作项目','软件服务外包','智慧城市') NOT NULL DEFAULT '数据库应用系统'  COMMENT '参赛作品类别',
  `teacherName` VARCHAR(20) NOT NULL COMMENT '带队教师姓名',
  `teacherPhone` VARCHAR(11) NOT NULL COMMENT '带队教师电话',
  PRIMARY KEY (`wid`),
  FOREIGN KEY (`sid`) REFERENCES `contest`.`school_info`(`sid`) ON UPDATE NO ACTION ON DELETE SET NULL
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_unicode_ci;

--参赛队员表
CREATE TABLE `contest`.`team_member`(  
  `mid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '参赛队员编号',
  `wid` INT UNSIGNED NOT NULL COMMENT '对应作品编号',
  `name` VARCHAR(20) NOT NULL COMMENT '队员姓名',
  `idcard` VARCHAR(18) NOT NULL COMMENT '身份证号',
  `college` VARCHAR(30) NOT NULL COMMENT '院系',
  `major` VARCHAR(30) NOT NULL COMMENT '专业',
  `grade` ENUM('大一','大二','大三','大四') NOT NULL DEFAULT '大一'  COMMENT '年级',
  `age` INT(10) UNSIGNED DEFAULT '18' NOT NULL COMMENT '年龄',
  `email` VARCHAR(50) NOT NULL COMMENT '邮箱',
  `phone` VARCHAR(11) NOT NULL COMMENT '电话',
  PRIMARY KEY (`mid`),
  FOREIGN KEY (`wid`) REFERENCES `contest`.`works`(`wid`) ON UPDATE NO ACTION ON DELETE CASCADE
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_unicode_ci;
