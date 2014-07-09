package clicker.v4.wrappers;
/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * Storing the class room quiz summary for sending to IITB 
 */
public class ClassroomQuizSummary {
	private String instName;
	private String courseID;
	private int qrid;
	private String quiztype;	
	private int noofQuestion;
	private int noofParticipant;
	private int noofCorrect;
	private int noofWrong;
	public String getCourseID() {
		return courseID;
	}
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}
	public int getQrid() {
		return qrid;
	}
	public void setQrid(int qrid) {
		this.qrid = qrid;
	}
	public int getNoofQuestion() {
		return noofQuestion;
	}
	public void setNoofQuestion(int noofQuestion) {
		this.noofQuestion = noofQuestion;
	}
	public String getQuiztype() {
		return quiztype;
	}
	public void setQuiztype(String quiztype) {
		this.quiztype = quiztype;
	}
	public int getNoofCorrect() {
		return noofCorrect;
	}
	public void setNoofCorrect(int noofCorrect) {
		this.noofCorrect = noofCorrect;
	}
	public int getNoofParticipant() {
		return noofParticipant;
	}
	public void setNoofParticipant(int noofParticipant) {
		this.noofParticipant = noofParticipant;
	}
	public int getNoofWrong() {
		return noofWrong;
	}
	public void setNoofWrong(int noofWrong) {
		this.noofWrong = noofWrong;
	}
	public String getInstName() {
		return instName;
	}
	public void setInstName(String instName) {
		this.instName = instName;
	}
}
