/*
 * Author : Dipti from Clicker Team, IDL LAB -IIT Bombay
 */

package clicker.v4.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;

import clicker.v4.global.Global;
import clicker.v4.rest.JSONReadandparse;

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
