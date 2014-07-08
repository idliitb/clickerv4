package clicker.v4.wrappers;

import java.util.ArrayList;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement

@XmlType(propOrder = { "courseId","launchtime","currenttime","quizId","quizrecordId","quizTime", "questions","notShuffle"})
/**
 *  Wrapper class for Quiz
 * @author rajavel
 *
 */
public class Quiz {
	
	private String courseId;
	private String launchtime;
	private String currenttime;
	private int quizId;
	private int quizrecordId;
	private String quiztype;
	private String quizTime;
    private ArrayList<Question> questions;
    private ArrayList<Integer> notShuffle;
    
    
    public Quiz(){
    	setcourseId("0");
    	setQuiztype("normal");
    }
    
    public Quiz(Quiz q){
    	courseId=q.courseId;
    	launchtime=q.launchtime;
    	currenttime=q.currenttime;
    	quizId=q.quizId;
    	quizrecordId=q.quizrecordId;
    	quiztype=q.quiztype;
    	quizTime=q.quizTime;
    	questions=q.questions;
    	notShuffle=q.notShuffle;
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

	 
}
