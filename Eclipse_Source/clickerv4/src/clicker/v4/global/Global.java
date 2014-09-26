package clicker.v4.global;
import clicker.v4.poll.*;

import java.util.HashSet;
import java.util.concurrent.ConcurrentHashMap;

import clicker.v4.wrappers.Quiz;
/**
 * 
 * @author rajavel , Dipti
 * This file is act as globally sharing static variables 
 */
public class Global {
	//Quiz detail for courses
	public static ConcurrentHashMap<String,Quiz> coursejsonobject= new ConcurrentHashMap<String, Quiz>();
	//Active courses detail
	public static ConcurrentHashMap<String, String> activecourses= new ConcurrentHashMap<String, String>();
	//Quiz current record id to store student response in database
	public static ConcurrentHashMap<String, Integer> quizrecordids= new ConcurrentHashMap<String, Integer>();
	//No of student requested for quiz
	public static ConcurrentHashMap<String,String> countrequestjson= new ConcurrentHashMap<String,String>();
	// No of Student Currently logged in for the course EX: 1@2@43@D123
	public static ConcurrentHashMap<String,HashSet<String>> activestudentlist= new ConcurrentHashMap<String,HashSet<String>>();
	// Raise hand counter for the courses
	public static ConcurrentHashMap<String, Integer> raisehandcounter = new ConcurrentHashMap<String, Integer>();
	//poll details
	public static ConcurrentHashMap<String,Poll> polljsonobject= new ConcurrentHashMap<String, Poll>();
	public static ConcurrentHashMap<String,String> responseobject= new ConcurrentHashMap<String,String>();
    //response details
	public static ConcurrentHashMap<String,String> responsepollobject= new ConcurrentHashMap<String,String>();
	//Active workshop detail
	public static ConcurrentHashMap<String, String> activeworkshop= new ConcurrentHashMap<String, String>();
	//No of Student Currently logged in for the workshop
	public static ConcurrentHashMap<String,HashSet<String>> activeparticipantlist= new ConcurrentHashMap<String,HashSet<String>>();
	//Quiz detail for workshop
	public static ConcurrentHashMap<String,Quiz> workshopjsonobject= new ConcurrentHashMap<String, Quiz>();
	//Main centre current quiz record id to store Participant response in database
	public static ConcurrentHashMap<String, Integer> remotemcquizrecordids= new ConcurrentHashMap<String, Integer>();
	//Current Quiz record id to store Participant response in database
	public static ConcurrentHashMap<String, Integer> remotequizrecordids= new ConcurrentHashMap<String, Integer>();
	//No of Participant requested for quiz
	public static ConcurrentHashMap<String,String> remotecountrequestjson= new ConcurrentHashMap<String,String>();
	// No of reponses of the Participants
	public static ConcurrentHashMap<String,Integer> remotecountresponsejson = new ConcurrentHashMap<String, Integer>( );
	//Poll detail for workshop
	public static ConcurrentHashMap<String,Poll> workshoppolljsonobject= new ConcurrentHashMap<String, Poll>();
	//response details
	public static ConcurrentHashMap<String,String> workshopresponsepollobject= new ConcurrentHashMap<String,String>();
	// poll response count	
	public static ConcurrentHashMap<String,Integer> remotecountresponsepoll = new ConcurrentHashMap<String, Integer>( );
	// is sent the instant response json
	public static ConcurrentHashMap<String, String> isInstantResponseSent =  new ConcurrentHashMap<String, String>();
	// Checks if the normal quiz response JSON is sent to the Main Center or not
	public static ConcurrentHashMap<String, String> isnormalresponsesent =  new ConcurrentHashMap<String, String>();
	// No of reponses of the students
	public static ConcurrentHashMap<String,Integer> countresponsejson = new ConcurrentHashMap<String, Integer>( );
	// storing stored participant ids
	public static ConcurrentHashMap<String, String> responsereceivedparticipants =  new ConcurrentHashMap<String, String>();	
}