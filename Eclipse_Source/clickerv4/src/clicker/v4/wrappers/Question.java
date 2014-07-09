package clicker.v4.wrappers;


import java.util.ArrayList;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


//Below statement means that class "Quiz.java" is the root-element of our example

@XmlRootElement(namespace = "quiz.Quiz")
@XmlType(propOrder = { "id", "text","type","options","correctans"})
/**
 * Wrapper class for Question 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class Question {

	private int id;
	private String text;
	private int type;
	private String correctAns;
    private ArrayList<Option> options = new ArrayList<Option>();
   	
    public Question() {
		
	}
    public Question(Question q) {
    	id=q.id;
    	text=q.text;
    	type=q.type;
    	correctAns=q.correctAns;
    	options=q.options;		
   	}
	
    public int getId() {
		return id;
	}
	
	//@XmlElement
	
	public void setId(int id) {
		this.id =id;
	}
	
	 public String getText() {
			return text;
		}
	
	//@XmlElement
	
	public void setText(String text) {
		this.text =text;
	}
	
	public int getType() {
		return type;
	}
	
	//@XmlElement
	
	public void setType(int type) {
		this.type =type;
	}
	

// XmLElementWrapper generates a wrapper element around XML representation
//@XmlElementWrapper(name = "options")
	// XmlElement sets the name of the entities in collection
//@XmlElement(name ="option")
	
public String getCorrectAns() {
	return correctAns;
}

public void setCorrectAns(String correctAns) {
	this.correctAns = correctAns;
}

public ArrayList<Option> getOptions() {
	return options;
}

public void setOptions(ArrayList<Option> options) {
	this.options = options;
}


	
	
}