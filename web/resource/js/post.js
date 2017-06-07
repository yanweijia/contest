/**
 * Created by weijia on 2017-04-21.
 */
function checkAndSubmit(){
    if($('#noticeTitle').val() == null || $('#noticeTitle').val().trim() == ''){
        alert('请输入新闻标题');
        $('#noticeTitle').focus();
        return;
    }
    if(!ueditor.hasContents()){
        alert('请输入新闻内容!');
        ueditor.focus();
        return;
    }

    var noticeTitle = $('#noticeTitle').val();
    var noticeAuthor = $('#noticeAuthor').val();
    // var noticeContent = BASE64.encoder(ueditor.getContent());
    var noticeContent = ueditor.getContent();
    var noticeType = $('#noticeType').val();

    //添加到form隐藏域,进行提交
    var inputTitle = document.createElement('input');
    inputTitle.type = 'input';
    inputTitle.name = 'noticeTitle';
    inputTitle.value = noticeTitle;
    var inputAuthor = document.createElement('input');
    inputAuthor.type = 'input';
    inputAuthor.name = 'noticeAuthor';
    inputAuthor.value = noticeAuthor;
    var inputContent = document.createElement('input');
    inputContent.type = 'input';
    inputContent.name = 'noticeContent';
    inputContent.value = noticeContent;
    var inputType = document.createElement('input');
    inputType.type = 'input';
    inputType.name = 'noticeType';
    inputType.value = noticeType;


    var form = document.getElementById('postNoticeForm');
    form.innerHTML='';  //先清空表单
    //添加表单项并提交表单.
    form.appendChild(inputTitle);
    form.appendChild(inputAuthor);
    form.appendChild(inputContent);
    form.appendChild(inputType);

    //form.submit(); /*用下面的ajax技术来提交新闻,这样不会刷新页面*/
    $.post($('#postNoticeForm').attr('action'),$('#postNoticeForm').serialize(),function(data){
        data = eval('('+data+')');
        if(data.result){
            alert('发送新闻成功!');
            //清空输入框
            $('#noticeTitle').val('');
            $('#noticeAuthor').val('');
            ueditor.setContent('要不要再发布一篇新闻呢?');
        }else{
            alert(data.reason);
        }
    });


}