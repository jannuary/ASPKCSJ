<%@ tag language="java" pageEncoding="utf-8"%>
<%@ tag import="java.sql.*" %>
<%@ attribute name="uid"  required="true"%>
<%@ attribute name="uname"  required="true"%>
<%@ attribute name="upassword"  required="true"%>
<%@ attribute name="uphone"  required="true"%>
<%@ variable name-given="backMess" scope="AT_END" %>
<%  boolean boo =true;
	if(uid!=null){
		if(uid.contains(",")||uid.contains("，")){
			boo=false;
		}
		if(boo){
			try{Class.forName("com.mysql.jdbc.Driver");
			}catch(Exception e){
				out.print(e);
			}
			Connection con;
			Statement sql;
			ResultSet re;
			String condition="insert into user values";
			condition+="("+"'"+uid;
			condition+="','"+uname;
			condition+="','"+upassword;
			condition+="','"+uphone+"')";
			try{
				byte[] b=condition.getBytes("ISO-8859-1");
				condition=new String(b);
				String uri ="jdbc:mysql://127.0.0.1:"+application.getInitParameter("port")+"/jspks?"+
		"user="+application.getInitParameter("user")+"&password="+ application.getInitParameter("password") +"&charaterEncoding=gb2312";
				con=DriverManager.getConnection(uri);
				sql=con.createStatement();
				sql.executeUpdate(condition);
				con.close();
				byte[] c= uid.getBytes("ISO-8859-1");
				uid=new String(c);
				String mess = uid+"注册成功";
				jspContext.setAttribute("backMess", mess);
				con.close();
				%>
<jsp:forward page="login.jsp"></jsp:forward>
<%
			}catch(Exception e){
				jspContext.setAttribute("backMess","没有填写用户名或者用户名已经被注册");
			}
		}
		else{
			jspContext.setAttribute("backMess", "注册失败，用户名中不能有逗号");
		}
	}
	%>