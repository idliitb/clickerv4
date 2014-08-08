/* Author : Gobianth M
 * Use :function that used in servlet for data    
 *  
 */
package clicker.v4.admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import clicker.v4.databaseconn.DatabaseConnection;

public class Admindata {
	
	public String getStudentIDs(){
		String studentIDs= "";
		Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;  
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            pst = con.prepareStatement("SELECT StudentID FROM student");
            
            rs = pst.executeQuery();
            while (rs.next()) {					
				studentIDs += rs.getString("StudentID") + ",";		
			}            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }		
		return studentIDs;
	}
	
	
	public String getInstrutorIDs(){
		String studentIDs= "";
		Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;      
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            pst = con.prepareStatement("SELECT InstrID FROM instructor");
            
            rs = pst.executeQuery();
            while (rs.next()) {					
				studentIDs += rs.getString("InstrID") + ",";		
			}            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }		
        
		return studentIDs;
	}

	
	public String departmentIDs(){
		
		String departIDs= "";
		Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;   
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createDatabaseConnection();
            pst = con.prepareStatement("SELECT DeptID FROM department");
            
            rs = pst.executeQuery();
            while (rs.next()) {					
            	departIDs += rs.getString("DeptID") + ",";		
			}            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeLocalConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }		
      
		return departIDs;
	}
	
	public String ParticipantIDs(String WS){
		String studentIDs= "";
		Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;  
        DatabaseConnection dbcon = new DatabaseConnection();
        try {
        	
            con = dbcon.createRemoteDatabaseConnection();
            pst = con.prepareStatement("SELECT ParticipantID FROM participant where WorkshopID='"+WS+"'");
            
            rs = pst.executeQuery();
            while (rs.next()) {					
				studentIDs += rs.getString("ParticipantID") + ",";		
			}            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally{
        	try {
        		if(rs!=null)rs.close();
				if(pst!=null)pst.close();
				if(con!=null)dbcon.closeRemoteConnection(con);
			} catch (SQLException e) {				
				e.printStackTrace();
			}            
        }		
		return studentIDs;
	}
	//get total number of tables in aakashclicker
			public int getTables(){
				int tablecount=0;
				DatabaseConnection dbcn = new DatabaseConnection();
				Connection cn = dbcn.createDatabaseConnection();
				
				try{
					Statement stm = cn.createStatement();
					String tablequery = "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'aakashclicker'";
					ResultSet rls = stm.executeQuery(tablequery);
					if (rls.next()) {
						tablecount = rls.getInt(1);
					}
				}catch(SQLException e){
					e.printStackTrace();
				}finally{
					dbcn.closeLocalConnection(cn);
				}	
				return tablecount;
			}
}