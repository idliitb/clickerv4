//  Author: Kirti
package clicker.v4.poll;
import clicker.v4.global.*;
public class Callpolljson {
public void callpolljson(String courseId,String pollquestion,String launchtime,String currenttime,String quizTime)
{
	 Poll pollq=new Poll();  
	 pollq.setpollquestion(pollquestion);
	 pollq.setlaunchtime(launchtime);
	 pollq.setcurrenttime(currenttime);
	 pollq.setcourseid(courseId);
	 pollq.setquizTime(quizTime);
	 Global.polljsonobject.put(courseId,pollq); 
	
}

public void remotecallpolljson(String courseId,String pollquestion,String launchtime,String currenttime,String quizTime)
{
	 Poll pollq=new Poll();  
	 pollq.setpollquestion(pollquestion);
	 pollq.setlaunchtime(launchtime);
	 pollq.setcurrenttime(currenttime);
	 pollq.setcourseid(courseId);
	 pollq.setquizTime(quizTime);
	 Global.workshoppolljsonobject.put(courseId,pollq);	
}


}