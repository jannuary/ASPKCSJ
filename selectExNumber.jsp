<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<% 
    String exid = request.getParameter("exid");
    String table="SELECT distinct exn from exam where exid='"+ exid +"'";
%>

<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        .login>a {
            width: 8em;
            color: aliceblue;
            text-align: center;
            display: block;
            background-color: #000;
            line-height: 2em;
            margin: 0.5em auto;
            transition: box-shadow 0.2s;
        }

        a:hover {
            box-shadow: 8px 7px 20px -4px #000000
        }

        a:active {
            background-color: aliceblue;
            color: #000;
        }
    </style>
    <title>Select exid</title>
</head>

<body>
    <%
        String user = application.getInitParameter("user");
        pageContext.setAttribute("user", user);
        String password = application.getInitParameter("password");
        pageContext.setAttribute("password", password);
        String port = application.getInitParameter("port");
        pageContext.setAttribute("port", port);
    %>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:${port}/jspks?useUnicode=true&characterEncoding=utf-8" user="${user}"
        password="${password}" />

    <sql:query dataSource="${snapshot}" var="result">
        <%=table%>;
    </sql:query>


    <div class="login">
        <c:forEach var="row" items="${result.rows}">
            <a href="ex.jsp?exid=<%=exid%>&exn=${row.exn}">第 ${row.exn} 套</a>
        </c:forEach>
        <div>
            <a href="selectEx.jsp" class="close-button"></a>
        </div>
    </div>


</body>

</html>