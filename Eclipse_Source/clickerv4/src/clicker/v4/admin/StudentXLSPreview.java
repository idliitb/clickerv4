/* Author : Gobianth M
 * Use :for seeing the preview of the student details from the xls file    
 *  
 */
package clicker.v4.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import java.sql.*;

import clicker.v4.databaseconn.*;

@SuppressWarnings("serial")
public class StudentXLSPreview extends HttpServlet {

	public String readstudentXLSFile(PrintWriter out, File xlsfile) {
		try {

			PreparedStatement pst = null;
			ResultSet rs = null;
			ResultSet rs1 = null;
			int dcount = 0;
			int ccount = 0;
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection conn = dbconn.createDatabaseConnection();
			Workbook workbook = Workbook.getWorkbook(xlsfile);
			Sheet sheet;
			Cell xlsCell;
			Cell[] cell;
			int selector = 0;
			sheet = workbook.getSheet(0);
			for (int i = 1; i < sheet.getRows(); i++) {
				String studentid = "";
				cell = sheet.getRow(i);

				xlsCell = sheet.getCell(0, i);
				studentid = xlsCell.getContents().toString().trim();
				System.out.println("xls student id = " + studentid);
				if (studentid.equals("")) {
					out.print("<p style='color: red'><b> Student ID with Sr. No."+ i + " cannot be null</b></p>");
					break;
				}

				xlsCell = sheet.getCell(1, i);
				String studrollno = xlsCell.getContents().toString().trim();
				if (studrollno.equals("")) {
					out.print("<p style='color: red'><b>Student Roll Number with Student ID "+ studentid + " cannot be empty!</b></p>");
					break;
				}

				xlsCell = sheet.getCell(2, i);
				String studentname = xlsCell.getContents().toString().trim();

				if (studentname.equals("")) {
					out.print("<p style='color: red'><b>Student Name with Student ID "+ studentid + " cannot be empty!</b></p>");
					break;
				}

				xlsCell = sheet.getCell(3, i);
				String yearofjoining = xlsCell.getContents().toString().trim();
				if (yearofjoining.equals("")) {
					out.print("<p style='color: red'><b>Please enter the Year of Joining of the student with ID "+ studentid + "</b></p>");
					break;
				}
				int yoj = Integer.parseInt(yearofjoining);

				xlsCell = sheet.getCell(4, i);
				String privivalue = xlsCell.getContents().toString().trim();

				if (privivalue.equals("")) {
					out.print("<p style='color: red'><b>Please enter the Privilege value for the student with ID "+ studentid + "</b></p>");
					break;
				}
				int privilege = Integer.parseInt(privivalue);

				xlsCell = sheet.getCell(5, i);
				String deptid = xlsCell.getContents().toString().trim()
						.toUpperCase();
				System.out.println("xls deptid = " + deptid);
				Statement st = null;
				String query1 = "SELECT DeptID FROM department where DeptID='"+ deptid + "'";
				st = conn.createStatement();
				rs = st.executeQuery(query1);
				while (rs.next()) {
					dcount++;
				}
				rs.close();
				if (dcount == 0) {
					out.print("<p style='color: red'><b>Department ID is wrong "+  deptid + " for the student "+ studentid + "</b></p>");
				}
				dcount = 0;
				if (deptid.equals("")) {
					out.print("<p style='color: red'><b>Please enter the Department ID for the student with ID "+ studentid + "</b></p>");
					break;
				}
				xlsCell = sheet.getCell(6, i);
				String email = xlsCell.getContents().toString().trim();
				xlsCell = sheet.getCell(7, i);
				String mac = xlsCell.getContents().toString().trim();
				xlsCell = sheet.getCell(8, i);
				String year = xlsCell.getContents().toString();
				if (year.equals("")) {
					out.print("<p style='color: red'><b>Please enter the year of course of the student with ID "+ studentid + "</b></p>");
					break;
				}
				int courseyear = Integer.parseInt(year);
				xlsCell = sheet.getCell(9, i);
				String semester = xlsCell.getContents().toString();
				if (semester.equals("")) {
					out.print("<p style='color: red'><b>Please enter the semester for the student with ID "+ studentid + "</b></p>");
					break;
				}
				xlsCell = sheet.getCell(10, i);
				String courseid = xlsCell.getContents().toString().trim()
						.toUpperCase();
				System.out.println("xls course id = " + courseid);

				Statement st1 = null;
				String query2 = "SELECT CourseID FROM course where CourseID='"+ courseid + "'";
				st1 = conn.createStatement();
				rs1 = st1.executeQuery(query2);
				while (rs1.next()) {
					ccount++;
				}
				if (ccount == 0) {
					out.print("<p style='color: red'><b>Course id is wrong for the student "+ studentid + " </b></p>");
				}
				ccount = 0;
				if (courseid.equals("")) {
					out.print("<p style='color: red'><b>Please enter course id of the course for which the student "+ studentid + " has enrolled in</b></p>");
					break;
				}

				if (selector == 0) {
					out.print("<table border = '1'><tr><th>Student ID</th> <th>Student Roll Number</th> <th>Student Name</th> <th>Year of Joining</th> "
							+ "<th>Privileges</th> <th>Department ID</th> <th>Email</th> <th>Mac</th> "
							+ "<th>CourseYear</th> <th>Semester</th> <th>Course ID</th> </tr>");
					selector = 1;
				}

				out.print("<tr><td>" + studentid + "</td><td>" + studrollno
						+ "</td><td>" + studentname + "</td><td>" + yoj
						+ "</td><td>" + privilege + "</td><td>" + deptid
						+ "</td><td>" + email + "</td><td>" + mac + "</td><td>"
						+ courseyear + "</td><td>" + semester + "</td><td>"
						+ courseid + "</td></tr>");

			}

			dbconn.closeLocalConnection(conn);
			out.print("</table>");

			return "Question uploaded  Successfully";

		} catch (NumberFormatException ex) {
			System.out.print("Wrong Credit value :" + ex);
			return "Wrong privilege or year of joining value";
		} catch (Exception exec) {
			System.out.print("Exception: " + exec);
			return "Wrong File Format";
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html");
		String url = request.getParameter("xls");
		ServletContext context = getServletContext();
		String pathurl = context.getRealPath("/uploads");
		File file = new File(pathurl + "/" + url);		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {			
			e.printStackTrace();
		}		
		readstudentXLSFile(out, file);
		out.close();
	}

}