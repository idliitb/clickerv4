/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This Class inserts Multiple questions from the XLS file in the database.
 */
package clicker.v4.questionbank;

import java.io.File;
import java.sql.*;

import clicker.v4.databaseconn.*;
import clicker.v4.questionbank.History;
import jxl.*;



public class XLSimport {
	int questionID = -1, k = 5, qtype = 0;
	String option = "", quest, instrid;
	public int getQuestionID() {
		return questionID;
	}

	public int insertQuery(String query, String columns, int selector, int endcount) {
		DatabaseConnection db = new DatabaseConnection();
		Connection conn = db.createDatabaseConnection();
		try {

			
			PreparedStatement st = null;
			//Statement st = con.createStatement();
			int i = 0, qid = 0, opcorrectness = 0;
			float credits = 0;
			String delimiter = "`";
			String cols[ ] = columns.split(delimiter);
			
			if(selector == 1){
			quest = cols[0];
			instrid = cols[4];
			credits = Float.parseFloat(cols[i + 1]);
			qtype = Integer.parseInt(cols[i + 2]);
			int shuffle = Integer.parseInt(cols[i + 5]);
			System.out.println("In question insertQuery");
			st = conn.prepareStatement(query);
			st.setString(1, cols[i]);
			st.setFloat(2, credits);
			st.setInt(3, qtype);
			st.setString(4, cols[i + 3]);
			st.setString(5, cols[i + 4]);
			st.setInt(6, shuffle);
			st.setString(7, cols[i + 6]);
			
			int result = st.executeUpdate( );
			System.out.println("result = " + result);
			ResultSet rs = st.getGeneratedKeys();
			if (rs.next()) {
				questionID = rs.getInt(1);
				System.out.println("insertQuery questionID: " + questionID);
			}
			db.closeLocalConnection(conn);
			
			}
			else
			{
				System.out.println("endcount: ----------------------" + endcount);
				System.out.println("qtype: ----------------------" + qtype);
				if(qtype == 1 || qtype == 2)
				{
					if(k <= endcount)
					{
						System.out.println("endcount: " + endcount);
						option += cols[i] + ",";
						k++;
					}
					if(k > endcount)
					{
						
						option = option.substring(0, option.length()-1);
						// Adding entry in the Questions history table
						History history = new History (questionID, quest, instrid, option);
						history.addentry ();
						k = 5;
						option = "";
					}
					
				}
				else
				{
					// Adding entry in the Questions history table
					History history = new History (questionID, quest, instrid, cols[i]);
					history.addentry ();
				}
				opcorrectness = Integer.parseInt(cols[i + 1]);
				credits = Float.parseFloat(cols[i + 2]);
				qid = Integer.parseInt(cols[i + 3]);
				System.out.println("In options insertQuery");
				st = conn.prepareStatement(query);
				st.setString(1, cols[i]);
				st.setInt(2, opcorrectness);
				st.setFloat(3, credits);
				st.setInt(4, qid);
				
				int result = st.executeUpdate( );
				System.out.println("result = " + result);
				db.closeLocalConnection(conn);
				
			}
			//int result = st.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
			
			/*if(selector == 1){
			}*/
			
			return questionID;
		} catch (SQLException ex) {
			System.out.println("insert query exception: " + ex);
			return -1;
		}
	}

	public void insertQuestion(String Questiontxt, float Credit, int shuffle,
			int QuestionType, String ansOrder, String InstrID, String courseid, int endcount) {
		try {
			
			
			String qcolumns = Questiontxt + "`" + Credit + "`" + QuestionType + "`" + ansOrder + "`" + InstrID + "`" + shuffle + "`" + courseid; 
			System.out.println("qcolumns: " + qcolumns);
			String sql = "Insert into question(Question, LevelofDifficulty, Archived, Credit, " +
						 "QuestionType, AnswerOrder, InstrID, Shuffle, CourseID) values(?, 1, 0, ?, ?, ?, ?, ?, ?)";	
			//System.out.println("Question" + insertQuery(sql, con));
			System.out.println("Question" + insertQuery(sql, qcolumns, 1, endcount));

			//conn1.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void insertOptions(String OptionValue, int OptionCorrectness, float credit,
			int QuestionID, int endcount) {
		try {
			
			String ocolumns = OptionValue + "`" + OptionCorrectness + "`" + credit + "`" + QuestionID;
			String sql = "Insert into options(OptionValue, OptionCorrectness, LevelofDifficulty, Archived," +
					"Credit, QuestionID) values(?, ?, 1, 0, ?, ?)";
			//System.out.println("options" + insertQuery(sql, con));
			System.out.println("options" + insertQuery(sql, ocolumns, 2, endcount));

			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String readQuestionXLSFile(String instrid, File xlsfile, String courseid) {
		try {
			Workbook workbook = Workbook.getWorkbook(xlsfile);
			int endcount = 0;
			// String sheetName[] = workbook.getSheetNames();
			Sheet sheet;
			Cell xlsCell;
			Cell[] cell;
			// Getting first sheet of xls
			sheet = workbook.getSheet(0);
			System.out.println("Sheet name = " + sheet.getName());
			// i start from 1 because it will avoid first row in xls sheet that
			// is (Row 1)
			for (int i = 1; i < sheet.getRows(); i++) {
				String Question = "";
				float Credit = 0.0f;
				//String instrid = "";
				cell = sheet.getRow(i);
				xlsCell = sheet.getCell(0, i);
				Question = xlsCell.getContents().toString();
				System.out.println("xls Question = " + Question);
				if (Question.equals("")) {
					return "Question cannot be blank!";
				}

				xlsCell = sheet.getCell(1, i);
				String cellvalue = xlsCell.getContents().toString();
				if (cellvalue.equals("") || !(cellvalue.equals("g") || cellvalue.equals("m") || cellvalue.equals("n") || cellvalue.equals("t"))) {
					return "Enter the value for Question Type as either g: Single Correct Answer" +
	                			" or m: Multiple Correct Answers or n: Numerical or t: True or False!"; 
				}
				// This Token defines the type of questions (g - General, m -
				// Multiple, n - Numeric, t - True / False and y - Yes / No)
				String QuestinTypeToken = "gmnty";
				int QType = QuestinTypeToken.indexOf(Character.toString(
						cellvalue.charAt(0)).toLowerCase()) + 1;
				System.out.println("Question Type " + QType);
				
				xlsCell = sheet.getCell(2, i);
				cellvalue = xlsCell.getContents().toString();
				if (cellvalue.equals("")|| cellvalue.equals("^[a-zA-Z]*")) {
					return "Credit Value field cannot be empty!";
				}
				Credit = Float.parseFloat(cellvalue);
				
				xlsCell = sheet.getCell(3, i);
				cellvalue = xlsCell.getContents().toString();
				if (cellvalue.equals("") || cellvalue == null) {
					cellvalue = "1";
				}
				int shuffle = Integer.parseInt(cellvalue);

				xlsCell = sheet.getCell(4, i);
				cellvalue = xlsCell.getContents().toString();
				int check = cellvalue.length();
				System.out.println("check: " + check);
				if (cellvalue.equals(""))
                {
                	return "Correct answer field cannot be empty!";
                	
                }
                else if(!(cellvalue.equals("true") || cellvalue.equals("false") || (QType == 3)))
                {
                	for(int m = 0; m < check; m++)
                		if(!(Character.toString(cellvalue.charAt(m)).equals("a") || Character.toString(cellvalue.charAt(m)).equals("b") 
                			|| Character.toString(cellvalue.charAt(m)).equals("c") || Character.toString(cellvalue.charAt(m)).equals("d")
                			|| Character.toString(cellvalue.charAt(m)).equals("e") || Character.toString(cellvalue.charAt(m)).equals("f")) || cellvalue == null)
                		{
                			return ("Enter the correct option between alphabets " +
                					"a and f corresponding to the correct options");
                		}
                }
				String Ans = cellvalue.toLowerCase();
				
				/*xlsCell = sheet.getCell(4, i);
				instrid = xlsCell.getContents().toString();
				System.out.println("xls instrid = " + instrid);
				 
				if (instrid.equals("")) {
					break;
				}*/
				int QuestionID = 0;
				if((QType == 3) || (QType == 4))
				{
					insertQuestion(Question, Credit, shuffle, QType, Ans, instrid, courseid, endcount); //Needs TO BE REVIEWED
					QuestionID = getQuestionID();
					System.out.println("question id is " + QuestionID);
				}
				// This will Execute for General and Multiple Questions
				if (QType == 1 || QType == 2) {
					if((cell.length >= 9) && (cell.length <= 11))
					{
						insertQuestion(Question, Credit, shuffle, QType, Ans, instrid, courseid, endcount); //Needs TO BE REVIEWED
						
						QuestionID = getQuestionID();
						
						// This Token define the Options
						String OptionToken = "abcdef";
						int OptionCorrectness = 0;
						// j start from 5 because it will take only options (from
						// Column F)
						for (int j = 5; j < cell.length; j++) {
							xlsCell = sheet.getCell(j, i);
							endcount = (cell.length - 1);
							System.out.println("Options: " + xlsCell.getContents().toString());
							String OptionValue = xlsCell.getContents().toString();
							if (OptionValue.equals("")) {
								return "Options cannot be empty. Please check the options.";
							}
							OptionCorrectness = 0;
							// Seting option correctness for General Question
							if (Ans.length() == 1) {
								if (OptionToken.indexOf(Ans) + 5 == j) {
									OptionCorrectness = 1;
								}
							}
							// Seting option correctness for Multiple Choice
							// Question
							else {
								for (int k = 0; k < Ans.length(); k++) {
									OptionCorrectness = 0;
									if (OptionToken.indexOf(Character.toString(Ans
											.charAt(k))) + 5 == j) {
										OptionCorrectness = 1;
										break;
									}
								}
							}
							insertOptions(OptionValue, OptionCorrectness, Credit, QuestionID, endcount);
						}
					}
					else
                	{
                		return "Options cannot be less than 4 and greater than 6 for the multiple correct and single correct answers. Please check the options.";
                		
                	}
				}
				// It will Execute for Numeric Questions
				else if (QType == 3) {
					String OptionValue = Ans;
					insertOptions(OptionValue, 1, Credit, QuestionID, endcount);
				} // It will Execute for True / False Questions
				else if (QType == 4) {
					//char s = Ans.charAt(0);
					String OptionValue = Ans;
					insertOptions(OptionValue, 1, Credit, QuestionID, endcount);
					if (Ans.equals("true")) {
						insertOptions("false", 0, Credit, QuestionID, endcount);
					} else {
						insertOptions("true", 0, Credit, QuestionID, endcount);
					}

				}

			}
			return "Question uploaded  Successfully";

		} catch (NumberFormatException ex) {
			System.out.print("Wrong Credit value = " + ex);
			return "Wrong Credit value";
		} catch (Exception exec) {
			System.out.print("Exception = " + exec);
			return "Wrong File Format";
		}
	}

}