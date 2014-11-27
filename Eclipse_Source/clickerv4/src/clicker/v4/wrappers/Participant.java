package clicker.v4.wrappers;

/**
 * Wrapper class for Participant
 * @author Dipti, Clicker Team, IDL Lab - IIT Bombay
 *
 */

import java.util.ArrayList;

public class Participant {
	
		private String participantid;
		private ArrayList<String> options;
		/**
		 * @return the participant
		 */
		public String getParticipant() {
			return participantid;
		}
		/**
		 * @param participant the participant to set
		 */
		public void setParticipant(String participantid) {
			this.participantid = participantid;
		}
		public ArrayList<String> getOptions() {
			return options;
		}
		public void setOptions(ArrayList<String> options) {
			this.options = options;
	}

}
