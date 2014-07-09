/*
 * Author Dipti, Rajavel
 * 
 */

package clicker.v4.rest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;



//import org.json.simple.JSONObject;
//import org.json.simple.JSONArray;
import org.json.simple.parser.*;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.global.Global;
import clicker.v4.poll.Poll;
import clicker.v4.poll.RemoteParticipant;
import clicker.v4.poll.RemotePoll;
import clicker.v4.remote.RemoteDBHelper;
import clicker.v4.remote.RemoteQuizResponseHelper;
import clicker.v4.wrappers.InstantQuizResponse;
import clicker.v4.wrappers.Quiz;

import com.google.gson.Gson;

import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class JSONReadandparse {

	static InputStream is = null;
	static JSONObject jObj = null;
	static String json = "";
	static String mainlaunchtime=null;

	// constructor
	public JSONReadandparse() {

	}

	private  String readAll(Reader rd) {
		StringBuilder sb = new StringBuilder();
		int cp;
		try {
			while ((cp = rd.read()) != -1) {
				sb.append((char) cp);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Error in main Server IP");
		}
		return sb.toString();
	}
	
	
	/*
	 * this is used to reach maincenter
	 */
	public  String connectToMainCenterFromUrl(String MainCenterIP) throws IOException, ParseException {
		InputStream is=null;
		String url="http://"+MainCenterIP+"/clicker/";
		String reachable=null;
		try{
			is= new URL(url).openStream();
			if(is==null){
				reachable="notreachable";
			}else{
				reachable="reachable";
			}
		}catch(Exception e){
			reachable="notreachable";
			System.out.println("Problem on main server url");

		} finally {
			try{
				is.close();
			}catch(Exception e){
				System.out.println("Problem in closing InputStream  ");
			}
		}

		return reachable;
	}
	
	/*
	 * this is used to get all workshop being conducted at maincenter
	 */
	public  String[] getWorkshopListFromUrl(String MainCenterIP) throws IOException, ParseException {
		InputStream is=null;
		String url="http://"+MainCenterIP+"/clicker/rest/quiz/getworkshoplist";
		System.out.println("URL to be fetch for workshop list : "+url);
		String jsonText=null;
		String [] workshopList=null;
		Gson gson = new Gson();

		try{
			is= new URL(url).openStream();
			BufferedReader rd=null;
			rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			jsonText = readAll(rd);
			String[] obj = gson.fromJson(jsonText, String[].class);
			workshopList=obj;
		}catch(Exception e){
			
			System.out.println("Error in main Server IP" );


		} finally {
			try{
				is.close();
			}catch(Exception e){
				System.out.println("Problem in closing InputStream  ");
			}
		}

		return workshopList;
	}

	
	
	
	/*
	 * this is used to read the status of server using rest
	 */

	public  String readStatusJsonFromUrl(String MainCenterIP,String workshopID) throws IOException, ParseException {
		InputStream is=null;
		String url="http://"+MainCenterIP+"/clicker/rest/quiz/listen/"+workshopID+"/"+MainCenterIP;
		String Status="";
		String jsonText=null;

		try{
			is= new URL(url).openStream();
		}catch(Exception e){

			Status="13"; //IF main server ip is wrongly enter in database while adding workshop
			System.out.println("Error in main Server IP");

		}
		try {
			BufferedReader rd=null;
			try{
				rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			}catch(Exception e){
				Status="13";
				System.out.println("Error in main Server IP");
			}
			try{
				jsonText = readAll(rd);
			}catch(Exception e){
				System.out.println(jsonText+"value of json text ");
				Status="13";
				System.out.println("Error in main Server IP");
			}

			if(jsonText!=null){
				Pattern p = Pattern.compile("\"([^\"]*)\"");
				Matcher m = p.matcher(jsonText);
				while (m.find()) {
					Status=m.group(1); 
				}
			}else{
				Status="13";
				System.out.println("Error in main Server IP");
			}

		} finally {
			try{
				is.close();
			}catch(Exception e){
				Status="13";
				System.out.println("Error in main Server IP");
			}
		}

		return Status;
	}

	/*
	 * This is used to get the normal quiz and instant quiz from main server using REST
	 */

	public  Quiz readQuizJsonFromUrl(String MainCenterIP,String workshopID, String QuizType, String coordinatorID,String centerId) throws IOException, ParseException, NumberFormatException, SQLException {
		String url="http://"+MainCenterIP+"/clicker/rest/quiz/remotequiz/"+workshopID+"/"+centerId;
		Gson gson = new Gson();
		InputStream is = new URL(url).openStream();
		try {
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = readAll(rd);
			Quiz obj = gson.fromJson(jsonText, Quiz.class);
			System.out.println("launch time at server"+obj.getlaunchtime());
			System.out.println("current time at server"+obj.getcurrenttime());
			

			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

			Date d1 = null;
			Date d2 = null;

			try {
				d1 = format.parse(obj.getlaunchtime());
				d2 = format.parse(obj.getcurrenttime());

				long diff = d2.getTime() - d1.getTime();
				long diffSeconds = diff / 1000; 
				System.out.print(diffSeconds+ " seconds delay");

				/* 
				 * this is consider for if delay is due to network access
				 * I have taken 8 sec as max delay that can happen due to network 
				 */
				if(diffSeconds<8){
					//If delay is less than 8 sec then same full quiz time will be given to RC
					System.out.println("this difference to be added from quiztime :"+diffSeconds);
					obj.setQuizTime(obj.getQuizTime());
					String currenttime  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
					obj.setlaunchtime(currenttime);
					obj.setcurrenttime(currenttime);

				}else{
					//If delay is more than 8 sec then only remaining quiz time will be given to RC
					System.out.println("this difference to be subtracted from quiztime :"+diffSeconds);
					long removedelaysec= Long.parseLong(obj.getQuizTime())-diffSeconds;
					String newQuiztime=Long.toString(removedelaysec);
					obj.setQuizTime(newQuiztime);

					String currenttime  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
					Date d3=null;
					d3 = format.parse(currenttime);
					Calendar cal = Calendar.getInstance();
					cal.setTimeInMillis(d3.getTime());
					cal.add(Calendar.SECOND, (int) -diffSeconds);
					String later = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
					//System.out.println("current time of the system "+currenttime);
					//System.out.println("launched time of the system"+later);
					obj.setlaunchtime(later);
					obj.setcurrenttime(currenttime);
					System.out.println("launch time at remote"+later);
					System.out.println("current time at remote"+currenttime);
				}



			}catch(Exception e){
				System.out.println(e);
			}
			obj.setcourseId(workshopID);
			RemoteDBHelper dbh=new RemoteDBHelper();
			try {
				if(QuizType.equals("instant")){
					obj.setQuiztype("instant");
					dbh.insertRemoteInstantQuizDetails(obj,workshopID, coordinatorID);
					obj.setQuizrecordId(Global.remotequizrecordids.get(workshopID));
				}else{
					dbh.insertRemoteQuizDetails(obj,workshopID);
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.out.println("Problem in saving entry in database");
			}
			Global.workshopjsonobject.put(workshopID, obj);
			System.out.println(gson.toJson(obj));
			if(!QuizType.equals("instant")){
				System.out.println("mcqid" + obj.getQuizrecordId());
			int quizrecordid=dbh.setRemoteQuizLaunchTime(workshopID,Integer.parseInt(obj.getQuizTime()), obj.getQuizrecordId());
			obj.setQuizrecordId(quizrecordid);
			System.out.println("quiz record id : "+quizrecordid);
			}
			
			return obj;

		} finally {
			is.close();
		}
	}

	/*
	 * this is used to send status to maincenter that your Rc has receive quiz successfully and acknowledgement is received 
	 * from maincenter.
	 */
	public  String updateStatusReceivedQuiz(String MainCenterIP,String CenterId,String McQuizRecordId,String WorkshopId,String RCstatus) throws IOException, ParseException {
		InputStream is=null;
		String url="http://"+MainCenterIP+"/clicker/rest/quiz/updatereceivedstatus/"+WorkshopId+"/"+CenterId+"/"+McQuizRecordId+"/"+RCstatus;
		String jsonText=null;
		String status=null;
		Gson gson = new Gson();

		try{
			is= new URL(url).openStream();
			BufferedReader rd=null;
			rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			jsonText = readAll(rd);
			String obj = gson.fromJson(jsonText, String.class);
			status=obj;
		}catch(Exception e){
			
			System.out.println("Error in main Server IP" );


		} finally {
			try{
				is.close();
			}catch(Exception e){
				System.out.println("Problem in closing InputStream  ");
			}
		}

		return status;
	}

	
	
	
	
// read poll json
	public  Poll readPollJsonFromUrl(String url,String workshopID) throws IOException, ParseException {
		Gson gson = new Gson();
	    InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);
	      
	      Poll obj = gson.fromJson(jsonText, Poll.class);
	      mainlaunchtime = obj.getlaunchtime();
	     System.out.println("This is launch time at server :-  "+mainlaunchtime);
	
	      obj.setcourseid(workshopID);
	     
	      
	     
	    
	      //Global.workshoppolljsonobject.put(workshopID, obj);
	  
	      System.out.println("poll json reading in remote : "+gson.toJson(obj));
	      
	      return obj;

	    } finally {
	      is.close();
	    }
	  }

	//to ceate main center json pollresponse
	public  void newPollJsonForMain(String workshopID ,String Coordinator ,String centerID, String pollquestion, String MainCenterURL) throws IOException, ParseException {
		String mainjson=null;
		//Poll poll= new Poll();
		String launchtime=Global.workshoppolljsonobject.get(workshopID).getlaunchtime();
		

		
		//1. set wid in RemoteParticipant.java
		RemotePoll rpoll = new RemotePoll();
		rpoll.setworkshopid(workshopID);
			
		//2.set cid in RemoteParticipant.java
		rpoll.setcenterid(centerID);
		
		//3.set pollquestion RemoteParticipant.java
		rpoll.setpollquestion(pollquestion);
		
		//4.set launchtime RemoteParticipant.java
		rpoll.setlaunchtime(launchtime);
			
		
		
		//5. setting partid and res in pollal arraylist
		//RemoteDBHelper dbh=new RemoteDBHelper();
		
	   
	    //String centerid = null;
		Connection conn = null;
		PreparedStatement st1 =null;
		
		ArrayList<RemoteParticipant> pollal = new ArrayList<RemoteParticipant>();
	    
		DatabaseConnection dbcon = new DatabaseConnection();
		conn=dbcon.createRemoteDatabaseConnection();
		try{
				String selectquery="SELECT ParticipantID , Response from poll p, pollquestion pq where p.TimeStamp=? and pq.PollID=p.PollID and pq.WorkshopID=?";
				st1 = conn.prepareStatement(selectquery);
				st1.setString(1, launchtime);
				st1.setString(2, workshopID);
				
				ResultSet resultSet = st1.executeQuery();
				
				while (resultSet.next())
				{
					RemoteParticipant rp=new RemoteParticipant();
					rp.setpid(resultSet.getString("ParticipantID"))  ;
					rp.setresponse(resultSet.getString("Response"));
					pollal.add(rp);
					
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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
					}
		
		
		
		//6.add arraylist pollal to RemoteParticipant.java
		rpoll.setpresponse(pollal);
		
		//7.create json
		Gson gson = new Gson();
		mainjson = gson.toJson(rpoll);
		System.out.println("main centre json: "+mainjson);
		
		sendJsonToUrl(mainjson , workshopID , Coordinator,MainCenterURL);
		

		


	}

	//sending json to main url

	public void sendJsonToUrl(String mainjson , String workshopID ,String Coordinator ,String MainCenterURL) throws IOException, ParseException {
		System.out.println("******main center url for sendung response url is ----"+MainCenterURL);

		URL url = null;
		try {
			url = new URL("http://"+MainCenterURL+"/clicker/rest/quiz/poll");
			HttpURLConnection conn = null;
			
			conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			
			OutputStream os;
			
			os = conn.getOutputStream();
			os.write(mainjson.getBytes());
			os.flush();
			
			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
					+ conn.getResponseCode());
			}
	 
			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));
	 
			String output;
			System.out.println("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				System.out.println("status in remote  center: " + output);
			}
	 
			conn.disconnect();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	
	
	public String sendInstantQuizResponceJSON(int quizrecordid, String MainCenterIP, String workshopID, String coordinatorID){
		System.out.println("Inside send instant quiz json");
		URL url = null;
		String output = null;
		Gson gson = new Gson();
		RemoteQuizResponseHelper rqrh= new RemoteQuizResponseHelper();
		InstantQuizResponse quizResponse =new InstantQuizResponse();
		quizResponse=null;
		try {
			url = new URL("http://"+MainCenterIP+"/clicker/rest/quiz/instantquizresponse");
			HttpURLConnection httpURLconn = (HttpURLConnection) url.openConnection();
			httpURLconn.setDoOutput(true);
			httpURLconn.setRequestMethod("POST");
			httpURLconn.setRequestProperty("Content-Type", "application/json");			
			OutputStream os = httpURLconn.getOutputStream();
			String responseJSON = rqrh.createResponseJSON(quizrecordid, workshopID, coordinatorID);
			os.write(responseJSON.getBytes());
			os.flush();			
			if (httpURLconn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "+ httpURLconn.getResponseCode());
			}	 
			BufferedReader br = new BufferedReader(new InputStreamReader(httpURLconn.getInputStream()));
			output=br.readLine(); 
			httpURLconn.disconnect();	
			if(output!=null){
				
			if(output.equals("Instant Quiz Response saved")){
				quizResponse=gson.fromJson(responseJSON, InstantQuizResponse.class);
				if(quizResponse!=null){
					rqrh.updateResponseSendForInstantQ(quizResponse);
				}
				
			}else{
				System.out.println("Saving failed at MC, feedback obtained from main center is :"+output);
			}
			
			}else{
				System.out.println("Remotecenter ws not able to connect to maincenter and save responses");
			}
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
	
	
	public String resendInstantQuizResponceJSON(String PendingIQResponseJson,String MainCenterIP){
		System.out.println("Inside resend instant quiz json");
		URL url = null;
		String output = null;
		Gson gson = new Gson();
		RemoteQuizResponseHelper rqrh= new RemoteQuizResponseHelper();
		InstantQuizResponse quizResponse =new InstantQuizResponse();
		quizResponse=null;
		try {
			System.out.println("Main center : " +MainCenterIP);
			url = new URL("http://"+MainCenterIP+"/clicker/rest/quiz/instantquizresponse");
			HttpURLConnection httpURLconn = (HttpURLConnection) url.openConnection();
			httpURLconn.setDoOutput(true);
			httpURLconn.setRequestMethod("POST");
			httpURLconn.setRequestProperty("Content-Type", "application/json");			
			OutputStream os = httpURLconn.getOutputStream();
			String responseJSON = PendingIQResponseJson;
			os.write(responseJSON.getBytes());
			os.flush();			
			if (httpURLconn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "+ httpURLconn.getResponseCode());
			}	 
			BufferedReader br = new BufferedReader(new InputStreamReader(httpURLconn.getInputStream()));
			output=br.readLine(); 
			httpURLconn.disconnect();	
			if(output!=null){
				
			if(output.equals("Instant Quiz Response saved")){
				quizResponse=gson.fromJson(responseJSON, InstantQuizResponse.class);
				if(quizResponse!=null){
					rqrh.updateResponseSendForInstantQ(quizResponse);
				}else{
					System.out.println("Response is not updated as send  ");
				}
				
			}else{
				System.out.println("Saving failed at MC, feedback obtained from main center is :"+output);
			}
			
			}else{
				System.out.println("Remotecenter ws not able to connect to maincenter and save responses");
			}
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
	
	
	
	
	
	
	public String sendAutoTestResponceJSON(int quizrecordid, String MainCenterIP, String workshopID, String coordinatorID){
		System.out.println("Inside send instant quiz json");
		URL url = null;
		String output = "";
		try {
			url = new URL("http://"+MainCenterIP+"/clicker/rest/quiz/autotestresponse");
			HttpURLConnection httpURLconn = (HttpURLConnection) url.openConnection();
			httpURLconn.setDoOutput(true);
			httpURLconn.setRequestMethod("POST");
			httpURLconn.setRequestProperty("Content-Type", "application/json");			
			OutputStream os = httpURLconn.getOutputStream();
			RemoteQuizResponseHelper responseHelper = new RemoteQuizResponseHelper();
			String responseJSON = responseHelper.createAutoTestResponseJSON(quizrecordid, workshopID, coordinatorID);
			os.write(responseJSON.getBytes());
			os.flush();			
			if (httpURLconn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "+ httpURLconn.getResponseCode());
			}	 
			BufferedReader br = new BufferedReader(new InputStreamReader(httpURLconn.getInputStream()));
	 		while ((output = br.readLine()) != null) {
				System.out.println("Maincenter Responce: " + output);
			}	 
			httpURLconn.disconnect();			
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

	public  Quiz readAutoTestQuizJsonFromUrl(String MainCenterIP, String centerID, String workshopid) throws IOException, ParseException {
		//System.out.println("workshopid: " + workshopid);
		String url="http://"+MainCenterIP+"/clicker/rest/quiz/autotest/"+ workshopid + "/" + centerID;
		Gson gson = new Gson();
		InputStream is = new URL(url).openStream();
		Quiz obj = null;		
		BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
		String jsonText = readAll(rd);
		obj = gson.fromJson(jsonText, Quiz.class);
		//System.out.println("JSON text: " + jsonText);
		JSONObject jsonobj = null;
		String wsid = "";
		try {
				jsonobj= new JSONObject(jsonText);
				wsid = jsonobj.getString("courseId");
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
				
		System.out.println("RC auto test status: " + wsid);
		
		if(!wsid.equals("noautotest"))
		{
			DatabaseConnection dbcon = new DatabaseConnection();
			Connection con = dbcon.createRemoteDatabaseConnection();
			try {					
					SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date mclaunchtime = format.parse(obj.getlaunchtime());
					Date mccurenttime = format.parse(obj.getcurrenttime());
					long diff = mccurenttime.getTime() - mclaunchtime.getTime();
					long diffSeconds = diff / 1000; 
					String currenttime  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
					Date rccurrenttime = format.parse(currenttime);
					Calendar cal = Calendar.getInstance();
					cal.setTimeInMillis(rccurrenttime.getTime());
					cal.add(Calendar.SECOND, (int) -diffSeconds);
					String rclaunchtime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
					obj.setlaunchtime(rclaunchtime);
					obj.setcurrenttime(currenttime);			
					Global.workshopjsonobject.put("autotest", obj);
					System.out.println(gson.toJson(obj));			
					PreparedStatement ps = con.prepareStatement("truncate autotestresponse");
					ps.execute();				
				}catch(SQLException e){
					e.printStackTrace();
				}catch (java.text.ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					is.close();
					dbcon.closeRemoteConnection(con);			
				}
		}
		else
		{
			obj.setcourseId(wsid);
		}
		return obj;		
	}
	
	public void sendClassroomQuizResponseJSON(){
		URL url = null;
		String output = "";
		try {
			RestHelper restHelper = new RestHelper();
			String responseJSON = restHelper.getConductedQuizDetailJSON();
			if(!responseJSON.equals("[]")){
				url = new URL("http://www.it.iitb.ac.in/clicker/rest/quiz/classroomresponse");
				HttpURLConnection httpURLconn = (HttpURLConnection) url.openConnection();
				httpURLconn.setDoOutput(true);
				httpURLconn.setRequestMethod("POST");
				httpURLconn.setRequestProperty("Content-Type", "application/json");			
				OutputStream os = httpURLconn.getOutputStream();			
				os.write(responseJSON.getBytes());
				os.flush();			
				if (httpURLconn.getResponseCode() != 200) {
					throw new RuntimeException("Failed : HTTP error code : "+ httpURLconn.getResponseCode());
				}	 
				BufferedReader br = new BufferedReader(new InputStreamReader(httpURLconn.getInputStream()));
				while ((output = br.readLine()) != null) {
					System.out.println("Maincenter Responce: " + output);
					restHelper.updateClassroomQuizrecord(output);
				}	 
				httpURLconn.disconnect();		
			}else{
				System.out.println("No updated quiz data !!!");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}