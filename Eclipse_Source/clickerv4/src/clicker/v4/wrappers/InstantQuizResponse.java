package clicker.v4.wrappers;

import java.util.ArrayList;

public class InstantQuizResponse {
	private int quizrecordid;
	private String centerid;
	private String workshopid;
	private ArrayList<ParticipantResponse> participantResponse;
	public String getCenterid() {
		return centerid;
	}
	public void setCenterid(String centerid) {
		this.centerid = centerid;
	}
	public int getQuizrecordid() {
		return quizrecordid;
	}
	public void setQuizrecordid(int quizrecordid) {
		this.quizrecordid = quizrecordid;
	}
	public String getWorkshopid() {
		return workshopid;
	}
	public void setWorkshopid(String workshopid) {
		this.workshopid = workshopid;
	}
	public ArrayList<ParticipantResponse> getParticipantResponse() {
		return participantResponse;
	}
	public void setParticipantResponse(ArrayList<ParticipantResponse> participantResponse) {
		this.participantResponse = participantResponse;
	}
}
