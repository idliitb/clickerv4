/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 * 
 * This class is helper class where all database queries related to raisehand module are placed.
 * 
 */

package clicker.v4.raisehand;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import java.sql.PreparedStatement;
import clicker.v4.wrappers.RepliedRaiseHand;
import clicker.v4.databaseconn.DatabaseConnection;

public class RaiseHandHelper {
	private Connection connection;
	private Statement statement;
	private PreparedStatement stmt;
	private ResultSet rs=null;
	private ArrayList<RaiseHandRowData> resultList=null;
	public RaiseHandHelper(){
		connection=null;
	}


	public void saveraisequestiontext(String courseid,String studentid,String raise_qu) throws SQLException{
		System.out.println("in raise question saving...");
		DatabaseConnection dbcon = new DatabaseConnection();
		try{

			
			connection=dbcon.createDatabaseConnection();
			/*
			 * querry to insert the raise question into database wrt student id ,courseid
			 */
			java.util.Date date= new java.util.Date();
			new Timestamp(date.getTime());

			stmt = connection.prepareStatement("INSERT INTO raisehand (CourseID,StudentID,Comments,RepliedDoubt,RepliedAnswer) VALUES (?,?,?,0,'null')" );
			stmt.setString(1,courseid);
			stmt.setString(2,studentid);
			stmt.setString(3,raise_qu);
			stmt.executeUpdate();

		}
		catch (SQLException e2) {
			// Exception when executing java.sql related commands, print error message to the console
			e2.printStackTrace();
		}finally{
			stmt.close();
			dbcon.closeLocalConnection(connection);
			
		}

	}


	public ArrayList<RaiseHandRowData> retrieveData(String courseID,String text,String date) throws SQLException{
		String CourseID=courseID;
		ResultSet rs=null;
		if(text==null||text.equals("")){
			text="%";
		}
		if(date==null||date.equals("All Time")){
			date="%";
		}
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			rs=statement.executeQuery("SELECT DISTINCT stu.StudentID,stu.StudentName,stu.EmailID,stuCou.Semester,rh.Comments,rh.RaiseTimeStamp FROM student as stu,studentcourse as stuCou,raisehand as rh WHERE rh.StudentID=stu.StudentID AND rh.StudentID=stuCou.StudentID AND rh.CourseID='"+CourseID+"'"+"AND rh.Comments LIKE '%"+text+"%' AND rh.RaiseTimeStamp LIKE '%"+date+"%' AND rh.RepliedDoubt=2 and stuCou.CourseID = rh.CourseID ORDER BY rh.RaiseTimeStamp DESC" );
			RaiseHandRowData data;
			resultList=new ArrayList<RaiseHandRowData>();
			while(rs.next()){
				data=new RaiseHandRowData();
				data.setStudentID(rs.getString("stu.StudentID"));
				data.setName(rs.getString("stu.StudentName"));
				data.setEmail(rs.getString("stu.EmailID"));
				data.setSemester(rs.getString("stuCou.Semester"));
				data.setComment(rs.getString("rh.Comments"));
				data.setRaiseHandTimeStamp(rs.getString("rh.RaiseTimeStamp"));
				resultList.add(data);
			}


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			rs.close();
			statement.close();
			dbcon.closeLocalConnection(connection);
		}
		return resultList;
	}
	
	
	public ArrayList<String> retrieveDate(String courseID) throws SQLException{
		String CourseID=courseID;
		ResultSet rs=null;
		ArrayList<String> resultListofDate=new ArrayList<String>();
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			rs=statement.executeQuery("SELECT DISTINCT rh.RaiseTimeStamp FROM student as stu,studentcourse as stuCou,raisehand as rh WHERE rh.StudentID=stu.StudentID AND rh.StudentID=stuCou.StudentID AND rh.CourseID='"+CourseID+"'"+" AND rh.RepliedDoubt=2 ORDER BY rh.RaiseTimeStamp DESC" );
			
			while(rs.next()){
				
				resultListofDate.add(rs.getString("rh.RaiseTimeStamp"));
			}


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			rs.close();
			statement.close();
			dbcon.closeLocalConnection(connection);
		}
		return resultListofDate;
	}
	
	

	public ArrayList<RaiseHandRowData> retrieveRaiseHand(String StudentID, String Date,String Status,String CourseID) throws SQLException{
		String courseID=CourseID;
		ResultSet rs=null;
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			String query="SELECT stu.StudentID,stu.StudentName,stu.EmailID,stuCou.Semester,rh.Comments,rh.RaiseTimeStamp FROM student as stu,studentcourse as stuCou,raisehand as rh WHERE rh.StudentID=stu.StudentID AND rh.StudentID=stuCou.StudentID AND rh.CourseID='"+courseID+"'"+" AND stuCou.CourseID=rh.CourseID AND rh.StudentID= '"+StudentID+"'"+" AND rh.RepliedDoubt='"+Status+"' AND rh.RaiseTimeStamp= '"+Date+"'";
			rs=statement.executeQuery(query);
			//System.out.println("Query...."+query);
			RaiseHandRowData data;
			resultList=new ArrayList<RaiseHandRowData>();
			while(rs.next()){
				data=new RaiseHandRowData();
				data.setStudentID(rs.getString("stu.StudentID"));
				data.setName(rs.getString("stu.StudentName"));
				data.setEmail(rs.getString("stu.EmailID"));
				//System.out.println("........."+rs.getString("stu.EmailID"));
				data.setSemester(rs.getString("stuCou.Semester"));
				data.setComment(rs.getString("rh.Comments"));
				data.setRaiseHandTimeStamp(rs.getString("rh.RaiseTimeStamp"));
				resultList.add(data);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			rs.close();
			statement.close();
			dbcon.closeLocalConnection(connection);
		}
		return resultList;
	}
	public void deleteData(String raiseHandTimeStamp) throws SQLException{
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			statement.execute("DELETE FROM raisehand WHERE RaiseTimeStamp='"+raiseHandTimeStamp+"'");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{

			statement.close();
			dbcon.closeLocalConnection(connection);
		}

	}

	public void updateRaiseHandStatus(String StudentID,String RaiseHandTimeStamp) throws SQLException{
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			statement.execute("update raisehand set RepliedDoubt=2 ,RepliedAnswer='Already Discussed in Class' WHERE StudentID='"+StudentID+"' and RaiseTimeStamp='"+RaiseHandTimeStamp+"'");
			System.out.println("update raisehand set RepliedDoubt=2 ,RepliedAnswer='Already Discussed in Class' WHERE StudentID='"+StudentID+"' and RaiseTimeStamp='"+RaiseHandTimeStamp+"'");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{

			statement.close();
			dbcon.closeLocalConnection(connection);
		}

	}

	public void updateRaiseHandReply(String StudentID,String RaiseHandTimeStamp,String Reply) throws SQLException{
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			statement.execute("update raisehand set RepliedDoubt=2 , RepliedAnswer='"+Reply+"' WHERE StudentID='"+StudentID+"' and RaiseTimeStamp='"+RaiseHandTimeStamp+"'");
			System.out.println("update raisehand set RepliedDoubt=2 , RepliedAnswer='"+Reply+"' WHERE StudentID='"+StudentID+"' and RaiseTimeStamp='"+RaiseHandTimeStamp+"'");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{

			statement.close();
			dbcon.closeLocalConnection(connection);
		}

	}


	public void updateRaiseHandAsPending(String CourseID) throws SQLException{
		ResultSet rs=null;
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			ArrayList<String> list = new ArrayList<String>();
			
			connection=dbcon.createDatabaseConnection();
			statement=connection.createStatement();
			String query="Select RaiseTimeStamp from raisehand WHERE CourseID='"+CourseID+"' and RepliedDoubt=0 ";
			rs=statement.executeQuery(query);
			while(rs.next()){
				list.add(rs.getString(1));
				
			}
			System.out.println(list.size());
			for(int i=0;i<list.size();i++){	
				System.out.println("update raisehand set RepliedDoubt=1 , RaiseTimeStamp='"+list.get(i)+"' WHERE CourseID='"+CourseID+"'"+"and RaiseTimeStamp='"+list.get(i)+"'"+" and RepliedDoubt=0");
				statement.execute("update raisehand set RepliedDoubt=1 , RaiseTimeStamp='"+list.get(i)+"' WHERE CourseID='"+CourseID+"'"+"and RaiseTimeStamp='"+list.get(i)+"'"+" and RepliedDoubt=0");
			}
			
		

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			rs.close();
			statement.close();
			dbcon.closeLocalConnection(connection);
		}

	}


	public RepliedRaiseHand getRaiseHandReply(String StudentID,String CourseID) throws SQLException{
		ResultSet rs=null;
		ArrayList<String> dt = new ArrayList<String>();
		ArrayList<String> rt  = new ArrayList<String>();
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
		
		connection=dbcon.createDatabaseConnection();
		statement=connection.createStatement();
		String query="SELECT Comments,RepliedAnswer FROM raisehand where CourseId='"+CourseID+"'"+ "and StudentId='"+StudentID+"'"+ "and RepliedDoubt=2";
		rs=statement.executeQuery(query);
		while(rs.next()){
			String doubttext=rs.getString(1);
			String replytext=rs.getString(2);
			dt.add(doubttext);
			rt.add(replytext);
		}
		}catch(Exception e){
			System.out.println(e);
		}
		finally{
			rs.close();
			statement.close();
			dbcon.closeLocalConnection(connection);
		}
		RepliedRaiseHand raisehandReplyList=new RepliedRaiseHand();
		raisehandReplyList.setDoubtText(dt);
		raisehandReplyList.setReplyText(rt);
		return raisehandReplyList;
	}


}

