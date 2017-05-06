/**
 * Created by weijia on 2017-05-02.
 */


/**
 * 初始化默认禁用后两个参赛队员.
 */
$(".student2").attr("disabled","disabled");
$(".student3").attr("disabled","disabled");


/**
 * 将form中table中表单中所有input(除去radio和checkbox类型)宽度自动填满上层表格
 * JQuery选择器用法请参考:
 *      http://www.w3school.com.cn/jquery/jquery_ref_selectors.asp
 */
$("#table_enrollment :input[type!=radio][type!=checkbox]").css("width","100%");



function ajaxSubmit(){
    if(!checkBeforeSubmit()){
        return;
    }
    $.post('/enroll.action', $("#form_enrollment").serialize(), function(data) {
        if(data.result){
            alert('提交成功');
        }else{
            alert(data.reason);
        }
        alert(data);
    });
}




/**
 * 提交前进行表单验证
 */
function checkBeforeSubmit(){

    //验证教师姓名是否合法
    // if(!$("#input_teacherName").val().match(/^[\u4e00-\u9fa5]{1,10}$/)){
    //     alert("姓名格式不正确！请重新输入！");
    //     $("#input_teacherName").focus();
    //     return false;
    // }

    // 验证身份证是否合法
    var idCardResult = isCardNo($.trim($('#input_studentIDCard1').val()));
    if(idCardResult.result == false) {
        alert(idCardResult.tip)
        $('#input_studentIDCard1').focus();
        return false;
    }

    //有第2个队员
    if($('#input_studentChecked2').prop("checked")){
        idCardResult = isCardNo($.trim($('#input_studentIDCard2').val()));
        if(idCardResult.result == false) {
            alert(idCardResult.tip)
            $('#input_studentIDCard2').focus();
            return false;
        }
    }

    //有第3个队员
    if($('#input_studentChecked3').prop("checked")){
        idCardResult = isCardNo($.trim($('#input_studentIDCard3').val()));
        if(idCardResult.result == false) {
            alert(idCardResult.tip)
            $('#input_studentIDCard3').focus();
            return false;
        }
    }

    return true;
}

/**
 * 验证身份证,支持15 18位身份证验证
 * 修改自:http://www.cnblogs.com/lzrabbit/archive/2011/10/23/2221643.html
 * @param code
 * @returns {{result: boolean, tip: string}}
 */
function isCardNo(code) {
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var result={"result":true,"tip":"校验成功"};

    if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
        result={"result":false,"tip":"身份证号格式错误"}
    }

    else if(!city[code.substr(0,2)]){
        result={"result":false,"tip":"地址编码错误"}
    }
    else{
        //18位身份证需要验证最后一位校验位
        if(code.length == 18){
            code = code.split('');
            //∑(ai×Wi)(mod 11)
            //加权因子
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
            //校验位
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++)
            {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            var last = parity[sum % 11];
            if(parity[sum % 11] != code[17]){
                result={"result":false,"tip":"校验位错误"}
            }
        }
    }
    return result;
}

/**
 * 根据输入的身份证号自动计算队员年龄并填入到对应年龄框中
 * @param inputBox
 */
function autoCalcAge(inputBox){
    if(inputBox.value.length != 18)
        return;
    var isCardNoResult = isCardNo(inputBox.value);
    if(!isCardNoResult.result){
        alert(isCardNoResult.tip);
        inputBox.focus();
        return;
    }

    var age = new Date().getFullYear() - inputBox.value.substring(6, 10);
    $('#input_studentAge' + inputBox.id.charAt(inputBox.id.length -1)).val(age);
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

