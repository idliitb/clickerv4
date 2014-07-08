package clicker.v4.report;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clicker.v4.databaseconn.DatabaseConnection;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

/**
 * Servlet implementation class GeneratReport
 */
//@WebServlet("/Report")
/**
 * 
 * @author rajavel
 * This class is used to generate jasper report as HTML
 */
public class ReportGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static JasperReport jasReport; // holds compiled JRXML file
	static JasperPrint jasPrint; // contains report after result filling process
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportGenerator() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response){
    	response.setContentType("text/html;charset=UTF-8");
    	HttpSession session = request.getSession(true);
    	PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}		
		double topScore = 1.0;
		String courseID="";
    	if(request.getParameter("cid")!=null){
    		courseID=request.getParameter("cid");
    	}else{
    		courseID = session.getAttribute("courseID").toString();
    	}
		String instructorID = session.getAttribute("InstructorID").toString();
		String ReportType = request.getParameter("report");
		if (ReportType.equals("studreport")) {
			String studentID = request.getParameter("sid");
			String reportname = "StudentResultPercentage";
			String path = getServletContext().getRealPath("/");
			String htmlFile = "<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Student Performance</title></head><body>";
			htmlFile += "<div>";
			htmlFile += studentReport(courseID, studentID, reportname, path);
			htmlFile += "</div>";				
			out.println(htmlFile);;
		}else if (ReportType.equals("quizreport")) {
			String Cid = courseID;
			String QID = request.getParameter("qid");
			String QTS = request.getParameter("qts");
			String reportname = request.getParameter("reportname");
			String path = getServletContext().getRealPath("/");
			System.out.println(reportname);
			if (reportname.equals("QuizResponse")) {				
				if (session.getAttribute("QuestionIDs")!=null){
					String [] questionIDs = (String [])session.getAttribute("QuestionIDs");
					StringBuffer htmlFile = new StringBuffer("<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Quiz Response</title></head><body>");
					htmlFile.append("<div style='background-color:#fff;margin:auto; text-align:center;'>");
					htmlFile.append(quizReport(Cid, QID, QTS, "QuizResponseHeader", path, topScore));
					String tContent = "";
					String tImg = "";
					String correctAns[] = session.getAttribute("correctAns").toString().split("@");
					for(int i=0;i<questionIDs.length;i++){
						tContent = questionReport(questionIDs[i], QID, QTS, "QuestionResponse", path, correctAns[i]);
						tImg = "<div style='margin:auto;'><img align='middle' src='../../"+instructorID+"/Chart"+i+".jpeg?"+new Date().getTime()+"'></img></div><br/><br/><br/>";
						htmlFile.append(tImg + tContent);
					}
					htmlFile.append("</div></body></html>");
					session.setAttribute("ReportContent", htmlFile.toString());
					if(session.getAttribute("QuestionIDs")!=null){
						session.removeAttribute("QuestionIDs");
					}
					if(session.getAttribute("correctAns")!=null){
						session.removeAttribute("correctAns");
					}
					//System.out.println(htmlFile);
					out.println(htmlFile.toString());				
				}
			} else if (reportname.equals("QuizResult")) {
				if(session.getAttribute("topPercentage") != null){
					topScore = Double.parseDouble(session.getAttribute("topPercentage").toString());
					session.removeAttribute("topPercentage");
				}
				StringBuffer htmlFile = new StringBuffer("<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Quiz Result</title></head><body>");
				htmlFile.append("<div style='overflow:auto;text-align:center;background-color:#fff;'>");
				htmlFile.append("<img src='../../"+instructorID+"/QuizResult.jpeg?"+new Date().getTime()+"'></img> <br/> <br/>"	+ "<img src='../../"+instructorID+"/QuizGrade.jpeg?"+new Date().getTime()+"'></img>");
				htmlFile.append(quizReport(Cid, QID, QTS, reportname, path, topScore));
				htmlFile.append("</div></body></html>");			
				session.setAttribute("QuizResultContent", htmlFile);
				out.println(htmlFile);
			}else {
				out.println(quizReport(Cid, QID, QTS, reportname, path, topScore));
			}			
		}else if (ReportType.equals("corusereport")) {
			String date = request.getParameter("date");
			String sn = request.getParameter("session");
			String reportname = request.getParameter("reportname");
			String path = getServletContext().getRealPath("/");
			String queryDate = request.getParameter("date");
			if (reportname.equals("Attendance")) {
				String htmlFile = "<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Attendance</title></head><body>";
				htmlFile += "<div><img src='../../"+instructorID+"/Attendance.jpeg?"+new Date().getTime()+"' />" + "</div>";
				htmlFile += "<div>";
				htmlFile += courseReport(courseID, date, sn, reportname, queryDate, path);
				htmlFile += "</div>";
				out.println(htmlFile);
			}else{
			out.println(courseReport(courseID, date, sn, reportname, queryDate, path));
			}
		}else if (ReportType.equals("instantquizreport")) {
			System.out.println("InstantQuizReport");
			String QID = request.getParameter("qid");
			String path = getServletContext().getRealPath("/");
			//out.println(instantQuizReport(QID, path));		
			StringBuffer htmlFile = new StringBuffer("<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Instant Quiz Response</title></head><body>");
			htmlFile.append("<div style='background-color:#fff;margin:auto; text-align:center;'>");
			String tContent = "";
			String tImg = "";
			tContent = instantQuizReport(QID, path);
			tImg = "<div style='margin:auto;'><img align='middle' src='../../"+instructorID+"/InstantChart.jpeg?"+new Date().getTime()+"'></img></div><br/><br/><br/>";
			htmlFile.append(tImg + tContent);
			htmlFile.append("</div></body></html>");
			out.println(htmlFile);
		}else if (ReportType.equals("instantquizreportnew")) {
			String Cid = courseID;
			String QID = request.getParameter("qid");
			String QTS = request.getParameter("qts");			
			String path = getServletContext().getRealPath("/");
			if (session.getAttribute("QuestionIDs")!=null){
					String [] questionIDs = (String [])session.getAttribute("QuestionIDs");
					StringBuffer htmlFile = new StringBuffer("<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Quiz Response</title></head><body>");
					htmlFile.append("<div style='background-color:#fff;margin:auto; text-align:center;'>");
					htmlFile.append(instantQuizReport(Cid, instructorID, QTS, "InstantQuizResponseHeader", path, topScore));
					String tContent = "";
					String tImg = "";
					for(int i=0;i<questionIDs.length;i++){
						tContent = instantQuestionReport(questionIDs[i], QID, "InstantQuestionResponse", path);
						tImg = "<div style='margin:auto;'><img align='middle' src='../../"+instructorID+"/Chart"+i+".jpeg?"+new Date().getTime()+"'></img></div><br/><br/><br/>";
						htmlFile.append(tImg + tContent);
					}
					htmlFile.append("</div></body></html>");
					session.setAttribute("InstantReportContent", htmlFile.toString());
					if(session.getAttribute("QuestionIDs")!=null){
						session.removeAttribute("QuestionIDs");
					}
					//System.out.println(htmlFile);
					out.println(htmlFile.toString());				
				}
			}else if (ReportType.equals("pollreport")) {
				System.out.println("PollReport");
				String PID = request.getParameter("pid");
				String path = getServletContext().getRealPath("/");
				StringBuffer htmlFile = new StringBuffer("<html><head><META HTTP-EQUIV='CACHE-CONTROL' CONTENT='NO-CACHE'></META><title>Poll Response</title></head><body>");
				htmlFile.append("<div style='background-color:#fff;margin:auto; text-align:center;'>");
				String tContent = "";
				String tImg = "";
				tContent = pollReport(PID, path);
				tImg = "<div style='margin:auto;'><img align='middle' src='../../"+instructorID+"/PollChart.jpeg?"+new Date().getTime()+"'></img></div><br/><br/><br/>";
				htmlFile.append(tImg + tContent);
				htmlFile.append("</div></body></html>");
				session.setAttribute("PollReportContent", htmlFile.toString());			
				out.println(htmlFile);
			}
    }
    
    public String studentReport(String courseID, String studentID, String reportname, String path) {
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
		StringBuffer file = new StringBuffer();
		try {
			HashMap<String, String> hmapParam = new HashMap<String, String>();
			jasReport = JasperCompileManager.compileReport(path+ "jasperreport/" + reportname + ".jrxml");
			hmapParam.put("Cid", courseID);
			hmapParam.put("SID", studentID);
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			
			// Appending PDF download link in report
			try {
				file.append("<div style='float:right;'><a href='../../DownloadPDF?reptype=stud&cid="
						+ URLEncoder.encode(courseID,"UTF-8")
						+ "&sid="
						+ studentID
						+ "&repname=StudentResult_Chart"
						+ "' method='post' target='_blank'> <img src='../../img/pdfdownload.png'> </a></div>");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();

			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER, file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);

			// Export the report to StringBuffer file
			htmlExporter.exportReport();
		} catch (JRException e) {			
			e.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
    
    /**
	 * This method is used to generate the quiz report
	 * @param Cid Course id
	 * @param QID Quiz id
	 * @param QTS Quiz Time stamp when the quiz was conducted
	 * @param reportname Name of the jasper report
	 * @param path path of jasper report
	 * @return
	 */
	private String quizReport(String Cid, String QID, String QTS,
			String reportname, String path, double topScore) {
		// TODO Auto-generated method stub
		System.out.println("Inside quizreport");
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
		StringBuffer file = new StringBuffer();
		String studentCount ="";
		try {
			
			HashMap hmapParam = new HashMap();
			System.out.println(path + "jasperreport/" + reportname
					+ ".jrxml");
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/" + reportname + ".jrxml");
			if (reportname.equals("QuizResponseHeader")) {
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select count(distinct qrq.StudentID) as studCount from quiz q, quizrecord qr, quizrecordquestion qrq, student s, options o where q.CourseID= '"+Cid+"' and qr.QuizID = q.QuizID and qr.QuizID = '"+QID+"' and qr.TimeStamp = '"+QTS+"' and qrq.QuizRecordID = qr.QuizRecordID and s.StudentID=qrq.StudentID and o.OptionID = qrq.OptionID");
				if(rs.next()){
					studentCount = rs.getString("studCount");
				}
				hmapParam.put("Cid", Cid);
				hmapParam.put("QID", QID);
				hmapParam.put("QTS", QTS);
				hmapParam.put("studCount", studentCount);	
			}else if (reportname.equals("QuizResult")) {
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select count(distinct qrq.StudentID) as studCount from " +
						"quiz q, quizrecord qr, quizrecordquestion qrq, student s, options o " +
						"where q.CourseID= '"+Cid+"' and qr.QuizID = q.QuizID and qr.QuizID = '"+QID+"' and " +
								"qr.TimeStamp = '"+QTS+"' and qrq.QuizRecordID = qr.QuizRecordID and " +
										"s.StudentID=qrq.StudentID and o.OptionID = qrq.OptionID");
				if(rs.next()){
					studentCount = rs.getString("studCount");
				}				
				
				System.out.println(topScore);
				hmapParam.put("Cid", Cid);
				hmapParam.put("QID", QID);
				hmapParam.put("QTS", QTS);
				hmapParam.put("studCount", studentCount);	
				hmapParam.put("topScore", topScore);
				rs.close();
				st.close();
			}else if (reportname.equals("QuizDetail")) {
				hmapParam.put("Cid", Cid);
				hmapParam.put("QID", QID);
			} 
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			
			if(reportname.equals("QuizResponseHeader")){
				file.append("<div align=\"right\"><a href='../../HTMLtoPDF?reportType=Response'> <img src='../../img/pdfdownload.png'> </img> </a></div>");
			}else if(reportname.equals("QuizResult")){
				file.append("<div align=\"right\"><a href='../../HTMLtoPDF?reportType=Result'> <img src='../../img/pdfdownload.png'></img>  </a></div>");
			}else{
				// Appending PDF download link in report
				file.append("<div align=\"right\"><a href='../../DownloadPDF?reptype=quiz&cid="
						+ URLEncoder.encode(Cid,"UTF-8")
						+ "&qid="
						+ QID
						+ "&qts="
						+ QTS
						+ "&studCount="
						+ studentCount
						+ "&topScore="
						+ topScore
						+ "&repname="
						+ reportname
						+ "' method='post' target='_blank'><img src='../../img/pdfdownload.png'></img>  </a></div>");
			}
			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();
			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,	Boolean.FALSE);
			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,
					file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasPrint);
		
			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
			
			//Export to xls
			/*JasperPrint print = JasperFillManager.fillReport(jasReport, hmapParam, con);
	        ByteArrayOutputStream output = new ByteArrayOutputStream();
	        OutputStream outputfile= new FileOutputStream(new File("/home/rajavel/Desktop/JasperReport.xls"));
		
	       JRXlsExporter exporterXLS = new JRXlsExporter();
	         exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, print);
	         exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, output);
	         exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
	         exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
	         exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
	         exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
	         exporterXLS.exportReport();
	         outputfile.write(output.toByteArray()); */
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	private String instantQuizReport(String Cid, String InstrID, String QTS, String reportname, String path, double topScore) {
		// TODO Auto-generated method stub
		System.out.println("Inside instant quizreport header");
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
		StringBuffer file = new StringBuffer();
		String studentCount ="";
		try {
			
			HashMap hmapParam = new HashMap();
			System.out.println(path + "jasperreport/" + reportname
					+ ".jrxml");
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/" + reportname + ".jrxml");
			if (reportname.equals("InstantQuizResponseHeader")) {
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select count(distinct ir.StudentID) as studCount from instantquizresponsenew ir, instantquiznew iq where iq.CourseID = '"+Cid+"' and iq.InstrID = '"+InstrID+"' and iq.QuizDate = '"+QTS+"' and ir.IQuizID = iq.IQuizID ");
				if(rs.next()){
					studentCount = rs.getString("studCount");
				}
				hmapParam.put("Cid", Cid);
				hmapParam.put("InstrID", InstrID);
				hmapParam.put("QTS", QTS);
				hmapParam.put("studCount", studentCount);	
			}
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			file.append("<div align=\"right\"><a href='../../HTMLtoPDF?reportType=InstantResponse'> <img src='../../img/pdfdownload.png'> </img> </a></div>");
			
			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();
			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,	Boolean.FALSE);
			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,	file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);
		
			// Export the report to StringBuffer file
			htmlExporter.exportReport();
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	/**
	 * This method is used to generate the quiz report
	 * @param Cid Course id
	 * @param QID Quiz id
	 * @param QTS Quiz Time stamp when the quiz was conducted
	 * @param reportname Name of the jasper report
	 * @param path path of jasper report
	 * @return
	 */
	private String questionReport(String QstnID, String QID, String QTS, String reportname, String path, String ans) {
		// TODO Auto-generated method stub
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
		StringBuffer file = new StringBuffer();		
		try {
			
			HashMap<String, String> hmapParam = new HashMap<String, String>();
			System.out.println(path + "jasperreport/" + reportname
					+ ".jrxml");
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/" + reportname + ".jrxml");

			hmapParam.put("QstnID", QstnID);
			hmapParam.put("QID", QID);
			hmapParam.put("QTS", QTS);
			hmapParam.put("ans", ans.toUpperCase());
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			
			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();
			
			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,	Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,	file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);
			
			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	private String instantQuestionReport(String QstnID, String QID, String reportname, String path) {		// TODO Auto-generated method stub
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
		StringBuffer file = new StringBuffer();		
		try {
			
			HashMap<String, String> hmapParam = new HashMap<String, String>();
			System.out.println(path + "jasperreport/" + reportname
					+ ".jrxml");
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/" + reportname + ".jrxml");

			hmapParam.put("QstnID", QstnID);
			hmapParam.put("QID", QID);						
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			
			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();
			
			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,	Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,	file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);
			
			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	/** 
	 * 
	 * This method is used to generate the course jasper report 
	 * 
	 * @param Cid Course id
	 * @param ATS Attendance Time stamp
	 * @param reportname Report name
	 * @param path Path of jasper report
	 * @return
	 */
	public String courseReport(String Cid, String date, String sn, String reportname, String queryDate,
			String path) {
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
        String StudCount = "0";
        String AttSummary ="";
        String NoofQuiz ="";
        StringBuffer file = new StringBuffer();
		
		try {
			HashMap hmapParam = new HashMap();
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/" + reportname + ".jrxml");

			if (reportname.equals("Attendance")) {
				Statement st = con.createStatement();				
				ResultSet rs = st.executeQuery("select sc.TotalCount-a.PresentCount as AbsentCount, a.PresentCount from (Select count(*) as TotalCount from studentcourse where CourseID = '"+Cid+"' ) as sc, (SELECT count(*) as PresentCount FROM attendance where CourseID = '"+Cid+"' and Session = '"+sn+"' and Date(AttendanceTS) = '"+date+"') as a");				
				if(rs.next()){
					AttSummary += "Absent :" + rs.getString("AbsentCount") + " ";
					AttSummary += "Present :" + rs.getString("PresentCount") + " ";					
				}
				hmapParam.put("Cid", Cid);
				hmapParam.put("date", date);
				hmapParam.put("session", sn);
				hmapParam.put("AttSummary", AttSummary);
				reportname += "_Chart";
			} else if (reportname.equals("StudentList")) {
				hmapParam.put("Cid", Cid);				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("SELECT count(*) as NoofStudent FROM studentcourse sc, student s where sc.CourseID = '" + Cid + "' and s.StudentID = sc.StudentID");
				if(rs.next()){
					StudCount = rs.getString("NoofStudent");
				}
				hmapParam.put("StudCount", StudCount);
			}else if (reportname.equals("QuizSummary")) {
				hmapParam.put("Cid", Cid);				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("SELECT count(*) as quizCount FROM quiz q, quizrecord qr where q.CourseID= '"+Cid+"' and qr.QuizID = q.QuizID");
				if(rs.next()){
					NoofQuiz = rs.getString("quizCount");
				}
				hmapParam.put("NoofQuiz", NoofQuiz);				
			}else if (reportname.equals("StudentQuery")) {
				hmapParam.put("Cid", Cid);				
				hmapParam.put("queryDate", queryDate);
			}else {
				hmapParam.put("Cid", Cid);
			}
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			String data;
			BufferedReader fbr;
			// Appending PDF download link in report
			file.append("<div align=\"right\"><a href='../../DownloadPDF?reptype=course&cid="
					+ URLEncoder.encode(Cid,"UTF-8")
					+ "&date="
					+ date
					+ "&session="
					+ sn
					+ "&StudCount="
					+ StudCount
					+ "&AttSummary="
					+ AttSummary
					+ "&NoofQuiz="
					+ NoofQuiz
					+ "&queryDate="
					+ queryDate
					+ "&repname="
					+ reportname
					+ "' method='post' target='_blank'> <img src='../../img/pdfdownload.png'></img>  </a></div>");

			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();

			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,
					file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasPrint);

			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
		} catch (Exception ex) {
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}

	public String instantQuizReport(String QID, String path) {
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
        String StudCount = "0";
        StringBuffer file = new StringBuffer();
		try {
			HashMap hmapParam = new HashMap();
			jasReport = JasperCompileManager.compileReport(path
					+ "jasperreport/InstantQuizResponse.jrxml");

			hmapParam.put("QID", QID);				
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select count(*) as NoofStudent from instantquizresponse where IQuizID = '" + QID + "'");
			if(rs.next()){
				StudCount = rs.getString("NoofStudent");
			}
			hmapParam.put("studCount", StudCount);
			//hmapParam.put("SUBREPORT_DIR", path+"jasperreport/");
			System.out.println(path+"jasperreport/");
			System.out.println(hmapParam);
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			// Appending PDF download link in report
			file.append("<div align=\"right\"><a href='../../DownloadPDF?reptype=instantquiz&QID="
					+ QID
					+ "&studCount="
					+ StudCount
					+ "&SUBREPORT_DIR="
					+ path+"jasperreport/"
					+ "&repname=InstantQuizResponse_Chart"
					+ "' method='post' target='_blank'> <img src='../../img/pdfdownload.png'></img>  </a></div>");

			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();

			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,	file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);

			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
		} catch (Exception ex) {
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	public String pollReport(String PID, String path) {
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
        String StudCount = "0";
        StringBuffer file = new StringBuffer();
		try {
			HashMap hmapParam = new HashMap();
			jasReport = JasperCompileManager.compileReport(path+ "jasperreport/PollResponse.jrxml");
			hmapParam.put("PID", PID);				
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select count(*) as NoofStudent from poll where PollID = '" + PID + "'");
			if(rs.next()){
				StudCount = rs.getString("NoofStudent");
			}
			hmapParam.put("studCount", StudCount);
			System.out.println(path+"jasperreport/");
			System.out.println(hmapParam);
			jasPrint = JasperFillManager.fillReport(jasReport, hmapParam, con);
			// Appending PDF download link in report
			file.append("<div align=\"right\"><a href='../../HTMLtoPDF?reportType=PollResponse'> <img src='../../img/pdfdownload.png'> </img> </a></div>");
			
			// Create the instance for HTML Exporter
			JRExporter htmlExporter = new JRHtmlExporter();

			// Setup report no header, no footer, no images for layout
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_HEADER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.HTML_FOOTER, "");
			htmlExporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);

			// Set parameter of output string and jasper print
			htmlExporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER,	file);
			htmlExporter.setParameter(JRExporterParameter.JASPER_PRINT,	jasPrint);

			// Export the report to StringBuffer file
			htmlExporter.exportReport();			
		} catch (Exception ex) {
		}finally{
			dbcon.closeLocalConnection(con);
		}
		return file.toString();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

}
