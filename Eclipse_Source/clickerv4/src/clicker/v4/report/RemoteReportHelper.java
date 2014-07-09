package clicker.v4.report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.wrappers.QuizMark;
import clicker.v4.wrappers.QuizMarkList;
/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * This class act as report helper
 */
public class RemoteReportHelper {
	public QuizMarkList getQuizMarkList(String courseID, String studentID){
		QuizMarkList quizMarkList = new QuizMarkList();		
		ArrayList<QuizMark> quizMarks = new ArrayList<QuizMark>();
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		try{
			con = dbcon.createDatabaseConnection();
			st = con.createStatement();
			rs = st.executeQuery("select sq.StudentName, sq.StudentID, sq.CourseName, sq.CourseID, sq.DeptName, sq.QuizName, sq.TimeStamp, sum(sq.Credit) as Total_marks, sum(sq.Credit * sq.correct) - (sum(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) as Mark_Obtained, format(if((sum((sq.Credit * sq.correct)-(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) / sum(sq.Credit) * 100) < 0,0.00, sum((sq.Credit * sq.correct)-(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) / sum(sq.Credit) * 100),2) as Percentage from (select distinct q.CourseID, c.CourseName, d.DeptName, q.QuizName, qr.TimeStamp, qr.NegativeMarking, qrq.StudentID, if(qrq.Response='Z' or qrq.Response='',0,1) as isNoResponse, s.StudentName, qst.QuestionID, qst.Credit, qst.NegativeMark, count(*), if((count(*) = sum(o.OptionCorrectness) and count(*) in (SELECT count(*) FROM options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0) as correct from quiz q, quizrecord qr, quizrecordquestion qrq, student s, options o, question qst, course c, department d where q.CourseID= '"+courseID+"' and c.CourseID = q.CourseID and qr.QuizID = q.QuizID and qrq.QuizRecordID = qr.QuizRecordID and qrq.StudentID=s.StudentID and qrq.StudentID='"+studentID+"' and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID and d.DeptID = c.DeptID group by s.StudentID, qst.QuestionID, qrq.QRTimeStamp) sq group by sq.TimeStamp order by sq.TimeStamp desc");
			if(rs.next()){
				quizMarkList.setStudentID(rs.getString("StudentID"));
				quizMarkList.setStudentName(rs.getString("StudentName"));
				quizMarkList.setCourseID(rs.getString("CourseID"));
				quizMarkList.setCourseName(rs.getString("CourseName"));
				QuizMark quizMark = new QuizMark();
				quizMark.setQuizName(rs.getString("QuizName"));
				quizMark.setQuizTime(rs.getString("TimeStamp"));
				quizMark.setTotalMark(rs.getFloat("Total_marks"));
				quizMark.setMarkObtained(rs.getFloat("Mark_Obtained"));
				quizMark.setPercentage(rs.getFloat("Percentage"));
				quizMarks.add(quizMark);
			}
			while(rs.next()){
				QuizMark quizMark = new QuizMark();
				quizMark.setQuizName(rs.getString("QuizName"));
				quizMark.setQuizTime(rs.getString("TimeStamp"));
				quizMark.setTotalMark(rs.getFloat("Total_marks"));
				quizMark.setMarkObtained(rs.getFloat("Mark_Obtained"));
				quizMark.setPercentage(rs.getFloat("Percentage"));
				quizMarks.add(quizMark);
			}
			quizMarkList.setQuizMarks(quizMarks);
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(st!=null)st.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return quizMarkList;
	}
	
	public String getParticipantInfo(String id) {
		String studinfo = "";
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;     
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
            con = dbcon.createRemoteDatabaseConnection();
            pst = con.prepareStatement("SELECT ParticipantName, MacAddress FROM participant where ParticipantID = ?");
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                studinfo = rs.getString("ParticipantName") + "~" + rs.getString("MacAddress");
            }            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }
        return studinfo;
	}
	
	public String getParticipantIDs(String courseID){
		String ParticipantIDs= "";
		Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null; 
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            pst = con.prepareStatement("SELECT ParticipantID FROM participant where WorkshopID = ?");
            pst.setString(1, courseID);
            rs = pst.executeQuery();
            while (rs.next()) {					
            	ParticipantIDs += rs.getString("ParticipantID") + ",";		
			}            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }		
		return ParticipantIDs;
	}
	
	public String getCalendarDate(String WorkshopID, String Datefrom, String instructorID){
		String calendarDate = "";
		if(Datefrom.equals("quizCondectedDate")){
			calendarDate = getDates("SELECT distinct Date(qr.TimeStamp) as TimeStamp FROM quiz q, quizrecord qr, quizrecordquestion qrq where q.WorkshopID = '"+WorkshopID+"' and qr.QuizID = q.QuizID and qrq.QuizRecordID = qr.QuizRecordID group by qr.QuizRecordID order by qr.TimeStamp", "TimeStamp");
		}
		else if(Datefrom.equals("attendanceTakenDate")){
			calendarDate = getDates("SELECT distinct Date(AttendanceTS) as AttendanceTS FROM attendance where WorkshopID = '" +WorkshopID+ "' order by AttendanceTS", "AttendanceTS");
		}
		else if(Datefrom.equals("instantQuizCondectedDate")){
			calendarDate = getDates("SELECT distinct Date(i.QuizDate) as IQuizDate FROM instantquiznew i, instantquizresponsenew r where i.InstrID = '"+instructorID+"' and i.WorkshopID='"+WorkshopID+"' and r.IQuizID = i.IQuizID order by QuizDate", "IQuizDate");
		}else if(Datefrom.equals("pollCondectedDate")){
			calendarDate = getDates("SELECT distinct Date(pq.TimeStamp) as PollDate FROM pollquestion pq, poll p where pq.PollID = p.PollID and pq.WorkshopID ='"+WorkshopID+"'", "PollDate");
		}
		return calendarDate;
	}
	
	public String getDates(String query, String fieldName){
		String dates = "", startDate="", endDate = "";
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			
			con = dbcon.createRemoteDatabaseConnection();
			st = con.createStatement();
			rs = null;
			rs = st.executeQuery(query);
			boolean dateflag = false;
			while (rs.next()) {
				dateflag=true;
				String date = rs.getString(fieldName);			
				dates += date +",";				
			}
			if(!dateflag){
				java.util.Date dt = new java.util.Date();
				String sdf = new SimpleDateFormat("yyyy-MM-dd").format(dt);				
				startDate = sdf;
				endDate = sdf;				
			}else{
				if (rs.first()) {
					startDate = rs.getString(fieldName);						
				}
				if (rs.last()) {
					endDate = rs.getString(fieldName);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return dates +"@"+ startDate +"@"+endDate;
	}
	
	public String getQuizNames(String courseid, String date, String instructorID) {
        String selettquizname = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String queryquizname = "SELECT distinct q.QuizID, q.QuizName from quiz q, quizrecord qr where q.WorkshopID = '"+courseid+"' and qr.QuizID = q.QuizID  and date(qr.TimeStamp) = '"+date+"'";
            rs = st.executeQuery(queryquizname);
            selettquizname += "<select name='quiznameselect' id='quiznameselect' onchange='fillQuizTime(this.value)' style='margin-left: 10px; width: 145px'><option value= 'Quiz Name'>Quiz Name</option>";
            while (rs.next()) {
            	selettquizname += "<option value= " + rs.getString("QuizID") + ">" + rs.getString("QuizName").replace("<", "&lt;") + "</option>";                
            }
            selettquizname += "</select>";            
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}           
        }
        return selettquizname;
    }
	
	public String getQuizTime(String WID, String quizid, String date) {
        String qts = "";
        Connection con= null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String queryquizname = "select distinct qr.TimeStamp from quizrecord qr, quizrecordquestion qrq where qr.QuizID = '"+quizid+"' and qr.WorkshopID = '"+WID+"' and qrq.QuizRecordID = qr.QuizRecordID and date(TimeStamp) = '"+date+"' order by TimeStamp DESC";
            rs = st.executeQuery(queryquizname);
            qts = "<select name='quiztimeselect' id='quiztimeselect' onchange='setQuizTime()'><option value= 'Time Stamp'>Time Stamp</option>";
            while (rs.next()) {
                qts += "<option value= " + rs.getString("TimeStamp") + ">" + rs.getString("TimeStamp") + "</option>";                
            }
            qts += "</select>";            
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        }        
        return qts;        
    }
	
	public String getInstantQuizTime(String CID, String instrID, String date) {
        String qts = "";
        Connection con= null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String queryquizname = "SELECT distinct i.IQuizID, i.QuizDate from instantquiznew i, instantquizresponsenew r where WorkshopID = '"+CID+"' and InstrID = '"+instrID+"' and date(QuizDate) = '"+date+"' and r.IQuizID = i.IQuizID";
            rs = st.executeQuery(queryquizname);
            qts = "<select name='quiztimeselect' id='quiztimeselect' onchange='setInstantQuizTime()'><option value= 'Time Stamp'>Time Stamp</option>";
            while (rs.next()) {
                qts += "<option value= " + rs.getString("IQuizID") + ">" + rs.getString("QuizDate") + "</option>";                
            }
            qts += "</select>";            
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        }        
        return qts;        
    }
	
	public String getQuestionIDs(String qid, String wid){
		String questionIDs = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "SELECT QuestionID FROM quizquestion where QuizID = " +qid + " and WorkshopID='"+wid+"'";
            rs = st.executeQuery(query);
            while (rs.next()) {
            	questionIDs += rs.getString("QuestionID") + "@";
            }           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        } 
		return questionIDs;
	}
	
	public String getInstantQuestionIDs(String qid){
		String questionIDs = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "SELECT IQuestionID FROM instantquestion where IQuizID = " +qid;
            rs = st.executeQuery(query);
            while (rs.next()) {
            	questionIDs += rs.getString("IQuestionID") + "@";
            }           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        } 
		return questionIDs;
	}
	
	/**
	 * This is method is used to get the Quiz response for particular quiz
	 * @param qstnid Question id
	 * @param qid Quiz id
	 * @param qts Quiz Time stamp
	 * @return Student response of quiz
	 */
	public String getQuestionResponse(String qstnid, String qid, String qts){
		String response = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        Statement st1 = null;
        ResultSet rs1 = null;
        String correctAnswer = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "Select Sresponse.Response, count(*) as RCount from (select GROUP_CONCAT(qrq.Response SEPARATOR '') as Response, qrq.ParticipantID, q.QuestionType from quizrecord qr, quizrecordquestion qrq, options o, question q where qr.QuizID = '"+qid+"' and qr.TimeStamp = '"+qts+"' and qrq.QuizRecordID = qr.QuizRecordID and qrq.QuestionID = '"+qstnid+"' and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.ParticipantID order by qrq.Response) as Sresponse group by Response";
            //System.out.println(query);
            rs = st.executeQuery(query);
            st1 = con.createStatement();
            query = "SELECT o.OptionID, o.OptionCorrectness, o.OptionValue, q.QuestionType FROM options o, question q where o.QuestionID = "+qstnid+" and q.QuestionID = o.QuestionID order by o.OptionID";
            //System.out.println(query);
            rs1 = st1.executeQuery(query);
            int qtype = 0;
           if (rs1.first()) {
				qtype = Integer.parseInt(rs1.getString("QuestionType"));
				if (qtype == 3) {
					if (Integer.parseInt(rs1.getString("OptionCorrectness")) == 1) {
						correctAnswer = rs1.getString("OptionValue");
					}
				}
				else {
					int ASCII = 65;
					if (Integer.parseInt(rs1.getString("OptionCorrectness")) == 1) {
						correctAnswer += Character.toString((char) ASCII)+ ";";
					}
					while (rs1.next()) {
						ASCII++;
						if (Integer.parseInt(rs1.getString("OptionCorrectness")) == 1) {
							correctAnswer += Character.toString((char) ASCII) + ";";
						}
					}
				}				
			}
           if(qtype == 3 || qtype==2 ){
				String wrontResp = "Wrong";
				int wrontRespCount = 0;
				while (rs.next()) {
					String resp = rs.getString("Response");
					if(resp.equals(correctAnswer.replaceAll(";", ""))){
						response += resp + "=" + rs.getString("RCount") + ";";
					}else if("".equals(resp) || "Z".equals(resp)){
						response += "No Response" + "=" + rs.getString("RCount") + ";";
					}else{				
						wrontRespCount += Integer.parseInt(rs.getString("RCount"));
					}
				}
				response += wrontResp + "=" + wrontRespCount + ";";
			}else{
				while (rs.next()) {
	            	response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";            	
	            }
			}           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
        		 rs.close();
                 st.close();
                 rs1.close();
                 st1.close();
                 dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        } 
        System.out.println(response + "@" + correctAnswer);
        return response + "@" + correctAnswer;
	}
	
	
	public String getInstantQuestionResponse(int quizrecordid, String questionid){
		String response = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        Statement st1 = null;
        ResultSet rs1 = null;
        String correctAnswer = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "SELECT Response, count(*) as RCount FROM instantquizresponsenew where IQuizID = "+quizrecordid+" and IQuestionID = '"+questionid+"' group by Response";
            //System.out.println(query);
            rs = st.executeQuery(query);
            st1 = con.createStatement();
            query = "SELECT CorrectAns, IQuestionType FROM instantquestion where IQuizID = '"+quizrecordid+"' and IQuestionID = '"+questionid+"'";
            //System.out.println("QUERY: " + query);
            rs1 = st1.executeQuery(query);
            int qtype = 0;
			if (rs1.next()) {
				qtype = Integer.parseInt(rs1.getString("IQuestionType"));
				correctAnswer = rs1.getString("CorrectAns");
				if(qtype == 3 || qtype==2 ){
					String wrontResp = "Wrong";
					int wrontRespCount = 0;
					while (rs.next()) {
						String resp = rs.getString("Response");
						if(resp.equals(correctAnswer)){
							response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";
						}else if("".equals(resp) || "Z".equals(resp)){
							response += "No Response" + "=" + rs.getString("RCount") + ";";
						}else{				
							wrontRespCount += Integer.parseInt(rs.getString("RCount"));
						}
					}
					response += wrontResp + "=" + wrontRespCount + ";";
				}else if(qtype == 4){
					while (rs.next()) {
						String resp = rs.getString("Response");
						if(resp.equals("A")){resp="True";}
						else if(resp.equals("B")){resp="False";}
						if(correctAnswer.equals("A")){correctAnswer = "True";}
						else{correctAnswer = "False";}
		            	response += resp + "=" + rs.getString("RCount") + ";";           	
		            }
				}else{
					while (rs.next()) {
		            	response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";            	
		            }
				}
			}
			
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();                
        		if(st!=null)st.close();			
        		if(rs1!=null)rs1.close();
        		if(st1!=null)st1.close();
        		if(con!=null)dbcon.closeRemoteConnection(con);
            } catch (SQLException e) {
				e.printStackTrace();
			}
        }
        System.out.println(response + "@" + correctAnswer);
        return response + "@" + correctAnswer;
	}
	
	public String getPollResponse(String pid){
		Connection con = null;
        Statement st = null;
        ResultSet rs = null;      
        String response = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "Select if(Response='1', 'Yes', if(Response='0','No','No Response')) as PResponse, count(*) as RCount from poll where PollID = '"+pid+"' group by Response";
            rs = st.executeQuery(query);            
            while (rs.next()) {
	           	response += rs.getString("PResponse") + "=" + rs.getString("RCount") + ";"; 
	        }			           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
        		 rs.close();
                 st.close();                
                 dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        } 
        System.out.println(response + "@" + "Yes");
        return response + "@" + "Yes";
	}
	
	/**
	 * This method is used to get the result information for a quiz
	 * @param cid Course id
	 * @param qid Quiz id
	 * @param qts Quiz Time stamp
	 * @return Student result as percentage
	 */
	public String getQuizResult(String cid, String qid, String qts){
		String result = "";
		String grade = "";
		String grades = "";
		String topPrecentage = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            double topScore = 1.0;
            Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("select max(p.Percentage) as topScore from (select sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100 as Percentage from " +
					"(select qrq.ParticipantID, qst.Credit, if((count(*) = sum(o.OptionCorrectness) and count(*) in (SELECT count(*) FROM " +
					"options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0) as correct " +
					"from quiz q, quizrecord qr, quizrecordquestion qrq, participant pt, options o, question qst " +
					"where q.WorkshopID= '"+cid+"' and qr.QuizID = q.QuizID and qr.QuizID = "+qid+" and qr.TimeStamp = '"+qts+"' " +
					"and qrq.QuizRecordID = qr.QuizRecordID and pt.ParticipantID=qrq.ParticipantID  and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID " +
					"group by pt.ParticipantID, qst.QuestionID order by pt.ParticipantID, qst.QuestionID) sq group by sq.ParticipantID) p");
			if(rs1.next()){
				topPrecentage=rs1.getString("topScore");
				topScore = Double.parseDouble(rs1.getString("topScore"));
			}            
			
            st = con.createStatement();            
            String query = "select sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100 as Percentage, " +
            		"if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / "+topScore+" * 100 >=91,'A', " +
            		"if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / "+topScore+" * 100 >=71, 'B'," +
            		"if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / "+topScore+" * 100 >=51,'C', " +
            		"if((sum(sq.Credit * sq.correct) / sum(sq.Credit) * 100) / "+topScore+" * 100 >=41,'D', 'F')))) as Grade " +
            		"from (select pt.ParticipantID, qst.Credit, if((count(*) = sum(o.OptionCorrectness) and count(*) in " +
            		"(SELECT count(*) FROM options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0) as correct " +
            		"from quiz q, quizrecord qr, quizrecordquestion qrq, participant pt, options o, question qst " +
            		"where q.WorkshopID= '"+cid+"' and qr.QuizID = q.QuizID and qr.QuizID = "+qid+" and qr.TimeStamp = '"+qts+"'" +
            		"and qrq.QuizRecordID = qr.QuizRecordID and pt.ParticipantID=qrq.ParticipantID  and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID " +
            		" group by pt.ParticipantID, qst.QuestionID order by pt.ParticipantID, qst.QuestionID) sq group by sq.ParticipantID";
            //String query = "select round(sum(qst.Credit *o.OptionCorrectness) / sum(qst.Credit) * 100, 2) as Percentage from quiz q, quizrecord qr, quizrecordquestion qrq, student s, options o, question qst, course c where q.CourseID= '" +cid+ "' and c.CourseID = q.CourseID and qr.QuizID = q.QuizID and qr.QuizID = '" +qid+ "' and qr.TimeStamp = '" +qts+ "' and qrq.QuizRecordID = qr.QuizRecordID and s.StudentID=qrq.StudentID  and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID group by s.StudentID";
            System.out.println(query);
            rs = st.executeQuery(query);
            int p_below50 = 0;
            int p_50to70 = 0;
            int p_70to90 = 0;
            int p_above90 = 0;
            int grade_a = 0;
            int grade_b = 0;
            int grade_c = 0;
            int grade_d = 0;
            int grade_f = 0;
            float persentage;
            while (rs.next()) {
            	persentage = Float.parseFloat(rs.getString("Percentage"));
            	grade += rs.getString("Grade") +";";
            	System.out.println("Percentage :" +persentage);
            	if (persentage < 50){
            		p_below50++;
            	}
            	else if(persentage < 70){
            		p_50to70++;
            	}
            	else if(persentage < 90){
            		p_70to90++;
            	}
            	else if(persentage >= 90){
            		p_above90++;
            	}
            	
            	grade = rs.getString("Grade");
            	if (grade.equalsIgnoreCase("A")){
            		grade_a++;
            	}
            	else if(grade.equalsIgnoreCase("B")){
            		grade_b++;
            	}
            	else if(grade.equalsIgnoreCase("C")){
            		grade_c++;
            	}
            	else if(grade.equalsIgnoreCase("D")){
            		grade_d++;
            	}else if(grade.equalsIgnoreCase("F")){
            		grade_f++;
            		
            	}
            }
            result = "0 to 50=" +p_below50 + ";50 to 70=" + p_50to70 + ";70 to 90=" + p_70to90 + ";90 to 100=" + p_above90;
            grades = "A="+grade_a + ";B="+grade_b +";C="+grade_c +";D="+grade_d +";F="+grade_f ;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
       		 	rs.close();
                st.close();
                dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
       } 
        return result + "@" +grades +"@"+ topPrecentage;
	}
	
	/**
	 * This is method is used to get the student attendance detail for a course 
	 * @param cid Course id
	 * @param ats Attendance Time stamp
	 * @return Student Attendance details
	 */
	public String getAttendance(String cid, String date, String session){
		String attendance = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "select p.TotalCount-a.PresentCount as AbsentCount, a.PresentCount from (Select count(*) as TotalCount from participant where WorkshopID = '"+cid+"' ) as p, (SELECT count(*) as PresentCount FROM attendance where WorkshopID = '"+cid+"' and session = '"+session+"' and Date(AttendanceTS) = '"+date+"') as a";
            System.out.println(query);
            rs = st.executeQuery(query);
            int present = 0;
            int absent = 0;
            if (rs.next()) {
            	present = rs.getInt("PresentCount");
            	absent = rs.getInt("AbsentCount");            	   	
            }
            attendance = "Absent=" + absent + ";Present=" +present;
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
       		 	rs.close();
                st.close();
                dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
       } 
        return attendance;
	}
	
	public String getAttendanceInfo(String cid, String date){
		String attendance = "<select name='attendancetimestamp'	id='attendancetimestamp' onclick='attendanceReport(\""+cid+"\", \""+date+"\", this.value)'><option value=''>Time Stamp</option>";
		Connection con = null;
        Statement st = null;
        ResultSet rs = null;  
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String query = "SELECT distinct Session FROM attendance where WorkshopID = '"+cid+"' and Date(AttendanceTS) = '" +date+ "' order by AttendanceTS";
            //System.out.println(query);
            rs = st.executeQuery(query);
            while (rs.next()) {            	
            	 attendance += "<option value= " + rs.getString("Session") + ">" + rs.getString("Session") + "</option>";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
       		 	rs.close();
                st.close();
                dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
       } 
        return attendance + "</select>" ;
	}
	
	public String getPollTime(String CID, String date) {
        String qts = "";
        Connection con= null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            st = con.createStatement();
            String queryquizname = "SELECT distinct p.PollID, p.TimeStamp from pollquestion p, poll po where p.WorkshopID = '"+CID+"' and date(p.TimeStamp) = '"+date+"' and po.PollID = p.PollID";
            rs = st.executeQuery(queryquizname);
            qts = "<select name='polltimeselect' id='polltimeselect' onchange='setPollTime()'><option value= 'Time Stamp'>Time Stamp</option>";
            while (rs.next()) {
                qts += "<option value= " + rs.getString("PollID") + ">" + rs.getString("TimeStamp") + "</option>";                
            }
            qts += "</select>";            
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
        	try {
				rs.close();
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        }        
        return qts;        
    }
	
	public String getInstantResponse(String qid){
		Connection con = null;
        Statement st = null;
        ResultSet rs = null;      
        String response = "";
        String correctAnswer = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            st = con.createStatement();
            String query = "select r.Response, count(*) as RCount, i.CorrectAns from instantquiz i, instantquizresponse r where i.IQuizID = '"+qid+"' and r.IQuizID = i.IQuizID group by r.Response";
            //System.out.println(query);
            rs = st.executeQuery(query);            
            while (rs.next()) {
	           	response += rs.getString("Response") + "=" + rs.getString("RCount") + ";"; 
	           	correctAnswer = rs.getString("CorrectAns");
	        }			           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
        		 rs.close();
                 st.close();                
                 dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}           
        } 
        System.out.println(response + "@" + correctAnswer);
        return response + "@" + correctAnswer;
	}
	
	public String getReportDashboardData(String wid){
		Connection con = null;
        PreparedStatement st = null, st1=null, st2=null, st3=null, st4=null;
        ResultSet rs = null, rs1=null;      
        StringBuffer normalQuiz = new StringBuffer();
        StringBuffer instantQuiz = new StringBuffer();
        StringBuffer poll = new StringBuffer();
        StringBuffer studentquizparticipation = new StringBuffer();
        StringBuffer chartdata = new StringBuffer();
        DatabaseConnection dbcon = new DatabaseConnection();
        int noofquiz=0, pollid=0,totquizconducted=0;  
        String query="", tquery="";
        try {        	
            con = dbcon.createRemoteDatabaseConnection();
            query = "SELECT distinct q.QuizName, q.QuizID, qr.TimeStamp, qr.QuizRecordID FROM quiz q, quizrecord qr, quizrecordquestion qrq where q.WorkshopID=? and qr.QuizID = q.QuizID and qrq.QuizRecordID=qr.QuizRecordID order by QuizName, TimeStamp desc";            
            st = con.prepareStatement(query);
            st.setString(1, wid);             
            rs = st.executeQuery();            
            int quizid= 0;
            tquery = "select sum(obtain), sum(Credit) from (SELECT if(FIND_IN_SET('0',group_concat(o.OptionCorrectness))=0,1,0) * if(q.Credit=0,1,q.Credit) as obtain, if(q.Credit=0,1,q.Credit) as Credit FROM quizrecordquestion qrq inner join question q on q.QuestionID=qrq.QuestionID and qrq.QuizRecordID=? inner join options o on qrq.QuestionID = q.QuestionID and o.OptionID=qrq.OptionID group by qrq.QuestionID, qrq.ParticipantID order by qrq.QuestionID, qrq.ParticipantID) as sq";        	
            if(rs.next()){
            	quizid = rs.getInt(2);
            	normalQuiz.append("$#$" + rs.getString(1));
            	normalQuiz.append("~!~" + quizid);
            	normalQuiz.append("~!~" + rs.getString(3));
            	noofquiz++;
            	PreparedStatement tst = con.prepareStatement(tquery);
            	tst.setInt(1, rs.getInt(4));
            	ResultSet trs = tst.executeQuery();
            	if(trs.next()){
            		chartdata.append("~!~"+trs.getInt(1)*100/trs.getInt(2)); 
            	}
            	trs.close();
            	tst.close();
            }
            while (rs.next()) {
	           	if(rs.getInt(2)!=quizid){
	           		quizid = rs.getInt(2);
	           		normalQuiz.append("$#$" + rs.getString(1));
	            	normalQuiz.append("~!~" + quizid);
	           	}
	           	normalQuiz.append("~!~" + rs.getString(3));
	           	noofquiz++;
	           	PreparedStatement tst = con.prepareStatement(tquery);
            	tst.setInt(1, rs.getInt(4));
            	ResultSet trs = tst.executeQuery();
            	if(trs.next()){
            		chartdata.append("~!~" + trs.getInt(1)*100/trs.getInt(2)); 
            	}
            	trs.close();
            	tst.close();
	        }		
            totquizconducted=noofquiz;
            normalQuiz.insert(0, ""+noofquiz);
            chartdata.append("~@~");
            query = "SELECT distinct iq.IQuizID, iq.QuizDate FROM instantquiznew iq, instantquizresponsenew iqr where iq.WorkshopID=? and iqr.IQuizID = iq.IQuizID order by iq.QuizDate desc";            
            st1 = con.prepareStatement(query);
            st1.setString(1, wid);
            rs = st1.executeQuery();
            noofquiz=0;
            tquery = "select sum(obtain), sum(correct) from (SELECT if(r.Response= q.CorrectAns,1,0) as obtain, 1 as correct from instantquizresponsenew r inner join instantquiznew iq on iq.IQuizID = r.IQuizID and iq.IQuizID=? inner join instantquestion q on r.IQuizID = q.IQuizID and q.IQuestionID = r.IQuestionID) as sq";        	
            while (rs.next()) {
            	noofquiz++;
            	instantQuiz.append("$#$Instant Quiz "+noofquiz);
            	instantQuiz.append("~!~" + rs.getInt(1));
            	instantQuiz.append("~!~" + rs.getString(2));
            	PreparedStatement tst = con.prepareStatement(tquery);
            	tst.setInt(1, rs.getInt(1));
            	ResultSet trs = tst.executeQuery();
            	if(trs.next()){
            		chartdata.append("~!~" + trs.getInt(1)*100/trs.getInt(2)); 
            	}
            	trs.close();
            	tst.close();
            }
            totquizconducted+=noofquiz;
            instantQuiz.insert(0, ""+noofquiz);
            query = "SELECT p.ParticipantID, p.ParticipantName, count(distinct qrq.QuizRecordID) FROM quizrecordquestion qrq join quizrecord qr on qr.QuizRecordID = qrq.QuizRecordID and qr.QuizID in (select QuizID from quiz where WorkshopID=?) right outer join participant p on p.ParticipantID=qrq.ParticipantID where p.WorkshopID = ? group by p.ParticipantID";            
            st2 = con.prepareStatement(query);
            st2.setString(1, wid);
            st2.setString(2, wid);
            rs = st2.executeQuery();
            query = "select p.ParticipantID, count(distinct iqr.IQuizID) from instantquizresponsenew iqr join instantquiznew iq on iq.IQuizID=iqr.IQuizID and iq.WorkshopID=? right outer join participant p on p.ParticipantID = iqr.ParticipantID where p.WorkshopID=? group by p.ParticipantID";            
            st3 = con.prepareStatement(query);
            st3.setString(1, wid);
            st3.setString(2, wid);
            rs1 = st3.executeQuery();
            noofquiz=0;
            while (rs.next() && rs1.next()) {
            	noofquiz++;
            	studentquizparticipation.append("$#$"+rs.getString(1));
            	studentquizparticipation.append("~!~" + rs.getString(2));
            	studentquizparticipation.append("~!~No.of Normal Quiz : " + rs.getInt(3));
            	studentquizparticipation.append("~!~No.of Instant Quiz : " + rs1.getInt(2));
            	studentquizparticipation.append("~!~" + (rs1.getInt(2)+rs.getInt(3)));
            }
            studentquizparticipation.insert(0, ""+noofquiz+"@@"+totquizconducted);
            
            query = "SELECT pq.PollID, pq.Question, if(p.Response=1,'Yes',if(p.Response=0,'No','No Response')) as Response, Count(p.Response) as RCount, pq.TimeStamp FROM pollquestion pq, poll p where pq.WorkshopID=? and pq.PollID=p.PollID group by p.PollID, p.Response order by pq.TimeStamp Desc";            
            st4 = con.prepareStatement(query);
            st4.setString(1, wid);
            rs = st4.executeQuery();
            noofquiz=0;
            if(rs.next()){
           		pollid = rs.getInt(1);
           		poll.append("$#$" + rs.getString(2));
           		poll.append("~!~" + rs.getInt(1));
           		poll.append("~!~Date - " + rs.getString(5));
            	poll.append("~!~" + rs.getString(3) +" : "+rs.getInt(4));
            	noofquiz++;
           	}
            while (rs.next()) {
            	if(rs.getInt(1)!=pollid){
            		pollid = rs.getInt(1);
            		poll.append("$#$" + rs.getString(2));
            		poll.append("~!~" + rs.getInt(1));
            		poll.append("~!~Date - " + rs.getString(5));
	            	noofquiz++;
	           	}            	            	
            	poll.append("~!~" + rs.getString(3) +" : "+rs.getInt(4));
            }
            poll.insert(0, ""+noofquiz);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally{
        	try {
        		 if(rs!=null)rs.close();
                 if(st!=null)st.close();
                 if(st1!=null)st1.close();
                 if(st2!=null)st2.close();
                 if(rs1!=null)rs1.close();
                 if(st3!=null)st3.close();
                 if(st4!=null)st4.close();
                 dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
        }
        //System.out.println(chartdata + "~$~" +normalQuiz + "@#@" + instantQuiz + "@#@" + studentquizparticipation);
        return chartdata + "~$~" +normalQuiz + "@#@" + instantQuiz+ "@#@" + studentquizparticipation + "@#@" + poll;
	}
}
