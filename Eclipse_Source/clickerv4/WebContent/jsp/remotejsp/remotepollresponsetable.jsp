<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for displaying list of participants on click of responses of poll.
-->
<%@page import="clicker.v4.poll.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%
RemoteDBHelper rdh= new RemoteDBHelper();
String WorkshopID=(String) session.getAttribute("WorkshopID");
String responseflag= request.getParameter("rflag");
String chart=request.getParameter("chart");
String launchtimepoll=request.getParameter("launchtime");


DatabaseConnection dbcon = new DatabaseConnection();
Connection con = null;
PreparedStatement st = null;
ResultSet rs = null;
con = dbcon.createRemoteDatabaseConnection();
StringBuffer responseTable=null;

try {
	
	if(chart.equals("response"))
	{
		String responsevalue=null;
		responseTable = new StringBuffer("<table width=300px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th><th>Response</th>");
		//int pid=rdh.getPollid();
		int pid=rdh.getpollidnew(launchtimepoll, WorkshopID);
		st = (PreparedStatement) con.prepareStatement("SELECT ParticipantID, Response from poll where PollID=? and Response=?;");
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
			responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td><td>" + responsevalue + "</td></tr>");							
		}
		responseTable.append("</table>");
	}
	
	else if(chart.equals("stats"))
	{
		responseTable = new StringBuffer("<table width=300px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th>");
		//int pid=rdh.getPollid();
		int pid=rdh.getpollidnew(launchtimepoll,WorkshopID);
		if(responseflag.equals("Attended"))
		{
			st = con.prepareStatement("SELECT ParticipantID from poll where PollID=?");
			st.setInt(1,pid);
		}
		else
		{
			st = con.prepareStatement("Select ParticipantID from participant where WorkshopID=? and ParticipantID not in(select ParticipantID from poll where PollID=?)");
			st.setString(1,WorkshopID);
			st.setInt(2,pid);
		}
		
		rs=st.executeQuery();
		int count = 0;
		while (rs.next()) {
			count++;
			
			responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td></tr>");							
		}
		responseTable.append("</table>");
		
	}
	
	
} catch (SQLException e) {
	e.printStackTrace();
}finally{
	try {
		if(rs!=null)rs.close();
		if(st!=null)st.close();
		if(con!=null)dbcon.closeRemoteConnection(con);
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
}
out.print( responseTable.toString());




%>