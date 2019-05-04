<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="register" %>
<!DOCTYPE html>

<head>
	<meta charset="UTF-8">
	<title>Sign up</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
	<link rel="stylesheet" href="css/style.css">
</head>

<body>
	<div class='login'>
		<form action="#" method="post">
			<h2>注 册</h2>
			<input name='uid' autofocus="autofocus"  placeholder='学号' required="required" type='text' />
			<input name='uname' required="required" placeholder='姓名' type='text' />
			<input name='uphone' required="required" placeholder='电话' type='text' />
			<input type='password' name='upassword' required="required" placeholder='密码' />
			<input type='submit' value='Sign up' />
		</form>

		<%	String uid=request.getParameter("uid");
			String uname=request.getParameter("uname");
			String upassword=request.getParameter("upassword");
			String uphone=request.getParameter("uphone");
		%>

		<register:Register upassword="<%=upassword %>" uname="<%=uname %>" uid="<%=uid %>" uphone="<%=uphone %>">
		</register:Register>
		<login:Login upassword="<%=upassword %>" uid="<%=uid %>" uname="<%=uname %>"></login:Login>
		<p class="tip"><%=backMess==null?"" : backMess %></p>
		<a class='forgot' href='login.jsp'>Sign in </a>
	</div>
	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script src="js/index.js"></script>
</body>

</html>



