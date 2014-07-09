//Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay.
package clicker.v4.poll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clicker.v4.global.Global;

/**
 * Servlet implementation class RemotePollResponseCount
 */
public class RemotePollResponseCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemotePollResponseCount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// TODO Auto-generated method stub=
		HttpSession session = request.getSession(true);
		String workshopid = (String) session.getAttribute("WorkshopID");
		 int count=Global.remotecountresponsepoll.get(workshopid);
		 response.getWriter().print(count);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
	}

}
