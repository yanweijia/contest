/**
 * Created by weijia on 2017-05-08.
 */

/**
 * nivoSlider图片轮播初始化
 */
$(window).load(function() {
    $('#slider').nivoSlider();
});


/**
 * 鼠标移动到新闻导航条上自动(点击)切换到相应内容
 */
$("#noticeNavBar-notice").mouseover(function (){
    $("#noticeNavBar-notice").click();
});
$("#noticeNavBar-news").mouseover(function (){
    $("#noticeNavBar-news").click();
});
$("#noticeNavBar-info").mouseover(function (){
    $("#noticeNavBar-info").click();
});