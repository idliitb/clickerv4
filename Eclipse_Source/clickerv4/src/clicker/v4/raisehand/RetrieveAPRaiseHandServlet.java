/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 * 
 * This servlet helps to retrive active and pending doubts of that particular course
 */

package clicker.v4.raisehand;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RetrieveAPRaiseHand
 */

public class RetrieveAPRaiseHandServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ArrayList<RaiseHandRowData> list;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetrieveAPRaiseHandServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getParameter("StudentIDandTimeStamp");
		request.getParameter("Status");
		String[] StudIDandTimeStmp=request.getParameter("StudentIDandTimeStamp").split("@");
		
		try {
			list = new RaiseHandHelper().retrieveRaiseHand(StudIDandTimeStmp[0],StudIDandTimeStmp[1],StudIDandTimeStmp[2],StudIDandTimeStmp[3]);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		request.setAttribute("studentData", list);
		RequestDispatcher rd=null;
			rd=request.getRequestDispatcher("./jsp/raisehand/viewdoubts.jsp");
			//rd.forward( request, response );
			System.out.println("SaveDoubts...");
		try {
			rd.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}