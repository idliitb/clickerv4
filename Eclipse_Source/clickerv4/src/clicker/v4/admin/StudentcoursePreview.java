/* Author : Gobianth M
 * Use :for seeing the course preview of the student   
 *  
 */
package clicker.v4.admin;

import java.io.IOException;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import java.io.PrintWriter;
import java.io.File;

/**
 * Servlet implementation class StudentcoursePreview
 */
public class StudentcoursePreview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	public String readXLSFile(PrintWriter out, File xlsfile) {
		//System.out.println("Enter to the servelet");
		try {
			// PrintWriter out = new PrintWriter(xlsfile);
			System.out.println("XLS Preview Filename: " + xlsfile.getPath());
			Workbook workbook = Workbook.getWorkbook(xlsfile);
			// String sheetName[] = workbook.getSheetNames();
			Sheet sheet;
			Cell xlsCell;
			Cell[] cell;
			int selector = 0;
			// Getting first sheet of xls
			sheet = workbook.getSheet(0);

			// i starts from 1 because it will avoid first row in xls sheet that
			// is (Row 1)
			for (int i = 1; i < sheet.getRows(); i++) {
				String studentid = "";

				cell = sheet.getRow(i);

				xlsCell = sheet.getCell(0, i);
				studentid = xlsCell.getContents().toString();
				//System.out.println("xls student id = " + studentid);
				if (studentid.equals("")) {
					out.print("<p style='color: red'><b> Student ID with Sr. No."
							+ i + " cannot be null</b></p>");
					break;
				}

				

				xlsCell = sheet.getCell(1, i);
				String year = xlsCell.getContents().toString();
				if (year.equals("")) {
					out.print("<p style='color: red'><b>Please enter the year of course of the student with ID "
							+ studentid + "</b></p>");
					break;
				}
				int courseyear = Integer.parseInt(year);
			//	System.out.println("xls course year = " + courseyear);
				
				
				

				xlsCell = sheet.getCell(2, i);
				String semester = xlsCell.getContents().toString();
				if (semester.equals("")) {
					out.print("<p style='color: red'><b>Please enter the semester for the student with ID "
							+ studentid + "</b></p>");
					break;
				}

				
				
				xlsCell = sheet.getCell(3, i);
				String courseid = xlsCell.getContents().toString();
				//System.out.println("xls course id = " + courseid);
				if (courseid.equals("")) {
					out.print("<p style='color: red'><b>Please enter course id of the course for which the student "
							+ studentid + " has enrolled in</b></p>");
					break;
				}

				
				
				if (selector == 0) {
					out.print("<center><table style='border: solid 3px #7f7f7f;border-collapse:collapse;font-size:small;padding: 2px;border: solid 1px #7f7f7f;' border='1'><tr><th>Student ID</th> "
							
							+ "<th>CourseYear</th> <th>Semester</th> <th>Course ID</th> </tr>");
					selector = 1;
				}
				out.print("<tr><td>" + studentid + "</td><td>" +courseyear + "</td><td>" + semester + "</td><td>"
						+ courseid + "</td></tr>");

				
			}
			out.print("</table></center>");

			return "Question uploaded  Successfully";

		} catch (NumberFormatException ex) {
			//System.out.print("Wrong Credit value :" + ex);
			return "Wrong privilege or year of joining value";
		} catch (Exception exec) {
			System.out.print("Exception: " + exec);
			return "Wrong File Format";
		}
	}
	
	
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentcoursePreview() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		String url = request.getParameter("xls");
		ServletContext context = getServletContext();
		//System.out.println("Servlet config: " + context);
		String pathurl = context.getRealPath("/uploads");
		File file = new File(pathurl + "/" + url);
		System.out.println("Filename: " + file.getPath());
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// System.out.println("---------------------------- " +
		// getServletContext().getInitParameter("file"));
		readXLSFile(out, file);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}