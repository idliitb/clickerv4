package clicker.v4.report;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * Servlet implementation class DownloadXLS is to download the report in XLS file format
 */
public class RemoteDownloadXLS extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HSSFCellStyle boldStyle;	
	HSSFCellStyle textWrappStyle;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoteDownloadXLS() {
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
	
	// This method is adding the numeric value in the XLS sheet's cell
	private void addNumber(HSSFSheet sheet, int column, int row, int integer)
    {
    	HSSFCell cell = sheet.getRow(row).createCell(column);
    	cell.setCellValue(integer);
    	cell.setCellStyle(textWrappStyle);
    }
    
    /* This method is adding the number value in the XLS sheet's cell wiht bold style
    private void addBoldNumber(HSSFSheet sheet, int column, int row, int integer) 
    {
    	HSSFCell cell = sheet.getRow(row).createCell(column);
    	cell.setCellValue(integer);
    	cell.setCellStyle(boldStyle);
    }*/

	// This method is adding the string value to the XLS sheet's cell
    private void addLabel(HSSFSheet sheet, int column, int row, String s)
    {
    	HSSFCell cell = sheet.getRow(row).createCell(column);
    	cell.setCellValue(s);
    	cell.setCellStyle(textWrappStyle);
    }
    
    // This method is adding the numeric value with bold content in the XLS sheet's cell
    private void addBoldLabel(HSSFSheet sheet, int column, int row, String s)
    {
    	HSSFCell cell = sheet.getRow(row).createCell(column);
    	cell.setCellValue(s);
    	cell.setCellStyle(boldStyle);    	
    }  
    
    // This method create the new row in the sheet
    private void createRow(HSSFSheet sheet, int row)
    {
    	sheet.createRow(row);    	
    }
    
    // This method sets the column size for a specified cell 
    private void setColumnSize(HSSFSheet sheet, int column,int size)
    {
    	sheet.setColumnWidth(column,size);
    }  
    
    // This method sets the row size for a specified cell
    private void setRowSize(HSSFSheet sheet, int row, short size)
    {
    	sheet.getRow(row).setHeight(size);
    }
    
    // This method set the specified cell as formula generating cell
    private void addFormula(HSSFSheet sheet, int column, int row, String formulaString)
    {
    	HSSFCell cell = sheet.getRow(row).createCell(column);
    	cell.setCellFormula(formulaString);
    	cell.setCellStyle(boldStyle);
    }
    
    // This method is used to create the text style for the XLS page 
    private void createStyle(HSSFWorkbook wb){
    	HSSFFont font = wb.createFont();
    	font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	boldStyle = wb.createCellStyle();
    	textWrappStyle = wb.createCellStyle();
    	textWrappStyle.setWrapText(true);
    	boldStyle.setFont(font);
    	boldStyle.setWrapText(true);
    }
    
    /* This method is used to create the XLS page with proper report content based on 
	requests (quiz response or result, student list, quiz details, instant quiz response) */ 
    protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String reportname = request.getParameter("repname");
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=" + reportname + ".xls");
		DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createRemoteDatabaseConnection();   
        HSSFWorkbook wb = new HSSFWorkbook();		
        createStyle(wb);
        try {
			String wID = request.getParameter("cid");
			String reptype = request.getParameter("reptype");
			String pID = "";
			String QID = "";
			String QTS = "";
			String date = "", sn="";	
			String participantCount ="";
			if (reptype.equals("stud")) {
				pID = request.getParameter("sid");
				PreparedStatement pst = con.prepareStatement("select sq.ParticipantName, sq.ParticipantID, sq.WorkshopID, sq.QuizName, " +
						"sq.TimeStamp, sum(sq.Credit) as Total_marks, sum(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)" +
						" as NegativeMark, sum(sq.Credit * sq.correct) as Mark_Obtained, if(sum((sq.Credit * sq.correct)-(sq.NegativeMark * " +
						"(NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) / if(sum(sq.Credit)=0,1,sum(sq.Credit)) * 100 < 0,0.00," +
						"sum((sq.Credit * sq.correct)-(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) / " +
						"if(sum(sq.Credit)=0,1,sum(sq.Credit)) * 100) as Percentage from (select distinct q.WorkshopID,  q.QuizName, " +
						"qr.TimeStamp, qr.NegativeMarking, qrq.ParticipantID, if(qrq.Response='Z' or qrq.Response='',0,1) as isNoResponse, " +
						"p.ParticipantName, qst.QuestionID, qst.Credit, qst.NegativeMark, count(*), if((count(*) = sum(o.OptionCorrectness) " +
						"and count(*) in (SELECT count(*) FROM options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0)" +
						" as correct from quiz q, quizrecord qr, quizrecordquestion qrq, participant p, options o, question qst where " +
						"q.WorkshopID= ? and qr.QuizID = q.QuizID and qr.WorkshopID=? and qrq.QuizRecordID = qr.QuizRecordID " +
						"and qrq.ParticipantID=p.ParticipantID and qrq.ParticipantID=? and o.OptionID = qrq.OptionID and " +
						"qst.QuestionID = qrq.QuestionID group by p.ParticipantID, qst.QuestionID, qrq.QRTimeStamp) sq group by sq.TimeStamp " +
						"order by sq.TimeStamp desc");
				pst.setString(1, wID);
				pst.setString(2, wID);
				pst.setString(3, pID);
				ResultSet rs = pst.executeQuery();
				HSSFSheet sheet = wb.createSheet("Participant Report");
				createRow(sheet,0);
				setRowSize(sheet, 0, (short)400);
				addBoldLabel(sheet,0,0,"Participant Performance");
				sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
				addBoldLabel(sheet,3,0,"Clicker V4");
				sheet.addMergedRegion(new CellRangeAddress(0,0,3,4));
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				Date rdate = new Date();
				addBoldLabel(sheet,5,0,dateFormat.format(rdate));
				sheet.addMergedRegion(new CellRangeAddress(0,0,5,6));
				int i=2;
				if(rs.next()){
					createRow(sheet,i);
					addBoldLabel(sheet,3,i,"Participant ID");
					addLabel(sheet,5,i,rs.getString(2));
					i++;
					createRow(sheet, i);
					addBoldLabel(sheet,0,i,"Workshop ID");
					addLabel(sheet,1,i,rs.getString(3));
					addBoldLabel(sheet,3,i,"Participant Name");
					addLabel(sheet,5,i,rs.getString(1));
					i++;i++;
					createRow(sheet,i);
					i++;
					createRow(sheet,i);					
					addBoldLabel(sheet,0,i-1,"Quiz Name");
					addLabel(sheet,0,i,rs.getString(4));
					setColumnSize(sheet, 0, 25*250);
					addBoldLabel(sheet,1,i-1,"Time Stamp");
					addLabel(sheet,1,i,rs.getString(5));
					setColumnSize(sheet, 1, 20*250);
					int mark = rs.getInt(8);
					int neg = rs.getInt(7);
					int outof = rs.getInt(6);
					addBoldLabel(sheet,2,i-1,"Mark");
					addNumber(sheet,2,i,mark);
					addBoldLabel(sheet,3,i-1,"-ve Mark");
					addNumber(sheet,3,i,neg);
					addBoldLabel(sheet,4,i-1,"Obtain");
					addFormula(sheet,4,i,"C"+(i+1)+"-D"+(i+1));
					addBoldLabel(sheet,5,i-1,"Out of");
					addNumber(sheet,5,i,outof);
					addBoldLabel(sheet,6,i-1,"%");
					addFormula(sheet,6,i,"E"+(i+1)+"*100/F"+(i+1));
					sheet.addMergedRegion(new CellRangeAddress(2,2,3,4));
					sheet.addMergedRegion(new CellRangeAddress(3,3,3,4));					
					sheet.addMergedRegion(new CellRangeAddress(2,2,5,6));
					sheet.addMergedRegion(new CellRangeAddress(3,3,5,6));
					i++;
				}
				while(rs.next()){
					createRow(sheet, i);
					addLabel(sheet,0,i,rs.getString(4));
					addLabel(sheet,1,i,rs.getString(5));
					int mark = rs.getInt(8);
					int neg = rs.getInt(7);
					int outof = rs.getInt(6);
					addNumber(sheet,2,i,mark);
					addNumber(sheet,3,i,neg);
					addFormula(sheet,4,i,"C"+(i+1)+"-D"+(i+1));
					addNumber(sheet,5,i,outof);
					addFormula(sheet,6,i,"E"+(i+1)+"*100/F"+(i+1));
					//addBoldNumber(sheet,6,i,(mark-neg)*100/outof);
					i++;					
				}				
			} else if (reptype.equals("quiz")) {
				QID = request.getParameter("qid");
				QTS = request.getParameter("qts");
				if (reportname.indexOf("Response") != -1 || reportname.indexOf("Result") != -1) {					
					participantCount = request.getParameter("studCount");
					if(reportname.indexOf("Response") != -1){
						//hmapParam.put("SUBREPORT_DIR", path + "jasperreport/");
						PreparedStatement pst = con.prepareStatement("select q.WorkshopID, q.QuizName, qr.TimeStamp from quiz q, quizrecord qr " +
								"where q.WorkshopID= ? and qr.QuizID = q.QuizID and qr.QuizID = ? and qr.TimeStamp = ? and " +
								"qr.WorkshopID= q.WorkshopID");
						pst.setString(1, wID);
						pst.setString(2, QID);
						pst.setString(3, QTS);
						ResultSet rs = pst.executeQuery();
						if(rs.next()){
							System.out.println("QN -"+ rs.getString(2));
							HSSFSheet sheet = wb.createSheet("Quiz Response");
							createRow(sheet,0);
							setRowSize(sheet, 0, (short)400);
							addBoldLabel(sheet,0,0,"Quiz Response");
							setColumnSize(sheet, 0, 20*250);
							setColumnSize(sheet, 1, 20*250);
							sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
							addBoldLabel(sheet,3,0,"Clicker V4");
							setColumnSize(sheet, 2, 10*250);
							setColumnSize(sheet, 3, 20*250);
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
							Date rdate = new Date();
							addBoldLabel(sheet,4,0,dateFormat.format(rdate));
							setColumnSize(sheet, 4, 20*250);
							int i=2;
							createRow(sheet,i);
							addBoldLabel(sheet,0,i,"Workshop ID");
							addLabel(sheet,1,i,rs.getString(1));
							addBoldLabel(sheet,3,i,"Quiz Name");
							addLabel(sheet,4,i,rs.getString(2));
							i++;
							createRow(sheet, i);
							addBoldLabel(sheet,0,i,"Time Stamp");
							addLabel(sheet,1,i,rs.getString(3));
							addBoldLabel(sheet,3,i,"Total Student");
							addLabel(sheet,4,i,participantCount);
							String [] questionIDs = (String [])session.getAttribute("QuestionIDs");
							String [] ans = session.getAttribute("correctAns").toString().split("@");
							for(int j=0;j<questionIDs.length;j++){
								PreparedStatement pst1 = con.prepareStatement("Select sr.Question, sr.ParticipantID, sr.ParticipantName, " +
										"GROUP_CONCAT(sr.Response SEPARATOR '') as Response, GROUP_CONCAT(sr.OptionValue) as OptionValue, " +
										"if (GROUP_CONCAT(sr.Response SEPARATOR '') like 'Z', 'NoResponse',if (GROUP_CONCAT(sr.Response " +
										"SEPARATOR '') like ?, 'Correct', 'Wrong')) as OptionCorrectness, sr.TimeStamp  from " +
										"(select q.Question, qrq.ParticipantId, p.ParticipantName, qrq.Response, o.OptionValue, qr.TimeStamp " +
										"from question q, quizrecord qr, quizrecordquestion qrq, participant p, options o where qr.QuizID = ?" +
										" and qr.TimeStamp =  ? and qr.WorkshopID=  ? and qrq.QuizRecordID = qr.QuizRecordID and " +
										"qrq.QuestionID = ? and q.QuestionID = qrq.QuestionID and p.ParticipantID=qrq.ParticipantID " +
										"and o.OptionID = qrq.OptionID order by p.ParticipantID, qrq.Response) as sr group by sr.ParticipantID");
								pst1.setString(1, ans[j]);
								pst1.setString(2, QID);
								pst1.setString(3, QTS);
								pst1.setString(4, wID);
								pst1.setString(5, questionIDs[j]);
								ResultSet rs1 = pst1.executeQuery();
								if(rs1.next()){		
									i++;i++;
									createRow(sheet, i);
									addBoldLabel(sheet,0,i,rs1.getString(1));
									sheet.addMergedRegion(new CellRangeAddress(i,i,0,4));
									i++;
									createRow(sheet, i);
									addBoldLabel(sheet,0,i,"Participant ID");
									addBoldLabel(sheet,1,i,"Participant Name");
									addBoldLabel(sheet,2,i,"Response");
									addBoldLabel(sheet,3,i,"Response Value");
									addBoldLabel(sheet,4,i,"Correctness");
									i++;
									createRow(sheet, i);
									addLabel(sheet,0,i,rs1.getString(2));
									addLabel(sheet,1,i,rs1.getString(3));
									addLabel(sheet,2,i,rs1.getString(4));
									addLabel(sheet,3,i,rs1.getString(5));
									addLabel(sheet,4,i,rs1.getString(6));
								}
								while(rs1.next()){
									i++;
									createRow(sheet, i);
									addLabel(sheet,0,i,rs1.getString(2));
									addLabel(sheet,1,i,rs1.getString(3));
									addLabel(sheet,2,i,rs1.getString(4));
									addLabel(sheet,3,i,rs1.getString(5));
									addLabel(sheet,4,i,rs1.getString(6));
								}
							}
						}						
					}else{
						double topScore = Double.parseDouble(request.getParameter("topScore"));
						PreparedStatement pst = con.prepareStatement("select sq.WorkshopID, sq.QuizName, sq.TimeStamp, sq.ParticipantID, " +
								"sq.ParticipantName, sum(sq.Credit) as TotalMarks, sum(sq.Credit * sq.correct) as MarkObtained, " +
								"sum((NOT sq.correct) * sq.NegativeMark * sq.NegativeMarking * sq.isNoResponse) as NegativeMark, " +
								"if( (sum(sq.Credit * sq.correct) - sum((NOT sq.correct) * sq.NegativeMark * sq.NegativeMarking * sq.isNoResponse))" +
								" / sum(sq.Credit) * 100 < 0,0.00, (sum(sq.Credit * sq.correct) - sum((NOT sq.correct) * sq.NegativeMark * " +
								"sq.NegativeMarking * sq.isNoResponse)) / sum(sq.Credit) * 100) as Percentage, if((sum(sq.Credit * sq.correct) " +
								"/ sum(sq.Credit) * 100) / ? * 100 >=91,'A', if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) " +
								"/ ? * 100 >=71, 'B',if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / ? * 100 >=51," +
								"'C', if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / ? * 100 >=41,'D', 'F')))) as Grade " +
								"from (select q.WorkshopID, q.QuizName, qr.TimeStamp, qr.NegativeMarking, qrq.ParticipantID, if(qrq.Response='Z' " +
								"or qrq.Response='',0,1) as isNoResponse, p.ParticipantName, qst.QuestionID, qst.NegativeMark, qst.Credit, " +
								"o.OptionCorrectness, count(*), sum(o.OptionCorrectness), if((count(*) = sum(o.OptionCorrectness) and count(*) " +
								"in (SELECT count(*) FROM options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0) " +
								"as correct from quiz q, quizrecord qr, quizrecordquestion qrq, participant p, options o, question qst " +
								"where q.WorkshopID= ? and qr.QuizID = q.QuizID and qr.QuizID = ? and qr.TimeStamp = ? " +
								"and qr.WorkshopID = q.WorkshopID and qrq.QuizRecordID = qr.QuizRecordID and p.ParticipantID=qrq.ParticipantID  " +
								"and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID group by p.ParticipantID, qst.QuestionID " +
								"order by p.ParticipantID, qst.QuestionID) sq group by sq.ParticipantID order by MarkObtained desc");
						pst.setDouble(1, topScore);
						pst.setDouble(2, topScore);
						pst.setDouble(3, topScore);
						pst.setDouble(4, topScore);
						pst.setString(5, wID);
						pst.setString(6, QID);
						pst.setString(7, QTS);
						ResultSet rs = pst.executeQuery();
						HSSFSheet sheet = wb.createSheet("Quiz Result");
						createRow(sheet,0);
						setRowSize(sheet, 0, (short)400);
						addBoldLabel(sheet,0,0,"Quiz Result");
						sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
						addBoldLabel(sheet,3,0,"Clicker V4");
						sheet.addMergedRegion(new CellRangeAddress(0,0,3,4));
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						Date rdate = new Date();
						addBoldLabel(sheet,5,0,dateFormat.format(rdate));
						sheet.addMergedRegion(new CellRangeAddress(0,0,5,6));
						int i=2;
						if(rs.next()){
							createRow(sheet,i);
							addBoldLabel(sheet,3,i,"Quiz Name");
							addLabel(sheet,5,i,rs.getString(2));
							i++;
							createRow(sheet, i);
							addBoldLabel(sheet,0,i,"Workshop ID");
							addLabel(sheet,1,i,rs.getString(1));
							addBoldLabel(sheet,3,i,"TimeStamp");
							addLabel(sheet,5,i,rs.getString(3));
							i++;
							createRow(sheet, i);
							addBoldLabel(sheet,0,i,"No.of Participant");
							addLabel(sheet,1,i,participantCount);
							addBoldLabel(sheet,3,i,"Total Marks");
							addLabel(sheet,5,i,rs.getString(6));
							i++;i++;
							createRow(sheet,i);
							i++;
							createRow(sheet,i);					
							addBoldLabel(sheet,0,i-1,"Participant ID");
							addLabel(sheet,0,i,rs.getString(4));
							setColumnSize(sheet, 0, 25*250);
							addBoldLabel(sheet,1,i-1,"Participant Name");
							addLabel(sheet,1,i,rs.getString(5));
							setColumnSize(sheet, 1, 20*250);
							int mark = rs.getInt(7);
							int neg = rs.getInt(8);
							int outof = rs.getInt(6);
							addBoldLabel(sheet,2,i-1,"Mark");
							addNumber(sheet,2,i,mark);
							addBoldLabel(sheet,3,i-1,"-ve Mark");
							addNumber(sheet,3,i,neg);
							addBoldLabel(sheet,4,i-1,"Obtain");
							addFormula(sheet,4,i,"C"+(i+1)+"-D"+(i+1));
							addBoldLabel(sheet,5,i-1,"Out of");
							addNumber(sheet,5,i,outof);
							addBoldLabel(sheet,6,i-1,"%");
							addFormula(sheet,6,i,"E"+(i+1)+"*100/F"+(i+1));
							sheet.addMergedRegion(new CellRangeAddress(2,2,3,4));
							sheet.addMergedRegion(new CellRangeAddress(3,3,3,4));
							sheet.addMergedRegion(new CellRangeAddress(4,4,3,4));
							sheet.addMergedRegion(new CellRangeAddress(2,2,5,6));
							sheet.addMergedRegion(new CellRangeAddress(3,3,5,6));							
							i++;
						}
						while(rs.next()){
							createRow(sheet, i);
							addLabel(sheet,0,i,rs.getString(4));
							addLabel(sheet,1,i,rs.getString(5));
							int mark = rs.getInt(7);
							int neg = rs.getInt(8);
							int outof = rs.getInt(6);
							addNumber(sheet,2,i,mark);
							addNumber(sheet,3,i,neg);
							addFormula(sheet,4,i,"C"+(i+1)+"-D"+(i+1));
							addNumber(sheet,5,i,outof);
							addFormula(sheet,6,i,"E"+(i+1)+"*100/F"+(i+1));
							i++;					
						}
					}			
				} else if (reportname.indexOf("Detail") != -1) {
					PreparedStatement pst = con.prepareStatement("SELECT qz.QuizID, qz.QuizName, q.Question, q.Credit, if(q.QuestionType=1," +
							"'Single Correct',if(q.QuestionType=2,'Multiple Correct', if(q.QuestionType=3,'Numeric', 'True False'))) as " +
							"QuestionType, qz.WorkshopID FROM quizquestion qq, question q, quiz qz where qq.QuizID = ? and " +
							"qq.WorkshopID = ? and qz.QuizID = qq.QuizID and q.QuestionID = qq.QuestionID and qz.WorkshopID = qq.WorkshopID");
					pst.setString(1, QID);
					pst.setString(2, wID);
					ResultSet rs = pst.executeQuery();
					HSSFSheet sheet = wb.createSheet("Quiz Details");
					createRow(sheet,0);
					setRowSize(sheet, 0, (short)400);
					addBoldLabel(sheet,0,0,"Quiz Details");
					sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
					addBoldLabel(sheet,2,0,"Clicker V4");
					sheet.addMergedRegion(new CellRangeAddress(0,0,2,3));
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date rdate = new Date();
					addBoldLabel(sheet,4,0,dateFormat.format(rdate));
					sheet.addMergedRegion(new CellRangeAddress(0,0,4,5));
					int i=2;
					if(rs.next()){
						createRow(sheet,i);
						addBoldLabel(sheet,0,i,"Workshop ID");
						setColumnSize(sheet, 0, 20*250);
						addLabel(sheet,1,i,rs.getString(6));
						setColumnSize(sheet, 1, 20*250);						
						addBoldLabel(sheet,2,i,"Quiz Name");
						sheet.addMergedRegion(new CellRangeAddress(i,i,2,3));
						addLabel(sheet,4,i,rs.getString(2));
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));						
						i++;i++;
						createRow(sheet,i);
						i++;
						createRow(sheet,i);					
						addBoldLabel(sheet,0,i-1,"Question");
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,0,2));
						addLabel(sheet,0,i,rs.getString(3));
						sheet.addMergedRegion(new CellRangeAddress(i,i,0,2));
						addBoldLabel(sheet,3,i-1,"Credit");
						addLabel(sheet,3,i,rs.getString(4));
						addBoldLabel(sheet,4,i-1,"Quiz Type");
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,4,5));
						addLabel(sheet,4,i,rs.getString(5));
						setColumnSize(sheet, 4, 15*250);
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;
					}
					while(rs.next()){
						createRow(sheet,i);					
						addLabel(sheet,0,i,rs.getString(3));
						sheet.addMergedRegion(new CellRangeAddress(i,i,0,2));
						addLabel(sheet,3,i,rs.getString(4));
						addLabel(sheet,4,i,rs.getString(5));
						setColumnSize(sheet, 4, 15*250);
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;
					}
				}
			} else if (reptype.equals("course")) {
				if (reportname.indexOf("Attendance") != -1) {
					date = request.getParameter("date");
					sn = request.getParameter("session");
					String AttSummary = request.getParameter("AttSummary");
					PreparedStatement pst = con.prepareStatement("SELECT p.WorkshopID, p.ParticipantID, p.ParticipantName, if(ParticipantID in " +
							"(select ParticipantID from attendance where date(AttendanceTS) = ? and Session=? and WorkshopID = ?),'Present'," +
							"'Absent') as Attendance_Flag FROM participant p where WorkshopID = ? order by Attendance_Flag, p.ParticipantID");
					pst.setString(1, date);
					pst.setString(2, sn);
					pst.setString(3, wID);
					pst.setString(4, wID);
					ResultSet rs = pst.executeQuery();
					HSSFSheet sheet = wb.createSheet("Attendance");
					createRow(sheet,0);
					setRowSize(sheet, 0, (short)400);
					addBoldLabel(sheet,0,0,"Attendance");
					sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
					addBoldLabel(sheet,2,0,"Clicker V4");
					sheet.addMergedRegion(new CellRangeAddress(0,0,2,3));
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date rdate = new Date();
					addBoldLabel(sheet,4,0,dateFormat.format(rdate));
					sheet.addMergedRegion(new CellRangeAddress(0,0,4,5));
					int i=2;
					if(rs.next()){
						createRow(sheet,i);
						addBoldLabel(sheet,2,i,"Date & Session");
						sheet.addMergedRegion(new CellRangeAddress(i,i,2,3));
						addLabel(sheet,4,i,date + " "+sn);
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;
						createRow(sheet, i);
						addBoldLabel(sheet,0,i,"Workshop ID");
						addLabel(sheet,1,i,rs.getString(1));
						addBoldLabel(sheet,2,i,"Summary");
						sheet.addMergedRegion(new CellRangeAddress(i,i,2,3));
						addLabel(sheet,4,i,AttSummary);
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;i++;
						createRow(sheet,i);
						i++;
						createRow(sheet,i);					
						addBoldLabel(sheet,0,i-1,"Participant ID");
						addLabel(sheet,0,i,rs.getString(2));
						setColumnSize(sheet, 0, 20*250);
						addBoldLabel(sheet,1,i-1,"Participant Name");
						setColumnSize(sheet, 1, 25*250);
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,1,3));
						addLabel(sheet,1,i,rs.getString(3));
						sheet.addMergedRegion(new CellRangeAddress(i,i,1,3));
						//setColumnSize(sheet, 1, 20*250);
						addBoldLabel(sheet,4,i-1,"Status");
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,4,5));
						addLabel(sheet,4,i,rs.getString(4));
						setColumnSize(sheet, 1, 15*250);
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;
					}
					while(rs.next()){
						createRow(sheet,i);					
						addLabel(sheet,0,i,rs.getString(2));
						addLabel(sheet,1,i,rs.getString(3));
						sheet.addMergedRegion(new CellRangeAddress(i,i,1,3));
						addLabel(sheet,4,i,rs.getString(4));
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						i++;
					}
				} else if (reportname.equals("ParticipantList")) {
					participantCount = request.getParameter("StudCount");
					PreparedStatement pst = con.prepareStatement("SELECT ParticipantID, ParticipantName FROM participant " +
							"where WorkshopID = ? Order by ParticipantID");
					pst.setString(1, wID);
					ResultSet rs = pst.executeQuery();
					HSSFSheet sheet = wb.createSheet("Participant List");
					createRow(sheet,0);
					setRowSize(sheet, 0, (short)400);
					addBoldLabel(sheet,0,0,"Participant List");
					sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
					addBoldLabel(sheet,2,0,"Clicker V4");
					sheet.addMergedRegion(new CellRangeAddress(0,0,2,3));
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date rdate = new Date();
					addBoldLabel(sheet,4,0,dateFormat.format(rdate));
					sheet.addMergedRegion(new CellRangeAddress(0,0,4,6));
					int i=2;
					if(rs.next()){
						createRow(sheet,i);
						addBoldLabel(sheet,0,i,"Workshop ID");
						sheet.addMergedRegion(new CellRangeAddress(i,i,0,1));
						addLabel(sheet,2,i,wID);
						sheet.addMergedRegion(new CellRangeAddress(i,i,2,3));
						addBoldLabel(sheet,4,i,"No.of Participant");
						sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
						addLabel(sheet,6,i,participantCount);
						i++;i++;
						createRow(sheet,i);
						i++;
						createRow(sheet,i);					
						addBoldLabel(sheet,0,i-1,"Participant ID");
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,0,2));
						addLabel(sheet,0,i,rs.getString(1));
						sheet.addMergedRegion(new CellRangeAddress(i,i,0,2));
						addBoldLabel(sheet,3,i-1,"Participant Name");
						sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,3,6));
						addLabel(sheet,3,i,rs.getString(2));
						sheet.addMergedRegion(new CellRangeAddress(i,i,3,6));
						i++;
					}
					while(rs.next()){
						createRow(sheet,i);					
						addLabel(sheet,0,i,rs.getString(1));
						sheet.addMergedRegion(new CellRangeAddress(i,i,0,2));
						addLabel(sheet,3,i,rs.getString(2));
						sheet.addMergedRegion(new CellRangeAddress(i,i,3,6));
						i++;
					}
				}
			}else if (reptype.equals("InstantResponse")) {
					String InstrID = request.getParameter("InstrID");
					String iQID = request.getParameter("qid");
					QTS = request.getParameter("qts");
					participantCount = request.getParameter("studCount");
					System.out.println(wID + " " + InstrID + " " +QTS);
					PreparedStatement pst = con.prepareStatement("select WorkshopID, QuizDate from instantquiznew where WorkshopID = ? " +
							"and QuizDate = ?");
					pst.setString(1, wID);
					//pst.setString(2, InstrID);
					pst.setString(2, QTS);
					ResultSet rs = pst.executeQuery();
					if(rs.next()){
						System.out.println("QN -"+ rs.getString(2));
						HSSFSheet sheet = wb.createSheet("Instant Quiz Response");
						createRow(sheet,0);
						setRowSize(sheet, 0, (short)400);
						addBoldLabel(sheet,0,0,"Instant Quiz Response");
						setColumnSize(sheet, 0, 20*250);
						setColumnSize(sheet, 1, 20*250);
						sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
						addBoldLabel(sheet,2,0,"Clicker V4");
						setColumnSize(sheet, 2, 20*250);
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						Date rdate = new Date();
						addBoldLabel(sheet,3,0,dateFormat.format(rdate));
						setColumnSize(sheet, 3, 20*250);
						int i=2;
						createRow(sheet,i);
						addBoldLabel(sheet,2,i,"Time Stamp");
						addLabel(sheet,3,i,rs.getString(2));
						i++;
						createRow(sheet, i);
						addBoldLabel(sheet,0,i,"Workshop ID");
						addLabel(sheet,1,i,rs.getString(1));
						addBoldLabel(sheet,2,i,"No of Student");
						addLabel(sheet,3,i,participantCount);
						String [] questionIDs = (String [])session.getAttribute("QuestionIDs");
						for(int j=0;j<questionIDs.length;j++){
							PreparedStatement pst1 = con.prepareStatement("SELECT ir.ParticipantID, p.ParticipantName, ir.Response, if(i.IQuestionType = 1," +
									"'Single Correct Answer', if(i.IQuestionType = 2, 'Multiple Correct Answer', if(i.IQuestionType = 3, 'Numetic Answer'," +
									"'True or False'))) as Question, if(ir.Response = 'Z', 'No Response',if(ir.Response = i.CorrectAns,'Correct', 'Wrong')) " +
											"as Correctness FROM instantquestion i, instantquizresponsenew ir, participant p where i.IQuestionID = ? " +
											"and i.IQuizID = ? and ir.IQuestionID = i.IQuestionID and ir.IQuizID = i.IQuizID and" +
											" p.ParticipantID = ir.ParticipantID order by p.ParticipantID, ir.Response");
							pst1.setString(1, questionIDs[j]);
							pst1.setString(2, iQID);
							ResultSet rs1 = pst1.executeQuery();
							if(rs1.next()){		
								i++;i++;
								createRow(sheet, i);
								addBoldLabel(sheet,0,i,rs1.getString(4));
								sheet.addMergedRegion(new CellRangeAddress(i,i,0,4));
								i++;
								createRow(sheet, i);
								addBoldLabel(sheet,0,i,"Participant ID");
								addBoldLabel(sheet,1,i,"Participant Name");
								addBoldLabel(sheet,2,i,"Response");
								addBoldLabel(sheet,3,i,"Correctness");
								i++;
								createRow(sheet, i);
								addLabel(sheet,0,i,rs1.getString(1));
								addLabel(sheet,1,i,rs1.getString(2));
								addLabel(sheet,2,i,rs1.getString(3));
								addLabel(sheet,3,i,rs1.getString(5));
							}
							while(rs1.next()){
								i++;
								createRow(sheet, i);
								addLabel(sheet,0,i,rs1.getString(1));
								addLabel(sheet,1,i,rs1.getString(2));
								addLabel(sheet,2,i,rs1.getString(3));
								addLabel(sheet,3,i,rs1.getString(5));
							}
						}
					}
			}else if (reptype.equals("PollResponse")) {
				String pid = request.getParameter("pid");
				participantCount = request.getParameter("studCount");
				PreparedStatement pst = con.prepareStatement("select pq.WorkshopID, pq.TimeStamp, pq.Question, ps.ParticipantID, ps.ParticipantName," +
						" if(p.Response='1', 'Yes', if(p.Response='0','No','No Response')) as PResponse from poll p, pollquestion pq, participant ps" +
						" where pq.PollID = ? and p.PollID = pq.PollID and ps.ParticipantID = p.ParticipantID");
				pst.setString(1, pid);
				ResultSet rs = pst.executeQuery();
				HSSFSheet sheet = wb.createSheet("Poll Response");
				createRow(sheet,0);
				setRowSize(sheet, 0, (short)400);
				addBoldLabel(sheet,0,0,"Poll Response");
				sheet.addMergedRegion(new CellRangeAddress(0,0,0,1));
				addBoldLabel(sheet,2,0,"Clicker V4");
				sheet.addMergedRegion(new CellRangeAddress(0,0,2,3));
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				Date rdate = new Date();
				addBoldLabel(sheet,4,0,dateFormat.format(rdate));
				sheet.addMergedRegion(new CellRangeAddress(0,0,4,5));
				int i=2;
				if(rs.next()){
					createRow(sheet,i);
					addBoldLabel(sheet,0,i,"Workshop ID");
					setColumnSize(sheet, 0, 20*250);					
					addLabel(sheet,1,i,rs.getString(1));
					sheet.addMergedRegion(new CellRangeAddress(i,i,1,2));
					addBoldLabel(sheet,3,i,"Date");
					addLabel(sheet,4,i,rs.getString(2));
					sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
					i++;
					createRow(sheet, i);
					addBoldLabel(sheet,0,i,"No.of Student");
					addLabel(sheet,1,i,participantCount);
					i++;i++;
					createRow(sheet,i);									
					addBoldLabel(sheet,0,i,"Poll Question");
					addLabel(sheet,1,i,rs.getString(3));
					sheet.addMergedRegion(new CellRangeAddress(i,i,1,5));
					i++;
					createRow(sheet,i);	
					i++;
					createRow(sheet,i);	
					addBoldLabel(sheet,0,i-1,"Participant ID");
					addLabel(sheet,0,i,rs.getString(4));
					addBoldLabel(sheet,1,i-1,"Participant Name");
					sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,1,3));
					addLabel(sheet,1,i,rs.getString(5));
					sheet.addMergedRegion(new CellRangeAddress(i,i,1,3));
					addBoldLabel(sheet,4,i-1,"Response");
					sheet.addMergedRegion(new CellRangeAddress(i-1,i-1,4,5));
					addLabel(sheet,4,i,rs.getString(6));
					sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
					i++;
				}
				while(rs.next()){
					createRow(sheet,i);	
					addLabel(sheet,0,i,rs.getString(4));
					addLabel(sheet,1,i,rs.getString(5));
					sheet.addMergedRegion(new CellRangeAddress(i,i,1,3));
					addLabel(sheet,4,i,rs.getString(6));
					sheet.addMergedRegion(new CellRangeAddress(i,i,4,5));
					i++;
				}		
			}					
			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte [] outArray = outByteStream.toByteArray();
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();
			outStream.close();			
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			dbcon.closeRemoteConnection(con);
		}
	}
}