package clicker.v4.wrappers;


public class ParticipantResponse {
	private String participantid;
	private int questionid;
	private String response;
	public String getParticipantid() {
		return participantid;
	}
	public void setParticipantid(String participantid) {
		this.participantid = participantid;
	}
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	public int getQuestionid() {
		return questionid;
	}
	public void setQuestionid(int questionid) {
		this.questionid = questionid;
	}
}
