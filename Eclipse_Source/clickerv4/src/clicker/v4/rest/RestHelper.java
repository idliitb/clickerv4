package clicker.v4.rest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.google.gson.Gson;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.wrappers.ClassroomQuizSummary;
import clicker.v4.wrappers.Option;
import clicker.v4.wrappers.Question;
import clicker.v4.wrappers.Quiz;

/**
 * This class is used as helper of Restful activities 
 * @author rajavel, dipti Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class RestHelper {
	
	/* This method is used take the student response and 
	 check the response is from normal quiz are instant quiz as will as 
	 check whether the response is from current quiz or previous quiz */
	public void localModeResponse(String response, String course_id){
		System.out.println("Response from student " + response);		
		JSONObject responseJSon = null;
		try {
			responseJSon = new JSONObject(response);
			int quizrecordid =0;
			if(Global.quizrecordids.get(course_id)!=null)
				quizrecordid= Global.quizrecordids.get(course_id);
			//Normal Quiz response for current quiz
			if(responseJSon.get("quiztype").toString().equals("normal") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) ==quizrecordid){
				localNormalQuizResponse(responseJSon, course_id, quizrecordid, true);
				int count = Global.countresponsejson.get(course_id);
				Global.countresponsejson.replace(course_id, ++count);
				HashSet<String> studList = Global.respondedstudlist.get(course_id);
				if(studList!=null){
					studList.add(responseJSon.get("studId").toString());
					Global.respondedstudlist.replace(course_id, studList);
				}
			}
			//Normal Quiz response for previous quiz
			else if(responseJSon.get("quiztype").toString().equals("normal") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) !=quizrecordid){			
				localNormalQuizResponse(responseJSon, course_id, Integer.parseInt(responseJSon.get("quizrecordId").toString()), false);
			}
			//Instant Quiz response for current quiz
			else if(responseJSon.get("quiztype").toString().equals("instant") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) ==quizrecordid){
				localInstantQuizResponse(responseJSon, course_id, quizrecordid, true);
				int count = Global.countresponsejson.get(course_id);
				Global.countresponsejson.replace(course_id, ++count);
				HashSet<String> studList = Global.respondedstudlist.get(course_id);
				if(studList!=null){
					studList.add(responseJSon.get("studId").toString());
					Global.respondedstudlist.replace(course_id, studList);
				}
			}
			//Instant Quiz response for previous quiz
			else if(responseJSon.get("quiztype").toString().equals("instant") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) !=quizrecordid){			
				localInstantQuizResponse(responseJSon, course_id, Integer.parseInt(responseJSon.get("quizrecordId").toString()), false);
			}	
		} 
		catch (JSONException e) {			
			e.printStackTrace();
		}
	}
	
	/*
	 * Student Response of normal quiz is stored based on current quiz are previous quiz  
	 * before insert delete the previous response stored for the same student to avoid duplication 
	 */
	public void localNormalQuizResponse(JSONObject responseJSon, String course_id, int quizrecordid, boolean isCurrentResponse){
		Quiz quiz = null;
		if(isCurrentResponse){
			quiz = Global.coursejsonobject.get(course_id);
		}
		//If response is previous quiz then quiz details is taken from database 
		else{
			quiz = getQuizDetails(quizrecordid, course_id);
			System.out.println("Previouse response for quizrecordid : "+quizrecordid);
		}
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createDatabaseConnection();
		PreparedStatement pstmtdel = null, pstmt=null;
		try{
			JSONArray responseOptionJSon = responseJSon.getJSONArray("options");							
			ArrayList<Question> questionList =  quiz.getquestions();
			String studentid = responseJSon.get("studId").toString();
			pstmtdel = con.prepareStatement("delete from quizrecordquestion where StudentID=? and QuizRecordID =?");
			pstmtdel.setString(1, studentid);
			pstmtdel.setInt(2, quizrecordid);
			pstmtdel.executeUpdate();
			pstmt = con.prepareStatement("insert into quizrecordquestion (QuizRecordID, QuestionID, OptionID, StudentID, Response, QRIndex, InvalidQuiz, TimeTaken, ResponseIndex, ResponseIndexCorrect) values(?,?,?,?,?,?,?,?,?,?)");			
			for(int i=0;i<responseOptionJSon.length();i++){
				Question question = questionList.get(i);
				int questionid = question.getId();
				int optionid = 0;
				String resp = responseOptionJSon.get(i).toString();
				int respIndex = 0;
				if(question.getType()==3){
					Option op = question.getOptions().get(0);
					if(resp.equals(op.getOptiontext())){
						optionid = op.getOptionid();
					}									
				}else if(question.getType()==2){
					if(!resp.equalsIgnoreCase("Z")){
						for(int j=0;j<resp.length();j++){
							char respChar = resp.charAt(j);							
							Option op = question.getOptions().get(((int)respChar)-65);
							optionid = op.getOptionid();
							pstmt.setInt(1, quizrecordid);
							pstmt.setInt(2, questionid);
							pstmt.setInt(3, optionid);
							pstmt.setString(4, studentid);
							pstmt.setString(5, Character.toString(respChar));
							pstmt.setInt(6, 0);
							pstmt.setBoolean(7, false);
							pstmt.setInt(8, 0);
							pstmt.setInt(9, ((int)respChar)-65);
							pstmt.setInt(10, 0);
							pstmt.addBatch();
						}						
					}else{
						optionid = 0;								
				}
				}else if(question.getType()==4 || question.getType()==1 ){											
					if(!resp.equalsIgnoreCase("Z")){						
						Option op = question.getOptions().get(((int)resp.charAt(0))-65);
						optionid = op.getOptionid();
					}else{
						optionid = 0;
					}
					respIndex = ((int)resp.charAt(0))-65;							
				}
				if(question.getType()!=2 || (question.getType()==2 && resp.equalsIgnoreCase("Z"))){
					pstmt.setInt(1, quizrecordid);
					pstmt.setInt(2, questionid);
					pstmt.setInt(3, optionid);
					pstmt.setString(4, studentid);
					pstmt.setString(5, resp);
					pstmt.setInt(6, 0);
					pstmt.setBoolean(7, false);
					pstmt.setInt(8, 0);
					pstmt.setInt(9, respIndex);
					pstmt.setInt(10, 0);
					pstmt.addBatch();
				}
				pstmt.executeBatch();
			}			
			
			}catch(SQLException ex){
				ex.printStackTrace();
			}catch (JSONException e) {
				e.printStackTrace();
			}finally{
				if(pstmtdel!=null)
					try {
						pstmtdel.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				if(pstmt!=null)
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				dbcon.closeLocalConnection(con);
			}
	}
	
	/*
	 * This method is used to get the quiz details for quiz record id 
	 */
	public Quiz getQuizDetails(int quizrecordid, String courseID){
		int quizID = getQuizID(quizrecordid);
		Quiz quiz = new Quiz();
		quiz.setcourseId(courseID);
		quiz.setQuizId(quizID);
		quiz.setcurrenttime("0000/00/00 00:00:00");
		quiz.setlaunchtime("0000/00/00 00:00:00");
		quiz.setQuizTime("0");
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		PreparedStatement pstmt=null, pstmt1=null;
		ResultSet rs=null, rs1=null;
		ArrayList<Integer> notshuffle = new ArrayList<Integer>();
		String sql = "SELECT q.QuestionID, q.Question, q.QuestionType, q.Shuffle from question q, quizquestion qq where qq.QuizID = ? and q.QuestionID = qq.QuestionID";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,quizID);			
			rs = pstmt.executeQuery();
			ArrayList<Question> questionList = new ArrayList<Question>();
			while (rs.next()){
				Question question = new Question();
				question.setId(rs.getInt("QuestionID"));
				question.setText(rs.getString("Question"));
				if(rs.getInt("Shuffle")==0){
					notshuffle.add(rs.getInt("QuestionID"));
				}
				int questionType = rs.getInt("QuestionType");
				question.setType(questionType);
				sql = "SELECT OptionID, OptionValue, OptionCorrectness FROM options where QuestionID = ?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1,rs.getInt("QuestionID"));			
				rs1 = pstmt1.executeQuery();
				ArrayList<Option> options = new ArrayList<Option>();
				String correctAns = "";
				int i=0;
				while (rs1.next()){
					i++;
					Option op = new Option();
					op.setOptionid(rs1.getInt("OptionID"));
					op.setOptiontext(rs1.getString("OptionValue"));
					options.add(op);
					int isCorrect = rs1.getInt("OptionCorrectness");
					if(isCorrect == 1){
						if(questionType==3){
							correctAns = rs1.getString("OptionValue");
						}
						else{
							correctAns += (char)(i+64);
						}
					}
				}
				question.setOptions(options);
				question.setCorrectAns(correctAns);
				questionList.add(question);
			}
			quiz.setquestions(questionList);
			quiz.setNotShuffle(notshuffle);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			try{if(rs!=null){rs.close();}}catch(SQLException ex){}
			try{if(rs1!=null){rs1.close();}}catch(SQLException ex){}
			try{if(pstmt!=null){pstmt.close();}}catch(SQLException ex){}
			try{if(pstmt1!=null){pstmt1.close();}}catch(SQLException ex){}
			dbconn.closeLocalConnection(con);
		}
		return quiz;
	}
	
	/*
	 * This is used to get the quizid for a quizrecordID
	 */
	public int getQuizID(int quizrecordid){
		int quizid=0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con=dbconn.createDatabaseConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try{
			stmt = con.createStatement();
			rs = stmt.executeQuery("select QuizID from quizrecord where QuizRecordID="+quizrecordid);
			if(rs.next()){
				quizid = rs.getInt("QuizID");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				if(con!=null)dbconn.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return quizid;
	}
	
	/*
	 * Student Response of instant quiz is stored based on current quiz are previous quiz  
	 * before insert delete the previous response stored for the same student to avoid duplication 
	 */
	public void localInstantQuizResponse(JSONObject responseJSon, String course_id, int quizrecordid, boolean isCurrentResponse){
		Quiz quiz = null;
		if(isCurrentResponse){
			quiz = Global.coursejsonobject.get(course_id);
		}
		//If response is previous quiz then quiz details is taken from database		
		else{
			quiz = getInstantQuizDetails(quizrecordid, course_id, "local");
			System.out.println("Previouse instant quiz response for quizrecordid : "+quizrecordid);
		}
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createDatabaseConnection();
		PreparedStatement pstmt=null, pstmtdel=null;
		try{			
			JSONArray responseOptionJSon = responseJSon.getJSONArray("options");
			ArrayList<Question> questionList =  quiz.getquestions();
			String studentid = responseJSon.get("studId").toString();
			pstmtdel = con.prepareStatement("delete from instantquizresponsenew where StudentID=? and IQuizID =?");
			pstmtdel.setString(1, studentid);
			pstmtdel.setInt(2, quizrecordid);
			pstmtdel.executeUpdate();			
			pstmt = con.prepareStatement("Insert into instantquizresponsenew(StudentID, IQuestionID, Response, IQuizID) values (?,?,?,?)");			
			for(int i=0;i<responseOptionJSon.length();i++){
				Question question = questionList.get(i);
				int questionid = question.getId();				
				String resp = responseOptionJSon.get(i).toString();
				pstmt.setString(1, studentid);
				pstmt.setInt(2, questionid);
				pstmt.setString(3, resp);
				pstmt.setInt(4, quizrecordid);
				pstmt.addBatch();
				pstmt.executeBatch();
			}					
		}catch(SQLException ex){
			ex.printStackTrace();
		}catch (JSONException e) {
			e.printStackTrace();
		}finally{
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmtdel!=null){try {pstmtdel.close();} catch (SQLException e) {e.printStackTrace();}}
			dbcon.closeLocalConnection(con);	
		}
	}
	
	/*
	 * Used to get the instat quiz details for quiz record id
	 */
	public Quiz getInstantQuizDetails(int quizrecordid, String course_id, String mode){
		Quiz quiz = new Quiz();
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		if(mode.equals("local")){
			con = dbcon.createDatabaseConnection();
		}else{
			con = dbcon.createRemoteDatabaseConnection();
		}
		Statement st=null;
		ResultSet rs =null;
		ArrayList<Question> questionList = new ArrayList<Question>();
		try{
			st = con.createStatement();
			rs = st.executeQuery("select IQuestionID from instantquestion where IQuizID="+quizrecordid);
			while(rs.next()){
				Question question = new Question();
				question.setId(rs.getInt("IQuestionID"));
				questionList.add(question);
			}
			quiz.setquestions(questionList);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(st!=null)st.close();
				if(mode.equals("local")){
					if(con!=null)dbcon.closeLocalConnection(con);
				}else{
					if(con!=null)dbcon.closeLocalConnection(con);
				}
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return quiz;
	}
	
	/* This method is used take the participant response and 
	 check the response is from normal quiz are instant quiz as will as 
	 check whether the response is from current quiz or previous quiz */
	public void remoteModeResponse(String response, String course_id){
		System.out.println("Response from participant " + response);		
		JSONObject responseJSon = null;
		int quizrecordid=0;
		try {
			responseJSon = new JSONObject(response);
			
			if(Global.remotequizrecordids.get(course_id)!=null){
				quizrecordid = Global.remotequizrecordids.get(course_id);
				System.out.println("quiz Record is not null for this workshop");
			}
			
			if(course_id.equals("autotest")){
				autoTest(responseJSon, course_id);
			}	
			else if(responseJSon.get("quiztype").toString().equals("normal") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) ==quizrecordid){
				remoteNormalQuizResponse(responseJSon, course_id, quizrecordid, true);
				int count = Global.remotecountresponsejson.get(course_id);
				Global.remotecountresponsejson.replace(course_id, ++count);
				HashSet<String> participantList = Global.respondedparticipantlist.get(course_id);
				participantList.add(responseJSon.get("studId").toString());
				Global.respondedparticipantlist.replace(course_id, participantList);
			}
			else if(responseJSon.get("quiztype").toString().equals("normal") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) !=quizrecordid){			
				remoteNormalQuizResponse(responseJSon, course_id, Integer.parseInt(responseJSon.get("quizrecordId").toString()), false);
			}						
			else if(responseJSon.get("quiztype").toString().equals("instant") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) ==quizrecordid){
				remoteInstantQuizResponse(responseJSon, course_id, quizrecordid, true);
				int count = Global.remotecountresponsejson.get(course_id);
				Global.remotecountresponsejson.replace(course_id, ++count);
				HashSet<String> participantList = Global.respondedparticipantlist.get(course_id);
				participantList.add(responseJSon.get("studId").toString());
				Global.respondedparticipantlist.replace(course_id, participantList);
			}		
			else if(responseJSon.get("quiztype").toString().equals("instant") && Integer.parseInt(responseJSon.get("quizrecordId").toString()) !=quizrecordid){
				remoteInstantQuizResponse(responseJSon, course_id, Integer.parseInt(responseJSon.get("quizrecordId").toString()), false);
			}
		} catch (JSONException e) {			
			e.printStackTrace();
		}		
	}
	
	/*
	 * Insert the auto test quiz's participant responses
	 */
	public void autoTest(JSONObject responseJSon, String course_id){
		Quiz quiz = Global.workshopjsonobject.get(course_id);
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createRemoteDatabaseConnection();
		JSONArray responseOptionJSon;
		PreparedStatement pstmt=null;
		try {
			responseOptionJSon = responseJSon.getJSONArray("options");
			int quizrecordid = Integer.parseInt(responseJSon.get("quizID").toString());
			int count = Global.remotecountresponsejson.get(course_id);
			Global.remotecountresponsejson.replace(course_id, ++count);
			System.out.println("Value of quizrecordid....in auto test of remote mode..."+quizrecordid);
			ArrayList<Question> questionList =  quiz.getquestions();
			String studentid = responseJSon.get("studId").toString();			
			pstmt = con.prepareStatement("Insert into autotestresponse(ParticipantID, IQuestionID, Response, IQuizID) values (?,?,?,?)");
			for(int i=0;i<responseOptionJSon.length();i++){
				Question question = questionList.get(i);
				int questionid = question.getId();				
				String resp = responseOptionJSon.get(i).toString();
				pstmt.setString(1, studentid);
				pstmt.setInt(2, questionid);
				pstmt.setString(3, resp);
				pstmt.setInt(4, quizrecordid);
				pstmt.addBatch();
				pstmt.executeBatch();
			}		
		}catch (JSONException e) {
			e.printStackTrace();
		}	 catch (SQLException e) {
			e.printStackTrace();
		}	
		finally
		{
			try{if(pstmt!=null){pstmt.close();}}catch(SQLException ex){}
			if(con!=null)dbcon.closeRemoteConnection(con);
		}
	}
	
	/*
	 * This is used for Remote Mode ,when late response is received from tablet it will be checked for quiz record id of the NORMAL quiz
	 * and then student response will be saved accordingly to quiz detail received according to quizrecord id provided
	 */
	
	public void remoteNormalQuizResponse(JSONObject responseJSon, String course_id, int quizrecordid, boolean isCurrentResponse){
		Quiz quiz = null;
		if(isCurrentResponse){
			quiz = Global.workshopjsonobject.get(course_id);
		}
		//If response is previous quiz then quiz details is taken from database 
		else{
			quiz = getRemoteQuizDetails(quizrecordid, course_id);
			System.out.println("Previouse response for quizrecordid : "+quizrecordid);
		}
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createRemoteDatabaseConnection();		
		PreparedStatement pstmtdel = null, pstmt=null;		
		ArrayList<Question> questionList =  quiz.getquestions();
		try{
			JSONArray responseOptionJSon = responseJSon.getJSONArray("options");
			String participantid = responseJSon.get("studId").toString();
			pstmtdel = con.prepareStatement("delete from quizrecordquestion where ParticipantID=? and QuizRecordID =?");
			pstmtdel.setString(1, participantid);
			pstmtdel.setInt(2, quizrecordid);
			pstmtdel.executeUpdate();			
			pstmt = con.prepareStatement("insert into quizrecordquestion (QuizRecordID, QuestionID, OptionID, ParticipantID, Response, QRIndex, InvalidQuiz, TimeTaken, ResponseIndex, ResponseIndexCorrect,ResponseSend) values(?,?,?,?,?,?,?,?,?,?,?)");			
			for(int i=0;i<responseOptionJSon.length();i++){
				Question question = questionList.get(i);
				int questionid = question.getId();				
				int optionid = 0;
				String resp = responseOptionJSon.get(i).toString();
				int respIndex = 0;
				if(question.getType()==3){
					Option op = question.getOptions().get(0);
					if(resp.equals(op.getOptiontext())){
						optionid = op.getOptionid();
					}
				}else if(question.getType()==2){
					if(!resp.equalsIgnoreCase("Z")){
						for(int j=0;j<resp.length();j++){
							char respChar = resp.charAt(j);	
							Option op = question.getOptions().get(((int)respChar)-65);
							optionid = op.getOptionid();
							pstmt.setInt(1, quizrecordid);
							pstmt.setInt(2, questionid);
							pstmt.setInt(3, optionid);
							pstmt.setString(4, participantid);
							pstmt.setString(5, Character.toString(respChar));
							pstmt.setInt(6, 0);
							pstmt.setBoolean(7, false);
							pstmt.setInt(8, 0);
							pstmt.setInt(9, ((int)respChar)-65);
							pstmt.setInt(10, 0);
							pstmt.setInt(11, 0);
							pstmt.addBatch();
						}						
					}else{
						optionid = 0;							
					}
				}else if(question.getType()==4 || question.getType()==1 ){											
					if(!resp.equalsIgnoreCase("Z")){			
						System.out.println(resp);
						Option op = question.getOptions().get(((int)resp.charAt(0))-65);
						optionid = op.getOptionid();							
					}else{
						optionid = 0;
					}
					respIndex = ((int)resp.charAt(0))-65;						
				}
				if(question.getType()!=2 || (question.getType()==2 && resp.equalsIgnoreCase("Z"))){
					pstmt.setInt(1, quizrecordid);
					pstmt.setInt(2, questionid);
					pstmt.setInt(3, optionid);
					pstmt.setString(4, participantid);
					pstmt.setString(5, resp);
					pstmt.setInt(6, 0);
					pstmt.setBoolean(7, false);
					pstmt.setInt(8, 0);
					pstmt.setInt(9, respIndex);
					pstmt.setInt(10, 0);
					pstmt.setInt(11, 0);
					pstmt.addBatch();
				}
				pstmt.executeBatch();
			}
		}catch (JSONException e) {
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}	
		finally
		{
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmtdel!=null){try {pstmtdel.close();} catch (SQLException e) {e.printStackTrace();}}
			dbcon.closeRemoteConnection(con);
		}
	}
	
	/*
	 * This is used to get quiz details like questions, options and all for particular quiz of NORMAL quiz type whose quizrecordid and courseid we know.
	 */
	
	public Quiz getRemoteQuizDetails(int quizrecordid, String courseID){
		int quizID = getRemoteQuizID(quizrecordid, courseID);
		System.out.println(quizID);
		Quiz quiz = new Quiz();
		quiz.setcourseId(courseID);
		quiz.setQuizId(quizID);
		quiz.setcurrenttime("0000/00/00 00:00:00");
		quiz.setlaunchtime("0000/00/00 00:00:00");
		quiz.setQuizTime("0");
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createRemoteDatabaseConnection();
		ArrayList<Integer> notshuffle = new ArrayList<Integer>();
		String sql = "SELECT q.QuestionID, q.Question, q.QuestionType from question q, quizquestion qq where qq.QuizID = ? and qq.WorkshopID = ? and q.QuestionID = qq.QuestionID order by qq.QQOrderID";
		System.out.println(sql);
		PreparedStatement pstmt=null, pstmt1=null;
		ResultSet rs=null,rs1=null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,quizID);			
			pstmt.setString(2, courseID);
			rs = pstmt.executeQuery();
			ArrayList<Question> questionList = new ArrayList<Question>();
			while (rs.next()){
				Question question = new Question();
				question.setId(rs.getInt("QuestionID"));
				question.setText(rs.getString("Question"));
				int questionType = rs.getInt("QuestionType");
				question.setType(questionType);
				System.out.println(rs.getInt("QuestionID"));
				sql = "SELECT OptionID, OptionValue, OptionCorrectness FROM options where QuestionID = ?";
				System.out.println(sql);
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1,rs.getInt("QuestionID"));			
				rs1 = pstmt1.executeQuery();
				ArrayList<Option> options = new ArrayList<Option>();
				String correctAns = "";
				int i=0;
				while (rs1.next()){
					i++;
					Option op = new Option();
					op.setOptionid(rs1.getInt("OptionID"));
					op.setOptiontext(rs1.getString("OptionValue"));
					options.add(op);
					int isCorrect = rs1.getInt("OptionCorrectness");
					if(isCorrect == 1){
						if(questionType==3){
							correctAns = rs1.getString("OptionValue");
						}
						else{
							correctAns += (char)(i+64);
						}
					}
				}
				question.setOptions(options);
				question.setCorrectAns(correctAns);
				questionList.add(question);
			}
			quiz.setquestions(questionList);
			quiz.setNotShuffle(notshuffle);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{	
			try{
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				if(pstmt!=null)pstmt.close();
				if(pstmt1!=null)pstmt1.close();
				dbconn.closeRemoteConnection(con);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return quiz;
	}
	
	/*
	 * This is used to get quiz ID for particular quizrecord id
	 */
	public int getRemoteQuizID(int quizrecordid, String courseid){
		int quizid=0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con=dbconn.createRemoteDatabaseConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try{
			stmt = con.createStatement();
			rs = stmt.executeQuery("select QuizID from quizrecord where QuizRecordID="+quizrecordid +" and WorkshopID='"+courseid + "'");
			if(rs.next()){
				quizid = rs.getInt("QuizID");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				if(con!=null)dbconn.closeRemoteConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return quizid;
	}
	
	/*
	 * This is used for Remote Mode ,when late response is received from tablet it will be checked for quiz record id of the INSTANT quiz
	 * and then student response will be saved accordingly to quiz detail received according to quizrecord id provided
	 */
	public void remoteInstantQuizResponse(JSONObject responseJSon, String course_id, int quizrecordid, boolean isCurrentResponse){
		Quiz quiz = null;
		if(isCurrentResponse){
			quiz = Global.workshopjsonobject.get(course_id);
		}
		//If response is previous quiz then quiz details is taken from database 
		else{
			quiz = getInstantQuizDetails(quizrecordid, course_id, "remote");
			System.out.println("Previouse response for quizrecordid : "+quizrecordid);
		}
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createRemoteDatabaseConnection();
		PreparedStatement pstmt=null, pstmtdel=null;
		try{						
			JSONArray responseOptionJSon = responseJSon.getJSONArray("options");
			int count = Global.remotecountresponsejson.get(course_id);
			Global.remotecountresponsejson.replace(course_id, ++count);
			System.out.println("Value of quizrecordid....in restquizresource remote mode..."+quizrecordid);
			ArrayList<Question> questionList =  quiz.getquestions();
			String studentid = responseJSon.get("studId").toString();
			pstmtdel = con.prepareStatement("delete from instantquizresponsenew where ParticipantID=? and IQuizID =?");
			pstmtdel.setString(1, studentid);
			pstmtdel.setInt(2, quizrecordid);
			pstmtdel.executeUpdate();
			pstmt = con.prepareStatement("Insert into instantquizresponsenew(ParticipantID, IQuestionID, Response, IQuizID,ResponseSend) values (?,?,?,?,?)");			
			for(int i=0;i<responseOptionJSon.length();i++){
				Question question = questionList.get(i);
				int questionid = question.getId();				
				String resp = responseOptionJSon.get(i).toString();
				pstmt.setString(1, studentid);
				pstmt.setInt(2, questionid);
				pstmt.setString(3, resp);
				pstmt.setInt(4, quizrecordid);
				pstmt.setInt(5,0);
				pstmt.addBatch();
				pstmt.executeBatch();
			}					
		}catch(SQLException ex){
			ex.printStackTrace();
		}catch (JSONException e) {
			e.printStackTrace();
		}finally{
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmtdel!=null){try {pstmtdel.close();} catch (SQLException e) {e.printStackTrace();}}
			dbcon.closeRemoteConnection(con);	
		}
	}
	
	public String getConductedQuizDetailJSON(){
		String classroomresponse="", instiName="";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createDatabaseConnection();
		ResultSet rs = null, rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null;
		PreparedStatement pstmt =null, pstmt1=null, pstmt2=null,pstmt3=null, pstmt4=null, pstmt5=null, pstmt6=null;
		ArrayList<ClassroomQuizSummary> quizzesSummary = new ArrayList<ClassroomQuizSummary>();
		try{
			pstmt3= con.prepareStatement("SELECT InstiName from institution where InstiID='I1'");			
			rs3=pstmt3.executeQuery();
			if(rs3.next()){
				instiName=rs3.getString(1);
			}
			pstmt= con.prepareStatement("SELECT distinct qr.QuizRecordID, q.CourseID from quizrecord qr, quizrecordquestion qrq, quiz q where qr.Note !='sent' and qrq.QuizRecordID = qr.QuizRecordID and q.QuizID = qr.QuizID");			
			rs=pstmt.executeQuery();
			while(rs.next()){
				ClassroomQuizSummary quizSummary = new ClassroomQuizSummary();
				pstmt1= con.prepareStatement("SELECT distinct o.QuestionID, Group_Concat(distinct o.OptionID order by o.OptionID SEPARATOR '@') as correctAns FROM aakashclicker.quizrecordquestion q, options o where q.QuizRecordID=? and q.QuestionID=o.QuestionID and o.OptionCorrectness=1 group by o.QuestionID");
				int qrid = rs.getInt(1);
				quizSummary.setQrid(qrid);
				quizSummary.setCourseID(rs.getString(2));
				quizSummary.setQuiztype("NQ");
				pstmt1.setInt(1, qrid);
				rs1=pstmt1.executeQuery();
				int noofQuestion=0;
				int noofParticipant=0;
				int noofCorrect=0;
				int noofWrong=0;
				while(rs1.next()){		
					noofQuestion++;
					pstmt2= con.prepareStatement("select cw, sum(respcount) from (select if(a.resp=?, 'Correct', 'Wrong') as cw, count(*) as respcount from (SELECT Group_concat(OptionID order by OptionID SEPARATOR '@') as resp FROM aakashclicker.quizrecordquestion where QuestionID=? and QuizRecordID=? group by StudentID order by OptionID) as a  group by a.resp) as b group by cw");
					pstmt2.setString(1, rs1.getString(2));
					pstmt2.setInt(2, rs1.getInt(1));
					pstmt2.setInt(3, qrid);
					rs2=pstmt2.executeQuery();					
					while(rs2.next()){
						if(rs2.getString(1).equals("Correct")){
							noofCorrect = rs2.getInt(2);
							noofParticipant += noofCorrect;
						}else{
							noofWrong = rs2.getInt(2);
							noofParticipant += noofWrong;
						}
					}
				}
				quizSummary.setNoofQuestion(noofQuestion);
				quizSummary.setNoofParticipant(noofParticipant/noofQuestion);
				quizSummary.setNoofCorrect(noofCorrect);
				quizSummary.setNoofWrong(noofWrong);	
				quizSummary.setInstName(instiName);
				quizzesSummary.add(quizSummary);
			}			
			pstmt4= con.prepareStatement("SELECT distinct iq.IQuizID, iq.CourseID from instantquiznew iq, instantquizresponsenew iqr where IsSent !='sent' and iqr.IQuizID = iq.IQuizID");			
			rs4=pstmt4.executeQuery();
			while(rs4.next()){
				System.out.println("instant quiz send");
				ClassroomQuizSummary quizSummary = new ClassroomQuizSummary();
				pstmt5= con.prepareStatement("SELECT IQuestionID, CorrectAns FROM instantquestion where IQuizID=?");
				int qrid = rs4.getInt(1);
				quizSummary.setQrid(qrid);
				quizSummary.setCourseID(rs4.getString(2));
				quizSummary.setQuiztype("IQ");
				pstmt5.setInt(1, qrid);
				rs5=pstmt5.executeQuery();
				int noofQuestion=0;
				int noofParticipant=0;
				int noofCorrect=0;
				int noofWrong=0;
				while(rs5.next()){		
					noofQuestion++;
					pstmt6= con.prepareStatement("Select cw, sum(rc) as rcount from (SELECT if(Response=?, 'Correct', 'Wrong') as cw, count(*) as rc FROM instantquizresponsenew where IQuizID=? and IQuestionID=? group by Response) as sq group by cw");
					pstmt6.setString(1, rs5.getString(2));
					pstmt6.setInt(2, qrid);
					pstmt6.setInt(3, rs5.getInt(1));
					rs6=pstmt6.executeQuery();					
					while(rs6.next()){
						if(rs6.getString(1).equals("Correct")){
							noofCorrect = rs6.getInt(2);
							noofParticipant += noofCorrect;
						}else{
							noofWrong = rs6.getInt(2);
							noofParticipant += noofWrong;
						}
					}
				}
				quizSummary.setNoofQuestion(noofQuestion);
				quizSummary.setNoofParticipant(noofParticipant/noofQuestion);
				quizSummary.setNoofCorrect(noofCorrect);
				quizSummary.setNoofWrong(noofWrong);	
				quizSummary.setInstName(instiName);
				quizzesSummary.add(quizSummary);
			}			
		}catch(SQLException ex){
			ex.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				if(rs2!=null)rs2.close();
				if(rs3!=null)rs3.close();
				if(rs4!=null)rs4.close();
				if(rs5!=null)rs5.close();
				if(rs6!=null)rs6.close();
				if(pstmt!=null)pstmt.close();
				if(pstmt1!=null)pstmt1.close();
				if(pstmt2!=null)pstmt2.close();
				if(pstmt3!=null)pstmt3.close();
				if(pstmt4!=null)pstmt4.close();
				if(pstmt5!=null)pstmt5.close();
				if(pstmt6!=null)pstmt6.close();
				
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {			
				e.printStackTrace();
			}	
		}
		Gson gson = new Gson();
	    classroomresponse = gson.toJson(quizzesSummary);
	    System.out.println(classroomresponse);
		return classroomresponse;
	}
	
	/*
	 * Updates the classroom quiz record status whether response sent to main-center or not  
	 */
	public void updateClassroomQuizrecord(String qrids){
		Connection con = null;
		PreparedStatement ps = null, ps1=null;
		String[] NQRIDs=qrids.split("#")[0].split("@");
		String[] IQRIDs = null;
		if(qrids.split("#").length==2)
			IQRIDs=qrids.split("#")[1].split("@");
		DatabaseConnection dbcon = new DatabaseConnection();
		try {
			con = dbcon.createDatabaseConnection();				
			ps = con.prepareStatement("update quizrecord set Note='sent' where QuizRecordID=?");
			for (int i = 0; i < NQRIDs.length; i++) {
				ps.setString(1,NQRIDs[i]);				
				ps.addBatch();
			}				
			ps.executeBatch();
			ps1 = con.prepareStatement("update instantquiznew set IsSent='sent' where IQuizID=?");
			if(IQRIDs!=null){
				for (int i = 0; i < IQRIDs.length; i++) {
					ps1.setString(1,IQRIDs[i]);				
					ps1.addBatch();
				}				
			}
			ps1.executeBatch();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			try {
				if(ps!=null)ps.close();
				if(ps1!=null)ps1.close();
				if(con!=null)dbcon.closeLocalConnection(con);
				} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
}
