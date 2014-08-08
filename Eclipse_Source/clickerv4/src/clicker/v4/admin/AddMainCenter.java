/* Author : Gobianth M
 * Use :for adding,updating and deleting the main center  
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;
/**
 * Servlet implementation class AddMainCenter
 */
public class AddMainCenter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMainCenter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
			
		String MainCenterID=request.getParameter("MainCenterID");
		String MainCentername=request.getParameter("MainCentername");
		String City=request.getParameter("MainCentercity");
		String State=request.getParameter("MainCenterstate");
		String mainurl = request.getParameter("mainurl");
		String flag = request.getParameter("Flag");
				
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con=dbcon.createRemoteDatabaseConnection();
		PreparedStatement st = null;
		
		System.out.println("-----" +MainCenterID+"  "+City+"  " +State+ " "+ mainurl);
		
		
		if(flag.equalsIgnoreCase("ADD"))
		{
		String insertquery="insert into maincenter(MainCName,City,State,URL) values(?,?,?,?)";
		try {
			st = con.prepareStatement(insertquery);		
			st.setString(1,MainCentername);
			st.setString(2,City);
			st.setString(3,State);
			st.setString(4,mainurl);
			
			
			int rs = st.executeUpdate();
			System.out.println("rows affected : "+rs);
			//response.sendRedirect("jsp/home/remotehome.jsp");
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
		}else if(flag.equalsIgnoreCase("DELETE"))
		{
		
		
		String query4 = "delete FROM maincenter where MainCenterID='"+ MainCenterID + "'";	
		Statement st1;
		try {
			st1 = con.createStatement();
			int rs1 = st1.executeUpdate(query4);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		finally
		{
			dbcon.closeRemoteConnection(con);
		}
		}else if(flag.equalsIgnoreCase("UPDATE"))
		{
	
		try {

			Statement st2 = con.createStatement();
			System.out.println("update maincenter set MainCName='"+MainCentername+"',URL='"+mainurl+"' where MainCenterID='"+MainCenterID+"'");
			String query3 = "update maincenter set MainCName='"+MainCentername+"',URL='"+mainurl+"' where MainCenterID='"+MainCenterID+"'";
			int rs3 = st2.executeUpdate(query3);
			
			dbcon.closeRemoteConnection(con);	

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}