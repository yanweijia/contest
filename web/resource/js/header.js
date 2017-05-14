/**
 * Created by weijia on 2017-05-14.
 */

/**
 * 网站顶部登录表单的登录请求
 * @returns {boolean} always false 不使用表单提交.
 */
function checkBeforeLogin(){
    //用JQuery的post方法来请求登录,所以末尾直接返回false不用form表单提交.

    $.post('/login.action', $("#form_login").serialize(), function(data) {
        var jsonResult = eval('('+data+')');
        if(jsonResult.result){
            //自动跳转到登录后页面
            alert('登录成功!');
        }else{
            alert(jsonResult.reason);
        }
    });

    return false;
}