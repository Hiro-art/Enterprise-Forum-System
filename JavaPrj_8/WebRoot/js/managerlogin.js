function check() {
    if(document.loginForm.uName.value==""){
        alert("用户名不能为空");
        return false;
    }
    if(document.loginForm.uPass.value==""){
        alert("密码不能为空");
        return false;
    }
}