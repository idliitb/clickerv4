/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 * 
 * This servlet helps to send save reply for doubt in database and update raise hand status as replied ie( setting '2')
 *  and redirect again instructor to raisehand main page. 
 * 
 */
package clicker.v4.raisehand;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RaiseHandRepliedServlet
 */

public class RaiseHandRepliedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RaiseHandRepliedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String Reply=request.getParameter("content");
		String RaiseHandTimeStamp=request.getParameter("timestamp");
		String StudentID=request.getParameter("studentid");
		RaiseHandHelper rdb = new RaiseHandHelper();
		try {
			rdb.updateRaiseHandReply(StudentID, RaiseHandTimeStamp, Reply);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("jsp/raisehand/raisehand.jsp");
		
	}

}
