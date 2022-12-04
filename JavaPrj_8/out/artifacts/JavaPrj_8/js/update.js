function check(flag){
    var topic = document.updateForm.title.value;
    var content = document.updateForm.content.value;
    var regTopic = /^.{4,20}$/;
    var regContent = /^(.|[\r\n]){1,1000}$/;
    if(flag){
        if(topic=="" || !topic.match(regTopic)){
            alert("标题不能为空,长度在4-20");
            return false;
        }

    }

    if(content=="" || !content.match(regContent)) {
        alert("内容不能为空，并且长度不大于1000");
        return false;
    }
}