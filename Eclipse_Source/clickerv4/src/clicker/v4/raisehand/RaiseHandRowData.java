/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 * 
 * This class is used to set and get the details of raise hand of selected student ID for displaying in JSP
 * 
 */

package clicker.v4.raisehand;


public class RaiseHandRowData {
	private String courseID;
	private String studentID;
	private String name;
	private String email;
	private String semester;
	private String comment;
	private String raiseHandTimeStamp;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}
	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setRaiseHandTimeStamp(String raiseHandTimeStamp) {
		this.raiseHandTimeStamp = raiseHandTimeStamp;
	}
	public String getCourseID() {
		return courseID;
	}
	public String getStudentID() {
		return studentID;
	}
	public String getComment() {
		return comment;
	}
	public String getRaiseHandTimeStamp() {
		return raiseHandTimeStamp;
	}
	
}
