<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for displaying list of students on click of responses of poll.
-->
<%@page import="clicker.v4.poll.*"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%
PollHelper ph=new PollHelper();
String responseflag= request.getParameter("rflag");
String chart=request.getParameter("chart");
String courseId=(String)session.getAttribute("courseID");
String launchtimepoll=request.getParameter("launchtime");
String pollid=session.getAttribute("pollid").toString();

DatabaseConnection dbcon = new DatabaseConnection();
Connection con = null;
PreparedStatement st = null;
ResultSet rs = null;
con = dbcon.createDatabaseConnection();
StringBuffer responseTable=null;

try {
	if(chart.equals("response"))
	{
		String responsevalue=null;
		responseTable = new StringBuffer("<table width=300px border='1' cellpadding='5'><tr><th>S.No</th><th>Student ID</th><th>Response</th>");
		//int pid=ph.getPollid();
		int pid=Integer.parseInt(pollid);
		st = (PreparedStatement) con.prepareStatement("SELECT StudentID, Response from poll where PollID=? and Response=?;");
		st.setInt(1,pid);
		st.setString(2,responseflag);
		rs=st.executeQuery();	

		int count = 0;
		while (rs.next()) {
			count++;
			if(rs.getInt("Response")==1)
				responsevalue="Yes";
			else if(rs.getInt("Response")==0)
				responsevalue="No";
			else
				responsevalue="No Response";
			responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("StudentID") + "</td><td>" + responsevalue + "</td></tr>");							
		}
		responseTable.append("</table>");
	}
	else if(chart.equals("stats"))
	{
		responseTable = new StringBuffer("<table width=300px border='1' cellpadding='5'><tr><th>S.No</th><th>Student ID</th>");
		//int pid=ph.getPollid();
		int pid=Integer.parseInt(pollid);
		if(responseflag.equals("Attended"))
		{
			st = con.prepareStatement("SELECT StudentID from poll where PollID=?");
			st.setInt(1,pid);
		}
		else
		{
			st = con.prepareStatement("Select StudentID from studentcourse where CourseID=? and StudentID not in(select StudentID from poll where PollID=?)");
			st.setString(1,courseId);
			st.setInt(2,pid);
		}
		
		rs=st.executeQuery();
		int count = 0;
		while (rs.next()) {
			count++;
			
			responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("StudentID") + "</td></tr>");							
		}
		responseTable.append("</table>");
		
	}
	
	
	
} catch (SQLException e) {
	e.printStackTrace();
}finally{
	try {
		if(rs!=null)rs.close();
		if(st!=null)st.close();
		if(con!=null)dbcon.closeLocalConnection(con);
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
}
out.print( responseTable.toString());




%>