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
    String exn = request.getParameter("exn");
    String table="SELECT * from exam where exid='"+ exid  +"' and exn='"+ exn +"'";
%>

<html>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel="stylesheet" href="css/style.css">
    <title><%=exid %> <%=exn%></title>
    <style>
        :root{
            color: aliceblue;
        }

        label{
            margin-left:5em;
        }
        .a-radio{
            display: none;
        }
        .b-radio{
            display: inline-block;
            border:1.5px solid rgb(43, 196, 16);
            width:13px;
            height: 13px;
            border-radius:10px;
            vertical-align: middle;
            margin-right: 5px;
            position: relative;
        }
        .b-radio:before{
            content: '';
            font-size: 0;
            width: 8px;
            height: 8px;
            background: rgb(43, 196, 16);
            position: absolute;
            left:50%;
            top:50%;
            margin-left: -4px;
            margin-top: -4.5px;
            border-radius: 10px;
            display: none;
        }
        .a-radio:checked~.b-radio:before{
            display: block;
        }

        .login{
            width: 40em;
            position: relative;
            margin: 2em auto;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;

        }
        h1{
            text-align: center;
            font-size: 2em;
        }
        hr{
            margin: 1.5em;
            border:none;
            border-bottom: 2px solid #fff;
        }
        p{
            display: block;
            margin: 1em;
        }
        input[type="submit"]{
            width: 7em;
            font-size: 1em;
            color: black;
            display: block;
            margin: 2em auto 1em;
        }

        .close-button:before, .close-button:after {
            height: 6px;
            width: 30px;
        }
    </style>
</head>
<body>
    <!--
JDBC 驱动名及数据库 URL 
数据库的用户名与密码，需要根据自己的设置
useUnicode=true&characterEncoding=utf-8 防止中文乱码
 -->
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

    <div class='login'>


    <h1> <%=exid %> <%=exn%> </h1>
    <hr>
    <form class="form" action="ex" method="post">
        
        <c:forEach var="row" items="${result.rows}">
            <div id="ex">
                <p>${row.number}. ${row.title}</p>
                <p>
                    <label>
                        <input type="radio" class="a-radio" name="t_${row.number}" value="a" checked>
                        <span class="b-radio"></span> ${row.opa}
                    </label>
                </p>
                <p>
                    <label>
                        <input type="radio" class="a-radio" name="t_${row.number}" value="b" > 
                        <span class="b-radio"></span> ${row.opb}    
                    </label>
                    
                </p>
                <p>
                    <label>
                        <input type="radio" class="a-radio" name="t_${row.number}" value="c" > 
                        <span class="b-radio"></span> ${row.opc}    
                    </label>
                    
                </p>
                <p>
                    <label>
                        <input type="radio" class="a-radio" name="t_${row.number}" value="d" > 
                        <span class="b-radio"></span> ${row.opd}    
                    </label>
                </p>
                <input type="hidden" name="exid" value="${row.exid}">
                <input type="hidden" name="exn" value="${row.exn}">
            </div>
        </c:forEach>


        <input type="submit" value="提交">

    </form>
    <div>
        <a href="selectExNumber.jsp?exid=<%=exid %>&exn=<%=exn%>" class="close-button"></a>
    </div>
    </div>

        
</body>

</html>