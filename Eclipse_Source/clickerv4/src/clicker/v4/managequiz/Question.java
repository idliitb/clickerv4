/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clicker.v4.managequiz;

import java.util.Vector;

/**
 * This class is used to set and get he details of questions belongs to
 * particular quiz
 * 
 * @author manjur, Harshavardhan
 */

public class Question {

	private String questionText;

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}

	private String questionID;
	
	private int LOD;
	private float Credit;
	private int duration;
	private char template;
	private String image;
	private String plainquestext;
	private int questiontype;
	private String ansorder;
	private Vector<Option> options = new Vector<Option>();

	/**
	 * Default constructor to do nothing
	 */
	public Question() {
	}

	/**
	 * This method set the Question name
	 * 
	 * @param qn
	 *            Question name to set
	 */

	/**
	 * This method set the Question id
	 * 
	 * @param id
	 *            Question name to set
	 */
	public void setQuestionID(String id) {
		questionID = id;
	}

	public void addOption(Option op) {
		// Option op = new Option(id);
		options.addElement(op);
	}

	/**
	 * This method set the Level of Difficulty for the questions
	 * 
	 * @param l
	 *            Level of Difficulty to set
	 */
	public void setLOD(int l) {
		LOD = l;
	}

	/**
	 * This method set the path of the image for a image question
	 * 
	 * @param img
	 *            Image path
	 */
	public void setImage(String img) {
		image = img;
	}

	/**
	 * This method set the Question content for plain question
	 * 
	 * @param qn_txt
	 *            Question text
	 */
	public void setPlainText(String qn_txt) {
		plainquestext = qn_txt;
	}

	/**
	 * This method set the Question type
	 * 
	 * @param qtype
	 *            Question type to set
	 */
	public void setQuestionType(int qtype) {
		questiontype = qtype;
	}

	/**
	 * This method is used to set Question duration
	 * 
	 * @param seconds
	 *            Questing duration in quiz
	 */
	public void setDuration(int seconds) {
		duration = seconds;
	}

	/**
	 * This method is used to set answer order for multiple choice question
	 * 
	 * @param ansorder
	 *            Answer order
	 */
	public void setAnsOrder(String ansorder) {
		this.ansorder = ansorder;
	}

	/**
	 * This method is used to get image path for image type question
	 * 
	 * @return Path of image question
	 */
	public String getImage() {
		return image;
	}

	/**
	 * This method is used to get question template like i for image, d for
	 * plain text and c for code questions
	 * 
	 * @return Question template as chat
	 */
	public char getTemplate() {
		return template;
	}

	/**
	 * This method is used to get Question id
	 * 
	 * @return Question id as string
	 */
	public String getQuestionID() {
		return questionID;
	}

	/**
	 * This method is used to get Question credit
	 * 
	 * @return Question credit as integer
	 */
	public float getCredit() {
		System.out.println("Credit in getCredit Func : " + Credit);
		return Credit;
	}

	/**
	 * This method is used to get Level of Difficulty
	 * 
	 * @return Level of difficulty as integer
	 */
	public int getLOD() {
		return LOD;
	}

	/**
	 * This method is used to get Question as plain text
	 * 
	 * @return Question plain text
	 */
	public String getPlainText() {
		return plainquestext;
	}

	/**
	 * This method is used to get Question type
	 * 
	 * @return Question type as integer
	 */
	public int getQuestionType() {
		return questiontype;
	}

	/**
	 * This method is used to get list of option for a question in Vector
	 * 
	 * @return Question options as Vector
	 */
	public Vector<Option> getOptions() {
		return options;
	}

	/**
	 * This method is used to get Question duration
	 * 
	 * @return Question duration as integer
	 */
	public int getDuration() {
		return duration;
	}

	/**
	 * This method is used to get answer order for a multiple choice question
	 * 
	 * @return Answer order
	 */
	public String getAnsOrder() {
		return ansorder;
	}

	/**
	 * This method is used to get Question Name
	 * 
	 * @return Question Name as string
	 */
}