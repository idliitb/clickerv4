/*
   Author      : Gobinath M
   Description : used for attendance, it reads the data from Global.activestudentlist  
   				  and send to the attendance.jsp page 
 */

package clicker.v4.dashboard;

import java.util.HashSet;


import clicker.v4.global.Global;
import clicker.v4.databaseconn.*;

import java.sql.*;




public class AttendanceHelper {

	static int i = 0;

	public HashSet<String> studentlist(String courseID) {
		HashSet<String> student_list = new HashSet<String>();
		student_list = Global.activestudentlist.get(courseID);
		return student_list;

	}

	public int getstudentList(String courseID) {
		
		if(courseID== null)
		{
			return 0;
		}
			HashSet<String> student_list = new HashSet<String>();
			student_list = Global.activestudentlist.get(courseID);
			if (Global.activestudentlist.get(courseID) == null) {
				return 0;
			} else {
				return student_list.size();
			}
		
	}
	public int get_total_Studentlist(String courseID) 
	{
	String Student_id=null;
	int total=0;
	if(courseID== null)
	{
		return 0;
	}
	else
	{
		DatabaseConnection dbconn1 = new DatabaseConnection();
		Connection conn1 = dbconn1.createDatabaseConnection();
	try {
		
		
		Statement st1 = conn1.createStatement();
		String query1 = "SELECT count(StudentID) from studentcourse where CourseID='"
				+ courseID + "'";
		ResultSet rs = st1.executeQuery(query1);
	

		while (rs.next()) {
			Student_id = rs.getString(1);
		}
		total=Integer.parseInt(Student_id);
		
		st1.close();
		rs.close();

	} catch (Exception e) {
		
	}
	finally
	{dbconn1.closeLocalConnection(conn1);}
	return total;
       	
}
	}
	
	public HashSet<String> getStudentID( String CourseID)
	{
		//System.out.println("Inside Get ID");
		HashSet<String> studentname= new HashSet<String>();
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();		
		String Query = "select StudentID from studentcourse where CourseID='"+ CourseID +"'";		
		try
		{		
		Statement st1 = conn.createStatement();
		ResultSet rs1 = st1.executeQuery(Query);		
		while(rs1.next()) {	
			//System.out.println("rs1.getString(QuizID)=="+rs1.getString("QuizID"));
			String name = rs1.getString("StudentID");		
			//System.out.println("---->"+name);			
			studentname.add(name);		
		}
		}
		catch (Exception ex)
		{
			
		}	
		finally{dbconn.closeLocalConnection(conn);}
		return studentname;
	}
	
	
}
