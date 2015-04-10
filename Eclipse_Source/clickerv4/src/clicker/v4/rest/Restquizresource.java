package clicker.v4.rest;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;




import javax.servlet.ServletContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.google.gson.Gson;

import clicker.v4.poll.Callpolljson;
import clicker.v4.poll.Poll;
import clicker.v4.poll.PollHelper;
import clicker.v4.quiz.encrypt;
import clicker.v4.raisehand.*;
import clicker.v4.report.ReportHelper;
import clicker.v4.global.Global;
import clicker.v4.util.CourseHelper;
import clicker.v4.wrappers.CourseList;
import clicker.v4.wrappers.Question;
import clicker.v4.wrappers.Quiz;
import clicker.v4.wrappers.QuizMarkList;
import clicker.v4.wrappers.RepliedRaiseHand;
import clicker.v4.remote.*;
import clicker.v4.student.StudentHelper;

//annotation for getting access to this resource PAGE 
@Path("quiz")
/**
 * 
 * @author rajavel, Dipti
 * Clicker Team, IDL Lab - IIT Bombay
 * This class provides the RESTFul services to the students 
 */
public class Restquizresource {

	boolean flag=false;
	RemoteDBHelper remoteDB=new RemoteDBHelper();
	StudentHelper studenthelper=new StudentHelper();
	JSONReadandparse jsonread=new JSONReadandparse();
	//int responsecount = 0, check = 0;			
	int pollcount = 0;
	// Annotation for getting access USING GET METHOD
	@GET 
	// URL to get course list for a student
	@Path("/course/{id}/{mac}")
	// It produces quiz object in JSon format
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used for get the course list for a student
	public String getcoursejson(@PathParam("id") String studentid,@PathParam("mac") String mac){
		System.out.println(studentid);
		String json=null;
		flag=remoteDB.checkWhetherStudent(studentid);
		//System.out.println("Status of remote or local:-- True for local and false for remote..."+flag);
		if(flag){
			String Mode="local";
			CourseHelper courseHelper = new CourseHelper();
			CourseList courseList = new CourseList();
			// Get list of course of a student with active course
			courseList = courseHelper.getCourseList(studentid,mac,Mode);
			Gson gson = new Gson();
			json = gson.toJson(courseList);			
			return json;

		}else{
			String Mode="remote";
			CourseHelper courseHelper = new CourseHelper();
			CourseList courseList = new CourseList();
			// Get list of workshop of a participant with workshop course
			courseList = courseHelper.getCourseList(studentid,mac,Mode);
			Gson gson = new Gson();
			json = gson.toJson(courseList);	
			System.out.println(json);
			return json;

		}
	}


	/*
	 * This is for browser login for student
	 * 
	 */


	// Annotation for getting access USING GET METHOD
	@GET 
	// URL to get course list for a student
	@Path("/courselist/{id}/{password}")
	// It produces quiz object in JSon format
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used for get the course list for a student
	public String getcoursejsonforbrowserlogin(@PathParam("id") String studentid,@PathParam("password") String password) throws IOException, org.json.simple.parser.ParseException{
		System.out.println(studentid);
		String jsontext="WrongUsername";
		flag=remoteDB.checkWhetherStudent(studentid);
		//System.out.println("Status of remote or local:-- True for local and false for remote..."+flag);
		if(flag){

			//Check whether password matches or not 

			boolean flag1=studenthelper.checkStudentPassword(studentid, password);
			if(flag1){
				String Mode="local";
				CourseHelper courseHelper = new CourseHelper();
				CourseList courseList = new CourseList();
				// Get list of course of a student with active course
				courseList = courseHelper.getCourseListForStudent(studentid,password,Mode);
				Gson gson = new Gson();
				jsontext = gson.toJson(courseList);			
				return jsontext;

			}else{
				jsontext="WrongPassword";
			}

		}else{

			boolean flag1=studenthelper.checkParticipantPassword(studentid, password);
			if(flag1){
				String Mode="remote";
				CourseHelper courseHelper = new CourseHelper();
				CourseList courseList = new CourseList();
				// Get list of course of a student with active course
				courseList = courseHelper.getCourseListForStudent(studentid,password,Mode);
				Gson gson = new Gson();
				jsontext = gson.toJson(courseList);			
				return jsontext;
			}else{
				jsontext="WrongPassword";
			}

		}
		return jsontext;
	}
	
	
	/*
	 * This is for browser dependent update password for student and partcipant
	 * 
	 */

	// Annotation for getting access USING GET METHOD
	@GET 
	// URL to update password for student/Participant
	@Path("/updatepwd/{id}/{cpassword}/{newpassword}/{confirmpassword}")
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used for update password for student/participant
	public String updatepasswordforbrowserlogin(@PathParam("id") String studentid,@PathParam("cpassword") String cpassword,@PathParam("newpassword") String newpassword,@PathParam("confirmpassword") String confirmpassword) throws IOException, org.json.simple.parser.ParseException{
		String jsontext="WrongPassword";
		
		//This is used to check if student or participant
		flag=remoteDB.checkWhetherStudent(studentid);
		//System.out.println("Status of remote or local:-- True for local and false for remote..."+flag);
		if(flag){

			//Check whether password matches or not 
			boolean flag1=studenthelper.checkStudentPassword(studentid,cpassword);
			if(flag1){
				
				//To update password for student
					String status= studenthelper.updateStudentPassword(studentid, newpassword);
					jsontext=status;		
					return jsontext;
			}else{
				jsontext="WrongPassword";
			}
		}else{
			
			//Check whether password matches or not 
			boolean flag1=studenthelper.checkParticipantPassword(studentid, cpassword);
			if(flag1){
				
				//To update password for participant
					String status= studenthelper.updateParticipantPassword(studentid, newpassword);
					jsontext=status;		
					return jsontext;
				
			}else{
				jsontext="WrongPassword";
			}
		}
		return jsontext;
	}

	// Annotation for getting access USING GET METHOD
	@GET 
	// URL to get course list for a student
	@Path("/courselist/{id}")
	// It produces quiz object in JSon format
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used for get the course list for a student
	public String getCourseListforBrowserLogin(@PathParam("id") String studentid) throws IOException, org.json.simple.parser.ParseException{
		flag=remoteDB.checkWhetherStudent(studentid);
		if(flag){
			String Mode="local";
			StudentHelper studentHelper = new StudentHelper();
			CourseList courseList = new CourseList();
			courseList = studentHelper.getCourseListForStudent(studentid,Mode);
			Gson gson = new Gson();
			String jsontext = gson.toJson(courseList);			
			return jsontext;
		}else{
			String Mode="remote";
			StudentHelper studentHelper = new StudentHelper();
			CourseList courseList = new CourseList();
			courseList = studentHelper.getCourseListForStudent(studentid,Mode);
			Gson gson = new Gson();
			String jsontext = gson.toJson(courseList);			
			return jsontext;
		}
	}


	// Annotation for getting access USING GET METHOD 
	@GET
	// URL path to get quiz JSon
	@Path("/{courseid}/{mode}/{sid}")
	// It produces quiz object in JSon format
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used to get the quiz data in JSon format
	public String getQuizjson(@PathParam("courseid") String courseid,@PathParam("mode") String mode,@PathParam("sid") String sid) throws IOException{
		String Mode="local";

		if(mode.equals(Mode)||mode==Mode){
			Quiz quiz=null;
			Quiz quiz1 = new Quiz();
			System.out.println(courseid);
			System.out.println(Global.coursejsonobject);
			quiz = Global.coursejsonobject.get(courseid);
			if(quiz!=null){
				System.out.println(quiz);
				System.out.println(quiz.getlaunchtime());
				String launchtime=quiz.getlaunchtime();
				long quiztime=Long.parseLong(quiz.getQuizTime());
				String curr_time= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
				SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd HH:mm:ss");  
				Date d1 = null;
				Date d2 = null;
				try {
					d1 = format.parse(launchtime);
					d2 = format.parse(curr_time);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				// Get microsecond from each, and subtract so that we get updated time.
				long diff = d2.getTime() - d1.getTime();
				long diffSeconds = diff / 1000; 
				// Only when quiz is time is not finish he/she is able to access quiz JSon
				if(diffSeconds < quiztime && Global.respondedstudlist.get(courseid).contains(sid))
				{
					quiz1.setcourseId("-2");
				}
				else if(diffSeconds < quiztime && !Global.respondedstudlist.get(courseid).contains(sid))
				{        	
					quiz.setcurrenttime(curr_time);		
					int count=Integer.parseInt(Global.countrequestjson.get(courseid));
					count++;
					Global.countrequestjson.replace(courseid,""+count);
					System.out.println("Request for quiz : "+count);
					quiz1 = quiz;
				}
				else
				{
					// if quiz is not launched or quiz has been finished 
					System.out.println("time over...cant't get quiz...:(");
				}
			}else
			{
				// if quiz is not launched or quiz has been finished 
				System.out.println("Quiz is not available now");
			}
			Gson gson = new Gson();
			String json = gson.toJson(quiz1);			
			return json;	       

		}else{

			Quiz quiz=null;
			Quiz quiz1 = new Quiz();
			System.out.println(Global.workshopjsonobject);
			quiz = Global.workshopjsonobject.get(courseid);
			if(quiz!=null){
				System.out.println(quiz);
				System.out.println(quiz.getlaunchtime());
				String launchtime=quiz.getlaunchtime();
				long quiztime=Long.parseLong(quiz.getQuizTime());			
				String curr_time= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
				SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd HH:mm:ss");  
				Date d1 = null;
				Date d2 = null;
				try {
					d1 = format.parse(launchtime);
					d2 = format.parse(curr_time);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				// 	Get microsecond from each, and subtract so that we get updated time.
				long diff = d2.getTime() - d1.getTime();
				long diffSeconds = diff / 1000; 
				// 	Only when quiz is time is not finish he/she is able to access quiz JSon
				System.out.println("courseid" + courseid);
				System.out.println("sid" + sid);
				System.out.println(Global.respondedparticipantlist.get(courseid) );
				System.out.println(Global.respondedparticipantlist.get(courseid).contains(sid));
				System.out.println(diffSeconds + "     --    " + quiztime);
				if(diffSeconds < quiztime && Global.respondedparticipantlist.get(courseid).contains(sid))
				{
					quiz1.setcourseId("-2");
				}
				else if(diffSeconds < quiztime && !Global.respondedparticipantlist.get(courseid).contains(sid))
				{        	
					quiz.setcurrenttime(curr_time);		
					quiz1 = new Quiz(quiz);
					ArrayList<Question> questions = new ArrayList<Question>();
					for(int i=0;i<quiz1.getquestions().size();i++){
						Question question = new Question(quiz1.getquestions().get(i));				
						question.setCorrectAns(new encrypt().encrypt1(question.getCorrectAns()));
						questions.add(question);
					}
					quiz1.setquestions(questions);				    
				}
				else
				{
					// 	if quiz is not launched or quiz has been finished 
					System.out.println("time over...cant't get quiz...:(");
				}
			}
			else
			{
				// if quiz is not launched or quiz has been finished 
				System.out.println("Quiz is not available now");
			}				
			Gson gson = new Gson();
			String json = gson.toJson(quiz1);	
			System.out.println("==========>"+json);
			return json;	
		}

	}

	// Annotation for getting access USING POST METHOD 
	@POST
	// URL path to give quiz response in JSon format
	@Path("/response")
	// Gives multiple value (course id, response JSon)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	// Gets the response updated status
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used to update the student's quiz response in server 
	public String getresponsejson(MultivaluedMap<String, String> personParams){		
		// Capture the quiz responses of a student
		String Mode="local";
		String response=personParams.getFirst("response");
		String course_id=personParams.getFirst("courseid");
		String mode=personParams.getFirst("mode");
		RestHelper restHelper = new RestHelper();
		if(mode.equals(Mode)||mode==Mode){				
			restHelper.localModeResponse(response,course_id); 				
		}
		else{
			restHelper.remoteModeResponse(response,course_id);
		}
		return "ResponseSubmitted";
	}

	// Annotation for getting access USING POST METHOD 
	@POST
	// URL path to give quiz response in JSon format
	@Path("/responseweb")
	// Gives multiple value (course id, response JSon)
	@Consumes(MediaType.APPLICATION_JSON)
	// Gets the response updated status
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used to update the student's quiz response in server 
	public String getWebResponseJSON(String responses){		
		// Capture the quiz responses of a student as JSON
		try {
			JSONObject obj = new JSONObject(responses);
			String mode=obj.getString("mode");
			String response=obj.getString("response");
			String course_id=obj.getString("courseid");
			RestHelper restHelper = new RestHelper();
			if(mode.equals("local")||mode=="local"){				
				restHelper.localModeResponse(response,course_id); 				
			}else{
				restHelper.remoteModeResponse(response,course_id);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}		
		return "ResponseSubmitted";
	}



	// here post method is used to raise hand
	@POST
	// path url extention used for accessing raise hand module 
	@Path("/raisequestion")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.APPLICATION_JSON)

	//public String getraisequestion@PathParam("courseid") String courseid,@PathParam("studentid") String studentid,@PathParam("questiontext") String questiontext){
	public String getraisequestion(MultivaluedMap<String, String> personParams) {
		System.out.println("catch raisehand question..."); 
		// get the raise hand question 
		String question_text=personParams.getFirst("questiontext");
		String student_id=personParams.getFirst("studentid");
		String course_id=personParams.getFirst("courseid");
		System.out.println("studentId:"+student_id);
		System.out.println("courseId:"+course_id);
		System.out.println("raised question: "+question_text);         
		RaiseHandHelper rhdb=new RaiseHandHelper();
		try {
			rhdb.saveraisequestiontext(course_id,student_id,question_text);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try{
			int currentCounter = Global.raisehandcounter.get(course_id);
			System.out.println(currentCounter);
			Global.raisehandcounter.replace(course_id, currentCounter+1);
		}catch(Exception e){
			System.out.println("Course is not Active....!");
		}
		return "Your doubt is submitted successfully";
	}

	
	// Annotation for getting access USING GET METHOD
	@GET 
	// URL to get doubt reply for a student
	@Path("/replydoubt/{studentid}/{courseid}")
	// It produces replydoubt object in JSon format
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used for get the course list for a student
	public String getdoubtreplyjson(@PathParam("studentid") String studentid,@PathParam("courseid") String courseid) {
		RaiseHandHelper raisehandHelper = new RaiseHandHelper();
		RepliedRaiseHand replyLists = new RepliedRaiseHand();
		try{
			replyLists=raisehandHelper.getRaiseHandReply(studentid,courseid);
		}catch(Exception e){
			System.out.println(e);
		}
		String json=null;
		Gson gson = new Gson();
		json = gson.toJson(replyLists);			
		return json;
	}



	// Annotation for getting access USING GET METHOD 
	@GET 
	// URL path to get quiz results
	@Path("/result/{courseid}/{studentid}/{mode}")
	// Produces the quiz result in JSon
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used to get quiz mark list with percentage
	public String getresultmaks(@PathParam("courseid") String courseid,@PathParam("studentid") String studentid,@PathParam("mode") String mode){
		QuizMarkList quizMarkList = new QuizMarkList();
		ReportHelper reportHelper = new ReportHelper();
		String json=null;
		// Get quiz mark list for a course of a student
		if(mode.equals("local")){
			quizMarkList = reportHelper.getQuizMarkList(courseid, studentid);
		}else {
			quizMarkList = reportHelper.getQuizMarkListRemote(courseid, studentid);
		}
		Gson gson = new Gson();
		json = gson.toJson(quizMarkList);			
		return json;
	}

	@Context
	ServletContext context;

	// Annotation for getting access USING GET METHOD 
	@GET 
	// URL path to get current version of APK
	@Path("/version")
	// Produces the current version detail with URL in JSon
	@Produces(MediaType.APPLICATION_JSON)
	// Method is used to get quiz current version of APK
	public String getCurrentVersion(){
		JSONObject obj = new JSONObject();
		try {						
			String filename = "";
			float latestversion = 0.0F;
			final File apkpath = new File(context.getRealPath("apk"));			
			for (final File fileEntry : apkpath.listFiles()) {			        
				String file = fileEntry.getName();
				String version;
				if(file.indexOf(".apk")!=-1 && file.lastIndexOf("V")!=-1){
					version = file.substring(file.lastIndexOf("V")+1,file.indexOf(".apk"));
					version = version.replace("_", ".");
					if(isNumeric(version) && Float.parseFloat(version) >= latestversion){
						latestversion = Float.parseFloat(version);
						filename = file;
					}
				}
			}
			System.out.println(latestversion + "  " + Float.toString(latestversion));
			obj.put("version", Float.toString(latestversion));
			obj.put("URL", "apk/"+filename);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return obj.toString();
	}


	public static boolean isNumeric(String str)  
	{  
		try  
		{  
			double d = Double.parseDouble(str);  
			System.out.println("Version - " + d);
		}  
		catch(NumberFormatException nfe)  
		{  
			return false;  
		}  
		return true;  
	}


	// get method used for poll. Student/participants will fetch the poll details from this URL.
	@GET
	// path url used to access poll module
	@Path("/poll/{courseid}/{mode}")
	@Produces(MediaType.APPLICATION_JSON) 
	public String getPolljson(@PathParam("courseid") String courseId , @PathParam("mode") String mode) throws IOException{			     
		String Mode="local";
		if(mode.equals(Mode)||mode==Mode)
		{
			String json3=null;
			Poll pollq=new Poll();
			Poll poll=null;
			String curr_time= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
			SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd HH:mm:ss");  
			// get the lauch time for requested quiz
			poll = Global.polljsonobject.get(courseId);
			if(poll!=null){
				int pollid=poll.getpollid();
				String launchtime=poll.getlaunchtime();
				String pollquestion= poll.getpollquestion();
				String courseid1= poll.getcourseid();
				String quizTime= poll.getquizTime();
				Callpolljson ob=new Callpolljson();
				System.out.println("time :" + launchtime + "CourseID :"+courseid1);
				ob.callpolljson(pollid,courseid1,pollquestion,launchtime,curr_time,quizTime);		
				// get server side time
				long t_duration=Long.parseLong(quizTime);
				Date d1 = null;
				Date d2 = null;
				try {
					d1 = format.parse(launchtime);
					d2 = format.parse(curr_time);
				} catch (Exception e) {
					e.printStackTrace();
				}    

				// Get msec from each, and subtract.
				long diff = d2.getTime() - d1.getTime();
				long diffSeconds = diff / 1000; 
				System.out.println("---------" + (diffSeconds<t_duration));
				if(diffSeconds<t_duration)
				{
					pollq=Global.polljsonobject.get(courseId);
					System.out.println("get poll json");
					Gson gson = new Gson();
					// convert java object to JSON format and returned as JSON formatted string
					json3 = gson.toJson(pollq);
					System.out.println("json to students is : "+json3);
				}
				else
				{				
					Gson gson2 = new Gson();
					json3 = gson2.toJson(pollq);
					System.out.println("pollq2: "+pollq);
					System.out.println("No any live polling....");	        	
				}
			}else{
				Gson gson2 = new Gson();
				json3 = gson2.toJson(pollq);
				System.out.println("pollq2: "+pollq);				
				System.out.println("polling is not started....");
			}
			return json3;

		}
		else
		{	System.out.println("in remote mode");
		String json3=null;
		Poll pollq=new Poll();
		Poll poll=null;
		//String curr_time= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd HH:mm:ss");  
		// get the lauch time for requested quiz
		poll = Global.workshoppolljsonobject.get(courseId);
		if(poll!=null)
		{
			int pollid=poll.getpollid();
			String launchtime=poll.getlaunchtime();
			String curr_time=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
			String pollquestion= poll.getpollquestion();
			String courseid1= poll.getcourseid();
			String quizTime= poll.getquizTime();
			Callpolljson ob=new Callpolljson();
			System.out.println("time :" + launchtime + " curr_time :"+curr_time);
			ob.remotecallpolljson(pollid,courseid1,pollquestion,launchtime,curr_time,quizTime);		
			// get server side time
			long t_duration=Long.parseLong(quizTime);
			Date d1 = null;
			Date d2 = null;
			try {
				d1 = format.parse(launchtime);
				d2 = format.parse(curr_time);
			} catch (Exception e) {
				e.printStackTrace();
			}    

			// Get msec from each, and subtract.
			long diff = d2.getTime() - d1.getTime();
			long diffSeconds = diff / 1000; 
			if(diffSeconds<t_duration)
			{
				pollq=Global.workshoppolljsonobject.get(courseId);
				Gson gson = new Gson();
				// convert java object to JSON format and returned as JSON formatted string
				json3 = gson.toJson(pollq);
				System.out.println("json to students is : "+json3);
			}
			else
			{				
				Gson gson2 = new Gson();
				json3 = gson2.toJson(pollq);
				System.out.println("pollq2: "+pollq);
				System.out.println("No any live polling....");	        	
			}
		}else{
			Gson gson2 = new Gson();
			json3 = gson2.toJson(pollq);
			System.out.println("pollq2: "+pollq);				
			System.out.println("polling is not started....");
		}
		return json3;


		}

	}

	//post method used for poll submission
	@POST
	// path url to poll module
	@Path("/poll")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.APPLICATION_JSON)
	public String getpolljson(MultivaluedMap<String, String> personParams){
	System.out.println("catch pollresponse..."); 
	String Mode="local";
	String student_id = null , response=null , launchtime=null , flag="new";
	int current_pid =0;
	PollHelper ph=new PollHelper();	
	String pollresponse=personParams.getFirst("poll_res");
	String course_id=personParams.getFirst("courseId");
	String mode=personParams.getFirst("mode");
	String pollid=personParams.getFirst("pollId");
	int p_id=Integer.parseInt(pollid);
	
	
	//Checking mode is local or remote
	if(mode.equals(Mode)||mode==Mode)
	{
			System.out.println("courseID:"+course_id);
			System.out.println("pollresponse json:   "+pollresponse);
			System.out.println("mode json:   "+mode);
			System.out.println("pollid json:   "+pollid);
			JSONObject pollresponseJSon = null;
			try {
				pollresponseJSon = new JSONObject(pollresponse);
				 student_id=pollresponseJSon.get("stuid").toString();
				 response = pollresponseJSon.get("option").toString();
				 launchtime=Global.polljsonobject.get(course_id).getlaunchtime();
				 current_pid=ph.getpollidnew(launchtime, course_id);
			} catch (JSONException e) {			
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//checking if this is previous poll response or not.....
			if(current_pid==p_id)
			{
				//checking  if student already gave response from other device or not...
				List<String> check_duplicate_student_response =  Global.respondedpollstudlist.get(course_id);
			
				if(!check_duplicate_student_response.contains(student_id))
				{	
					System.out.println("==--> new entry");
					try {
						ph.savepollresponse(student_id, response, launchtime, course_id , p_id,flag);
					} catch (SQLException e) {
					// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
					check_duplicate_student_response.add(student_id);
					Global.respondedpollstudlist.replace(course_id, check_duplicate_student_response);
					System.out.println(" --> --> after replace  --> -->"+Global.respondedpollstudlist.get(course_id));
				
				
					String prepollresponse=Global.responsepollobject.get(course_id);
					//System.out.println("&&&&&&&&&&&&&& pre_response --> "+Global.responsepollobject.get(course_id));
					// get all student poll results and split 
					pollresponse=prepollresponse+pollresponse+"@@";
					Global.responsepollobject.replace(course_id,pollresponse); 

				
				}
				else
				{
					System.out.println("% already present");
				
				}
			}
			else
			{
				System.out.println("previous poll response------- storing in database------------will not dispaly in chart");
				try {
					flag="old";
					ph.savepollresponse(student_id, response, launchtime, course_id , p_id , flag);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return "Your poll response has been successfully submitted";
	}
	else
	{
		
		RemoteDBHelper rdh= new RemoteDBHelper();
		JSONObject pollresponseJSon = null;
		try {
			pollresponseJSon = new JSONObject(pollresponse);
			student_id=pollresponseJSon.get("stuid").toString();
			response = pollresponseJSon.get("option").toString();
			launchtime=Global.workshoppolljsonobject.get(course_id).getlaunchtime();
			current_pid=rdh.getpollidnew(launchtime, course_id);
			System.out.println("stuid in rest :"+pollresponseJSon.get("stuid").toString());
		}
		 catch (JSONException e) {			
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//**************************************************************************************************************
			
			
			//checking if this is previous poll response or not.....
			if(current_pid==p_id)
			{
				//checking  if student already gave response from other device or not...
				List<String> check_duplicate_student_response =  Global.remoterespondedpollstudlist.get(course_id);
				//System.out.println("%%%%%%%%%%%%%%%%%%%%% ==--> checking list entry : "+Global.remoterespondedpollstudlist.get(course_id));
				if(!check_duplicate_student_response.contains(student_id))
				{	
					System.out.println(" ==--> new entry");
					try {
						rdh.saveremotepollresponse(student_id, response, launchtime,course_id, p_id , flag);
					} catch (SQLException e) {
					// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
					check_duplicate_student_response.add(student_id);
					Global.remoterespondedpollstudlist.replace(course_id, check_duplicate_student_response);
					System.out.println(" --> --> after replace  --> -->"+Global.remoterespondedpollstudlist.get(course_id));
				
				
					String prepollresponse=Global.workshopresponsepollobject.get(course_id);
					// get all student poll results and split 
					pollresponse=prepollresponse+pollresponse+"@@";
					Global.workshopresponsepollobject.replace(course_id,pollresponse);
					pollcount = Global.remotecountresponsepoll.get(course_id);
					pollcount++;
					Global.remotecountresponsepoll.replace(course_id, pollcount);

				
				}
				else
				{
					System.out.println("%% already present");
				
				}
			}
			else
			{
				System.out.println("previous poll response------- storing in database------------will not dispaly in chart");
				try {
					flag="old";
					rdh.saveremotepollresponse(student_id, response, launchtime,course_id,  p_id , flag);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return "Your poll response has been successfully submitted";
		}
		
	}


}