package clicker.v4.wrappers;

import java.util.ArrayList;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement

@XmlType(propOrder = { "courseId","launchtime","currenttime","quizId","quizName","quizrecordId","quizTime", "questions","notShuffle", "isShowAns"})
/**
 *  Wrapper class for Quiz
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class Quiz {
	
	private String courseId;
	private String launchtime;
	private String currenttime;
	private int quizId;
	private String quizName;
	private int quizrecordId;
	private String quiztype;
	private String quizTime;
    private ArrayList<Question> questions;
    private ArrayList<Integer> notShuffle;
    private boolean isShowAns;
    
    
    public Quiz(){
    	setcourseId("0");
    	setQuiztype("normal");
    }
    
    public Quiz(Quiz q){
    	courseId=q.courseId;
    	launchtime=q.launchtime;
    	currenttime=q.currenttime;
    	quizId=q.quizId;
    	quizName=q.quizName;
    	quizrecordId=q.quizrecordId;
    	quiztype=q.quiztype;
    	quizTime=q.quizTime;
    	questions=q.questions;
    	notShuffle=q.notShuffle;
    	isShowAns=q.isShowAns;
    }
    
	public String getcourseId() {
		return courseId;
	}
	//@XmlElement
	
	public void setcourseId(String courseId) {
		this.courseId =courseId;
	}
	
	public String getlaunchtime() {
		return launchtime;
	}
	//@XmlElement
	
	public void setlaunchtime(String launchtime) {
		this.launchtime =launchtime;
	}
	
	public String getcurrenttime() {
		return currenttime;
	}
	//@XmlElement
	
	public void setcurrenttime(String currenttime) {
		this.currenttime =currenttime;
	}
	
	public int getQuizId() {
		return quizId;
	}
	//@XmlElement
	
	public void setQuizId(int quizId) {
		this.quizId =quizId;
	}
	
	public int getQuizrecordId() {
		return quizrecordId;
	}

	public void setQuizrecordId(int quizrecordId) {
		this.quizrecordId = quizrecordId;
	}	
	
	
	public String  getQuizTime() {
		return quizTime;
	}
	
	//@XmlElement
	
	public void setQuizTime(String quizTime) {
		this.quizTime =quizTime;
	}
	
	// XmLElementWrapper generates a wrapper element around XML representation
//@XmlElementWrapper(name = "questions")
	// XmlElement sets the name of the entities in collection
   
//@XmlElement(name ="Question")
	
	public void setquestions(ArrayList<Question> questions) {
		this.questions = questions;
	}	
	
	public ArrayList<Question> getquestions() {
		return questions;
	}

	public ArrayList<Integer> getNotShuffle() {
		return notShuffle;
	}

	public void setNotShuffle(ArrayList<Integer> notShuffle) {
		this.notShuffle = notShuffle;
	}

	public String getQuiztype() {
		return quiztype;
	}

	public void setQuiztype(String quiztype) {
		this.quiztype = quiztype;
	}
	//@XmlElement
	public String getQuizName() {
		return quizName;
	}

	public void setQuizName(String quizName) {
		this.quizName = quizName;
	}

	public boolean isShowAns() {
		return isShowAns;
	}

	public void setShowAns(boolean isShowAns) {
		this.isShowAns = isShowAns;
	}

	 
}
