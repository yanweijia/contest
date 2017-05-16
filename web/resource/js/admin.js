/**
 * Created by weijia on 2017-05-16.
 */

/**
 * 登出功能
 */
function logout() {
    //先判断当前页面是否有数据需要保存
    if (confirm("确认保存好了当前页面的数据了么?")) {
        $.getJSON("login.action?method=logout", function (jsonData) {
            if (jsonData != null || jsonData.trim() != '') {
                if (jsonData.result) {
                    alert('登出成功!');
                    //载入默认首页
                    window.location.href="/";
                } else {
                    alert('登出失败!');
                }
            }
        });
    }
}

/**
 * 右侧container加载页面
 * @param url
 */
function loadContent(url){
    $('#container').load(url);
}