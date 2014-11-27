/*
 * Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 * 
 * this servlet helps in retriving doubts for particaulr course
 */

package clicker.v4.raisehand;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RetrieveRecordsServlet
 */

public class RetrieveRecordsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ArrayList<RaiseHandRowData> list;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetrieveRecordsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			list = new RaiseHandHelper().retrieveData(request.getParameter("CourseID"),request.getParameter("text"),request.getParameter("date"));
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		request.setAttribute("records", list);
		RequestDispatcher rd=null;
		if((request.getParameter("text")==null)&&(request.getParameter("date")==null)){
			rd=request.getRequestDispatcher("./jsp/raisehand/saveddoubts.jsp");
		}
		else{
			rd=request.getRequestDispatcher("./jsp/raisehand/filtereddoubts.jsp");
		}
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

