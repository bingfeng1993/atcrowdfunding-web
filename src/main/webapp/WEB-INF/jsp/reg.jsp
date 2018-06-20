<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="${APP_PATH }/index" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form id="regForm" action="${APP_PATH }/doreg" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="userpswd" name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH }/login">我有账号</a>
          </label>
        </div>
<%--         <a class="btn btn-lg btn-success btn-block" href="${APP_PATH }/member" > 注册</a> --%>
		<a class="btn btn-lg btn-success btn-block" onclick="doreg()" > 注册</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/layer/layer.js"></script>
    <script type="text/javascript">
     	function doreg(){ 
     		 //验证表单元素 
             var loginacct = $("#loginacct"); 
             if(loginacct.val() == "" || loginacct.val() == null){ 
             	layer.msg("登录账号不能为空，请重新输入", {time:3000, icon:5, shift:6}, function(){ 
             		loginacct.focus(); 
             	}); 
             	return; 
             } 
           //设置验证用户名的正则表达式 
     		var userReg = /^[a-z0-9_-]{3,16}$/; 
     		//验证用户名 
     		var flag = userReg.test($("#loginacct").val()); 
     		if(!flag){ 
     			//弹出提示框 -->
     			layer.msg("请输入3-16位小写字母、数字或下划线、减号的登录账号！", {time:3000, icon:5, shift:6}, function(){ 
             		loginacct.focus(); 
             	}); 
             	return; 
     		} 
            
             var userpswd = $("#userpswd"); 
             if(userpswd.val() == ""){ 
             	//alert("密码不能为空，请重新输入"); 
             	layer.msg("登录密码不能为空，请重新输入", {time:3000, icon:5, shift:6}, function(){ 
             		userpswd.focus(); 
             	}); 
             	return; 
             } 
           //设置验证密码的正则表达式 
     		var pswdReg = /^[a-z0-9_-]{6,18}$/; 
     		//验证用户名 
     		var bool = pswdReg.test($("#userpswd").val()); 
     		if(!bool){ 
     			//弹出提示框 
     			layer.msg("请输入6-18位小写字母、数字或下划线、减号的登录密码！", {time:3000, icon:5, shift:6}, function(){ 
             		userpswd.focus(); 
             	}); 
             	return; 
     		} 
            
             var email = $("#email"); 
             if(email.val() == ""){ 
             	//alert("密码不能为空，请重新输入"); 
             	layer.msg("邮箱地址不能为空，请重新输入", {time:3000, icon:5, shift:6}, function(){ 
             		email.focus(); 
             	}); 
             	return; 
             } 
           //设置验证邮箱的正则表达式 
     		var emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; 
     		//验证用户名 
     		var eml = emailReg.test($("#email").val()); 
     		if(!eml){ 
     			//弹出提示框 
     			layer.msg("请输入正确格式的邮箱！", {time:3000, icon:5, shift:6}, function(){ 
             		email.focus(); 
             	}); 
             	return; 
     		} 
            
//              $("#regForm").submit(); 
		var registIndex = 0;
		var jsonObj = {
			url:"${APP_PATH}/checkRegist",
			type:"POST",
			dataType:"json",
			data:{
				"loginacct":loginacct.val(),
				"userpswd":userpswd.val(),
				"email":email.val()
			},
			beforeSend:function(){
				registIndex = layer.load(2, {time: 10*1000});
			},
			success:function(result){
				layer.close(registIndex);
				if(result.success){
           			window.location.href = "${APP_PATH}/login"
           		}else{
           			layer.msg("登陆账号或密码不正确，请重新输入", {time:2000, icon:5, shift:6}, function(){
                   	});
           		}
			}
		}
		$.ajax(jsonObj);
     	}    
             $("#loginacct").change(function(){
            	 //获取用户输入的登录账号
            	 var loginacct = $(this).val();
            	 if(loginacct.val() == "" || loginacct.val() == null){ 
                  	layer.msg("登录账号不能为空，请重新输入", {time:3000, icon:5, shift:6}, function(){ 
                  		loginacct.focus(); 
                  	}); 
                  	return; 
                  } 
                //设置验证用户名的正则表达式 
          		var userReg = /^[a-z0-9_-]{3,16}$/; 
          		//验证用户名 
          		var flag = userReg.test($("#loginacct").val()); 
          		if(!flag){ 
          			//弹出提示框 -->
          			layer.msg("请输入3-16位小写字母、数字或下划线、减号的登录账号！", {time:3000, icon:5, shift:6}, function(){ 
                  		loginacct.focus(); 
                  	}); 
                  	return; 
          		} 
             });
     	 
    	
    </script>
    
  </body>
</html>