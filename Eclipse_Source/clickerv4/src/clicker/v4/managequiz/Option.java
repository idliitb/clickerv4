/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clicker.v4.managequiz;

/**
 * This class is used to set the details of Option belongs to question
 * 
 * @author manjur, Harshavardhan
 */
public class Option {

	private String optionID;
	private String optionValue;

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	private int LOD;
	private String exp;
	private boolean correct;
	private float credit;
	private String questionID;
	private char type;

	/**
	 * Default Constructor to do nothing
	 */
	public Option() {
	}

	/**
	 * Constructor to set the option Id
	 * 
	 * @param id
	 *            Option id to set
	 */
	public Option(String id) {
	}

	/**
	 * This method set the Option Id
	 * 
	 * @param id
	 *            Option Id to set
	 */
	public void setOptionID(String id) {
		optionID = id;
	}

	/**
	 * This method set the Question id for the option
	 * 
	 * @param id
	 *            Question Id to set
	 */
	public void setQuestionId(String id) {
		questionID = id;
	}

	/**
	 * This method set the Option Explanation
	 * 
	 * @param exp
	 *            Option Explanation to set
	 */
	public void setExp(String exp) {
		this.exp = exp;
	}

	/**
	 * This method set the Option correctness
	 * 
	 * @param correct
	 *            Option correctness to set
	 */
	public void setCorrect(boolean correct) {
		this.correct = correct;
	}

	/**
	 * This method set the option Credit
	 * 
	 * @param credit
	 *            Option credit to set
	 */
	public void setCredit(float credit) {
		this.credit = credit;
	}

	/**
	 * This method set the option type
	 * 
	 * @param ch
	 *            Option type to set
	 */
	public void setType(char ch) {
		this.type = ch;
	}

	/**
	 * This method set the LOD for a Option
	 * 
	 * @param LOD
	 *            Level of difficulty to set
	 */
	public void setLOD(int LOD) {
		this.LOD = LOD;
	}

	/**
	 * This method is used to get the type of option
	 * 
	 * @return Option Type as character
	 */
	public char getType() {
		return type;
	}

	/**
	 * This method is used to get the Option id
	 * 
	 * @return Option id as string
	 */
	public String getOptionID() {
		return optionID;
	}

	/**
	 * This method is used to get the Explanation of the option
	 * 
	 * @return Option explanation id as string
	 */
	public String getExp() {
		return exp;
	}

	/**
	 * This method is used to get the correctness of the option
	 * 
	 * @return Option correctness as boolean
	 */
	public boolean getCorrect() {
		return correct;
	}

	/**
	 * This method is used to get the Credit of the option
	 * 
	 * @return Credit of the option as integer
	 */
	public float getCredit() {
		return credit;
	}

	/**
	 * This method is used to get the Level of difficulty
	 * 
	 * @return Level of difficulty as integer
	 */
	public int getLOD() {
		return LOD;
	}

	/**
	 * This method is used to get the Question id
	 * 
	 * @return Question id as string
	 */
	public String getQuestionID() {
		return questionID;
	}
}
