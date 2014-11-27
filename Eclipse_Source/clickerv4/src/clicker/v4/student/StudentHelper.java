package clicker.v4.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.wrappers.CourseList;

/**
 * 
 * @author rajavel, dipti
 * This class is act as helper class for student activities
 */
public class StudentHelper {
	/*
	 * This method is used to get the all Courses for which the student is registered 
	 */
	public String getCourseList(String sid){
		String courseList = "";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		try{
			con = dbcon.createDatabaseConnection();
			pst = con.prepareStatement("Select CourseID from studentcourse where StudentID = ?");
			pst.setString(1, sid);
			rs = pst.executeQuery();
			while(rs.next()){
				courseList += rs.getString(1) + "@";
			}			
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
		return courseList;
	}

	/*
	 * This method is used to get the all workshop for which the participant is registered 
	 */
	public String getCourseListParticipant(String pid){
		String workshopList = "";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		try{
			con = dbcon.createRemoteDatabaseConnection();
			pst = con.prepareStatement("Select WorkshopID from participant where ParticipantID = ?");
			pst.setString(1, pid);
			rs = pst.executeQuery();
			while(rs.next()){
				workshopList += rs.getString(1) + "@";
			}			
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
		return workshopList;
	}


	/*
	 * this is used to check whether a studentID and Password matches or not (It is used in Rest file)
	 */
	public boolean checkStudentPassword(String StudentID,String Password){
		String StudID=null;
		boolean Flag=false; 
		Connection con = null;
		PreparedStatement st = null;
		DatabaseConnection dbconn=new DatabaseConnection();
		try
		{

			con = dbconn.createDatabaseConnection();
			st = (PreparedStatement) con.prepareStatement("SELECT StudentID FROM student WHERE StudentID =? and Password=?");
			st.setString(1,StudentID);
			st.setString(2,Password);
			ResultSet rs=st.executeQuery();	
			rs.next();
			StudID=rs.getString("StudentID");
			if(StudID!=null&&StudID.equals(StudentID)){
				Flag= true;	
			}else{
				Flag= false;
			}
		}
		catch (SQLException e) 
		{
			System.out.println("No student with this password, or password doesnot matched");
		}
		finally{
			try {
				st.close();
				dbconn.closeLocalConnection(con);
			} catch (SQLException e) {
				System.out.println("No student with this password, or password doesnot matched");
			}
		}
		return Flag;
	}



	/*
	 * this is used to check whether a studentID and Password matches or not (It is used in Rest file)
	 */
	public boolean checkParticipantPassword(String StudentID,String Password){
		String StudID=null;
		boolean Flag=false; 
		Connection con = null;
		PreparedStatement st = null;
		DatabaseConnection dbconn=new DatabaseConnection();
		try
		{

			con = dbconn.createRemoteDatabaseConnection();
			st = (PreparedStatement) con.prepareStatement("SELECT ParticipantID FROM participant WHERE ParticipantID =? and Password=?");
			st.setString(1,StudentID);
			st.setString(2,Password);
			ResultSet rs=st.executeQuery();	
			rs.next();
			StudID=rs.getString("ParticipantID");
			if(StudID!=null&&StudID.equals(StudentID)){
				Flag= true;	
			}else{
				Flag= false;
			}
		}
		catch (SQLException e) 
		{
			System.out.println("No Participant with this password, or password doesnot matched");
		}
		finally{
			try {
				st.close();
				dbconn.closeRemoteConnection(con);
			} catch (SQLException e) {
				System.out.println("No participant with this password, or password doesnot matched");
			}
		}
		return Flag;
	}


	/*
	 * This method is used to get the course list for a student (For Browser too)
	 */	
	public CourseList getCourseListForStudent(String studentid, String Mode){
		
		String mode="remote";
		
		if(Mode!="remote"||!Mode.equals(mode)){
			DatabaseConnection dbConn = new DatabaseConnection();
			Connection conn = dbConn.createDatabaseConnection();
			String Validation = "Success";
			ArrayList<String> courseIDs = new ArrayList<String>();
			ArrayList<Boolean> isCourseActive = new ArrayList<Boolean>();
			PreparedStatement pst = null;
			ResultSet rs = null;
			try {
				pst = conn.prepareStatement("SELECT CourseID from studentcourse sc where StudentID = ?");
				pst.setString(1, studentid);
				rs = pst.executeQuery();
				String courseID = "";
				while(rs.next()){				
					courseID = rs.getString("CourseID");
					courseIDs.add(courseID);
					System.out.println("Active Courses" + Global.activecourses);
					if(Global.activecourses.containsKey(courseID)){
						isCourseActive.add(true);
						HashSet<String> activestudentlist = Global.activestudentlist.get(courseID);
						activestudentlist.add(studentid);
						Global.activestudentlist.replace(courseID, activestudentlist);
						System.out.println("Active Student List" + Global.activestudentlist);
					}else{
						isCourseActive.add(false);
					}
				}
			}catch (SQLException e) {			
				e.printStackTrace();
			}
			finally{
				if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				if(pst!=null)try {pst.close();} catch (SQLException e) {e.printStackTrace();}
				if(conn!=null)dbConn.closeLocalConnection(conn);
			}			
			CourseList courseList = new CourseList();
			courseList.setCourseIDs(courseIDs);
			courseList.setIsActive(isCourseActive);
			courseList.setValidation(Validation);
			courseList.setMode(Mode);
			return courseList;

		}else{
			//This is for participant 

			DatabaseConnection dbConn = new DatabaseConnection();
			Connection conn = dbConn.createRemoteDatabaseConnection();
			String Validation = "Success";
			ArrayList<String> workshopIDs = new ArrayList<String>();
			ArrayList<Boolean> isWorkshopActive = new ArrayList<Boolean>();
			PreparedStatement pst = null;
			ResultSet rs = null;
			try {
				pst = conn.prepareStatement("SELECT WorkshopID from participant where ParticipantID = ?");
				pst.setString(1, studentid);
				rs = pst.executeQuery();
				String workshopID = "";
				while(rs.next()){				
					workshopID = rs.getString("WorkshopID");
					workshopIDs.add(workshopID);
					System.out.println("Active Courses" + Global.activeworkshop);
					if(Global.activeworkshop.containsKey(workshopID)){
						isWorkshopActive.add(true);
						HashSet<String> activeparticipantlist = Global.activeparticipantlist.get(workshopID);
						activeparticipantlist.add(studentid);
						Global.activeparticipantlist.replace(workshopID, activeparticipantlist);
						System.out.println("Active Participant List" + Global.activeparticipantlist);
					}else{
						isWorkshopActive.add(false);
					}
				}
			}catch (SQLException e) {			
				e.printStackTrace();
			}
			finally{
				if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				if(pst!=null)try {pst.close();} catch (SQLException e) {e.printStackTrace();}
				if(conn!=null)dbConn.closeLocalConnection(conn);
			}			
			CourseList courseList = new CourseList();
			courseList.setCourseIDs(workshopIDs);
			courseList.setIsActive(isWorkshopActive);
			courseList.setValidation(Validation);
			courseList.setMode(Mode);
			return courseList;

		}


	}
	
	/*
	 * To update password of student for browser login.
	 */
	
	public String updateStudentPassword(String StudentID,String NewPassword){
		String status="";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		PreparedStatement pst = null;
		try{
			con = dbcon.createDatabaseConnection();
			pst = con.prepareStatement("update student set Password=? where StudentID=? ");
			pst.setString(1,NewPassword);
			pst.setString(2, StudentID);
			pst.executeUpdate();
			status="success";
					
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
		
		return status;
	}

	/*
	 * To update password of Participant for browser login.
	 */
	
	public String updateParticipantPassword(String ParticipantID,String NewPassword){
		String status="failed";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		PreparedStatement pst = null;
		try{
			con = dbcon.createRemoteDatabaseConnection();
			pst = con.prepareStatement("update participant set Password=? where ParticipantID=? ");
			pst.setString(1,NewPassword);
			pst.setString(2, ParticipantID);
			pst.executeUpdate();
			status="success";
					
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
		
		return status;
	}
	
	
}
