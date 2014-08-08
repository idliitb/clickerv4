package clicker.v4.quiz;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
//import java.util.HashMap;

import com.google.gson.Gson;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.wrappers.Option;
import clicker.v4.wrappers.Question;
import clicker.v4.wrappers.Quiz;
/**
 * 
 * @author rajavel, Kriti, Clicker Team, IDL Lab - IIT Bombay
 * This class file act as helper for conducting quiz
 */
public class QuizHelper {

	public String getQuizList(String courseID, String instructorID){
		String quizList = "";
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		String sql = "Select QuizName, QuizID from quiz where CourseID = ? and QuizType=? and Archived = ? and InstrID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, courseID);
			pstmt.setInt(2, 1);
			pstmt.setInt(3, 0);
			pstmt.setString(4,instructorID);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				quizList += rs.getString("QuizID") + "-&-" + rs.getString("QuizName") + "-@-";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			dbconn.closeLocalConnection(con);
		}
		return quizList;
	}
	
	public String getQuizDetail(int quizID, String courseID) {
		String encryptedans=null;
		StringBuffer quizDetails = new StringBuffer(); 
		Quiz quiz = new Quiz();
		quiz.setcourseId(courseID);
		quiz.setQuizId(quizID);
		quiz.setcurrenttime("0000/00/00 00:00:00");
		quiz.setlaunchtime("0000/00/00 00:00:00");
		quiz.setQuizTime("0");
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		ArrayList<Integer> notshuffle = new ArrayList<Integer>();
		String sql = "SELECT q.QuestionID, q.Question, q.QuestionType, q.Shuffle from question q, quizquestion qq where qq.QuizID = ? and q.QuestionID = qq.QuestionID";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,quizID);			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<Question> questionList = new ArrayList<Question>();
			int qindex=0;
			while (rs.next()){
				qindex++;
				Question question = new Question();
				question.setId(rs.getInt("QuestionID"));
				question.setText(rs.getString("Question"));
				if(rs.getInt("Shuffle")==0){
					notshuffle.add(rs.getInt("QuestionID"));
				}
				quizDetails.append("<br/><br/><div class='question'>"+ qindex + ". " + rs.getString("Question").replace("<", "&lt;")+"</div>");
				int questionType = rs.getInt("QuestionType");
				question.setType(questionType);
				sql = "SELECT OptionID, OptionValue, OptionCorrectness FROM options where QuestionID = ?";
				PreparedStatement pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1,rs.getInt("QuestionID"));			
				ResultSet rs1 = pstmt1.executeQuery();
				ArrayList<Option> options = new ArrayList<Option>();
				String correctAns = "";
				int i=0;
				quizDetails.append("<div class='optns'>");
				while (rs1.next()){
					i++;
					if(questionType!=3){
						quizDetails.append((char) (i+64) + ". " +  rs1.getString("OptionValue").replace("<", "&lt;")+"<br/>");
					}
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
				System.out.println("==============***********========> correct ans is : "+correctAns);
				encrypt en=new encrypt();
				encryptedans=en.encrypt1(correctAns);
				System.out.println("=============*********=========>encrypted correct ans is : "+encryptedans);
				quizDetails.append("</div>");
				question.setOptions(options);
				question.setCorrectAns(encryptedans);
				questionList.add(question);
			}
			quiz.setquestions(questionList);
			quiz.setNotShuffle(notshuffle);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			dbconn.closeLocalConnection(con);
		}
		Global.coursejsonobject.put(courseID, quiz);
		Gson gson = new Gson();
		System.out.println(gson.toJson(quiz));
		return quizDetails.toString();
	}
	
	public int getQuizTime(int quizID, String courseID) {
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		int duration=0;
		String sql = "SELECT Duration from quiz where QuizID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,quizID);			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				duration = rs.getInt("Duration");
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			dbconn.closeLocalConnection(con);
		}
		return duration;
	}
	
	public String setQuizLaunchTime(String courseID, int sec, int isnegativemarking, boolean isShowAns){
		int quizrecordid =0;
		Quiz quiz = new Quiz();
		quiz = Global.coursejsonobject.get(courseID);
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		String sql = "insert into quizrecord(QuizID, NegativeMarking) values (?,?)";
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,quiz.getQuizId());
			pstmt.setInt(2,isnegativemarking);
			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs != null && rs.next()) {
				quizrecordid = rs.getInt(1);
				System.out.println("QUIZ RECORD ID: " + quizrecordid);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbconn.closeLocalConnection(con);
		}
		Calendar cal = Calendar.getInstance();
		String currenttime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
		quiz.setQuizrecordId(quizrecordid);
		quiz.setcurrenttime(currenttime);
		quiz.setlaunchtime(currenttime);
		quiz.setQuizTime(""+sec);
		quiz.setShowAns(isShowAns);
		Gson gson = new Gson();
		System.out.println(gson.toJson(quiz));
		Global.coursejsonobject.put(courseID, quiz);
		Global.countrequestjson.put(courseID,"0");
		Global.quizrecordids.put(courseID, quizrecordid);
		Global.countresponsejson.put(courseID, 0);
		return ""+quizrecordid;
	}
	
	
	public String setInstantQuizDetailNew(String courseID, String instrID, String IQuiz, int sec, boolean isShowAns) {
		String encryptedans=null;
		Quiz quiz = new Quiz();
		quiz.setcourseId(courseID);		
		int iquizid = 0;
		Calendar cal = Calendar.getInstance();
		String currenttime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
		quiz.setcurrenttime(currenttime);
		quiz.setlaunchtime(currenttime);
		quiz.setQuizTime(""+sec);	
		quiz.setQuiztype("instant");
		JSONObject iQuiz = null;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		try {
			iQuiz = new JSONObject(IQuiz);
			JSONArray questions = iQuiz.getJSONArray("questions");
			String sql = "insert into instantquiznew(DurationSec, CourseID, InstrID) values (?,?,?)";			
			PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,sec);
			pstmt.setString(2, courseID);
			pstmt.setString(3, instrID);				
			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs != null && rs.next()) {
				iquizid = rs.getInt(1);
			}		
			quiz.setQuizId(iquizid);
			quiz.setQuizrecordId(iquizid);
			ArrayList<Question> questionList = new ArrayList<Question>();	
			ArrayList<Integer> notshuffle = new ArrayList<Integer>();			
			for(int i=0;i<questions.length();i++){
				Question question = new Question();
				JSONObject questionjson = (JSONObject) questions.get(i);
				int qtype=Integer.parseInt(questionjson.get("qtype").toString());
				int noofoptions = Integer.parseInt(questionjson.get("noofoptions").toString());
				String ans = questionjson.get("ans").toString();
				sql = "insert into instantquestion(IQuestionType, NoofOptions, CorrectAns, IQuizID) values (?,?,?,?)";
				PreparedStatement pstmt1 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				//PreparedStatement pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1,qtype);
				pstmt1.setInt(2, noofoptions);
				pstmt1.setString(3, questionjson.get("ans").toString());		
				pstmt1.setInt(4, iquizid);
				pstmt1.executeUpdate();
				int questionid = 0;
				ResultSet rs1 = pstmt1.getGeneratedKeys();
				if (rs1 != null && rs1.next()) {
					questionid = rs1.getInt(1);
				}
				
				System.out.println("==============***********========> correct ans is : "+ans);
				encrypt en=new encrypt();
				encryptedans=en.encrypt1(ans);
				System.out.println("=============*********=========>encrypted correct ans is : "+encryptedans);
				
				question.setId(questionid);
				notshuffle.add(questionid);
				question.setType(qtype);
				question.setCorrectAns(encryptedans);
				ArrayList<Option> options = new ArrayList<Option>();
				if(qtype==1){
					question.setText("Select a option from the following ");
					for(int j=1;j<=noofoptions;j++){
						Option op = new Option();
						op.setOptionid(j);
						op.setOptiontext("Option "+ j);
						options.add(op);
					}					
				}else if(qtype == 2){
					question.setText("Select the options from the following ");
					for(int j=1;j<=noofoptions;j++){
						Option op = new Option();
						op.setOptionid(j);
						op.setOptiontext("Option "+ j);
						options.add(op);
					}
				}else if(qtype == 3){
					question.setText("Enter the correct ans ");
					Option op = new Option();
					op.setOptionid(1);
					op.setOptiontext(ans);
					options.add(op);
				}else if(qtype == 4){
					question.setText("Select the correct answer ");
					Option op = new Option();
					op.setOptionid(1);
					op.setOptiontext("True");
					options.add(op);
					Option op1 = new Option();
					op1.setOptionid(2);
					op1.setOptiontext("False");
					options.add(op1);
				}
				question.setOptions(options);
				questionList.add(question);
			}			
			quiz.setquestions(questionList);
			quiz.setNotShuffle(notshuffle);			
			quiz.setShowAns(isShowAns);
			Gson gson = new Gson();
			String json = gson.toJson(quiz);			
			System.out.println(json);
		} catch (JSONException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}	
		finally
		{
			dbconn.closeLocalConnection(con);
		}
		Global.coursejsonobject.put(courseID, quiz);
		Global.countrequestjson.put(courseID,"0");
		Global.quizrecordids.put(courseID, iquizid);
		Global.countresponsejson.put(courseID, 0);
		Gson gson = new Gson();
		System.out.println(gson.toJson(quiz));
		return "" + iquizid;
	}	
	
	public int getNoofStudent (String courseID){
		int noofStudents = 0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		String sql = "SELECT count(*) as studentcount from studentcourse where CourseID = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,courseID);			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()){
				noofStudents = rs.getInt("studentcount");
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{			
			dbconn.closeLocalConnection(con);
		}
		return noofStudents;
	}
	
	
	
	public String get_quizsumm(String QuizID)
	{
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		String No_of_question = null;
		String Credit = null;
		String count="0";
		String query1 = "SELECT count(QuestionID),sum(questionCredit) FROM quizquestion where QuizID='"+QuizID+"'" ;	
		String sql = "SELECT count(TimeStamp) FROM quizrecord where QuizID='"+QuizID+"'";
		
		try {
			PreparedStatement pstmt;
			pstmt = con.prepareStatement(query1);	
			ResultSet rs = pstmt.executeQuery();			
			while (rs.next())
			{
				No_of_question = rs.getString(1);
				Credit=rs.getString(2);
			}
			
			PreparedStatement pstmt1;
			pstmt1 = con.prepareStatement(sql);			
			ResultSet rs1 = pstmt1.executeQuery();
			while (rs1.next()){
				//quiz_date += rs.getString("TimeStamp") + "@";
				count=rs1.getString(1);				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			dbconn.closeLocalConnection(con);
		}		
		return (count+"~"+No_of_question+"~"+Credit);
	}
	
	public String get_quiz_per(String quiz_id)
	{
	
		String ret = null;		
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection con = dbconn.createDatabaseConnection();
		int count=0;
		int percentage=0;
		String Quiz_record_id=null;
		String quer = "SELECT distinct qr.QuizRecordID FROM quizrecord qr, quizrecordquestion qrq where qr.QuizID='"+quiz_id+"' and qrq.QuizRecordID = qr.QuizRecordID";	
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(quer);
			ResultSet rs = pstmt.executeQuery();
			percentage=0;
			while (rs.next())
			{				
				Quiz_record_id=rs.getString(1);				
				String query = "Select sum(Correctness) as obtain, count(Correctness) as Total from (select if(Group_Concat(OptionID order by OptionID) = (select Group_Concat(o.OptionID order by o.OptionID) from options o where o.QuestionID=qrq.QuestionID and o.OptionCorrectness=1), 1, 0) as Correctness  from quizrecordquestion qrq where QuizRecordID='"+Quiz_record_id+"' group by qrq.QuestionID, qrq.StudentID) as sq;";	
				PreparedStatement pstmt1;
				pstmt1 = con.prepareStatement(query);
				ResultSet rs1 = pstmt1.executeQuery();				
				while(rs1.next())
				{
										
					percentage=percentage+(Integer.parseInt(rs1.getString(1))/Integer.parseInt(rs1.getString(2)))*100;
					System.out.println("Quiz_record_id :"+Quiz_record_id+" percentage :"+percentage);
					
				}
				count++;			
			}			
			if(count== 0)
			{
				return  "0";
			}else
			{				
			    ret=""+percentage/count;				
				return ret;
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			dbconn.closeLocalConnection(con);
		}
		return "0";	
	}
}
