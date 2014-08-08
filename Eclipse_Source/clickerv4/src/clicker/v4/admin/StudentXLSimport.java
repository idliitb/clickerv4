/* Author : Gobianth M
 * Use : for import the student data from xls file to database 
 *  
 */
package clicker.v4.admin;

import java.io.File;
import java.sql.*;

import clicker.v4.databaseconn.*;
import jxl.*;



public class StudentXLSimport {
	public String insertQuery(String studentid, String studrollno, String studentname, int yoj, int privilege,
			String deptid, String email, String mac, int courseyear,
			String semester, String courseid) {
		int rs = 0, rs1 = 0;
		String did = "";				
		Connection conn = null;
		int selector = 0, count1 = 0; 
		PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null, ps4 = null;
		ResultSet result1 = null, result2 = null, result3 = null;
		DatabaseConnection db = new DatabaseConnection();
		try {			
			conn = db.createDatabaseConnection();			
			ps4 = conn.prepareStatement("select count(CourseID) as cid, DeptID from course where CourseID=?");
			ps4.setString(1, courseid);			
			result3 = ps4.executeQuery();			
			while(result3.next())
			{
				count1 = result3.getInt("cid");
				did = result3.getString("DeptID");				
			}			
			result3.close();
			ps4.close( );			
			if((count1 != 0) && (did.equals(deptid)))
			{			
				ps2 = conn.prepareStatement("select StudentID, CourseID from studentcourse where StudentID=?");
				ps2.setString(1, studentid);				
				ps3 = conn.prepareStatement("select StudentID from student where StudentID=?");
				ps3.setString(1, studentid);				
				result1 = ps2.executeQuery();
				result2 = ps3.executeQuery();				
				while(result2.next())
				{	
					if(result2.getString("StudentID").equals(studentid))
					{
						while(result1.next())
						{
							if(result1.getString("StudentID").equals(studentid) && result1.getString("CourseID").equals(courseid))
							{
								String stu_id = result1.getString("StudentID");
								result1.close();
								result2.close();
								ps2.close();
								ps3.close();
								db.closeLocalConnection(conn);
								return (stu_id);
							}
						}
						
							ps1 = conn.prepareStatement("insert into studentcourse values(?, ?, ?, ?)");
							ps1.setInt(1, courseyear);
							ps1.setString(2, semester);
							ps1.setString(3, courseid);
							ps1.setString(4, studentid);							
							rs1 = ps1.executeUpdate();
							
							result1.close();
							result2.close();
							ps3.close();
							ps2.close();
							ps1.close( );
							db.closeLocalConnection(conn);
							return "Successfull";
						
						
					}
				}
				
				
					ps = conn.prepareStatement("insert into student(StudentID, StudentRollNo, StudentName, " +
							"YearofJoining, Privileges, DeptID, EmailID, MacAddress) values(?, ?, ?, ?, ?, ?, ?, ?)");
					ps.setString(1, studentid);
					ps.setString(2,	studrollno);
					ps.setString(3, studentname);
					ps.setInt(4, yoj);
					ps.setInt(5, privilege);
					ps.setString(6, deptid);
					ps.setString(7, email);
					ps.setString(8, mac);
				
					
					ps1 = conn.prepareStatement("insert into studentcourse values(?, ?, ?, ?)");
					ps1.setInt(1, courseyear);
					ps1.setString(2, semester);
					ps1.setString(3, courseid);
					ps1.setString(4, studentid);
					
								
					rs = ps.executeUpdate();
					rs1 = ps1.executeUpdate();
					
					result1.close( );
					result2.close( );
					ps.close( );
					ps1.close();
					ps3.close();
					ps2.close();
					db.closeLocalConnection(conn);
					return "Successfull";
				
			}
			db.closeLocalConnection(conn);
			return "Unsuccessfull";
		} catch (SQLException ex) {
		//	System.out.println("insert query exception: " + ex);
			return "0";
		}
		/*finally
		{
			try
			{
				ps.close( );
				ps1.close( );
				conn.close( );
			}
			catch(Exception e)
			{
				e.getStackTrace();
			}
		}*/
	}

	public String readStudentXLSFile(File xlsfile) {
		
		try {
			    ResultSet rs = null; 
	            ResultSet rs1 = null; 
	            int dcount=0;
	            int ccount=0;
	           			
				Workbook workbook = Workbook.getWorkbook(xlsfile);
				Sheet sheet;
				Cell xlsCell;
				Cell[] cell;
				String query = "";			
				sheet = workbook.getSheet(0);
				for (int i = 1; i < sheet.getRows(); i++) {
				String studentid = "";			
				cell = sheet.getRow(i);				
				xlsCell = sheet.getCell(0, i);
				studentid = xlsCell.getContents().toString();			
				if (studentid.equals("") || studentid == null) {
					return ("Student ID field entry with Sr.No." + i + " cannot be empty!");					
				}
				xlsCell = sheet.getCell(1, i);
				String studrollno = xlsCell.getContents().toString();
				if (studrollno.equals("")) {
					return ("Student Roll Number with Student ID " + studentid + " cannot be empty!");
				}				
				xlsCell = sheet.getCell(2, i);
				String studentname = xlsCell.getContents().toString();
				if (studentname.equals("")) {
					return ("Student Name with Student ID " + studentid + " cannot be empty!");
				}				
				xlsCell = sheet.getCell(3, i);
				String yearofjoining = xlsCell.getContents().toString();
				if (yearofjoining.equals("")) {
					return ("Please enter the Year of Joining of the student with ID " + studentid);
				}
				int yoj = Integer.parseInt(yearofjoining);				
				xlsCell = sheet.getCell(4, i);
				String privivalue = xlsCell.getContents().toString();								 
				if (privivalue.equals("")) {
					return ("Please enter the Privilege value for the student with ID " + studentid);
				}
				int privilege = Integer.parseInt(privivalue);				
				xlsCell = sheet.getCell(5, i);
				String deptid = xlsCell.getContents().toString().toUpperCase().trim();
				System.out.println("xls department id = " + deptid);
				if (deptid.equals("")) {
					return ("Please enter the Department ID for the student with ID " + studentid);
				}	
				
				 DatabaseConnection dbconn = new DatabaseConnection();
				Connection conn = dbconn.createDatabaseConnection();
				
				Statement st=null;
				String query1 ="SELECT DeptID FROM department where DeptID='"+deptid+"'";
			    st = conn.createStatement();
				rs = st.executeQuery(query1);	           
	            while (rs.next()) {					
						dcount++;						
				}   
	            if(dcount==0)
	            {
	            	dbconn.closeLocalConnection(conn);
	            	return("Department ID is wrong " + deptid + " for the student "+ studentid );
					//break;
				}	
	            dcount=0;	            
				xlsCell = sheet.getCell(6, i);
				String email = xlsCell.getContents().toString();
				if (email.equals("")) {
					email = "";
				}								
				xlsCell = sheet.getCell(7, i);
				String mac = xlsCell.getContents().toString();
				if (mac.equals("")) {
					mac = "";
				}				
				xlsCell = sheet.getCell(8, i);
				String year = xlsCell.getContents().toString();
				if (year.equals("")) {
					dbconn.closeLocalConnection(conn);
					return ("Please enter the year of course of the student with ID " + studentid);
				}
				int courseyear = Integer.parseInt(year);				
				xlsCell = sheet.getCell(9, i);
				String semester = xlsCell.getContents().toString();
				if (semester.equals("")) {
					dbconn.closeLocalConnection(conn);
					return ("Please enter the semester for the student with ID " + studentid);
				}				
				xlsCell = sheet.getCell(10, i);
				String courseid = xlsCell.getContents().toString().toUpperCase().trim();
				System.out.println("xls course id = " + courseid);				
				if (courseid.equals("")) {
					dbconn.closeLocalConnection(conn);
					return ("Please enter course id of the course for which the student " + studentid + " has enrolled in");
				}
				  Statement st1=null;
					String query2 ="SELECT CourseID FROM course where CourseID='"+courseid+"'";
				    st1 = conn.createStatement();
					rs1 = st1.executeQuery(query2);							
				    while (rs1.next()) {					
							ccount++;	
					} 		            
				    if(ccount==0)
				    {
				    	dbconn.closeLocalConnection(conn);
				    	return("Course id is wrong for the student " + studentid );
				    	//break;						
				    }
				    ccount=0;				
				    dbconn.closeLocalConnection(conn);
			        query = insertQuery(studentid, studrollno, studentname, yoj, privilege, deptid, email, mac,
					courseyear, semester, courseid);
			if(studentid.equals(query))
				return ("Student " + query + " is registered with the same course. Please enter different Course ID for the student");
			
			else if(query.equals("0"))
			return ("Wrong file Format");
			
			else if(query.equals("Unsuccessfull"))
				return ("The Course ID and/or Department ID entered for the student " + studentid + " does not exist. Please enter the correct course id or/and department id.");
		}
				
			return "Student information added successfully";	
			
	}
		catch (NumberFormatException ex) {
			System.out.print("Wrong privilege or year of joining value = " + ex);
			return "Wrong privilege or year of joining value";
		}
		catch (Exception exec) {
			System.out.print("Exception import = " + exec);
			exec.printStackTrace();
			return "Wrong File Format";
		}
		
				
	}

}