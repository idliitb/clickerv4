package clicker.v4.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.wrappers.CourseList;
/**
 * 
 * @author rajavel ,dipti
 * This class is used as a course helper
 * 
 * Made change inorder to get the mode ie local or remote and likewise functionalities will work
 */
public class CourseHelper {
	public CourseList getCourseList(String studentid, String mac,String Mode){
		String mode="remote";
		
		if(Mode!="remote"||!Mode.equals(mode)){
			//System.out.println("..............This is local mode................");
			DatabaseConnection dbConn = new DatabaseConnection();
			Connection conn = dbConn.createDatabaseConnection();
			String Validation = "";
			String ModeValue="local";
			Statement st = null;
			ResultSet rs = null;
			ArrayList<String> courseIDs = new ArrayList<String>();
			ArrayList<Boolean> isActive = new ArrayList<Boolean>();
			try {
				st = conn.createStatement();
				rs = st.executeQuery("SELECT StudentID FROM student WHERE  StudentID = '"+studentid+"' && MacAddress = '" + mac + "'");
				if(rs.next()){				
					Validation =  "Success";				
				}else {
					Statement st1 = conn.createStatement();
					ResultSet rs1 = st1.executeQuery("SELECT StudentID FROM student WHERE StudentID = '"+studentid+"' && MacAddress != ''" );
					if(rs1.next()){
						Validation = "You are using Wrong Tablet";
					}else{
						Statement st2 = conn.createStatement();
						ResultSet rs2 = st2.executeQuery("SELECT StudentID FROM student WHERE MacAddress = '"+mac+"'" );
						if(rs2.next()){
							Validation = "Wrong Enrollment ID";
						}else{
							Statement st3 = conn.createStatement();
							ResultSet rs3 = st3.executeQuery("SELECT StudentID FROM student WHERE  StudentID = '"+studentid+"' && MacAddress = ''");
							if(rs3.next()){
								Statement st4 = conn.createStatement();
								st4.executeUpdate("Update student set MacAddress = '"+mac+"' where StudentID = '"+studentid+"'");
								Validation = "Success";
								st4.close();
							}
							if(rs3!=null)rs3.close();			
							if(st3!=null)st3.close();
						}
						if(rs2!=null)rs2.close();			
						if(st2!=null)st2.close();
					}
					if(rs1!=null)rs1.close();			
					if(st1!=null)st1.close();
				}
				if(rs!=null)rs.close();			
				if(st!=null)st.close();
				if(Validation.equals("Success")){
					Statement st1 = conn.createStatement();
					ResultSet rs1 = st1.executeQuery("select sc.CourseID from student s, studentcourse sc where s.StudentID = '"+studentid+"' and sc.StudentID = s.StudentID");
					String courseID = "";
					while(rs1.next()){				
						courseID = rs1.getString("CourseID");
						courseIDs.add(courseID);
						System.out.println("Active Courses" + Global.activecourses);
						if(Global.activecourses.containsKey(courseID)){
							isActive.add(true);
							HashSet<String> activelist = Global.activestudentlist.get(courseID);
							activelist.add(studentid);
							Global.activestudentlist.replace(courseID, activelist);
							insertAttendance(conn, studentid, courseID,ModeValue);
							System.out.println("Active Student List" + Global.activestudentlist);
						}else{
							isActive.add(false);
						}
					}
				}
			}catch (SQLException e) {			
				e.printStackTrace();
			}
			finally{
				if(conn!=null)dbConn.closeLocalConnection(conn);
			}			
			CourseList courseList = new CourseList();
			courseList.setCourseIDs(courseIDs);
			courseList.setIsActive(isActive);
			courseList.setValidation(Validation);
			courseList.setMode(ModeValue);
			return courseList;
		}
		else{
			
			//System.out.println("..............This is Remote mode................");
			DatabaseConnection dbConn = new DatabaseConnection();
			Connection conn = dbConn.createRemoteDatabaseConnection();
			boolean isParticipant=false;
			String Validation = "Participant is Not Registered";
			String ModeValue="remote";
			Statement st = null;
			ResultSet rs = null;
			ArrayList<String> WorkshopIDs = new ArrayList<String>();
			ArrayList<Boolean> isActive = new ArrayList<Boolean>();
			try {
				
				Statement st10 = conn.createStatement();
				ResultSet rs10 = st10.executeQuery("select WorkshopID from participant where ParticipantID = '"+studentid+"'");
				String WorkshopID1 = "";
				while(rs10.next())
				{
					isParticipant=true;
					WorkshopID1 = rs10.getString("WorkshopID");
					if(Global.activeworkshop.containsKey(WorkshopID1))
					{
						System.out.println("is active");
						st = conn.createStatement();
						rs = st.executeQuery("SELECT ParticipantID FROM participant WHERE  ParticipantID = '"+studentid+"' && MacAddress = '" + mac + "' && WorkshopID = '"+WorkshopID1+"'");
						if(rs.next()){				
							Validation =  "Success";				
						}else {
							Statement st1 = conn.createStatement();
							ResultSet rs1 = st1.executeQuery("SELECT ParticipantID FROM participant WHERE ParticipantID = '"+studentid+"' && MacAddress != '' && WorkshopID = '"+WorkshopID1+"'" );
							if(rs1.next()){
								Validation = "You are using Wrong Tablet";
							}else{
								Statement st2 = conn.createStatement();
								ResultSet rs2 = st2.executeQuery("SELECT ParticipantID FROM participant WHERE MacAddress = '"+mac+"' && WorkshopID = '"+WorkshopID1+"'" );
								if(rs2.next()){
									Validation = "Wrong Enrollment ID";
								}else{
									Statement st3 = conn.createStatement();
									ResultSet rs3 = st3.executeQuery("SELECT ParticipantID FROM participant WHERE  ParticipantID = '"+studentid+"' && MacAddress = '' && WorkshopID = '"+WorkshopID1+"'");
									if(rs3.next()){
										Statement st4 = conn.createStatement();
										st4.executeUpdate("Update participant set MacAddress = '"+mac+"' where ParticipantID = '"+studentid+"' && WorkshopID = '"+WorkshopID1+"' ");
										Validation = "Success";
										st4.close();
									}
									if(rs3!=null)rs3.close();			
									if(st3!=null)st3.close();
								}
								if(rs2!=null)rs2.close();			
								if(st2!=null)st2.close();
							}
							if(rs1!=null)rs1.close();			
							if(st1!=null)st1.close();
						}
						if(rs!=null)rs.close();			
						if(st!=null)st.close();
						if(Validation.equals("Success"))
						{
							
								WorkshopIDs.add(WorkshopID1);
								System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+Global.activeworkshop);
								if(Global.activeworkshop.containsKey(WorkshopID1)){
									isActive.add(true);
									HashSet<String> activelist = Global.activeparticipantlist.get(WorkshopID1);
									activelist.add(studentid);
									Global.activeparticipantlist.replace(WorkshopID1, activelist);
									insertAttendance(conn, studentid, WorkshopID1,ModeValue);
									System.out.println(Global.activeparticipantlist);
								}else{
									isActive.add(false);
								}
								
						
						}
					
						
					}
					
						
				}
				if(isParticipant && Validation.equals("Participant is Not Registered")){
					Validation = "No Active Course(s)";
				}
				if(Global.activeworkshop.containsKey("autotest")){
					WorkshopIDs.add("autotest");
					isActive.add(true);
				}
				
			
				
			}catch (SQLException e) {			
				e.printStackTrace();
			}
			finally{
				if(conn!=null)dbConn.closeRemoteConnection(conn);
			}	
			CourseList courseList = new CourseList();
			if(Validation=="Success"){
				
				System.out.println("in 1");
				courseList.setCourseIDs(WorkshopIDs);
				courseList.setIsActive(isActive);
				courseList.setValidation(Validation);
				courseList.setMode(ModeValue);
				
			}
			else if(Validation!="Success" && WorkshopIDs.isEmpty()){
				System.out.println("in 2");
				courseList.setCourseIDs(WorkshopIDs);
				courseList.setIsActive(isActive);
				courseList.setValidation(Validation);
				courseList.setMode(ModeValue);
			}
			else if(Validation!="Success" && WorkshopIDs != null){
				System.out.println("in 3");
				courseList.setCourseIDs(WorkshopIDs);
				courseList.setIsActive(isActive);
				courseList.setValidation("Success");
				courseList.setMode(ModeValue);
			}
			return courseList;
		}
		
	}
	
	public void insertAttendance(Connection con, String studentID, String courseID,String Mode){
		
		String mode="remote";
		if(Mode!="remote"||!Mode.equals(mode)){
			PreparedStatement ps = null;
			PreparedStatement pst = null;
			try{
				 
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date( ));
				String formatted_date = (date.substring(0, 10));
				String session = "";
				int attendance_count = 0;
				System.out.println("Date : " + date);
				
				if(date.compareTo(formatted_date + " 12:00:00") > 0)
					session = "Afternoon";
				else
					session = "Forenoon";
				//System.out.println("Session: " + session);
				ps = con.prepareStatement("Select StudentID, Attendance_Count, AttendanceTS from attendance where StudentID=? and Session like ? and CourseID = ? and Date(AttendanceTS) = ?");
				ps.setString(1, studentID);
				ps.setString(2, session);//ps.setString(2, Global.activecourses.get(courseID));
				ps.setString(3, courseID);
				ps.setString(4, formatted_date);
				ResultSet rs = ps.executeQuery();
				
				if(rs.next())
				{
					//System.out.println("in IF!!");
					attendance_count = rs.getInt("Attendance_Count");
					pst = con.prepareStatement("update attendance set Attendance_Count = ? where StudentID = ? and Session like ? and Date(AttendanceTS) like ? and CourseID = ?");
					pst.setInt(1, ++attendance_count);					
					pst.setString(2, rs.getString("StudentID"));
					pst.setString(3, session);
					pst.setString(4, formatted_date);
					pst.setString(5, courseID);
					pst.executeUpdate();
				}
				else
				{
					//System.out.println("In else!!");
					pst = con.prepareStatement("Insert into attendance(StudentID, CourseID, Attendance_Count, Session) Values(?, ?, ?, ?)");
					pst.setString(1, studentID);
					pst.setString(2, courseID);
					pst.setInt(3, ++attendance_count);
					pst.setString(4, session);
					pst.executeUpdate();
				}
								
			}catch (SQLException e) {
				e.printStackTrace();
			} finally{
				try {
					if(pst!=null)pst.close();
					if(ps!=null)ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}else{
			PreparedStatement ps = null;
			PreparedStatement pst = null;
			try{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date( ));
				String formatted_date = (date.substring(0, 10));
				String session = "";
				int attendance_count = 0;
				System.out.println("Date : " + date);
				
				if(date.compareTo(formatted_date + " 12:00:00") > 0)
					session = "Afternoon";
				else
					session = "Forenoon";
				//System.out.println("Session: " + session);
				
				ps = con.prepareStatement("Select ParticipantID, Attendance_Count, AttendanceTS from attendance where ParticipantID=? and Session=? and WorkshopID = ? and Date(AttendanceTS) = ?");
				ps.setString(1, studentID);
				ps.setString(2, session);
				ps.setString(3, courseID);
				ps.setString(4, formatted_date);
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()){
					//System.out.println("in Remote IF!!");
					attendance_count = rs.getInt("Attendance_Count");
					pst = con.prepareStatement("update attendance set Attendance_Count = ? where ParticipantID = ? and WorkshopID = ? and Session = ? and Date(AttendanceTS) = ?");
					pst.setInt(1, ++attendance_count);
					pst.setString(2, rs.getString("ParticipantID"));
					pst.setString(3, courseID);
					pst.setString(4, session);
					pst.setString(5, formatted_date);
					pst.executeUpdate();
				}
				else
				{
					//System.out.println("In Remote else!!");
					pst = con.prepareStatement("Insert into attendance(ParticipantID, WorkshopID, Attendance_Count, Session) Values(?,?,?,?)");
					pst.setString(1, studentID);
					pst.setString(2, courseID);
					pst.setInt(3, ++attendance_count);
					pst.setString(4, session);
					pst.executeUpdate();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(pst!=null)pst.close();
					if(ps!=null)ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
		}
		
	}
}