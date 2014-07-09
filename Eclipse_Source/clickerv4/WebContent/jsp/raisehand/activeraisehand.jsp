<!-- 
Author- Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="clicker.v4.raisehand.*" %>
<%@page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
String CourseID=session.getAttribute("courseID").toString();
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
Statement st =conn.createStatement();	
Global.raisehandcounter.put(CourseID,0);
%>
<%
ResultSet rs1=null;
try{
		
		String query1="SELECT DISTINCT stu.StudentID,rh.RaiseTimeStamp FROM student as stu,studentcourse as stuCou,raisehand as rh WHERE rh.StudentID=stu.StudentID AND rh.StudentID=stuCou.StudentID AND rh.CourseID='"+CourseID+"'"+"AND rh.RepliedDoubt=0 ORDER BY rh.RaiseTimeStamp DESC";
		//System.out.println("query1==>"+query1);
		rs1=st.executeQuery(query1);

%>
<select class= "selectwindow" size="5" multiple="multiple" name="activeraise" id="activeraise" style="width: 250px; height:150px;" onchange="loadPendingDoubts('Active');">
<%while(rs1.next())
		{
			
		
			String studentID = rs1.getString(1);
			String TimeStamp=rs1.getString(2);
			
			 %>
<option class= "opt" value="<%=studentID+"@"+TimeStamp+"@"+0+"@"+CourseID%>"><%=studentID %></option>
<%
//System.out.println(studentID);
}

}
catch(Exception e)
{
out.println(e);
}finally{
	rs1.close();
	st.close();
	dbconn.closeLocalConnection(conn);
}

%>

</select>
</html>