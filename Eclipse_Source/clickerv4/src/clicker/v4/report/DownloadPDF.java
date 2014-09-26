package clicker.v4.report;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;


/**
 * Servlet implementation class DownloadPDF
 */
//@WebServlet("/DownloadPDF")
/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * This file is used to download the jasper report as PDF
 */
public class DownloadPDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static JasperReport jasReport; // holds compiled jrxml file
	static JasperPrint jasPrint; // contains report after result filling process
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadPDF() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String reportname = request.getParameter("repname");
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=" + reportname + ".pdf");
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
        try {
			String Cid = request.getParameter("cid");
			String reptype = request.getParameter("reptype");
			String SID = "";
			String QID = "";
			String QTS = "";
			String date = "", sn="";	
			String studCount ="";
			String path = getServletContext().getRealPath("/");
			jasReport = JasperCompileManager.compileReport(path	+ "jasperreport/" + reportname + ".jrxml");
			HashMap<String, Object> hmapParam = new HashMap<String, Object>();
			if (reptype.equals("stud")) {
				SID = request.getParameter("sid");
				hmapParam.put("Cid", Cid);
				hmapParam.put("SID", SID);
				hmapParam.put("SUBREPORT_DIR", path + "jasperreport/");		
			} else if (reptype.equals("quiz")) {
				QID = request.getParameter("qid");
				QTS = request.getParameter("qts");
				if (reportname.indexOf("Response") != -1 || reportname.indexOf("Result") != -1) {					
					hmapParam.put("Cid", Cid);
					hmapParam.put("QID", QID);
					hmapParam.put("QTS", QTS);
					if(reportname.indexOf("Response") != -1){
						hmapParam.put("SUBREPORT_DIR", path + "jasperreport/");
					}else{
						double topScore = Double.parseDouble(request.getParameter("topScore"));
						hmapParam.put("topScore", topScore);
					}
					studCount = request.getParameter("studCount");
					hmapParam.put("studCount", studCount);			
				} else if (reportname.indexOf("Detail") != -1) {
					hmapParam.put("Cid", Cid);
					hmapParam.put("QID", QID);
				}
			} else if (reptype.equals("course")) {
				if (reportname.indexOf("Attendance") != -1) {
					date = request.getParameter("date");
					sn = request.getParameter("session");
					String AttSummary = request.getParameter("AttSummary");
					hmapParam.put("Cid", Cid);
					hmapParam.put("date", date);
					hmapParam.put("session", sn);
					hmapParam.put("AttSummary", AttSummary);
					hmapParam.put("SUBREPORT_DIR", path + "jasperreport/");					
				} else if (reportname.equals("StudentList")) {
					hmapParam.put("Cid", Cid);				
					hmapParam.put("StudCount", request.getParameter("StudCount"));
				}else if (reportname.equals("QuizSummary")) {
					hmapParam.put("Cid", Cid);				
					String NoofQuiz = request.getParameter("NoofQuiz");		
					hmapParam.put("NoofQuiz", NoofQuiz);
				}else if (reportname.equals("StudentQuery")) {
					hmapParam.put("Cid", Cid);				
					hmapParam.put("queryDate", request.getParameter("queryDate"));
				}else {
					hmapParam.put("Cid", Cid);
				}
			}else if (reptype.equals("instantquiz")) {
					QID = request.getParameter("QID");
					studCount = request.getParameter("studCount");
					hmapParam.put("QID", QID);
					hmapParam.put("studCount", studCount);
					hmapParam.put("SUBREPORT_DIR", path + "jasperreport/");					
			}
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			JRXlsxExporter exporter = new JRXlsxExporter();
	        exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasPrint);
	        exporter.setParameter(JRXlsExporterParameter.OUTPUT_FILE_NAME, "/home/rajavel/Desktop/test.xls");

	        exporter.exportReport();
			System.out.println("Jasper Print : " + jasPrint);
			ServletOutputStream sos = response.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasPrint, sos);
			sos.close();
			        
	        
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(con);
		}
	}

}
