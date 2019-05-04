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
    String table="SELECT distinct exid from mark where uid='"+ uid +"' ";
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
        h2{
            margin: 0 0 1.5em;
        }
    </style>
    <title>Select exid</title>
</head>

<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/jspks?useUnicode=true&characterEncoding=utf-8" user=""
        password="" />

    <sql:query dataSource="${snapshot}" var="result">
        <%=table%>;
    </sql:query>


    <div class="login">
        <h2>选则要查看的科目</h2>
        <c:forEach var="row" items="${result.rows}">
            <a href="showMark.jsp?exid=${row.exid}">${row.exid}</a>
        </c:forEach>
        <div>
            <a href="exam.jsp" class="close-button"></a>
        </div>
    </div>

</body>

</html>