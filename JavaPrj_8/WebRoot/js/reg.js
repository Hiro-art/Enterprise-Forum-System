function check() {
    var reguName = /^[\u4e00-\u9fa5A-Za-z0-9]{3,10}$/;
    var reguPass = /^[0-9a-zA-Z]{3,20}$/;
    var uName = document.regForm.uName.value;
    var uPass = document.regForm.uPass.value;
    var uPass1 = document.regForm.uPass1.value;
    if(uName == ""){
        alert("用户名不能为空");
        return false;
    }

    if(uPass == ""){
        alert("密码不能为空");
        return false;
    }

    if(!uName.match(reguName)){
        alert("用户名只能输入中文、数字、字母，长度为3-10");
        return false;
    }

    if(!uPass.match(reguPass)){
        alert("密码只能输入数字、字母，长度为3-20");
        return false;
    }

    if(uPass != uPass1){
        alert("2次密码不一样");
        return false;
    }
}