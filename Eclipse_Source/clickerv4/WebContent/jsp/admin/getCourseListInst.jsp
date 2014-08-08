<%--
      @author Gobinath
DESCREPTION: it display the course list in the drop down menu in add instructor page
			 
USE        : to show the course for the particular department

--%>

<%@ page import="javax.swing.JOptionPane"%>

<%@ page import="java.util.ArrayList"%>

    <%@ page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@ page import="java.sql.*"%>



<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
	
	String deptid = request.getParameter("deptinstid");
	String oldCourseID = request.getParameter("cinstid");
	System.out.println("Dept " + deptid);
	session.setAttribute("ocid", oldCourseID);
	System.out.println("oldCourseID " + session.getAttribute("ocid"));
	String cList="";
	DatabaseConnection dbconn = new DatabaseConnection();
	Connection conn = dbconn.createDatabaseConnection();
	try {
		
		Statement st = conn.createStatement();
		String query1 = "SELECT CourseID FROM course where DeptID ='"+ deptid + "'";
		ResultSet rs = st.executeQuery(query1);
		int i=0;
		while(rs.next())
		{
			cList+=rs.getString(1).concat(";");
		}
		
		
	} 
	catch(Exception e) {
		e.printStackTrace();
	}
	finally
	{
		dbconn.closeLocalConnection(conn);
	}
	System.out.println("Clist "+cList);
    out.print(cList);
%>