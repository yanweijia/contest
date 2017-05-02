/**
 * Created by weijia on 2017-05-02.
 */


/**
 * 初始化默认禁用后两个参赛队员.
 */
$(".student2").attr("disabled","disabled");
$(".student3").attr("disabled","disabled");


/**
 * 将form表单中所有input(除去radio和checkbox类型)宽度自动填满上层表格
 * JQuery选择器用法请参考:
 *      http://www.w3school.com.cn/jquery/jquery_ref_selectors.asp
 */
$("form :input[type!=radio][type!=checkbox]").css("width","100%");


/**
 * 提交前进行表单验证
 */
function checkBeforeSubmit(){




    return true;
}

/**
 * 添加/取消添加 队员
 */
function pickTeamMember(checkbox){
    if(checkbox.checked)
        $("."+checkbox.getAttribute("student")).removeAttr("disabled");
    else
        $("."+checkbox.getAttribute("student")).attr("disabled","disabled");
}

