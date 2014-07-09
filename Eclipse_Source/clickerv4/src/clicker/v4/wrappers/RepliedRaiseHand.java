/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 */
package clicker.v4.wrappers;

import java.util.ArrayList;

public class RepliedRaiseHand {
	
	 private ArrayList<String> DoubtText = new ArrayList<String>();
	 private ArrayList<String> ReplyText = new ArrayList<String>();
	
	public ArrayList<String> getDoubtText() {
		return DoubtText;
	}
	public void setDoubtText(ArrayList<String> doubtText) {
		DoubtText = doubtText;
	}
	public ArrayList<String> getReplyText() {
		return ReplyText;
	}
	public void setReplyText(ArrayList<String> replyText) {
		ReplyText = replyText;
	}

}
