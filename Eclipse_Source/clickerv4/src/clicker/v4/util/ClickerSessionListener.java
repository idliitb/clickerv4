package clicker.v4.util;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import clicker.v4.global.Global;
import clicker.v4.remote.RemoteQuizResponseHelper;
import clicker.v4.rest.JSONReadandparse;
/**
 * 
 * @author Rajavel,Dipti from Clicker Team, IDL LAB ,IIT Bombay
 * This class is used for session listener
 */
public class ClickerSessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		HttpSession session = arg0.getSession();
		if(session.getAttribute("InstructorID")!=null){
			System.out.println("In Create :" + session.getAttribute("InstructorID").toString());
		}
		if(session.getAttribute("CoordinatorID")!=null){
			System.out.println("In Create :" + session.getAttribute("CoordinatorID").toString());
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		HttpSession session = arg0.getSession();
		if(session.getAttribute("InstructorID")!=null){
			System.out.println("Session is Destroyed :" + session.getAttribute("InstructorID").toString());
		}
		if(session.getAttribute("courseID")!=null){
			String courseID = session.getAttribute("courseID").toString();
			System.out.println("Active Coruse is removed : "+ courseID);
			Global.activecourses.remove(courseID);	
			JSONReadandparse jsonreader = new JSONReadandparse();
			jsonreader.sendClassroomQuizResponseJSON();
		}
		if(session.getAttribute("CoordinatorID")!=null){
			System.out.println("Session is Destroyed :" + session.getAttribute("CoordinatorID").toString());
		}
		if(session.getAttribute("WorkshopID")!=null){
			String MainCenterURL=(String)session.getAttribute("MainCenterURL");
			System.out.println("Active Workshop is removed : "+ session.getAttribute("WorkshopID").toString());
			RemoteQuizResponseHelper rqrh= new RemoteQuizResponseHelper();
			rqrh.ResendJsonForLateResponse(MainCenterURL);
			rqrh.createAndReSendIQResponseJsonToMC(MainCenterURL);
			Global.activeworkshop.remove(session.getAttribute("WorkshopID").toString());

		}
	}

}
