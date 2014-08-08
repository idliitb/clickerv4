/* Author : Gobianth M
 * Use :for adding the institute  
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class AddInstitute
 */
public class AddInstitute extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddInstitute() {
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
		PreparedStatement ps = null;
	    ResultSet rs = null;
	    int cid = 0, check = 0;
		
		String instname = request.getParameter("inst_name");
		String instAdd = request.getParameter("inst_address");
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createDatabaseConnection();
		
		
		
		try {
			ps = conn.prepareStatement("insert into institution values(?,?, ?)");
			ps.setString(1, "I1");
			ps.setString(2, instname);
			ps.setString(3, instAdd);
			
			check = ps.executeUpdate();
			
			response.sendRedirect("jsp/admin/department.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(conn);
		}
		
		
		
	}

}
