<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@ page language="java" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection conn,conn1;
conn = null;
conn1=null;
int qtype = -1;
int qid = -1;
DatabaseConnection db = new DatabaseConnection();
try{

conn = db.createDatabaseConnection();
qid = Integer.parseInt(request.getParameter("qid"));

String query = "select QuestionType from question where QuestionID='"+qid+"'";

Statement pstmt = conn.prepareStatement(query);
pstmt.execute("update question set Archived=0 where QuestionID="+qid);
ResultSet rs = pstmt.executeQuery(query);


while(rs.next())
{
	qtype = rs.getInt("QuestionType");
}
}catch(Exception e){
	e.getStackTrace();
}finally{
	try{
		db.closeLocalConnection(conn);
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		switch(qtype)
		{
		case 1:	response.sendRedirect("editsingleques.jsp?qid="+qid);
				break;
		case 2:	response.sendRedirect("editmultiques.jsp?qid="+qid);
				break;
		case 3:	response.sendRedirect("editnumeric.jsp?qid="+qid);
				break;
		case 4:	response.sendRedirect("editTF.jsp?qid="+qid);
				break;
		}
	}
}	



%>
</body>
</html>