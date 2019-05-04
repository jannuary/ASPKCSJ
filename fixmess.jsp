<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fixmess" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="connect" %>
<%	
	boolean is=false;
	String uid=(String)session.getAttribute("uid");
	if(uid!=null){
		int m=uid.indexOf(",");
		uid=uid.substring(0, m);
		is=true;
	}
	else{
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>Fix</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
</head>

<body>
	<connect:Connect uid="<%=uid %>"></connect:Connect>
	<div class='login'>
		<form action="" method="post">
			<h2>修改信息</h2>
			<input required="true" type='text' name="uname" value="<%=olduname%>" />
			<input  required="true" type="text" name="uphone" value="<%=olduphone%>">
			<input required="true" type='password' name="upassword" value="<%=oldupassword%>" />
			<input type='submit' name="enter" value='Updata' />
		</form>

		<%
			String enter=request.getParameter("enter");
			String uname=request.getParameter("uname");
			String upassword=request.getParameter("upassword");
			String uphone=request.getParameter("uphone");
			boolean ok=(enter!=null);
			if(ok&&is){
		%>
		<fixmess:Fixmess upassword="<%=upassword %>" uname="<%=uname %>" uid="<%=uid %>" uphone="<%=uphone %>">
		</fixmess:Fixmess>
		<p class="tip"><%=giveResult %></p>
		<%
			}
		%>
		<div>
			<a href="exam.jsp" class="close-button"></a>
		</div>
	</div>
	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script src="js/index.js"></script>
</body>