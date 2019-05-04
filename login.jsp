<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="login" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Sign in</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
	<link rel="stylesheet" href="/ks/css/style.css">
</head>

<body>
	<div class='login'>
		<form action="#" method="post">
			<h2>登 录</h2>
			<input name='uid' autofocus="autofocus"  placeholder='学号' required="required" type='text' />
			<input name='uname' required="required" placeholder='姓名' type='text' />
			<input name='upassword' required="required" placeholder='密码' type='password' />
			<input type='submit' value='Sign in' />
		</form>

<%	
	boolean is=false;
	String uid=(String)session.getAttribute("uid");
	if(uid!=null){
			request.getRequestDispatcher("exam.jsp").forward(request,response);
	}
	String backmess="";
	uid=request.getParameter("uid");
	if(uid==null){
		
		uid="";
	}
	String upassword=request.getParameter("upassword");
	if(upassword==null){
		upassword="";
	}
	String uname=request.getParameter("uname");
	if(uname==null){
		uname="";
	}
%>


<login:Login upassword="<%=upassword %>" uid="<%=uid %>" uname="<%=uname %>"></login:Login>
<%
if(uid!=""){
	backmess=backMess;
}
%>
		<p class="tip"><%=backmess %></p>
		<a class='forgot' href='register.jsp'>Sign up</a>

	</div>
	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script src="js/index.js"></script>
</body>

</html>