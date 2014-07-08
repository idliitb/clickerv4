<!--  

    Author       : Gobinath.M
    Description  : Display the Pending Raise Hand in Tables

 -->

<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../css/saveddoubts.css" rel="stylesheet" type="text/css" />
<script src="../../js/jquery-1.9.1.js"></script>
<title>Insert title here</title>
</head>


<%
String StudentID = (String)request.getParameter("studentID");
//String StudentID = "3";

DatabaseConnection dbconn = new DatabaseConnection();

Connection conn = dbconn.createDatabaseConnection();

int student = Integer.parseInt(StudentID);

String Student_name=null;

%>
<body>

<% 

String Query = "SELECT CourseID,RaiseTimeStamp,Comments FROM raisehand where StudentID='"+StudentID+"' and RepliedDoubt=1";
String query_sname="SELECT StudentName from student where StudentID='"+StudentID+"'";
//System.out.println(Query);
Statement st1 = conn.createStatement();
ResultSet rs1 = st1.executeQuery(query_sname);
if (rs1.next()) {
	Student_name = rs1.getString("StudentName");
}	
Statement st = conn.createStatement();
ResultSet rs = st.executeQuery(Query);
String table_data;
table_data="<H3>Name :"+Student_name+"</H3><H3>Student ID :"+StudentID +"</br></H3>";
table_data=table_data+"<table id='restbl' border='1' style='width: 580px;'><tr><td>Course ID</td> <td>Time Stamp</td> <td>Query</td> </tr><tr>";

try {
	while(rs.next())
	{
		table_data=table_data+"<td>"+ rs.getString(1)+"</td>";
		table_data=table_data+"<td>"+rs.getString(2)+"</td>";
		table_data=table_data+"<td>"+rs.getString(3)+"</td><td><!--<button type="+"button"+">Delete!</button> --> </td> </tr>";
	}
} catch (SQLException e) {
	e.printStackTrace();
}
table_data=table_data+"</table>";
//System.out.println(table_data);
dbconn.closeLocalConnection(conn);
out.println(table_data);


/*
try {
	while(rs.next())
	{
		String CourseId= rs.getString(1);
		String TimeStamp =rs.getString(2);
		String Comment=rs.getString(3);
		*/
		%>
		
		
<!-- 		
	<div class="doubtWrap"  style="text-align: center; margin-left: 0px;width: 610px ;height:220px;border:2px solid;border-radius: 10px ">
	<div class="doubtTextDiv" style="width: 600px ;height:120px;overflow:">
		<br> <label style="margin-left: 5px;">
		</label>
	</div>
	<br>
	<br>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>
				Already Discussed in class </b></label><input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='1' />
	</div>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>Reply to sender</b></label> 
		 <input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='2' />
	</div>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>
				Delete this doubt</b></label><input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='3' />
	</div>
	<div style="height: 50px; float: left;"></div>
	<input class="buttons" id="buttons" style=" padding-left: 20px;padding-top: 0px" type="button"
				value="  Submit    " id="submit" onclick="selected();"></input>
</div>
		 -->
		
		<%
	/*	
		
	}
} catch (SQLException e) {
	e.printStackTrace();
}


conn.close();*/
%>

</body>
</html>