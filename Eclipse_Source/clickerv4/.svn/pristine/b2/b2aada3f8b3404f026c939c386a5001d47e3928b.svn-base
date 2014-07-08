package clicker.v4.dashboard;
import java.util.HashSet;

import java.util.concurrent.ConcurrentHashMap;

import clicker.v4.global.Global;
import clicker.v4.databaseconn.*;

import java.sql.*;
import java.util.*;

public class graphhelper {
	
	public HashSet<Integer> getQuizid( String CourseID)
	{
		//System.out.println("Inside Get QuizID");
		HashSet<Integer> QuizID= new HashSet<Integer>();
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();		
		String Query = "SELECT Distinct q.QuizID FROM quiz q , quizrecord qc where q.QuizID = qc.QuizID and q.Archived = 0 and q.CourseID='"+ CourseID +"'";
		try
		{		
		Statement st1 = conn.createStatement();
		ResultSet rs1 = st1.executeQuery(Query);
		
		while(rs1.next()) {	
			//System.out.println("rs1.getString(QuizID)=="+rs1.getString("QuizID"));
			int id = Integer.parseInt(rs1.getString("QuizID"));		
			//System.out.println("---->"+id);			
			QuizID.add(id);		
		}
		}
		catch (Exception ex)
		{
			
		}
		finally{dbconn.closeLocalConnection(conn);}
		
		return QuizID;
	}
	
	public int getcredit(int quizid)
	{
		
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		
		int credit=0;
		try{		
		
		Statement st = conn.createStatement();
		String Query1 = "select sum(questionCredit) as cSum from quizquestion where QuizID='"+quizid +"'";
		//System.out.println("query in graph helper==>"+Query1);
		ResultSet rs3 = st.executeQuery(Query1);
		while(rs3.next())
		{
			int cr=Integer.parseInt(rs3.getString("cSum"));
			credit=credit+cr;
		}
		//System.out.println("Credit==>"+cr);
		
		
		}catch (Exception ex)
		{
			
		}
		finally{dbconn.closeLocalConnection(conn);}
		return credit;
	}
	
	public String getQuizname(int QuizID)
	{
		//System.out.println("Inside Get QuizID");
		String name = null;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();		
		String Query = "select QuizName from quiz where QuizID='"+ QuizID +"'";		
		try
		{		
		Statement st1 = conn.createStatement();
		ResultSet rs1 = st1.executeQuery(Query);		
		while(rs1.next()) {	
			//System.out.println("rs1.getString(QuizID)=="+rs1.getString("QuizID"));
			 name = rs1.getString("QuizName");		
			//System.out.println("---->"+id);			
				
		}
		}
		catch (Exception ex)
		{
			
		}	
		finally{dbconn.closeLocalConnection(conn);}
		return name;
	}
	
	public float getstudentPersentage(String CourseID,int quizid) throws SQLException
	{
		
		//System.out.println(CourseID+"------>"+quizid );
	    HashSet<String> studenid= new HashSet<String>();
		String Query1 = "select StudentID from studentcourse where CourseID='"+ CourseID +"'";		
		String name = null;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		Statement st = null;
		
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(Query1);
			
			
			while(rs.next()) {	
				   //System.out.println(rs.getString("StudentID"));
				   studenid.add(rs.getString("StudentID"));	
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{dbconn.closeLocalConnection(conn);}		
		
		Iterator it = studenid.iterator();
		DatabaseConnection dbconn1 = new DatabaseConnection();
		Connection conn1 = dbconn1.createDatabaseConnection();
		Statement st1;
		float per=0;
		int total=1;
		float ss=0;
		  while (it.hasNext()){
			  String nam=it.next().toString();
		  // System.out.println(it.next() + " "); 
		  String QQ="select DISTINCT s.StudentID, q.QuizName, sum(o.OptionCorrectness * qc.Credit) as Mark_Obtained, (sum(o.OptionCorrectness * qc.Credit) / (sum(qc.Credit)) *100) as Percentage from quizrecordquestion qrq, quizrecord qr, quiz q, options o, question qc, student s, course c, department d where qrq.StudentID = '"+nam+"' and c.CourseID = '"+CourseID +"' and c.CourseID = q.CourseID and qr.QuizRecordID = qrq.QuizRecordID and q.QuizID = qr.QuizID and o.OptionID = qrq.OptionID and qc.QuestionID = qrq.QuestionID and s.StudentID = qrq.StudentID and d.DeptID = c.DeptID  and qr.QuizID= "+quizid+"";
		  //System.out.println(QQ);
		  st1 = conn1.createStatement();
		  
		  ResultSet rs1 = st1.executeQuery(QQ);
		  
		  while(rs1.next()) {	
			  if(rs1.getString("s.StudentID") == null)
			  {
				  
			  }else
			  {
				 if(rs1.getString("Percentage") != null){
				  //System.out.println(total+"==>"+rs1.getString("s.StudentID")+"==>"+rs1.getString("q.QuizName")+"==>"+rs1.getString("Percentage"));		
				  per=per+Float.parseFloat(rs1.getString("Percentage"));
				  total++;
				  }
			  }
			   	   
		       }  
		  ss=per/total;
		  rs1.close();		  
		  }	
		  dbconn1.closeLocalConnection(conn1);
		 
		  return ss;
	}
}
