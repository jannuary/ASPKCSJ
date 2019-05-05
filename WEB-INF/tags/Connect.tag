<%@ tag language="java" pageEncoding="utf-8"%>
<%@ tag import="java.sql.*"%>
<%@ attribute name="uid" required="true"%>
<%@ variable name-given="oldupassword" scope="AT_END" %>
<%@ variable name-given="olduname" scope="AT_END" %>
<%@ variable name-given="olduphone" scope="AT_END" %>
<%@ variable name-given="olduid" scope="AT_END" %>
<%	try{Class.forName("com.mysql.jdbc.Driver");
}catch(Exception e){out.print(e);
}
StringBuffer str = new StringBuffer();
Connection con;
Statement sql;
ResultSet rs;
String uri="jdbc:mysql://127.0.0.1:"+application.getInitParameter("port")+"/jspks?"+
		"user="+application.getInitParameter("user")+"&password="+ application.getInitParameter("password") +"&charaterEncoding=gb2312";
try{
	con=DriverManager.getConnection(uri);
	String query="select uname,upassword,uphone "+
	"from user where uid='"+uid+"'";
	sql=con.createStatement();
	rs=sql.executeQuery(query);
	if(rs.next()){
		jspContext.setAttribute("olduname", rs.getString("uname"));
		jspContext.setAttribute("oldupassword", rs.getString("upassword"));
		jspContext.setAttribute("olduphone", rs.getString("uphone"));
		System.out.print("a");
	}else{
		jspContext.setAttribute("olduname","");
		jspContext.setAttribute("oldupassword", "");
		jspContext.setAttribute("olduphone","");
		System.out.print("b");
	}
	con.close();
}catch(Exception e){
	jspContext.setAttribute("olduname","");
	jspContext.setAttribute("oldupassword", "");
	jspContext.setAttribute("olduphone","");
	System.out.print(e);
}
%>