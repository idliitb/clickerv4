/*
 * Author : Dipti from Clicker Team, IDL LAB -IIT Bombay
 * 
 * This file is used to set workshop ID for coordinator login
 */

package clicker.v4.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MainCenterSetter
 */
public class MainCenterSetter extends HttpServlet {

	private static final long serialVersionUID = 1L;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainCenterSetter() {
        super();
        // TODO Auto-generated constructor stub
    }

    /*
     * This function is used to set the Workshop ID for particular coordinator login,In case of no workshop is available at maincenter 
     * workshop will be set as "No workshop Available"
     */
    protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			HttpSession session=request.getSession();
				
		if(request.getParameter("WorkshopID")!=null||(request.getParameter("WorkshopID")!="No workshop Available")){
			
			session.setAttribute("WorkshopID", request.getParameter("WorkshopID").toString());
					
					try {
						System.out.println("WorkShop ID..: "+request.getParameter("WorkshopID"));
						response.sendRedirect("./jsp/home/remotehome.jsp");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}else{
				session.setAttribute("WorkshopID", "No workshop Available");
				response.sendRedirect("./jsp/home/remotehome.jsp");
			}
		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
