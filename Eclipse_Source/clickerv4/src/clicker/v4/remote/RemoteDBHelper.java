/*
 * Author : Dipti, Rajavel
 * 
 * This class contain database query for remote center mode.
 */

package clicker.v4.remote;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import com.google.gson.Gson;

import clicker.v4.poll.Poll;
import clicker.v4.wrappers.Option;
import clicker.v4.wrappers.Question;
import clicker.v4.wrappers.Quiz;
import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;

public class RemoteDBHelper {
	Connection con=null;
	PreparedStatement st;
	PreparedStatement st1 =null, st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null;
	static private int pollid;
	
	public void setPollid(int i)
	{
		pollid=i;
	}
	
	public int getPollid()
	{
		return pollid;
	}
	
	public boolean checkWhetherStudent(String StudentID){
		String StudID=null;
		boolean Flag=false; 
		DatabaseConnection dbconn=new DatabaseConnection();
		try
		{
			
			con = dbconn.createDatabaseConnection();
			st = (PreparedStatement) con.prepareStatement("SELECT StudentID FROM student WHERE StudentID =?");
			st.setString(1,StudentID);
			ResultSet rs=st.executeQuery();	
			rs.next();
			StudID=rs.getString("StudentID");
			if(StudID!=null&&StudID.equals(StudentID)){
				Flag= true;	
			}else{
				Flag= false;
			}
		}
		catch (SQLException e) 
		{
			System.out.println("Not a Student, It is Participant");
		}
		finally{
			try {
				st.close();
				dbconn.closeLocalConnection(con);
			} catch (SQLException e) {
				System.out.println("Not a Student, It is Participant");
			}
		}
		return Flag;
	}


	public void insertRemoteQuizDetails(Quiz quiz,String WorkshopID) throws SQLException{		
		Connection conn = null;
		DatabaseConnection dbcon = new DatabaseConnection();	
		try{			
			conn = dbcon.createRemoteDatabaseConnection();
			String workshopid=WorkshopID;
			ArrayList<Question> ques=quiz.getquestions();
			int quizid = quiz.getQuizId();			
			ArrayList<Integer> notshufflequesno = new ArrayList<Integer>();
			notshufflequesno=quiz.getNotShuffle();			
			st6=conn.prepareStatement("select QuizID from quiz where WorkshopID='"+workshopid+"' and QuizID="+quizid);
			ResultSet rs1=st6.executeQuery();
			if(!rs1.next()){				
				st3 = conn.prepareStatement("INSERT INTO quiz (QuizID,Duration,WorkshopID,QuizName) VALUES (?,?,?,?)");
				st3.setInt(1,quizid);
				st3.setInt(2,Integer.parseInt(quiz.getQuizTime()));
				st3.setString(3,workshopid);
				st3.setString(4,workshopid+"_Quiz_"+quizid);
				st3.executeUpdate();		
				for(int i=0;i<ques.size();i++){
					Question question=ques.get(i);
					int typeofquestion=question.getType();
					String query = "select QuestionID from question where QuestionID = ? and WorkshopID=?";
					st7= conn.prepareStatement(query);
					st7.setInt(1, question.getId());
					st7.setString(2, workshopid);
					ResultSet rs = st7.executeQuery();
					int notshuffle=1;					
					if(!rs.next()){						
						for(int index=0;index<notshufflequesno.size();index++){
							String queryone = "select QuestionID from question where QuestionID = ? and WorkshopID=?";
							st9= conn.prepareStatement(queryone);
							st9.setInt(1, question.getId());
							st9.setString(2, workshopid);
							ResultSet rsone = st9.executeQuery();
							if(!rsone.next()){
							if(question.getId()==notshufflequesno.get(index)){
								notshuffle=0;
								st1 = conn.prepareStatement("Insert into question(QuestionID, Question,LevelOfDifficulty,Archived,Credit,QuestionType,WorkshopID,Shuffle) values(?,?,?,?,?,?,?,?)" );
								st1.setInt(1, question.getId());
								st1.setString(2,question.getText());
								st1.setInt(3,1);
								st1.setInt(4,0);
								st1.setFloat(5,2);
								st1.setInt(6,typeofquestion);
								st1.setString(7,workshopid);
								st1.setInt(8,notshuffle);
								st1.executeUpdate();
								
								
							}else{
								System.out.println("Question is already inserted");								
							}
							}
						}
						String queryone = "select QuestionID from question where QuestionID = ? and WorkshopID=?";
						st9= conn.prepareStatement(queryone);
						st9.setInt(1, question.getId());
						st9.setString(2, workshopid);
						ResultSet rstwo = st9.executeQuery();
						if(!rstwo.next()){
							notshuffle=1;
							st1 = conn.prepareStatement("Insert into question(QuestionID, Question,LevelOfDifficulty,Archived,Credit,QuestionType,WorkshopID,Shuffle) values(?,?,?,?,?,?,?,?)" );
							st1.setInt(1, question.getId());
							st1.setString(2,question.getText());
							st1.setInt(3,1);
							st1.setInt(4,0);
							st1.setFloat(5,2);
							st1.setInt(6,typeofquestion);
							st1.setString(7,workshopid);
							st1.setInt(8,notshuffle);
							st1.executeUpdate();
						}						
						st4= conn.prepareStatement("INSERT INTO quizquestion (QuizID,QuestionID,questionCredit,WorkshopID) VALUES (?,?,?,?)");
						st4.setInt(1,quizid);
						st4.setInt(2, question.getId());
						st4.setInt(3, 2);
						st4.setString(4,workshopid);
						st4.executeUpdate();

						char correctoption = 0;
						String correctans=question.getCorrectAns();
						ArrayList<Option> options=question.getOptions();
						for(int j=0;j<options.size();j++){
							Option option=options.get(j);
							int OptionCorrectness=0;
							if(question.getType()==3){
								OptionCorrectness=1;
								String optiontext=option.getOptiontext().replace("<", "&lt;");
								st2 = conn.prepareStatement("Insert into options(OptionID,OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID,WorkshopID) values(?,?,?,?,?,?,?,?)");
								st2.setInt(1, option.getOptionid());
								st2.setString(2,optiontext);
								st2.setInt(3,OptionCorrectness);
								st2.setInt(4,1);
								st2.setInt(5,0);
								st2.setFloat(6,2);
								st2.setInt(7,question.getId());
								st2.setString(8,workshopid);
								st2.executeUpdate();
							}
							else{
								for(int p=0;p<correctans.length();p++){
									correctoption=correctans.charAt(p);
									char correctvalue=(char)(j+1+64);
									if(correctoption==correctvalue){
										OptionCorrectness=1;
										String optiontext=option.getOptiontext().replace("<", "&lt;");
										st2 = conn.prepareStatement("Insert into options(OptionID,OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID,WorkshopID) values(?,?,?,?,?,?,?,?)");
										st2.setInt(1, option.getOptionid());
										st2.setString(2,optiontext);
										st2.setInt(3,OptionCorrectness);
										st2.setInt(4,1);
										st2.setInt(5,0);
										st2.setFloat(6,2);
										st2.setInt(7,question.getId());
										st2.setString(8,workshopid);
										st2.executeUpdate();
									}
								}
								String query1 = "select OptionID from options where OptionID=? and QuestionID = ? and WorkshopID=?";
								st8= conn.prepareStatement(query1);
								st8.setInt(1, option.getOptionid());
								st8.setInt(2, question.getId());
								st8.setString(3, workshopid);
								ResultSet optionrs = st8.executeQuery();
								if(!optionrs.next()){
									OptionCorrectness=0;
									String optiontext=option.getOptiontext().replace("<", "&lt;");
									st2 = conn.prepareStatement("Insert into options(OptionID,OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID,WorkshopID) values(?,?,?,?,?,?,?,?)");
									st2.setInt(1, option.getOptionid());
									st2.setString(2,optiontext);
									st2.setInt(3,OptionCorrectness);
									st2.setInt(4,1);
									st2.setInt(5,0);
									st2.setFloat(6,2);
									st2.setInt(7,question.getId());
									st2.setString(8,workshopid);
									st2.executeUpdate();
								}
								else{
									System.out.println("alreday present in option table");
								}
							}
							st5=conn.prepareStatement("INSERT INTO quizquestionoption (QuizID,QuestionID,OptionID,WorkshopID) VALUES (?,?,?,?)");
							st5.setInt(1,quizid);
							st5.setInt(2,question.getId());
							st5.setInt(3,option.getOptionid());
							st5.setString(4,workshopid);
							st5.executeUpdate();
						}				
					}else{
						System.out.println("Question already present in DB");
						st4= conn.prepareStatement("INSERT INTO quizquestion (QuizID,QuestionID,questionCredit,WorkshopID) VALUES (?,?,?,?)");
						st4.setInt(1,quizid);
						st4.setInt(2,rs.getInt("QuestionID"));
						st4.setInt(3, 2);
						st4.setString(4,workshopid);
						st4.executeUpdate();
						ArrayList<Option> options=question.getOptions();
						for(int j=0;j<options.size();j++){
							Option option=options.get(j);
							st5=conn.prepareStatement("INSERT INTO quizquestionoption (QuizID,QuestionID,OptionID,WorkshopID) VALUES (?,?,?,?)");
							st5.setInt(1,quizid);
							st5.setInt(2,question.getId());
							st5.setInt(3,option.getOptionid());
							st5.setString(4,workshopid);
							st5.executeUpdate();
						}
					}								
				}
			}else{
				System.out.println("Quiz is already inserted");
			}			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				if(st1!=null)st1.close();
				if(st2!=null)st2.close();
				if(st3!=null)st3.close();
				if(st4!=null)st4.close();
				if(st5!=null)st5.close();
				if(st6!=null)st6.close();
				if(st7!=null)st7.close();
				if(st8!=null)st8.close();
				if(st9!=null)st9.close();
				if(conn!=null)dbcon.closeRemoteConnection(conn);
			}catch(SQLException e){
				System.out.println("Error in closing statement and connection");
			}
		}
	}

	public void insertRemoteInstantQuizDetails(Quiz quiz,String WorkshopID, String coordinatorID) throws SQLException{
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createRemoteDatabaseConnection();		
		int mcquizid = quiz.getQuizId();
		PreparedStatement pstSelect=null, pstmt=null, pstmt1=null;
		ResultSet rsSelect=null, rs=null;
		try {
			String sql = "Select IQuizID from instantquiznew where MCQuizID=? and WorkshopID=?";
			pstSelect= con.prepareStatement(sql);
			pstSelect.setInt(1, mcquizid);
			pstSelect.setString(2, WorkshopID);
			rsSelect = pstSelect.executeQuery();
			if(!rsSelect.next()){
				int iquizid = 0;
				sql = "insert into instantquiznew(DurationSec, WorkshopID, InstrID, MCQuizID) values (?,?,?,?)";			
				pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1,Integer.parseInt(quiz.getQuizTime()));
				pstmt.setString(2, quiz.getcourseId());
				pstmt.setString(3, coordinatorID);
				pstmt.setInt(4,mcquizid);			
				pstmt.executeUpdate();			
				rs = pstmt.getGeneratedKeys();
				if (rs != null && rs.next()) {
					iquizid = rs.getInt(1);
				}
				ArrayList<Question> questionList = new ArrayList<Question>();	
				questionList = quiz.getquestions();
				for(int i=0;i<questionList.size();i++){
					Question question = new Question();
					question = questionList.get(i);
					int qtype=question.getType();
					int noofoptions = question.getOptions().size();
					String ans = question.getCorrectAns();
					sql = "insert into instantquestion(IQuestionID, IQuestionType, NoofOptions, CorrectAns, IQuizID) values (?,?,?,?,?)";
					pstmt1 = con.prepareStatement(sql);
					pstmt1.setInt(1,question.getId());
					pstmt1.setInt(2,qtype);
					pstmt1.setInt(3, noofoptions);
					pstmt1.setString(4, ans);		
					pstmt1.setInt(5, iquizid);
					pstmt1.executeUpdate();					
				}
				Global.workshopjsonobject.put(WorkshopID, quiz);
				Global.remotecountrequestjson.put(WorkshopID,"0");
				Global.remotequizrecordids.put(WorkshopID, iquizid);
				Global.remotemcquizrecordids.put(WorkshopID, mcquizid);	
				Global.remotecountresponsejson.put(WorkshopID, 0);	
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{			
			if(rsSelect!=null){rsSelect.close();}
			if(rs!=null){rs.close();}
			if(pstmt1!=null){pstmt1.close();}
			if(pstmt!=null){pstmt.close();}
			if(pstSelect!=null){pstSelect.close();}
			if(con!=null){dbconn.closeRemoteConnection(con);}
		}		
	}


	public int setRemoteQuizLaunchTime(String workshopID, int sec, int mcquizrecordid) throws SQLException{
		int quizrecordid =0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createRemoteDatabaseConnection();
		PreparedStatement pstSelect=null, pstmt=null;
		ResultSet rsSelect=null, rs=null;
		Quiz quiz = new Quiz();	
		String sql ="Select QuizRecordID from quizrecord where MCQuizRecordID=? and WorkshopID=?";
		try {
			pstSelect = con.prepareStatement(sql);
			pstSelect.setInt(1, mcquizrecordid);
			pstSelect.setString(2, workshopID);
			rsSelect = pstSelect.executeQuery();
			if(!rsSelect.next()){
				quiz = Global.workshopjsonobject.get(workshopID);
				System.out.println("Quiz ID from object : "+quiz.getQuizId());
				sql = "insert into quizrecord(QuizID,WorkshopID, MCQuizRecordID) values (?,?,?)";
				pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1,quiz.getQuizId());
				pstmt.setString(2, workshopID);
				pstmt.setInt(3, mcquizrecordid);
				pstmt.executeUpdate();
				rs = pstmt.getGeneratedKeys();
				if (rs != null && rs.next()) {
					quizrecordid = rs.getInt(1);
				}
				Calendar cal = Calendar.getInstance();
				String currenttime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
				quiz.setcurrenttime(currenttime);
				quiz.setlaunchtime(currenttime);
				quiz.setQuizTime(""+sec);
				quiz.setQuizrecordId(quizrecordid);
				Gson gson = new Gson();
				System.out.println(gson.toJson(quiz));
				Global.workshopjsonobject.put(workshopID, quiz);
				Global.remotecountrequestjson.put(workshopID,"0");
				Global.remotequizrecordids.put(workshopID, quizrecordid);
				Global.remotemcquizrecordids.put(workshopID, mcquizrecordid);
				Global.remotecountresponsejson.put(workshopID, 0);	
				Global.responsereceivedparticipants.put(workshopID, "");
			}else{
				quizrecordid=rsSelect.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rsSelect!=null){rsSelect.close();}
			if(rs!=null){rs.close();}
			if(pstmt!=null){pstmt.close();}
			if(pstSelect!=null){pstSelect.close();}
			dbconn.closeRemoteConnection(con);
		}		
		return quizrecordid;
	}

	//remotepollsaving
	public void insertRemotePollDetails(Poll poll,String WorkshopID,String timestamp) throws SQLException{
		Connection conn = null;
		DatabaseConnection dbcon = new DatabaseConnection();	
		try{			
			conn = dbcon.createRemoteDatabaseConnection();
			//String workshopid=WorkshopID;
			String pollquestion = poll.getpollquestion();
			st1 = conn.prepareStatement("INSERT INTO pollquestion (Question,WorkshopID,TimeStamp) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS );
			st1.setString(1,pollquestion);
			st1.setString(2,WorkshopID);
			st1.setString(3,timestamp);
			st1.executeUpdate();
			ResultSet rs=st1.getGeneratedKeys();
			if (rs.next()) {
				setPollid(rs.getInt(1));

			} else {
				throw new RuntimeException("PIB, can't find most recent insert we just entered");
			}
		}catch(Exception e){
			System.out.println("prblem in Inserting poll question and timings from Json");
		}finally{
			try{
				try{if(st1!=null){st1.close();}}catch(SQLException ex){}
				dbcon.closeRemoteConnection(conn);
			}catch(Exception e){
				System.out.println("Error in closing statement");
			}
		}

	}

	
	public int getpollidnew(String launchtime, String workshopid) throws SQLException
	{
		System.out.println("//////////////////////////pollidnew launchtime is : "+launchtime);
			int pollidnew = 0;
			Connection conn = null;
			DatabaseConnection dbcon = new DatabaseConnection();
			conn=dbcon.createRemoteDatabaseConnection();
			try{
				String selectpollquery="select PollID from pollquestion where WorkshopID=? and TimeStamp=?";
				st1 = conn.prepareStatement(selectpollquery);
				st1.setString(1,workshopid);	
				st1.setString(2,launchtime);
				ResultSet resultSet = st1.executeQuery();
				while (resultSet.next())
				{
					pollidnew = resultSet.getInt("PollID");
					System.out.println("//////////////////////////pollidnew is : "+pollidnew);
				}
				resultSet.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally{
				try {
					st1.close();
					dbcon.closeRemoteConnection(conn);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return pollidnew;			
	}
	//saving workshop poll responses	
	public void saveremotepollresponse(String studentid, String response , String launchtime , String workshopid) throws SQLException{
		int p=getpollidnew(launchtime,workshopid);
		System.out.println("in poll response saving...");
		Connection conn = null;
		DatabaseConnection dbcon = new DatabaseConnection();
		try{			
			conn = dbcon.createRemoteDatabaseConnection();
			/*
			 * querry to insert the raise question into database wrt student id ,courseid
			 */
			java.util.Date date= new java.util.Date();
			System.out.println("====================== "+new Timestamp(date.getTime()));
			int option=Integer.parseInt(response);
			st1 = conn.prepareStatement("INSERT INTO poll (ParticipantID,Response,TimeStamp,PollID) VALUES (?,?,?,?)");
			st1.setString(1,studentid);
			st1.setInt(2,option);
			st1.setString(3,launchtime);
			st1.setInt(4,p);
			st1.executeUpdate();		
		}
		catch (SQLException e2) {
			// Exception when executing java.sql related commands, print error message to the console
			e2.printStackTrace();
		}finally{
			try{if(st1!=null){st1.close();}}catch(SQLException ex){}
			dbcon.closeRemoteConnection(conn);
		}
	}
	//taking centerid
	public String getRemoteCenterID(String workshopID,String coordinatorID ){
		String centerid = null;
		Connection conn = null;

		DatabaseConnection dbcon = new DatabaseConnection();
		conn=dbcon.createRemoteDatabaseConnection();
		try{
			String selectquery="SELECT CenterID from remotecenter";
			st1 = conn.prepareStatement(selectquery);
			ResultSet resultSet = st1.executeQuery();

			while (resultSet.next())
			{
				centerid = resultSet.getString("CenterID");
				System.out.println("centerid is : "+centerid);
			}

			resultSet.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally{
			try {
				st1.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			dbcon.closeRemoteConnection(conn);
		}
		return centerid;	

	}


	public String getInstantQuestionIDs(int quizrecordid){
		String questionIDs = "";
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		DatabaseConnection dbcon = new DatabaseConnection();
		try {			
			con = dbcon.createRemoteDatabaseConnection();
			st = con.createStatement();
			String query = "SELECT IQuestionID FROM instantquestion Where IQuizID = "+ quizrecordid;
			rs = st.executeQuery(query);
			while (rs.next()) {
				questionIDs += rs.getString("IQuestionID") + "@";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} 
		finally
		{
			try{if(rs!=null){rs.close();}}catch(SQLException ex){}
			try{if(st!=null){st.close();}}catch(SQLException ex){}
			dbcon.closeRemoteConnection(con);
		}
		return questionIDs;
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

	public String getAutoTestResponse(String questionid){
		String response = "";
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String correctAnswer = "A";
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			
			con = dbcon.createRemoteDatabaseConnection();
			st = con.createStatement();
			String query = "SELECT Response, count(*) as RCount FROM autotestresponse where IQuestionID = '"+questionid+"' group by Response";
			rs = st.executeQuery(query);
			while (rs.next()) {
				String resp = rs.getString("Response");
				if("".equals(resp) || "Z".equals(resp)){
					response += "No Response" + "=" + rs.getString("RCount") + ";";
				}else{
					response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";
				}
			}					
		} catch (SQLException ex) {
			ex.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();                
				if(st!=null)st.close();			
				if(con!=null)dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println(response + "@" + correctAnswer);
		return response + "@" + correctAnswer;
	}

	public int getNoofParticipant (String workshopid){
		int noofParticipants = 0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createRemoteDatabaseConnection();
		PreparedStatement pstmt=null;
		String sql = "SELECT count(*) as participantcount from participant where WorkshopID = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,workshopid);			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				noofParticipants = rs.getInt("participantcount");
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			try{if(pstmt!=null){pstmt.close();}}catch(SQLException ex){}
			dbconn.closeRemoteConnection(con);
		}
		return noofParticipants;
	}
}