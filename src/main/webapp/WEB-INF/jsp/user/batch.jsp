<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<%@include file="/WEB-INF/common/userinfo.jsp" %>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<%@include file="/WEB-INF/common/menu.jsp" %>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<button type="button" id="addBtn" class="btn btn-primary" style="float:left;margin-left:10px;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
          <form id="userForm" action="${APP_PATH }/user/batchInsert" method="post">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody id="userTbody">
              <!--  
              	<tr>
              		<td><input type="text" class="form-control"></td>
              		<td><input type="text"></td>
              		<td><input type="text"></td>
              		<td><button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button></td>
              	</tr>
              -->
              </tbody>
            </table>
           </form>
<button id="saveBtn" type="button" class="btn btn-success" style="float:left;margin-left:10px;" ><i class="glyphicon glyphicon-plus"></i> 保存</button>           
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/layer/layer.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			     
			    $("#saveBtn").click(function(){
			    	$("#userForm").submit();
			    });
			    
			    var userCount = 0;
			    $("#addBtn").click(function(){
			    	
			    	var content = "";
			    	
					    content += '<tr>';
		              	content += '	<td><input type="text" class="form-control" name="user['+userCount+'].loginacct"></td>';
		              	content += '	<td><input type="text" class="form-control" name="user['+userCount+'].username"></td>';
		               	content += '	<td><input type="text" class="form-control" name="user['+userCount+'].email"></td>';
		              	content += '	<td><button type="button" onclick = "deleteRow(this)" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button></td>';
		              	content += '</tr>';
			    	
			    	$("#userTbody").append(content);
			    	userCount++;
			    });
            });
            
            function deleteRow(obj){
            	var trObj = $(obj).parent().parent();
            	trObj.remove();
            }
        </script>
  </body>
</html>
