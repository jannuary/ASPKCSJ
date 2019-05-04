<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>�˳���¼</title>
</head>
<body>
<%	
	String uid=(String)session.getAttribute("uid");
	if(uid!=null){
		int m=uid.indexOf(",");
		uid=uid.substring(0, m);
		session.invalidate();
		out.print("<h2>"+uid+"退出</h2>");
	}else{
		response.sendRedirect("login.jsp");
	}
%>
<jsp:forward page="exam.jsp"></jsp:forward>
</body>
</html>