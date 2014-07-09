//Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay 
package clicker.v4.poll;

import java.util.ArrayList;

public class RemotePoll {
private String centerid;
private String workshopId;
private String pollquestion;
private String launchtime;
private ArrayList<RemoteParticipant>  presponse;

public RemotePoll() {
	centerid="";
	workshopId="";
	pollquestion="";
	launchtime="";
}

public String getcenterid() {
	return centerid;
}


public void setcenterid(String centerid) {
	this.centerid=centerid;
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



public String getworkshopid() {
	return workshopId;
}


public void setworkshopid(String workshopId) {
	this.workshopId=workshopId;
}


public ArrayList getpresponse() {
	return presponse;
}


public  void setpresponse(ArrayList <RemoteParticipant> presponse) {
	 this.presponse=presponse;
}




}
