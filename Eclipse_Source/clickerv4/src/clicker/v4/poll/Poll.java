//Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay 
package clicker.v4.poll;

public class Poll {
private int pollid;
private String pollquestion;
private String launchtime;
private String currenttime;
private String courseId;
private String quizTime;
public Poll() {
	pollid=0;
	pollquestion="";
	launchtime="";
	currenttime="";
	courseId="";
	quizTime="";
}
public int getpollid() {
	return pollid;
}


public void setpollid(int pollid) {
	this.pollid=pollid;
}

public String getpollquestion() {
	return pollquestion;
}


public void setpollquestion(String pollquestion) {
	this.pollquestion=pollquestion;
}

public String getlaunchtime() {
	return launchtime;
}


public void setlaunchtime(String launchtime) {
	this.launchtime=launchtime;
}

public String getcurrenttime() {
	return currenttime;
}


public void setcurrenttime(String currenttime) {
	this.currenttime=currenttime;
}

public String getcourseid() {
	return courseId;
}


public void setcourseid(String courseId) {
	this.courseId=courseId;
}


public String getquizTime() {
	return quizTime;
}


public void  setquizTime(String quizTime) {
	this.quizTime=quizTime;
}


}
