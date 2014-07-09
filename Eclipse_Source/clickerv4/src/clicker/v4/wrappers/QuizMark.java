package clicker.v4.wrappers;
/**
 *  Wrapper class for Quiz Mark
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class QuizMark {
	private String quizName;
	private String quizTime;
	private float totalMark;
	private float markObtained;
	private float percentage;
	public String getQuizName() {
		return quizName;
	}
	public void setQuizName(String quizName) {
		this.quizName = quizName;
	}
	public String getQuizTime() {
		return quizTime;
	}
	public void setQuizTime(String quizTime) {
		this.quizTime = quizTime;
	}
	public float getTotalMark() {
		return totalMark;
	}
	public void setTotalMark(float totalMark) {
		this.totalMark = totalMark;
	}
	public float getMarkObtained() {
		return markObtained;
	}
	public void setMarkObtained(float markObtained) {
		this.markObtained = markObtained;
	}
	public float getPercentage() {
		return percentage;
	}
	public void setPercentage(float percentage) {
		this.percentage = percentage;
	}
}
