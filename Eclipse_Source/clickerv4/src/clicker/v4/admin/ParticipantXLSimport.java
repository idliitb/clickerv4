/**
 * 
 */
package clicker.v4.admin;

import java.io.File;
import java.sql.*;

import clicker.v4.databaseconn.*;
import jxl.*;



public class ParticipantXLSimport {
	public String insertQuery(String participantid, String participantname, String workshopid) {
		int rs = 0, pid = 0;
						
		Connection conn = null;
		ResultSet resultset = null;
		PreparedStatement ps = null, ps1 = null;
		DatabaseConnection db = new DatabaseConnection();
		try {

				
				conn = db.createRemoteDatabaseConnection();
				
				ps1 = conn.prepareStatement("select count(*) as pid from participant where ParticipantID=? and WorkshopID = ?");
				ps1.setString(1, participantid);
				ps1.setString(2, workshopid);
				
				resultset = ps1.executeQuery();
				while(resultset.next())
					pid = resultset.getInt("pid");
				resultset.close();
				if(pid == 0)
				{	System.out.println("hi");
					ps = conn.prepareStatement("insert into participant(ParticipantID, MACAddress,ParticipantName, WorkshopID,Password) values(?,?, ?, ?,?)");
					ps.setString(1, participantid);
					ps.setString(2, "");
					ps.setString(3, participantname);
					ps.setString(4, workshopid);
					ps.setString(5, participantid);
				
					rs = ps.executeUpdate();
					
					return "Successfull";
				}
				return participantid;
				
			}
		catch(SQLException e)
		{
			System.out.println("in insertquery");
			e.printStackTrace( );
			return "Unsuccessfull";
		}
		finally
		{
			db.closeRemoteConnection(conn);
		}
	}

	public String readQuestionXLSFile(File xlsfile, String workshopid) {
		
		try {
			
			Workbook workbook = Workbook.getWorkbook(xlsfile);
			
			Sheet sheet;
			Cell xlsCell;
			Cell[] cell;
			String query = "";
			// Getting first sheet of xls
			sheet = workbook.getSheet(0);
			System.out.println("In XLS Import: ");
			System.out.println("Sheet name = " + sheet.getName());
			// i start from 1 because it will avoid first row in xls sheet that
			// is (Row 1)
			
			for (int i = 1; i < sheet.getRows(); i++) {
				String participantid = "";
				
				cell = sheet.getRow(i);
				
				xlsCell = sheet.getCell(0, i);
				participantid = xlsCell.getContents().toString().trim();
				System.out.println("xls participant id = " + participantid);
				if (participantid.equals("") || participantid == null) {
					return ("Participant ID field entry with Sr.No." + i + " cannot be empty!");
					
				}

				xlsCell = sheet.getCell(1, i);
				String participantname = xlsCell.getContents().toString();
				System.out.println("xls Participant Name = " + participantname);
				if (participantname.equals("")) {
					return ("Name of the Participant with Participant ID " + participantid + " cannot be empty!");
				}
				
				
				
			query = insertQuery(participantid, participantname, workshopid);
			
			if((query.equals(participantid)))
				return ("Participant " + query + " is already registered for the same Workshop. Please enter a different Workshop ID for the Participant");
			if(query.equals("Unsuccessfull"))
			return ("Remote Center " + participantname + " having Participant ID " + participantid + " has no entry. Kindly add this Remote Center first.");
			
		}
			return "Participant information added successfully";	
	}
		catch (NumberFormatException ex) {
			System.out.print("Wrong center id = " + ex);
			return "Please enter Center ID in Integers only";
		}
		catch (Exception exec) {
			System.out.print("Exception import = " + exec);
			exec.printStackTrace();
			return "Wrong File Format";
		}
		
				
	}

}