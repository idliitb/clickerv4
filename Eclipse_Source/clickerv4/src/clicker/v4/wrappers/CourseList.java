package clicker.v4.wrappers;

import java.util.ArrayList;
/**
 * Wrapper class for CourseList
 * @author rajavel ,Dipti
 *
 */
public class CourseList {
	private String Validation;
	private ArrayList<String> courseIDs = new ArrayList<String>();
	private ArrayList<Boolean> isActive = new ArrayList<Boolean>();
	private String Mode;
	private boolean loggedIn;
	public String getValidation() {
		return Validation;
	}
	public void setValidation(String validation) {
		Validation = validation;
	}	
	public ArrayList<Boolean> getIsActive() {
		return isActive;
	}
	public void setIsActive(ArrayList<Boolean> isActive) {
		this.isActive = isActive;
	}
	public ArrayList<String> getCourseIDs() {
		return courseIDs;
	}
	public void setCourseIDs(ArrayList<String> courseIDs) {
		this.courseIDs = courseIDs;
	}
	public String getMode() {
		return Mode;
	}
	public void setMode(String mode) {
		Mode = mode;
	}
	public boolean isLoggedIn() {
		return loggedIn;
	}
	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
	
}
