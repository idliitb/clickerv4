package clicker.v4.report;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.DocumentException;

/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * Servlet implementation class RemoteHTMLtoPDF
 */
public class RemoteHTMLtoPDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoteHTMLtoPDF() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
   	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   	 */
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		// TODO Auto-generated method stub
   		doProcess(request, response);
   	}

   	/**
   	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   	 */
   	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		// TODO Auto-generated method stub
   		doProcess(request, response);
   	}
   	
   	protected void doProcess(HttpServletRequest request,	HttpServletResponse response) {
   		response.setContentType("application/pdf;");		
   		String path = getServletContext().getRealPath("/");
   		HttpSession session = request.getSession(true);		
   		ServletOutputStream sos = null;
   		try {
   			sos = response.getOutputStream();	
   			String reportType= request.getParameter("reportType");
   			String InstructorID = session.getAttribute("CoordinatorID").toString();
   			String reportContent = "";
   			if(reportType.equals("Response")){
   				response.setHeader("Content-Disposition", "attachment; filename=QuizResponse.pdf");
   				if (session.getAttribute("ReportContent") != null) {
   					reportContent = session.getAttribute("ReportContent").toString().replace("&nbsp", "");
   					reportContent = responseReplace(reportContent, sos, InstructorID, path);
   					//session.removeAttribute("ReportContent");
   				}
   			}
   			else if(reportType.equals("Result")){
   				response.setHeader("Content-Disposition", "attachment; filename=QuizResult.pdf");
   				if (session.getAttribute("QuizResultContent") != null) {
   					reportContent = session.getAttribute("QuizResultContent").toString().replace("&nbsp", "");
   					reportContent = resultReplace(reportContent, sos, InstructorID, path);
   					//session.removeAttribute("QuizResultContent");					
   				}
   			}else if(reportType.equals("InstantResponse")){
   				response.setHeader("Content-Disposition", "attachment; filename=InstantQuizResponse.pdf");
   				if (session.getAttribute("InstantReportContent") != null) {
   					reportContent = session.getAttribute("InstantReportContent").toString().replace("&nbsp", "");
   					reportContent = InstantResponseReplace(reportContent, sos, InstructorID, path);
   					//session.removeAttribute("ReportContent");
   				}
   			}else if(reportType.equals("PollResponse")){
				response.setHeader("Content-Disposition", "attachment; filename=PollResponse.pdf");
				if (session.getAttribute("PollReportContent") != null) {
					reportContent = session.getAttribute("PollReportContent").toString().replace("&nbsp", "");
					reportContent = pollResponseReplace(reportContent, sos, InstructorID, path);
					//session.removeAttribute("ReportContent");
				}
			}

   			// ITextRenderer is only works fine with compailed version of core-renderer.jar
   			ITextRenderer renderer = new ITextRenderer();
   			renderer.setDocumentFromString(reportContent);
   			renderer.layout();
   			try {
   				renderer.createPDF(sos);
   			} catch (DocumentException e) {
   				e.printStackTrace();
   			}
   			sos.close();			
   		} catch (IOException e) {
   			e.printStackTrace();
   		}
   	}
   	
   	public String responseReplace(String reportContent, ServletOutputStream sos, String InstructorID, String path) {
   		reportContent = reportContent.replace("<br>", "<br/>");
   		reportContent = reportContent.replace("../../","");
   		reportContent = reportContent.replace("<span>","</span>");
   		reportContent = reportContent.replace(InstructorID + "/", path + InstructorID + "/");
   		return reportContent;
   	}
   	public String InstantResponseReplace(String reportContent, ServletOutputStream sos, String InstructorID, String path) {
   		reportContent = reportContent.replace("<br>", "<br/>");
   		reportContent = reportContent.replace("../../","");
   		reportContent = reportContent.replace(InstructorID + "/", path + InstructorID + "/");
   		return reportContent;
   	}
   	
   	public String resultReplace(String reportContent, ServletOutputStream sos, String InstructorID, String path) {
   		reportContent = reportContent.replace("<br>", "<br/>");
   		reportContent = reportContent.replace("../../","");
   		reportContent = reportContent.replace("<span>","</span>");
   		reportContent = reportContent.replace(InstructorID + "/", path + InstructorID + "/");
   		return reportContent;
   	}
   	
   	public String pollResponseReplace(String reportContent, ServletOutputStream sos, String InstructorID, String path) {
		reportContent = reportContent.replace("<br>", "<br/>");
		reportContent = reportContent.replace("../../","");
		reportContent = reportContent.replace(InstructorID + "/", path + InstructorID + "/");
		return reportContent;
	}

}
