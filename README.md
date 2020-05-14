# contest
## JAVAEE课程设计 计算机应用能力技术大赛网站

项目地址:  
　　https://git.coding.net/yanweijia/contest.git  
或  
https://github.com/yanweijia/contest  
请解压contest.zip中contest目录为代码文件.

##项目图片演示请参考文件夹/pictures

###代码结构(使用Intellij IDEA Ult开发)如下:
src/   java源代码:网站后台逻辑/实体等  
　　config/  网站配置文件,mybatis,dbcp配置文件  
　　　　dao/  业务逻辑层的实现  
　　　　db/　　 数据库连接池及mybatis 的SqlSession封装使用  
　　　　entity/　　实体  
　　　　filter/　　过滤器  
　　　　servlet/　　网站后台逻辑(控制层Controller)  
　　　　test/　　　　用于测试编写中的java代码  
　　　　utils/   工具类,编码,日期时间,Excel导出,配置信息等  
　　web/　　网站代码及资源文件  
　　　　errorPage/　　错误页面,404页面  
　　　　notice/　　　　新闻相关显示页面  
　　　　page/　　　　网站可分割部分页面,(网站页头页脚,后台管理页面对应右边div的内容部分)  
　　　　plug-in/　　　　第三方类库/插件目录 如ueditor bootstrap, nivo-slider等  
　　　　resource/　　静态资源文件  
　　　　　　css/　　　　层叠样式表  
　　　　　　image/  图片  
　　　　　　js/　　　　网页脚本  
　　　　WEB-INF/　　受保护的目录  
　　　　　　admin/  管理员后台页面,用servlet控制,通过request的服务器内部转发来访问.  
　　　　　　lib/   相关jar包文件  
　　　　　　web.xml  网站配置文件  
　　　　其他jsp页面  
　　项目其他文档/  一些对数据库结构的说明  
  
代码清单:  
　　请参见代码目录结构,相关文件中文件头部会附上相关代码说明信息.   
