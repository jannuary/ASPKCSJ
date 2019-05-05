<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="favicon.ico" rel="icon" type="image/x-icon" />
    <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        body {
            background: #2f313d;
            font-family: sans-serif;
            letter-spacing: 0.2em;
        }
        h1{
            color: aliceblue;
            display: block;
            margin: 25vh auto 0;
            text-align: center;
        }
        p,a{  
            color: #d1dfec;
            text-align: center;
            text-decoration: none;
        }
    </style>
    <title>Document</title>
</head>
<body>
    <h1>欢迎来到考生系统</h1>
    <p><a href="login.jsp">即将到登陆界面</a></p>
    <p id="t">...</p>
    <script>
        let time = 2;
      setInterval(()=>{
        let t = document.getElementById("t");
        let str = "";
        for (let i = 0; i < time; i++) {
            str +=".";         
        }
        t.innerHTML = str;
        if(!time--){
            window.location.href = "login.jsp";
        }
      },1000)  
    </script>
</body>
</html>