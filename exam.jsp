<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    boolean is=false;
	String uid=(String)session.getAttribute("uid");
	if(uid==null){
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html>
<head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
	    <link rel="stylesheet" href="css/style.css">
        
        <style>
            .login>a {
                width: 10em;
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

            .out{
                --size: 2.5em;
                width: var(--size);
                height: var(--size);
                border-radius: var(--size);
                position: absolute;
                top: -1em;
                right: -1em;
                margin: 0;
            }
        </style>
        <title>Welcome</title>
</head>
<body>

    <div class="login">
        <a href="fixmess.jsp">修改信息</a>
        <a href="selectEx.jsp">进入考试</a>
        <a href="mark.jsp">历史分数</a>
        <div>
            <a href="exitLogin.jsp" class="close-button"></a>
        </div>
    </div>

</body>
</html>