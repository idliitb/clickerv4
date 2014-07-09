package clicker.v4.wrappers;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(namespace = "quiz.Question")
/**
 * Wrapper class for Option
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class Option {
	private String optiontext;
	private int optionid;
	public String getOptiontext() {
		return optiontext;
	}
	public void setOptiontext(String optiontext) {
		this.optiontext = optiontext;
	}
	public int getOptionid() {
		return optionid;
	}
	public void setOptionid(int optionid) {
		this.optionid = optionid;
	}	
}