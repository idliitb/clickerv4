package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class AddRemoteWorkshop
 */
public class AddRemoteWorkshop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRemoteWorkshop() {
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
		
		String workshopid=request.getParameter("workshopid");			
		String workshopname=request.getParameter("workshopname");
		String Description=request.getParameter("Description");
		String startDate_datepicker=request.getParameter("startDate_datepicker");
		String endDate_datepicker=request.getParameter("endDate_datepicker");
		String coordinatorid=request.getParameter("coordinatorid");
		String mainurl = request.getParameter("mainurl");
		
		
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con=dbcon.createRemoteDatabaseConnection();
		PreparedStatement st = null;
		
		String insertquery="insert into workshop (WorkshopID, WorkshopName, WorkshopDesc, Username, StartDate, EndDate, MainCenterUrl) values(?,?,?,?,?,?,?)";
		try {
			st = con.prepareStatement(insertquery);
			st.setString(1,workshopid);
			st.setString(2,workshopname);
			st.setString(3,Description);
			st.setString(4,coordinatorid);
			st.setString(5,startDate_datepicker);
			st.setString(6,endDate_datepicker);
			st.setString(7, mainurl);
			
			int rs = st.executeUpdate();
			//System.out.println("rows affected : "+rs);
			response.sendRedirect("jsp/admin/addremoteworkshop.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			try {
				st.close();
				dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
						
		
	}

}
