<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="checkManagerLogin.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>论坛后台管理</title>
</head>
<style type="">
	a{
		text-decoration: none;
	}
	a:hover{
		color:#FF0000;
		text-decoration:underline;
	}
	
	tr #managerTr div{/**/
		display:block;
		height:22px;
		text-align:center;
		vertical-align:middle;
		margin-left:5px;
		
	}
	
	.mainTd{
		border-top:1px solid #000000;
		border-bottom:1px solid #000000;
		border-right:1px solid #000000;
		border-left:1px solid #000000;
	}
	.leftTd{
		background-image:url(image/tableftbg.gif);		
	}
	
body { font-size:12px;
	background-color: #C5DEF5;
    margin: 20px 0px 15px;
}
</style>
<script type="">
	function opens(pid,sid){
	
			var pobj = document.getElementById (pid);
			var sobj = document.getElementById (sid);
			//alert(pobj);
			
			if(sobj.style.display == "block"){
				sobj.style.display = "none";
				sobj.style.visibility = "hidden";
				pobj.style.cssText="background-image:url(image/Menutab.jpg); background-position-x:150px;";
				return;
			}
			if(sobj.style.display == "none"){
				sobj.style.display = "block";
				sobj.style.visibility = "visible";
				pobj.style.cssText="background-image:url(image/Menutab.jpg); background-position-x:left;";

			}
			
		}

</script>
<body>
<div>
<table width="100%" height="981"  border="0" align="center" cellpadding="0" cellspacing="0"  style="border:1px solid #000000 ">
  <tr>
    <td height="21" align="center" valign="middle" bgcolor="#C5DEF5" style="background-image:url(image/topbar.jpg); background-position-y:30%; border-bottom:1px solid #000000">论坛后台管理</td>
  </tr>
    <tr>
        <td height="21" align="left" >
            <button onclick="location='../index.jsp'">退出管理员系统</button>
        </td>
    </tr>
  <tr>
    <td height="958" align="center" valign="middle"><table width="98%" height="100%"  border="0" cellpadding="0" cellspacing="0">
	  <tr><td height="891" align="center" valign="middle"><table width="100%" height="902"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="13%" height="837" align="center" valign="top"  class="leftTd">
            <table width="90%"  border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><table width="100%"  border="0" cellspacing="0" cellpadding="0" class="tt">
                    <tr id="managerTr">
                      <td id="parent1" height="30" align="left" valign="middle" style="background-image:url(image/Menutab.jpg); background-position-x:Left;" onClick="javascript:opens('parent1','sub1');"><a>&nbsp;&nbsp;&nbsp;&nbsp;版块设置</a></td>
                    </tr>
                    <tr id="managerTr">
                      <td id="sub1" align="left" valign="middle" style="display:block; background-image:url(image/top_level_bg.gif);">
                        <div><a href="managerSection.jsp" target="main">版块管理</a></div>
                        <div><a href="addSection.jsp" target="main">版块添加</a></div></td>
                    </tr>
                    <!---->
                    <tr id="managerTr">
                      <td id="parent2" height="30" align="left" valign="middle" style="background-image:url(image/Menutab.jpg); background-position-x:150px;" onClick="javascript:opens('parent2','sub2')"  ><a>&nbsp;&nbsp;&nbsp;&nbsp;用户设置</a></td>
                    </tr>
                    <tr id="managerTr">
                      <td  id="sub2" align="left" valign="middle" style="display:none;background-image:url(image/top_level_bg.gif);">
                        <div><a href="UserSection.jsp" target="main">用户管理</a></div>
                        <div><a href="addUser.jsp" target="main">用户添加</a></div>
                          <div><a href="deleteUser.jsp" target="main">用户删除</a></div>
                          <div><a href="selectChangeUser.jsp" target="main">用户信息修改</a></div></td>
                    </tr>
                </table></td>
              </tr>
          </table></td>
          <td width="100%" height="100%" align="center" valign="middle" bgcolor="#FFFFFF" class="mainTd">
            <iframe src="welcome.htm" marginheight="0" frameborder="0" marginwidth="0" scrolling="auto" name="main" width="95%" height="95%"/>    </td>
        </tr>
      </table></td>
	  </tr>
	  <tr>
	    <td width="34" height="17"><p>&nbsp;</p>	      </td>
	  </tr>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>
	