/* Author : Gobianth M
 * Use :for seeing the preview of the xls file   
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

@SuppressWarnings("serial")
public class ParticipantXLSPreview extends HttpServlet {
	 
	 public String readQuestionXLSFile(PrintWriter out, File xlsfile, String workshopid) {
	        try {
	        	//PrintWriter out = new PrintWriter(xlsfile);
	        	//System.out.println("XLS Preview Filename: " + xlsfile.getPath());
	            Workbook workbook = Workbook.getWorkbook(xlsfile);
	            //String sheetName[] = workbook.getSheetNames();
	            Sheet sheet;
	            Cell xlsCell;
	            Cell[] cell;
	            int selector = 0;
	            // Getting first sheet of xls
	            sheet = workbook.getSheet(0);
	            
	            // i starts from 1 because it will avoid first row in xls sheet that is (Row 1)
	            for (int i = 1; i < sheet.getRows(); i++) {
	            	String participantid = "";
					
					cell = sheet.getRow(i);
					
					xlsCell = sheet.getCell(0, i);
					participantid = xlsCell.getContents().toString();
					//System.out.println("xls participant id = " + participantid);
					if (participantid.equals("")) {
						out.print("<p style='color: red'><b> Participant ID with Sr. No." + i + " cannot be empty</b></p>");
						break;
					}

					xlsCell = sheet.getCell(1, i);
					String participantname = xlsCell.getContents().toString();
					if (participantname.equals("")) {
						out.print("<p style='color: red'><b>Name of the Participant with Participant ID " + participantid + " cannot be empty!</b></p>");
						break;
					}
																														
					if(selector == 0)
					{
						out.print("<table border = '1'><tr><th>Participant ID</th> <th>Participant Name</th> <th>Workshop ID</th></tr>");
						selector = 1;
					}
					out.print("<tr><td>" + participantid + "</td><td>" + participantname + "</td><td>" + workshopid + "</td></tr>");
					
					//System.out.println("--------------------------------");
	            }
	            out.print("</table>");
	            
	            return "Participant uploaded  Successfully";

	        } catch (NumberFormatException ex) {
	            System.out.print("Wrong Cener ID :" + ex);
	            return "Please enter Center ID in Integers only";
	        } catch (Exception exec) {
	            System.out.print("Exception: " + exec);
	            return "Wrong File Format";
	        }
	 }
	 protected void doGet(HttpServletRequest request,HttpServletResponse response){
		 response.setContentType("text/html");
		 String url = request.getParameter("xls");
		 String workshopid = request.getParameter("workshop");
		 ServletContext context = getServletContext();
		 //System.out.println("Servlet config: " + context);
		String pathurl = context.getRealPath("/uploads");
		
		File file = new File(pathurl + "/" + url);
		//System.out.println("Filename: " + file.getPath());
		 PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("---------------------------- " + getServletContext().getInitParameter("file"));
		 readQuestionXLSFile(out, file, workshopid);
		 out.close();
	 }
	    
}