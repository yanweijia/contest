/**
 * Created by weijia on 2017-05-08.
 */

/**
 * 窗口初始化
 */
$(window).load(function() {

    //nivoSlider图片轮播初始化:先加载新元素,再进行nivoSlider()
    changeNivoSliderData();

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


/**
 * 修改NivoSlider的内容为最新
 */
function changeNivoSliderData(){
    $.getJSON("sliderOperate?method=get",function(nivoSliderData){
        if(nivoSliderData != null || nivoSliderData.trim() != ''){
            var count = nivoSliderData.count;
            //手动先清除原先nivo-slider里面的内容,再加入新的内容
            $("#slider").empty();   //先清空slider对应div
            // $("#slider").append(nivoSliderData.toString());
            for(var i = 1 ;i <= count ; i++){
                var text = "<a href='" + nivoSliderData["url"+i] + "'><img src='" +nivoSliderData["img"+i] + "' alt='' title='" + nivoSliderData["name"+i] + "'/></a>";
                $("#slider").append(text);
            }
        }
        $('#slider').nivoSlider();
    });
}