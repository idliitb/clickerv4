package clicker.v4.remote;


	

	import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.google.gson.Gson;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.rest.JSONReadandparse;
import clicker.v4.wrappers.InstantQuizResponse;
import clicker.v4.wrappers.ParticipantResponse;
import clicker.v4.wrappers.QuizResponse;
import clicker.v4.wrappers.Participant;
import clicker.v4.wrappers.Question;
import clicker.v4.wrappers.Quiz;
	/**
	 * 
	 * @author dipti, rajavel
	 * This class is used as a helper for remote quiz response 
	 */
	public class RemoteQuizResponseHelper {
		
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
	        	
	            con = dbcon.createRemoteDatabaseConnection();
	            st = con.createStatement();
	            String query = "Select Sresponse.Response, count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.ParticipantID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID = "+quizrecordid+" and qrq.QuestionID = "+questionid+" and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.ParticipantID order by qrq.Response) as Sresponse group by Response";
	            //System.out.println(query);
	            rs = st.executeQuery(query);
	            st1 = con.createStatement();
	            query = "SELECT o.OptionID, o.OptionCorrectness, o.OptionValue, q.QuestionType FROM options o, question q where o.QuestionID = "+questionid+" and q.QuestionID = o.QuestionID order by o.OptionID";
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
				System.out.println("Question type" + qtype);
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
	        		if(con!=null)dbcon.closeRemoteConnection(con);
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
	        Connection con = dbcon.createRemoteDatabaseConnection();
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
	        		if(con!=null)dbcon.closeRemoteConnection(con);
	            } catch (SQLException e) {
					e.printStackTrace();
				}
	        }
	        System.out.println(response + "@" + correctAnswer);
	        return response + "@" + correctAnswer;
		}
		
		public String getResponseTable(String questionid, String courseID){
			int quizrecoredid = Global.remotequizrecordids.get(courseID);
			String Query = "SELECT qrq.ParticipantID, GROUP_CONCAT(Response) as Response from quizrecordquestion qrq where QuizRecordID = "+quizrecoredid+" AND QuestionID= "+questionid+" GROUP BY qrq.ParticipantID";
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th><th>Response</th>");
			try {
				con = dbcon.createRemoteDatabaseConnection();
				st = con.createStatement();
				rs = st.executeQuery(Query);
				int count = 0;
				while (rs.next()) {
					count++;
					responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
				}
				responseTable.append("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null)rs.close();
					if(st!=null)st.close();
					if(con!=null)dbcon.closeRemoteConnection(con);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			return responseTable.toString();
		}
		
		public String getResponseTable(String courseID){
			int quizrecoredid = Global.remotequizrecordids.get(courseID);
			String Query = "SELECT Distinct(iqr.ParticipantID), iqr.Response from instantquizresponse iqr, participant p where IQuizID = "+quizrecoredid+" and p.ParticipantID = iqr.ParticipantID GROUP BY iqr.ParticipantID";
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th><th>Response</th>");
			try {
				con = dbcon.createRemoteDatabaseConnection();
				st = con.createStatement();
				rs = st.executeQuery(Query);
				int count = 0;
				while (rs.next()) {
					count++;
					responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
				}
				responseTable.append("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null)rs.close();
					if(st!=null)st.close();
					if(con!=null)dbcon.closeRemoteConnection(con);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			return responseTable.toString();
		}
		
		public String getInstantResponseTable(String questionid, String courseID){
			int quizrecoredid = Global.remotequizrecordids.get(courseID);
			String Query = "SELECT Distinct(p.ParticipantID), p.ParticipantName, i.Response FROM instantquizresponsenew i, participant p where IQuizID = '"+quizrecoredid+"' and IQuestionID = '"+questionid+"' and p.ParticipantID = i.ParticipantID";
			//System.out.println(Query);
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th><th>Participant Name</th><th>Response</th>");
			try {
				con = dbcon.createRemoteDatabaseConnection();
				st = con.createStatement();
				rs = st.executeQuery(Query);
				int count = 0;
				while (rs.next()) {
					count++;
					responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td><td>" + rs.getString("ParticipantName") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
				}
				responseTable.append("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null)rs.close();
					if(st!=null)st.close();
					if(con!=null)dbcon.closeRemoteConnection(con);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			return responseTable.toString();
		}
		
		public String getAutoTestResponseTable(String questionid){
			int quizrecoredid = Global.remotequizrecordids.get("autotest");
			String Query = "SELECT Distinct(p.ParticipantID), p.ParticipantName, a.Response FROM autotestresponse a, participant p where IQuizID = '"+quizrecoredid+"' and IQuestionID = '"+questionid+"' and p.ParticipantID = a.ParticipantID";
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			StringBuffer responseTable = new StringBuffer("<table width=500px border='1' cellpadding='5'><tr><th>S.No</th><th>Participant ID</th><th>Participant Name</th><th>Response</th>");
			try {
				con = dbcon.createRemoteDatabaseConnection();
				st = con.createStatement();
				rs = st.executeQuery(Query);
				int count = 0;
				while (rs.next()) {
					count++;
					responseTable.append("<tr><td>" + count + "</td><td>" + rs.getString("ParticipantID") + "</td><td>" + rs.getString("ParticipantName") + "</td><td>" + rs.getString("Response").replace(",", "") + "</td></tr>");							
				}
				responseTable.append("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null)rs.close();
					if(st!=null)st.close();
					if(con!=null)dbcon.closeRemoteConnection(con);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			return responseTable.toString();
		}
		
		public void createMCResponseJson(int quizrecordid ,String MainCenterURL)
		{
			 ArrayList<Participant> participantlist = new ArrayList<Participant>();
				String workshopid = null, participantid = "";
				int centerid = 0, quizid = 0; 
				PreparedStatement ps = null, ps1 = null, preparedStatement=null;
				ResultSet workshopresult = null, centeridrs = null, responsers = null;				
				//System.out.println("Quiz Record ID: " + quizrecordid);
				DatabaseConnection dbcon = new DatabaseConnection();
				Connection con = dbcon.createRemoteDatabaseConnection();
				
				QuizResponse quizresponse = new QuizResponse( );				
				
				try {
						ps = con.prepareStatement("Select WorkshopID,MCQuizRecordID from quizrecord where QuizRecordID = ?");
						ps.setInt(1, quizrecordid);
						
						workshopresult = ps.executeQuery();
						workshopresult.next( );
						workshopid = workshopresult.getString("WorkshopID");
						quizid=workshopresult.getInt("MCQuizRecordID");
						ps = con.prepareStatement("Select CenterID from remotecenter");
						
						centeridrs = ps.executeQuery();
						centeridrs.next();
						centerid = centeridrs.getInt("CenterID");
						ps1 = con.prepareStatement("SELECT qr.MCQuizRecordID,ParticipantID, QuestionID, GROUP_CONCAT(Response order by Response SEPARATOR '' ) as Response from quizrecordquestion qrq, quizrecord qr where qrq.QuizRecordID = ? and qr.QuizRecordID= qrq.QuizRecordID group by QuestionID,ParticipantID order by ParticipantID, QRQID");
						ps1.setInt(1, quizrecordid);						
						responsers = ps1.executeQuery();					
						quizresponse.setCenterid(centerid);		
						quizresponse.setWorkshopid(workshopid);
						ArrayList<String> options = new ArrayList<String>();
						String pid= "";
						
						
						if(responsers.next()){
							options.add(responsers.getString("Response"));
							participantid = responsers.getString("ParticipantID");							
							quizid = responsers.getInt("MCQuizRecordID");
						}
						while(responsers.next()){							
							pid = responsers.getString("ParticipantID");							
							if(pid.equals(participantid)){
								participantid = pid;
								options.add(responsers.getString("Response"));						
							}else{
								Participant participant = new Participant();
								participant.setParticipant(participantid);
								participant.setOptions(options);		
								participantlist.add(participant);
								options = new ArrayList<String>();
								options.add(responsers.getString("Response"));
								participantid = pid;
							}							
						}
						
						Participant participant = new Participant();
						participant.setParticipant(participantid);
						participant.setOptions(options);		
						participantlist.add(participant);
						quizresponse.setQuizid(quizid);
						quizresponse.setParticipant(participantlist);
						
						
						
						
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally{
						try{
							
							workshopresult.close();
							centeridrs.close();
							responsers.close();
							ps.close( );
							ps1.close( );
							
						}catch(Exception e){
							System.out.println(e);
						}
					}
					
					Gson gson = new Gson();
					String qr = gson.toJson(quizresponse);
					System.out.println("MC Response Json: " + gson.toJson(quizresponse));
					
					String status=sendDatatoMainCenter(qr, MainCenterURL);
					
					/*
					 * this will update response send to participant response only after acknowledgement is received from main center
					 */
					
					if(status.equals("Response Saved")){
						
					try{
					//Updating response send parameter for participant
					String update = "UPDATE quizrecordquestion SET ResponseSend = 1 WHERE QuizRecordID=? and ParticipantID = ?";
					preparedStatement = con.prepareStatement(update);
					
					for(int p=0;p<participantlist.size();p++){
						
						Participant pvalue = new Participant();
						pvalue=participantlist.get(p);
						String particpantID = pvalue.getParticipant();
						preparedStatement.setInt(1,quizrecordid);
						preparedStatement.setString(2,particpantID);
						preparedStatement .executeUpdate();
						//System.out.println("Response send for this participant :"+particpantID+" ResponseSend updated to 1");
					
					}
					}catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally
					{
						try {
								preparedStatement.close();
								//dbcon.closeRemoteConnection(con);
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					}else{
						
						System.out.println("Response is not updated as sended for this remotecnter::::"+status);
					}
					dbcon.closeRemoteConnection(con);
					
		}
		
		
		public void ResendJsonForLateResponse(String MainCenterURL){
		
			PreparedStatement ps = null, ps1=null,ps2=null,ps3=null,ps4=null;
			ResultSet quizrecordidrs = null,quizRecordDetail=null ,centerid=null,responses=null;
			int QuizRecordID=0,MCQuizRecordID=0,RemoteCenterID=0;
			String WorkshopID=null,participantID=null;
			QuizResponse quizresponse = new QuizResponse( );
			 ArrayList<Participant> participantlist = new ArrayList<Participant>();
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			try{
				
				ps2 = con.prepareStatement("Select CenterID from remotecenter");
				
				centerid = ps2.executeQuery();
				centerid.next();
				RemoteCenterID = centerid.getInt("CenterID");
				
				ps = con.prepareStatement("Select distinct(QuizRecordID) from quizrecordquestion where ResponseSend = 0");
				quizrecordidrs=ps.executeQuery();
				
				try{
					
				if(quizrecordidrs!=null){
					
					while(quizrecordidrs.next()){
						QuizRecordID=quizrecordidrs.getInt("QuizRecordID");
						
						//Getting QuizID, WorkshopID and MCQuizRecordID from quizRecord for sending to Main center
						
						ps1=con.prepareStatement("Select WorkshopID,MCQuizRecordID from quizrecord where QuizRecordID = ?");
						ps1.setInt(1, QuizRecordID);
						quizRecordDetail=ps1.executeQuery();
						
						if(quizRecordDetail!=null){
							
						while(quizRecordDetail.next()){
							
							participantlist.clear();
							WorkshopID=quizRecordDetail.getString("WorkshopID");						
							MCQuizRecordID=quizRecordDetail.getInt("MCQuizRecordID");
							ps3=con.prepareStatement("SELECT ParticipantID, QuestionID, GROUP_CONCAT(Response order by Response SEPARATOR '' ) as Response from quizrecordquestion qrq, quizrecord qr where qrq.QuizRecordID = ? and qr.QuizRecordID= qrq.QuizRecordID and qrq.ResponseSend=0 group by QuestionID,ParticipantID order by ParticipantID, QRQID");
							ps3.setInt(1, QuizRecordID);						
							responses = ps3.executeQuery();	
							
							quizresponse.setCenterid(RemoteCenterID);		
							quizresponse.setWorkshopid(WorkshopID);
							ArrayList<String> options = new ArrayList<String>();
							String pid= "";
							
							
							if(responses.next()){
								options.add(responses.getString("Response"));
								participantID = responses.getString("ParticipantID");							
								
							}
							while(responses.next()){							
								pid = responses.getString("ParticipantID");							
								if(pid.equals(participantID)){
									participantID = pid;
									options.add(responses.getString("Response"));						
								}else{
									Participant participant = new Participant();
									participant.setParticipant(participantID);
									participant.setOptions(options);		
									participantlist.add(participant);
									options = new ArrayList<String>();
									options.add(responses.getString("Response"));
									participantID = pid;
								}							
							}
							
							Participant participant = new Participant();
							participant.setParticipant(participantID);
							participant.setOptions(options);		
							participantlist.add(participant);
							quizresponse.setQuizid(MCQuizRecordID);
							quizresponse.setParticipant(participantlist);
							
							Gson gson = new Gson();
							String qr = gson.toJson(quizresponse);
							System.out.println("Resending MC Response Json: " + gson.toJson(quizresponse));
							String status=sendDatatoMainCenter(qr, MainCenterURL);

							/*
							 * this will update response send to participant response only after acknowledgement is received from main center
							 */
							if(status!=null){
							if(status.equals("Response Saved")){
								
							try{
							//Updating response send parameter for participant
							String update = "UPDATE quizrecordquestion SET ResponseSend = 1 WHERE QuizRecordID=? and ParticipantID = ?";
							ps4 = con.prepareStatement(update);
							
							for(int p=0;p<participantlist.size();p++){
								
								Participant pvalue = new Participant();
								pvalue=participantlist.get(p);
								String particpantID = pvalue.getParticipant();
								ps4.setInt(1,QuizRecordID);
								ps4.setString(2,particpantID);
								ps4 .executeUpdate();
								//System.out.println("Response send for this participant :"+particpantID+" ResponseSend updated to 1");
							
							}
							}catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}else{
							System.out.println("Response is not updated as sended at remotecnter:::"+status);
						}
							}
						}	
						
						
						}
						
					}
					
				}else{
					
					System.out.println("All Participant response is already send to Main Center");
					
				}
				}catch(Exception e){
					System.out.println("All Response have already send, No pending Response");
				}finally{
					try {
						

						if(quizRecordDetail!=null)quizRecordDetail.close();
						if(centerid!=null)centerid.close();
						if(responses!=null)responses.close();
						if(ps1!=null)ps1.close();
						if(ps3!=null)ps3.close();
						if(ps4!=null)ps4.close();
						
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
				}
			}catch(Exception e){
				
				System.out.println("All Participant response is already send to Main Center");
				
			}finally{
				try {
					
					if(quizrecordidrs!=null)quizrecordidrs.close();
					if(ps!=null)ps.close();
					if(ps2!=null)ps2.close();
					if(con!=null)dbcon.closeRemoteConnection(con);
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
					
		}
			
		
		
		public String sendDatatoMainCenter(String quizresponse, String MainCenterURL)
		{
			URL url = null;
			String maincenterurl = "";
			String output=null;
						
			try {
				
				maincenterurl = MainCenterURL;
				System.out.println("Maincenter URL: " + maincenterurl);
				
				url = new URL("http://" + maincenterurl + "/clicker/rest/quiz/remoteresponse");
				System.out.println("URL "+url );
				HttpURLConnection conn = null;
				
				conn = (HttpURLConnection) url.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-Type", "application/json");
				
				OutputStream os;
				
				os = conn.getOutputStream();
				os.write(quizresponse.getBytes());
				os.flush();
				
				if (conn.getResponseCode() != 200) {
					throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
				}
		 
				BufferedReader br = new BufferedReader(new InputStreamReader(
						(conn.getInputStream())));
				output=br.readLine();
				System.out.println("Output from Server .... \n");
				conn.disconnect();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return output;
		}
		
		public String createResponseJSON(int mcquizrecordid, String workshopID, String coordinatorID){
			InstantQuizResponse quizResponse = new InstantQuizResponse();
			String centerid = new RemoteDBHelper().getRemoteCenterID(workshopID, coordinatorID);
			quizResponse.setCenterid(centerid);
			quizResponse.setQuizrecordid(mcquizrecordid);
			quizResponse.setWorkshopid(workshopID);
			ArrayList<ParticipantResponse> participantresponses = new ArrayList<ParticipantResponse>();
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			String sql = "select ParticipantID, IQuestionID, Response from instantquizresponsenew where IQuizID=?";
			PreparedStatement ps =null;
			try{
				ps = con.prepareStatement(sql);
				ps.setInt(1, Global.remotequizrecordids.get(workshopID));
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					ParticipantResponse participant = new ParticipantResponse();
					participant.setParticipantid(rs.getString("ParticipantID"));
					participant.setQuestionid(rs.getInt("IQuestionID"));
					participant.setResponse(rs.getString("Response"));
					participantresponses.add(participant);
				}
				quizResponse.setParticipantResponse(participantresponses);
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally{
				if(ps!=null){
					try {
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(con!=null){
					dbcon.closeRemoteConnection(con);
				}
			}
			Gson gson = new Gson();
		    String responseJSON = gson.toJson(quizResponse);
		    System.out.println(responseJSON);
			return responseJSON;
		}
		
		
		public void updateResponseSendForInstantQ(InstantQuizResponse instantQR){
			
			PreparedStatement ps = null, ps1=null;
			ResultSet iqquizrecordidrs = null;
			int iquizID=0;
			InstantQuizResponse iqResponse = new InstantQuizResponse();
			iqResponse=instantQR;
			String WorkshopID=iqResponse.getWorkshopid();
			int MCQuizRecordID=iqResponse.getQuizrecordid();
			ArrayList<ParticipantResponse> participantresponseslist=iqResponse.getParticipantResponse();
			
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			try{
			ps = con.prepareStatement("SELECT IQuizID FROM instantquiznew where WorkshopID=? and MCQuizID=?");
			ps.setString(1, WorkshopID);
			ps.setInt(2,MCQuizRecordID);
			iqquizrecordidrs = ps.executeQuery();
			if(iqquizrecordidrs!=null){
				iqquizrecordidrs.next( );
				iquizID = iqquizrecordidrs.getInt("IQuizID");
			}
			
				if(iquizID!=0){
				//Updating response send parameter for participant for instant quiz
				String update = "update instantquizresponsenew set ResponseSend=1 where ParticipantID=? and IQuestionID=? and IQuizID=? and Response=?";
				ps1 = con.prepareStatement(update);
				
				for(int p=0;p<participantresponseslist.size();p++){
					
					ParticipantResponse pvalue = new ParticipantResponse();
					pvalue=participantresponseslist.get(p);
					String particpantID = pvalue.getParticipantid();
					int QuestionID=pvalue.getQuestionid();
					String Response=pvalue.getResponse();
					ps1.setString(1,particpantID);
					ps1.setInt(2,QuestionID);
					ps1.setInt(3,iquizID);
					ps1.setString(4,Response);
					ps1 .executeUpdate();
					//System.out.println("Response send for this participant :"+particpantID+" ResponseSend updated to 1");
				
				}
				System.out.println("Response send  is updated to 1");
				}else{
					System.out.println("Response is not send  and thus not updated to 1");
				}
				
				}catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally{
					try{
						
						if(ps1!=null)ps1.close();
						if(iqquizrecordidrs!=null)iqquizrecordidrs.close();
						if(ps!=null)ps.close();
						if(con!=null)dbcon.closeRemoteConnection(con);
						
					}catch(Exception e){
						e.printStackTrace();
					}
					
				}
		}
		
		
		public void createAndReSendIQResponseJsonToMC(String MainCenterURL){
			
			String remoteCenterID=null, workshopID=null;
			int IquizID=0, mcQuizRecordID=0;
			PreparedStatement ps = null, ps1=null,ps2=null,ps3=null;
			ResultSet instantquizID = null,instantquizDetail=null ,centerid=null,responses=null;;
			InstantQuizResponse quizResponse = new InstantQuizResponse();
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			try{
			ps = con.prepareStatement("Select CenterID from remotecenter");
			
			centerid = ps.executeQuery();
			centerid.next();
			remoteCenterID = centerid.getString("CenterID");
			
			
			ps1=con.prepareStatement("SELECT Distinct(IQuizID) from instantquizresponsenew where ResponseSend=0");
			instantquizID=ps1.executeQuery();
			if(instantquizID!=null){
				
				while(instantquizID.next()){
					IquizID=instantquizID.getInt("IQuizID");
					ps2=con.prepareStatement("SELECT WorkshopID,MCQuizID FROM instantquiznew where IQuizID=?");
					ps2.setInt(1,IquizID );
					instantquizDetail=ps2.executeQuery();
					instantquizDetail.next();
					mcQuizRecordID=instantquizDetail.getInt("MCQuizID");
					workshopID=instantquizDetail.getString("WorkshopID");
					quizResponse.setCenterid(remoteCenterID);
					quizResponse.setQuizrecordid(mcQuizRecordID);
					quizResponse.setWorkshopid(workshopID);
					
					ArrayList<ParticipantResponse> participantresponses = new ArrayList<ParticipantResponse>();
					
					String sql = "select ParticipantID, IQuestionID, Response from instantquizresponsenew where IQuizID=? and ResponseSend=0";
					ps3 = con.prepareStatement(sql);
					ps3.setInt(1,IquizID );
					responses = ps3.executeQuery();
					while(responses.next()){
						ParticipantResponse participant = new ParticipantResponse();
						participant.setParticipantid(responses.getString("ParticipantID"));
						participant.setQuestionid(responses.getInt("IQuestionID"));
						participant.setResponse(responses.getString("Response"));
						participantresponses.add(participant);
					}
					quizResponse.setParticipantResponse(participantresponses);
					Gson gson = new Gson();
				    String responseJSON = gson.toJson(quizResponse);
				    JSONReadandparse sendJson=new JSONReadandparse();
				    sendJson.resendInstantQuizResponceJSON(responseJSON,MainCenterURL);
				}
				
			}else{
				System.out.println("Response for all instant quiz is already send to main center");
			}
			
	
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally{
					try {
						if(responses!=null)responses.close();
						if(ps3!=null)ps3.close();
						if(instantquizDetail!=null)instantquizDetail.close();
						if(ps2!=null)ps2.close();
						if(instantquizID!=null)instantquizID.close();
						if(ps1!=null)ps1.close();
						if(centerid!=null)centerid.close();
						if(ps!=null)ps.close();
						if(con!=null)dbcon.closeRemoteConnection(con);
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			
	
		}
		
		
		
		public String createAutoTestResponseJSON(int quizrecordid, String workshopID, String coordinatorID){
			InstantQuizResponse quizResponse = new InstantQuizResponse();
			String centerid = new RemoteDBHelper().getRemoteCenterID(workshopID, coordinatorID);
			quizResponse.setCenterid(centerid);
			quizResponse.setQuizrecordid(quizrecordid);
			quizResponse.setWorkshopid(workshopID);
			ArrayList<ParticipantResponse> participantresponses = new ArrayList<ParticipantResponse>();
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			String sql = "select ParticipantID, IQuestionID, Response from autotestresponse where IQuizID=?";
			PreparedStatement ps =null;
			try{
				ps = con.prepareStatement(sql);
				ps.setInt(1, quizrecordid);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					ParticipantResponse participant = new ParticipantResponse();
					participant.setParticipantid(rs.getString("ParticipantID"));
					participant.setQuestionid(rs.getInt("IQuestionID"));
					participant.setResponse(rs.getString("Response"));
					participantresponses.add(participant);
				}
				quizResponse.setParticipantResponse(participantresponses);
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally{
				if(ps!=null){
					try {
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(con!=null){
					dbcon.closeRemoteConnection(con);
				}
			}
			Gson gson = new Gson();
		    String responseJSON = gson.toJson(quizResponse);
		    System.out.println(responseJSON);
			return responseJSON;
		}
		
		
	// Below function are for High chart
		
		/*
		 * This below function is used to get the count of correct answer, wrong answer and not response answer according to 
		 * questions list in Normal Quiz.
		 * It will return a string having all this count 
		 * It is being used to pass this value to highcharts javascript for displaying chart 
		 */
		
		public String getNormalQuizResponseCount(int quizRecordID,String WorkshopID){
			System.out.println("QuizRecordid :::"+quizRecordID);
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
			Quiz quiz = Global.workshopjsonobject.get(WorkshopID);
			String questionIDpatten ="" ;
			System.out.println(quiz.getquestions().size());
			for(int i=0;i<quiz.getquestions().size();i++){
				Question question=quiz.getquestions().get(i);
				questionIDpatten +=question.getId()+ "@";
			}
			System.out.println("Question ID rom  responsehelper class ::::"+questionIDpatten);
			String questionIDs[] = questionIDpatten.split("@");
			int noofQuestions = questionIDs.length;   
			for(int j=0;j<noofQuestions;j++){
				System.out.println(questionIDs[j]);
				if(!questionIDs[j].equals("")){
					try{
						con = dbcon.createRemoteDatabaseConnection();
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
						pst1 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.ParticipantID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID =? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.ParticipantID order by qrq.Response) as Sresponse where Sresponse.Response LIKE ? group by Response");
						pst1.setInt(1, quizRecordID);
						pst1.setInt(2, Integer.parseInt(questionIDs[j]));
						pst1.setString(3,correctAnswer);
						rs1 = pst1.executeQuery();

						while (rs1.next()) {
							count=rs1.getString("RCount");
							correctAnsCount+= Integer.parseInt( count);
						}
						pst2 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.ParticipantID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID = ? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.ParticipantID order by qrq.Response) as Sresponse where Sresponse.Response NOT LIKE ? and Sresponse.Response NOT LIKE 'Z'  group by Response");
						pst2.setInt(1, quizRecordID);
						pst2.setInt(2, Integer.parseInt(questionIDs[j]));
						pst2.setString(3,correctAnswer);
						rs2 = pst2.executeQuery();

						while (rs2.next()) {
							count1=rs2.getString("RCount");
							wrongAnsCount+=Integer.parseInt( count1);		
						}
						pst3 = con.prepareStatement("Select count(*) as RCount from (select GROUP_CONCAT(qrq.Response order by qrq.Response SEPARATOR '') as Response, qrq.ParticipantID, q.QuestionType from quizrecordquestion qrq, options o, question q where qrq.QuizRecordID =? and qrq.QuestionID = ? and q.QuestionID = qrq.QuestionID and o.OptionID = qrq.OptionID group by qrq.ParticipantID order by qrq.Response) as Sresponse where Sresponse.Response  LIKE 'Z' group by Response");
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
							if(con!=null)dbcon.closeRemoteConnection(con);
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
			
			RemoteDBHelper remoteDBHelper =new RemoteDBHelper();
			String questionIDpatten = remoteDBHelper.getInstantQuestionIDs(quizRecordID);;
			System.out.println(questionIDpatten);
			String questionIDs[] = questionIDpatten.split("@");
			int noofQuestions = questionIDs.length;   
			for(int j=0;j<noofQuestions;j++){
				System.out.println(questionIDs[j]);
				if(!questionIDs[j].equals("")){
					try{
						con = dbcon.createRemoteDatabaseConnection();
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
							if(con!=null)dbcon.closeRemoteConnection(con);
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

	
