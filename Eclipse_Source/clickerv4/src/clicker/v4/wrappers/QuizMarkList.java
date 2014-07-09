package clicker.v4.wrappers;

import java.util.ArrayList;
/**
 *  Wrapper class for Quiz mark list
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class QuizMarkList {
	private String studentID;
	private String studentName;
	private String courseID;
	private String courseName;
	private ArrayList<QuizMark> quizMarks = new ArrayList<QuizMark>();
	public QuizMarkList(){
		courseName = "No Quiz Marks";
	}
	public String getStudentID() {
		return studentID;
	}
	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getCourseID() {
		return courseID;
	}
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public ArrayList<QuizMark> getQuizMarks() {
		return quizMarks;
	}
	public void setQuizMarks(ArrayList<QuizMark> quizMarks) {
		this.quizMarks = quizMarks;
	}
	
}
