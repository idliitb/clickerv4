/*  Author: Kirti, Clicker Team, IDL LAB ,IIT Bombay.
 * This file is used for setting the poll details in poll object and in global variable for both local and remote mode.
 */
package clicker.v4.poll;
import clicker.v4.global.*;
public class Callpolljson {
public void callpolljson(int pollid, String courseId,String pollquestion,String launchtime,String currenttime,String quizTime)
{
	 Poll pollq=new Poll();  
	 pollq.setpollid(pollid);
	 pollq.setpollquestion(pollquestion);
	 pollq.setlaunchtime(launchtime);
	 pollq.setcurrenttime(currenttime);
	 pollq.setcourseid(courseId);
	 pollq.setquizTime(quizTime);
	 Global.polljsonobject.put(courseId,pollq); 
	
}

public void remotecallpolljson(int pollid,String courseId,String pollquestion,String launchtime,String currenttime,String quizTime)
{
	 Poll pollq=new Poll(); 
	 pollq.setpollid(pollid);
	 pollq.setpollquestion(pollquestion);
	 pollq.setlaunchtime(launchtime);
	 pollq.setcurrenttime(currenttime);
	 pollq.setcourseid(courseId);
	 pollq.setquizTime(quizTime);
	 Global.workshoppolljsonobject.put(courseId,pollq);	
}


}
