package clicker.v4.wrappers;

/**
 * Wrapper class for course
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class Course {
	private String courseid;
	private boolean isActive;
	
	public String getcourseid()
	{
		return courseid;
	}
	public String setcourseid(String courseid)
	{
		this.courseid=courseid;
		return courseid;
	}
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}	
	
}
