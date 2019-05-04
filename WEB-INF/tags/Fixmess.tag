<%@ tag language="java" pageEncoding="utf-8"%>
<%@ tag import="java.sql.*" %>
<%@ attribute name="uid"  required="true"%>
<%@ attribute name="uname"  required="true"%>
<%@ attribute name="upassword"  required="true"%>
<%@ attribute name="uphone"  required="true"%>
<%@ variable name-given="giveResult" variable-class="java.lang.StringBuffer" scope="AT_END"%>
<%	
	byte[] c=uname.getBytes("ISO-8859-1");
	uname=new String(c);
	c=upassword.getBytes("ISO-8859-1");
	upassword=new String(c);
	c=uphone.getBytes("ISO-8859-1");;
	uphone=new String(c);
	try{
		Class.forName("com.mysql.jdbc.Driver");
	}catch(Exception e){
		out.print(e);
	}
	StringBuffer str=new StringBuffer();
	Connection con;
	Statement sql;
	ResultSet rs;
	String uri="jdbc:mysql://127.0.0.1/jspks?"+
			"user=&password=&charaterEncoding=gb2312";
	try{
		con=DriverManager.getConnection(uri);
		String updateCondition="update user set uname='"+uname+"',upassword='"+upassword+
		"',uphone='"+uphone+"'where uid='"+uid+"'";
		sql=con.createStatement();
		int m=sql.executeUpdate(updateCondition);
		if(m==1){
			str.append("修改信息成功");
	
		}
		else{
			str.append("更新失败");
		}
		con.close();
	}catch(Exception e){
		str.append("更新失败"+e);
	}
	jspContext.setAttribute("giveResult", str);
%>