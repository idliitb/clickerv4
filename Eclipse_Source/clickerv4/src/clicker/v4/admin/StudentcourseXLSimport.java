/* Author : Gobianth M
 * Use :for importing the student course data from the xls to database 
 *  
 */
package clicker.v4.admin;

import java.io.File;

import java.sql.*;

import clicker.v4.databaseconn.*;
import jxl.*;

public class StudentcourseXLSimport {

	@SuppressWarnings("null")
	public int insertQuery(String studentid, int courseyear, String semester,
			String courseid) {

		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		
		// int selector = 0, count1 = 0, count2 = 0;
		//PreparedStatement ps1 = null;
      //System.out.println("insert into studentcourse values("+courseyear+","+semester+","+courseid+","+studentid+")");
		try {
			Statement st =conn.createStatement();
			String strquerysc ="insert into studentcourse(Year,Semester,CourseID,StudentID) values('"+courseyear+"','"+semester+"','"+courseid+"','"+studentid+"') " ;
			
			int resultset1 =st.executeUpdate(strquerysc);
			
			if(resultset1!=0)
			{
				//System.out.println("Successful inserted into Instructor Course Only!!");
				
			}
			else
			{
				//System.out.println(" Not Successful!!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			//e.printStackTrace();
		}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}

		return 1;
	}

	public String readstudentCourseXLSfile(File xlsfile) {
		//System.out.println("========>readstudentCourseXLSfile   :"+xlsfile);
		
		try {

			Workbook workbook = Workbook.getWorkbook(xlsfile);
			Sheet sheet;
			Cell xlsCell;
			Cell[] cell;
			int query = 0;
			// Getting first sheet of xls
			sheet = workbook.getSheet(0);
			//System.out.println("In XLS Import: ");
			//System.out.println("Sheet name = " + sheet.getName());
			// i start from 1 because it will avoid first row in xls sheet that
			// is (Row 1)
			for (int i = 1; i < sheet.getRows(); i++) {
				String studentid = "";
				cell = sheet.getRow(i);
				xlsCell = sheet.getCell(0, i);
				studentid = xlsCell.getContents().toString();

				//System.out.println("xls student id = " + studentid);				

				xlsCell = sheet.getCell(1, i);
				String year = xlsCell.getContents().toString();
	
				int courseyear = Integer.parseInt(year);
				

				xlsCell = sheet.getCell(2, i);
				String semester = xlsCell.getContents().toString();
				

				xlsCell = sheet.getCell(3, i);
				String courseid = xlsCell.getContents().toString().toUpperCase();
                               
				//System.out.println("insert into studentcourse values("+courseyear+","+semester+","+courseid+","+studentid+")");
				query = insertQuery(studentid, courseyear, semester, courseid);
				
			}
			return "Student information added successfully";
		} catch (NumberFormatException ex) {
			System.out
					.print("Wrong privilege or year of joining value = " + ex);
			return "Wrong privilege or year of joining value";
		} catch (Exception exec) {
			System.out.print("Exception import = " + exec);
			exec.printStackTrace();
			return "Wrong File Format";
		}

	}

}
