<%@ tag language="java" pageEncoding="utf-8"%>
<%@ tag import="java.sql.*" %>
<%@ attribute name="uid" required="true"%>
<%@ attribute name="upassword" required="true"%>
<%@ attribute name="uname" required="true"%>
<%@ variable name-given="backMess" scope="AT_END"%>
<%  byte[] a=uid.getBytes("ISO-8859-1");
	uid=new String(a);
	byte[] b = upassword.getBytes("ISO-8859-1");
	upassword= new String(b);
	byte[] c = uname.getBytes("ISO-8859-1");
	uname= new String(c);
	String mess="";
	try{
		Class.forName("com.mysql.jdbc.Driver");
	}catch(Exception e){
		out.print(e);
	}
	Connection con;
	Statement sql;
	ResultSet rs;
	String loginMess =(String)session.getAttribute("uid");
	if(loginMess==null){
		loginMess="************";
	}
	String str=uid +","+upassword+","+uname;
	if(loginMess.equals(str)){
		mess=uid+"已经登录";
	}
	else{
		boolean boo=(uid.length()>0)&&(upassword.length()>0);
		try{String uri="jdbc:mysql://127.0.0.1/jspks?"+
		"user=&password=&charaterEncoding=gb2312";
		con=DriverManager.getConnection(uri);
		String condition = "select * from user where uid='"+uid+"'and upassword='"+upassword+"'and uname='"+uname+"'";
		sql=con.createStatement();
		if(boo){
			rs=sql.executeQuery(condition);
			boolean m=rs.next();
			if(m==true){
				mess=uid+"登录成功";
				str=uid+","+upassword+","+uname;
				session.setAttribute("uid", str);
%>
<jsp:forward page="exam.jsp"></jsp:forward>
<%
			}
			else{
				mess="你输入的用户名"+uid+"不存在或密码不正确";
			}
		}
		else{
			mess="还没有登录或你输入的用户名不存在或密码不般配";
		}
		con.close();
		}catch(Exception e){
		mess="问题:"+e;
	}
	}
	jspContext.setAttribute("backMess", mess);
%>