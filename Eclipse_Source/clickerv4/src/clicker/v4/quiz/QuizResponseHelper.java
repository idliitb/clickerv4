package clicker.v4.quiz;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
/**
 * 
 * @author rajavel,dipti
 * Clicker Team, IDL Lab - IIT Bombay
 * This class is used as a helper for quiz response 
 */
public class QuizResponseHelper {
	public String getQuestionIDs(int quizrecordid){
		String questionIDs = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            st = con.createStatement();
            String query = "select qq.QuestionID from quizrecord qr, quizquestion qq where qr.QuizRecordID = "+quizrecordid+" and qq.QuizID = qr.QuizID";
            rs = st.executeQuery(query);
            while (rs.next()) {
            	questionIDs += rs.getString("QuestionID") + "@";
            }
            rs.close();
            st.close();
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        finally
        {
        	dbcon.closeLocalConnection(con);
        }
		return questionIDs;
	}
	
	public String getInstantQuestionIDs(int quizrecordid){
		String questionIDs = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            st = con.createStatement();
            String query = "SELECT IQuestionID FROM instantquestion Where IQuizID = "+ quizrecordid;
            rs = st.executeQuery(query);
            while (rs.next()) {
            	questionIDs += rs.getString("IQuestionID") + "@";
            }
            rs.close();
            st.close();
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
        finally
        {
        	dbcon.closeLocalConnection(con);
        }
		return questionIDs;
	}
	
	public String getQuestionResponse(int quizrecordid, String questionid){
		String response = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        Statement st1 = null;
        ResultSet rs1 = null;
        String correctAnswer = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            st = con.createStatement();
            String query = "Select Sresponse.Response, count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.StudentID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID = "+quizrecordid+" and qrq.QuestionID = "+questionid+" and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.StudentID order by qrq.Response) as Sresponse group by Response";
            //System.out.println(query);
            rs = st.executeQuery(query);
            st1 = con.createStatement();
            query = "SELECT o.OptionID, o.OptionCorrectness, o.OptionValue, q.QuestionType FROM options o, question q where o.QuestionID = "+questionid+" and q.QuestionID = o.QuestionID order by o.OptionID";
            //System.out.println("QUERY: " + query);
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
						response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";
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
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();                
        		if(st!=null)st.close();			
        		if(rs1!=null)rs1.close();
        		if(st1!=null)st1.close();
        		if(con!=null)dbcon.closeLocalConnection(con);
            } catch (SQLException e) {
				e.printStackTrace();
			}
        }
        System.out.println(response + "@" + correctAnswer);
        return response + "@" + correctAnswer;
	}
	
	public String getInstantQuizResponse(int quizrecoredid){
		String response = "";
        DatabaseConnection dbcon = new DatabaseConnection();
        Connection con = dbcon.createDatabaseConnection();
        PreparedStatement pst = null;
        PreparedStatement pst1 = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        String correctAnswer = "";    	
        try {
        	pst = con.prepareStatement("SELECT Response, count(*) as RCount FROM instantquizresponse where IQuizID = ? group by Response");
        	pst1 = con.prepareStatement("SELECT CorrectAns FROM instantquiz where IQuizID=?");        	
        	pst.setInt(1, quizrecoredid);
        	rs = pst.executeQuery();
            while (rs.next()) {
            	response += rs.getString("Response") + "=" + rs.getString("RCount") + ";";            	
            }
            pst1.setInt(1, quizrecoredid);
            rs1 = pst1.executeQuery();
            if (rs1.next()) {
            	correctAnswer = rs1.getString("CorrectAns");            	
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();                
        		if(pst!=null)pst.close();
        		if(rs1!=null)rs1.close();                
        		if(pst1!=null)pst1.close();        		
        		if(con!=null)dbcon.closeLocalConnection(con);
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
        	
            con = dbcon.createDatabaseConnection();
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
        		if(con!=null)dbcon.closeLocalConnection(con);
            } catch (SQLException e) {
				e.printStackTrace();
			}
        }
        System.out.println(response + "@" + correctAnswer);
        return response + "@" + correctAnswer;
	}
	
	public String getResponseTable(String questionid, String courseID){
		int quizrecoredid = Global.quizrecordids.get(courseID);
		String Query = "SELECT qrq.StudentID, s.StudentName, GROUP_CONCAT(Response) as Response from quizrecordquestion qrq, student s where QuizRecordID = "+quizrecoredid+" AND QuestionID= "+questionid+" and s.StudentID = qrq.StudentID GROUP BY qrq.StudentID";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Student ID</th><th>Student Name</th><th>Response</th>");
		try {
			con = dbcon.createDatabaseConnection();
			st = con.createStatement();
			rs = st.executeQuery(Query);
			int count = 0;
			while (rs.next()) {
				count++;
				responseTable.append("<tr><td>" + count + "</td><td>" + rs.getInt("StudentID") + "</td><td>" + rs.getString("StudentName") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
			}
			responseTable.append("</table>");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(st!=null)st.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return responseTable.toString();
	}
	
	public String getInstantResponseTable(String questionid, String courseID){
		int quizrecoredid = Global.quizrecordids.get(courseID);
		String Query = "SELECT s.StudentID, s.StudentName, i.Response FROM instantquizresponsenew i, student s where IQuizID = '"+quizrecoredid+"' and IQuestionID = '"+questionid+"' and s.StudentID = i.StudentID";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Student ID</th><th>Student Name</th><th>Response</th>");
		try {
			con = dbcon.createDatabaseConnection();
			st = con.createStatement();
			rs = st.executeQuery(Query);
			int count = 0;
			while (rs.next()) {
				count++;
				responseTable.append("<tr><td>" + count + "</td><td>" + rs.getInt("StudentID") + "</td><td>" + rs.getString("StudentName") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
			}
			responseTable.append("</table>");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(st!=null)st.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return responseTable.toString();
	}
	
	public String getResponseTable(String courseID){
		int quizrecoredid = Global.quizrecordids.get(courseID);
		String Query = "SELECT iqr.StudentID, s.StudentName, iqr.Response from instantquizresponse iqr, student s where IQuizID = "+quizrecoredid+" and s.StudentID = iqr.StudentID GROUP BY iqr.StudentID";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Student ID</th><th>Student Name</th><th>Response</th>");
		try {
			con = dbcon.createDatabaseConnection();
			st = con.createStatement();
			rs = st.executeQuery(Query);
			int count = 0;
			while (rs.next()) {
				count++;
				responseTable.append("<tr><td>" + count + "</td><td>" + rs.getInt("StudentID") + "</td><td>" + rs.getString("StudentName") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
			}
			responseTable.append("</table>");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(st!=null)st.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return responseTable.toString();
	}
	
	
	// Below function for HighChart
	
	
	/*
	 * This below function is used to get the count of correct answer, wrong answer and not response answer according to 
	 * questions list in Normal Quiz.
	 * It will return a string having all this count 
	 * It is being used to pass this value to highcharts javascript for displaying chart 
	 */
	
	public String getNormalQuizResponseCount(int quizRecordID){

		Connection con = null;
		PreparedStatement pst=null,pst1=null,pst2=null,pst3 = null;
		ResultSet rs=null,rs1=null,rs2=null,rs3 = null;
		String count="0" ,count1="0",count2="0";
		String correctAnswer = "";
		int correctAnsCount=0,wrongAnsCount=0,noResponseCount=0;
		String correctCountString="";
		String wrongCountString="";
		String noReponseCountString="";
		DatabaseConnection dbcon = new DatabaseConnection();
		
		
		String questionIDpatten = getQuestionIDs(quizRecordID);
		System.out.println(questionIDpatten);
		String questionIDs[] = questionIDpatten.split("@");
		int noofQuestions = questionIDs.length;   
		for(int j=0;j<noofQuestions;j++){
			System.out.println(questionIDs[j]);
			if(!questionIDs[j].equals("")){
				try{
					con = dbcon.createDatabaseConnection();
					pst = con.prepareStatement("SELECT o.OptionID, o.OptionCorrectness, o.OptionValue, q.QuestionType FROM options o, question q where o.QuestionID = ? and q.QuestionID = o.QuestionID order by o.OptionID");
					pst.setInt(1,Integer.parseInt(questionIDs[j]));
					rs = pst.executeQuery();
					int qtype = 0;
					correctAnswer = "";
					if (rs.first()) {
						qtype = Integer.parseInt(rs.getString("QuestionType"));
						if (qtype == 3) {
							if (Integer.parseInt(rs.getString("OptionCorrectness")) == 1) {
								correctAnswer = rs.getString("OptionValue");
							}
						}
						else {
							int ASCII = 65;
							if (Integer.parseInt(rs.getString("OptionCorrectness")) == 1) {
								correctAnswer += Character.toString((char) ASCII)+ "";
							}
							while (rs.next()) {
								ASCII++;
								if (Integer.parseInt(rs.getString("OptionCorrectness")) == 1) {
									correctAnswer += Character.toString((char) ASCII) + "";
								}
							}
						}				
					}
					pst1 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.StudentID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID =? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.StudentID order by qrq.Response) as Sresponse where Sresponse.Response LIKE ? group by Response");
					pst1.setInt(1, quizRecordID);
					pst1.setInt(2, Integer.parseInt(questionIDs[j]));
					pst1.setString(3,correctAnswer);
					rs1 = pst1.executeQuery();

					while (rs1.next()) {
						count=rs1.getString("RCount");
						correctAnsCount+= Integer.parseInt( count);
					}
					pst2 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.StudentID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID = ? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.StudentID order by qrq.Response) as Sresponse where Sresponse.Response NOT LIKE ? and Sresponse.Response NOT LIKE 'Z'  group by Response");
					pst2.setInt(1, quizRecordID);
					pst2.setInt(2, Integer.parseInt(questionIDs[j]));
					pst2.setString(3,correctAnswer);
					rs2 = pst2.executeQuery();

					while (rs2.next()) {
						count1=rs2.getString("RCount");
						wrongAnsCount+=Integer.parseInt( count1);		
					}
					pst3 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.StudentID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID = ? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.StudentID order by qrq.Response) as Sresponse where Sresponse.Response  LIKE 'Z' group by Response");
					pst3.setInt(1, quizRecordID);
					pst3.setInt(2, Integer.parseInt(questionIDs[j]));
					rs3 = pst3.executeQuery();

					while (rs3.next()) {
						count2=rs3.getString("RCount");
						noResponseCount+=Integer.parseInt( count2);		
					}

					if(j==(noofQuestions-1)){
						correctCountString+=correctAnsCount+"";
						wrongCountString+=wrongAnsCount+"";
						noReponseCountString+=noResponseCount+"";
					}else{
						correctCountString+=correctAnsCount+",";
						wrongCountString+=wrongAnsCount+",";
						noReponseCountString+=noResponseCount+",";
					}
					wrongAnsCount=0;
					correctAnsCount=0;
					noResponseCount=0;
				}catch(Exception e){
					System.out.println(e);
				}finally{
					try {
						if(rs!=null)rs.close();                
						if(pst!=null)pst.close();
						if(rs1!=null)rs1.close();                
						if(pst1!=null)pst1.close(); 
						if(rs2!=null)rs2.close();                
						if(pst2!=null)pst2.close(); 
						if(rs3!=null)rs3.close();                
						if(pst3!=null)pst3.close(); 
						if(con!=null)dbcon.closeLocalConnection(con);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		System.out.println("Correct answer count ::::"+correctCountString +"::::::Wrong answer count:::"+wrongCountString+":::::::No Reponse String::::"+noReponseCountString);
		return (correctCountString+"@"+wrongCountString+"@"+noReponseCountString);
	}

	/*
	 * This below function is used to get the count of correct answer, wrong answer and not response answer according to 
	 * questions list in Instant quiz.
	 * It will return a string having all this count 
	 * It is being used to pass this value to highcharts javascript for displaying chart 
	 */
	
	
	public String getInstantQuestionResponseCount(int quizRecordID){
		Connection con = null;
		PreparedStatement pst=null,pst1=null,pst2=null,pst3 = null;
		ResultSet rs=null,rs1=null,rs2=null,rs3 = null;
		String count="0" ,count1="0",count2="0";
		String correctAnswer = "";
		int correctAnsCount=0,wrongAnsCount=0,noResponseCount=0;
		String correctCountString="";
		String wrongCountString="";
		String noReponseCountString="";
		DatabaseConnection dbcon = new DatabaseConnection();
		
		
		String questionIDpatten = getInstantQuestionIDs(quizRecordID);
		System.out.println(questionIDpatten);
		String questionIDs[] = questionIDpatten.split("@");
		int noofQuestions = questionIDs.length;   
		for(int j=0;j<noofQuestions;j++){
			System.out.println(questionIDs[j]);
			if(!questionIDs[j].equals("")){
				try{
					con = dbcon.createDatabaseConnection();
					pst = con.prepareStatement("SELECT CorrectAns FROM instantquestion where IQuizID = ? and IQuestionID = ?");
					pst.setInt(1,quizRecordID);
					pst.setInt(2,Integer.parseInt(questionIDs[j]));
					rs = pst.executeQuery();
					
					correctAnswer = "";
					if (rs.first()) {
						correctAnswer = rs.getString("CorrectAns");			
					}
					pst1 = con.prepareStatement("SELECT count(*) as RCount FROM instantquizresponsenew where IQuizID = ? and IQuestionID = ? and Response LIKE ? group by Response");
					pst1.setInt(1, quizRecordID);
					pst1.setInt(2, Integer.parseInt(questionIDs[j]));
					pst1.setString(3,correctAnswer);
					rs1 = pst1.executeQuery();

					while (rs1.next()) {
						count=rs1.getString("RCount");
						correctAnsCount+= Integer.parseInt( count);
					}
					pst2 = con.prepareStatement("SELECT count(*) as RCount FROM instantquizresponsenew where IQuizID = ? and IQuestionID = ? and Response NOT LIKE ? and Response NOT LIKE 'Z'  group by Response");
					pst2.setInt(1, quizRecordID);
					pst2.setInt(2, Integer.parseInt(questionIDs[j]));
					pst2.setString(3,correctAnswer);
					rs2 = pst2.executeQuery();

					while (rs2.next()) {
						count1=rs2.getString("RCount");
						wrongAnsCount+=Integer.parseInt( count1);		
					}
					pst3 = con.prepareStatement("SELECT count(*) as RCount FROM instantquizresponsenew where IQuizID = ? and IQuestionID = ? and Response LIKE 'Z' group by Response");
					pst3.setInt(1, quizRecordID);
					pst3.setInt(2, Integer.parseInt(questionIDs[j]));
					rs3 = pst3.executeQuery();

					while (rs3.next()) {
						count2=rs3.getString("RCount");
						noResponseCount+=Integer.parseInt( count2);		
					}

					if(j==(noofQuestions-1)){
						correctCountString+=correctAnsCount+"";
						wrongCountString+=wrongAnsCount+"";
						noReponseCountString+=noResponseCount+"";
					}else{
						correctCountString+=correctAnsCount+",";
						wrongCountString+=wrongAnsCount+",";
						noReponseCountString+=noResponseCount+",";
					}
					wrongAnsCount=0;
					correctAnsCount=0;
					noResponseCount=0;
				}catch(Exception e){
					System.out.println(e);
				}finally{
					try {
						if(rs!=null)rs.close();                
						if(pst!=null)pst.close();
						if(rs1!=null)rs1.close();                
						if(pst1!=null)pst1.close(); 
						if(rs2!=null)rs2.close();                
						if(pst2!=null)pst2.close(); 
						if(rs3!=null)rs3.close();                
						if(pst3!=null)pst3.close(); 
						if(con!=null)dbcon.closeLocalConnection(con);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		System.out.println("Correct answer count ::::"+correctCountString +"::::::Wrong answer count:::"+wrongCountString+":::::::No Reponse String::::"+noReponseCountString);
		return (correctCountString+"@"+wrongCountString+"@"+noReponseCountString);
	}

	
}
