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
    String table="SELECT * from mark where uid='"+ uid +"' and exid='"+ exid +"' order by exn asc ";
    String sql = "SELECT COUNT(exn) AS nn, exn FROM exam WHERE exid='"+ exid +"' GROUP by exn  ORDER BY exn";
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

        h2 {
            font-size: 1.5em;
            margin: 0 0 1.5em;
            color: #c9cbe0;
        }
        .login{
            width: 48em;
            left: 0;
            right: 0;
            margin: 1.5em auto;
            top: 0;
            bottom: 0;
        }
        .show, .titles{
            line-height: 1.5em;
            border-bottom: 1px solid;
            transition: line-height 0.3s;
            color: #b9bac9;
        }
        .titles{
            border-top: 1px solid;
            font-weight: 999;
        }
        span{
            border-right: 1px solid;
            display: inline-block;
            text-align: center;
            width: 7em;
        }
        #ti{
            border: none;
            width: 19em;
        }
        .show:hover{
            box-shadow: 0 0 3px #000;
            font-weight: 600;
            color: black;
            background: #b9bac9;
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
        <h2><%=exid%> 历史成绩</h2>
        

        <p class="titles"><span id="t">套题序号</span><span id="n">正确数目</span><span id="ns">题数目</span><span id="g">正确率</span><span id="ti">考试时间</span></p>

        <c:forEach var="row" items="${result.rows}">
            <p class="show"><span id="${row.exn}">${row.exn}</span><span id="n_${row.exn}">${row.mark}</span><span id="ns_${row.exn}">0</span><span id="g_${row.exn}">0</span><span id="ti">${row.createtime}</span></p>
        </c:forEach>

        <sql:query dataSource="${snapshot}" var="result">
            <%=sql%>;
        </sql:query>

        <script>
            let nn = [];    // 数量
            let ns = [];    // 套题
        </script>
        <c:forEach var="row" items="${result.rows}">
            <script>
                nn.push(${ row.nn });
                ns.push(${ row.exn });
            </script>
        </c:forEach>
        <script>
            for(let i=0;i < nn.length; i++){
                let xi = document.querySelectorAll("#ns_"+ns[i]);       // 题数
                let xs = document.querySelectorAll("#n_" + ns[i]);      // 正确
                let xg = document.querySelectorAll("#g_" + ns[i]);      // 正确率
                xi.forEach((x) => {
                    x.innerHTML = nn[i];
                })
                for (let j = 0; j < xg.length; j++) {
                    let x = (parseInt(xs[j].innerHTML) * 100 / nn[i]);
                    if(!/^([^0][0-9]+|0)$/.test(x)){
                        x = x.toFixed(1);
                    }
                    xg[j].innerHTML = x +"%";
                }
                xs.forEach((x) => {
                    console.log();
                })
            }


        </script>
        <div>
            <a href="exam.jsp" class="close-button"></a>
        </div>
    </div>
    
</body>

</html>