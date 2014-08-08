package clicker.v4.managequiz;

import java.sql.*;
import java.util.ArrayList;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * 
 * @author harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This class selects the options from the database
 */

public class RetrieveOptionsModel {
	private int questionID;
	private Connection conn=null;
	private Statement statement=null;
	private Statement statement2=null;
	private ArrayList<String> options=new ArrayList<String>();
	private int questionType;
	public int getQuestionType() {
		return questionType;
	}
	public RetrieveOptionsModel(int questionID){
		this.questionID=questionID;
	}
	public ArrayList<String> getOptions(){
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			conn=dbcon.createDatabaseConnection();
			statement=(Statement) conn.createStatement();
			statement2=(Statement) conn.createStatement();
			ResultSet resultSet=(ResultSet) statement2.executeQuery("SELECT QuestionType FROM question WHERE QuestionID="+questionID);
			if(resultSet.next()){
				questionType=resultSet.getInt("QuestionType");
			}
			statement.execute("SELECT OptionValue,OptionCorrectness FROM options WHERE QuestionID="+questionID);
			System.out.println("QID:"+questionID);
			ResultSet rs=(ResultSet) statement.getResultSet();
			while(rs.next()){
				if(rs.getInt("OptionCorrectness")==1)
					options.add("<label style='color:green'>"+rs.getString("OptionValue").replace("<", "&lt;")+"</label>");
				else
					options.add(rs.getString("OptionValue").replace("<", "&lt;"));				
			}
			statement.close();
		}
		catch(SQLException ex){
			System.out.println("Exception At 1");
			ex.printStackTrace();
		}finally{
			dbcon.closeLocalConnection(conn);
		}
		return options;
	}
	
	
}
