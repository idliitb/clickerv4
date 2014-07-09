//  Author: Kirti, Harshavardhan Clicker Team, IDL LAB ,IIT Bombay.
package clicker.v4.poll;


import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import clicker.v4.global.*;


public class Getresponsefromhash {
	
	/*
	 * getpollcount function is used  to get the poll responses from students from hashmap to 
	 * store in database
	 */
public void getpollcount(String courseId,int a[],int b[])
{
	 // accessing the poll responses from global hashmap 
	String allstudentpollresponsejson=Global.responsepollobject.get(courseId);
	System.out.println("allstudentpollresponsejson"+allstudentpollresponsejson);
	// split function is used to split the individual resposes
   	String parts[]=allstudentpollresponsejson.split("@@");
   	int len=parts.length;
   
   	if(len==0){
   			//if no poll response
   			b[0]=0;
   			System.out.println("no poll response");
   	}
   	 else
   		 b[0]=len-1;
   //no of student =len-1
   	String individualstudentpolljson=null;
   	for(int i=1;i<len;i++)
   	{
   		
   		individualstudentpolljson=parts[i];
   		//calling function to store the responses
        IndividualStudentpollRecord(a,individualstudentpolljson);
    }
   	// after storing the responses remove the entry in hashmap
   	Global.responseobject.remove(courseId);  	
}

//for remote mode
public void remotegetpollcount(String WorkshopID,int a[],int b[])
{
	 // accessing the poll responses from global hashmap 
	String allstudentpollresponsejson=Global.workshopresponsepollobject.get(WorkshopID);
	System.out.println("allstudentpollresponsejson"+allstudentpollresponsejson);
	// split function is used to split the individual resposes
 	String parts[]=allstudentpollresponsejson.split("@@");
 	int len=parts.length;
 
 	if(len==0){
 			//if no poll response
 			b[0]=0;
 			System.out.println("no poll response");
 	}
 	 else
 		 b[0]=len-1;
 //no of student =len-1
 	String individualstudentpolljson=null;
 	for(int i=1;i<len;i++)
 	{
 		
 		individualstudentpolljson=parts[i];
 		//calling function to store the responses
      IndividualStudentpollRecord(a,individualstudentpolljson);
  }
 	// after storing the responses remove the entry in hashmap
 	Global.responseobject.remove(WorkshopID);  	
}


public void  IndividualStudentpollRecord(int a[], String studentjsonresponse)	  
{
    //parse student optionsresponse json to array of string..String[] studentResposne,take quizid,question no(as array index of options),courseId
	JSONObject json=null;
	String current_sid=null;
	String optionvalue=null;

	try {
			json = new JSONObject(studentjsonresponse);
			current_sid=json.get("stuid").toString();
			optionvalue=json.get("option").toString();

	 
			if(optionvalue.equals("1"))
			{
				a[0]++;  
			}//1 for true, a[0] holds true count
			else if(optionvalue.equals("0"))
			{
				a[1]++;
			}//0 for false,a[1] holds false count
			else if(optionvalue.equals("2"))
			{
				a[2]++;
			}//2 means no response
	 
		}
	catch(JSONException e)
	{
		e.printStackTrace();	
	}
}	
}