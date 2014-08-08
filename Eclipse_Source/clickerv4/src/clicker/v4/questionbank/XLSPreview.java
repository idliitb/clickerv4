package clicker.v4.questionbank;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This servlet displays the questions in XLS file before inserting them in the database.
 */
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

@SuppressWarnings("serial")
public class XLSPreview extends HttpServlet {
	 
	 public String readQuestionXLSFile(PrintWriter out, File xlsfile) {
	        try {
	        	//PrintWriter out = new PrintWriter(xlsfile);
	        	System.out.println("XLS Preview Filename: " + xlsfile.getPath());
	            Workbook workbook = Workbook.getWorkbook(xlsfile);
	            //String sheetName[] = workbook.getSheetNames();
	            Sheet sheet;
	            Cell xlsCell;
	            Cell[] cell;
	            // Getting first sheet of xls
	            sheet = workbook.getSheet(0);
	            // i starts from 1 because it will avoid first row in xls sheet that is (Row 1)
	            for (int i = 1; i < sheet.getRows(); i++) {
	                String Question = "";
	                String instrid = "";
	                float Credit = 0.0f;
	                cell = sheet.getRow(i);
	                System.out.println("Cell: " + cell.length);
	                xlsCell = sheet.getCell(0, i);
	                Question = xlsCell.getContents().toString();
	                if (Question.equals("")) {
	                	out.print("<p style='color: red'><b>Question cannot be blank!</b></>");
	                	break;
	                }

	                xlsCell = sheet.getCell(1, i);
	                String cellvalue = xlsCell.getContents().toString();
	                System.out.println("qtype: " + cellvalue);
	                if (cellvalue.equals("") || !(cellvalue.equals("g") || cellvalue.equals("m") 
	                		|| cellvalue.equals("n") || cellvalue.equals("t"))) {
	                	out.print("<p style='color: red'><b>Enter the value for Question Type as either g: Single Correct Answer" +
	                			" or m: Multiple Correct Answers or n: Numerical or t: True or False!</b></>");
	                	break;
	                    
	                }
	                //This Token defines the type of questions (g - General, m - Multiple, n - Numeric, t - True / False and y - Yes / No)
	                String QuestinTypeToken = "gmnty";
	                int QType = QuestinTypeToken.indexOf(Character.toString(cellvalue.charAt(0)).toLowerCase()) + 1;
	                System.out.println("QTYPE: " + QType);
	                
	                xlsCell = sheet.getCell(2, i);
	                cellvalue = xlsCell.getContents().toString();
	                if (cellvalue.equals("")) {
	                	out.print("<p style='color: red'><b>Credit Value field cannot be empty!</b></p>");
	                    break;
	                }
	                Credit = Float.parseFloat(cellvalue);
	                System.out.println("Credits: " + Credit);
	                
	                xlsCell = sheet.getCell(3, i);
					cellvalue = xlsCell.getContents().toString();
					if (cellvalue.equals("") || cellvalue == null) {
						cellvalue = "1";
					}
					int shuffle = Integer.parseInt(cellvalue);
					System.out.println("shuffle: " + shuffle);
	                
					xlsCell = sheet.getCell(4, i);
	                cellvalue = xlsCell.getContents().toString();
	                System.out.println("Answer0: " + cellvalue);
	                int check = cellvalue.length();
					System.out.println("check: " + check);
					String Ans = "";
	                if (cellvalue.equals(""))
	                {
	                	out.print("<p style='color: red'><b>Correct answer field cannot be empty!</b></p>");
	                	break;
	                }
	                else if(!(cellvalue.equals("true") || cellvalue.equals("false") || (QType == 3)))
	                {
	                	for(int m = 0; m < check; m++)
	                		if(!(Character.toString(cellvalue.charAt(m)).equals("a") || Character.toString(cellvalue.charAt(m)).equals("b") 
	                			|| Character.toString(cellvalue.charAt(m)).equals("c") || Character.toString(cellvalue.charAt(m)).equals("d")
	                			|| Character.toString(cellvalue.charAt(m)).equals("e") || Character.toString(cellvalue.charAt(m)).equals("f")) || cellvalue == null)
	                		{
	                			out.print("<p style='color: red'><b>Enter the correct option between alphabets " +
	                					"a and f corresponding to the correct options </b> </p>");
	                			break;
	                		}
	                }
	                                               	
	                Ans = cellvalue.toLowerCase();
	                System.out.println("Answer1: " + Ans);
	                
	                out.print("<br><br><b>"+(i) +".</b> "+Question+"<br>");
	                
	                
	                // This will Execute for General and Multiple Questions
	                if (QType == 1 || QType == 2) {
	                	if((cell.length >= 9) && (cell.length <= 11))
	                	{
		                    // This Token define the Options
		                	System.out.println("in qtype");
		                    String OptionToken = "abcdef";
		                    int OptionCorrectness = 0;
		                    char ch='a';
		                    System.out.println("in qtype1");
		                    // j start from 5 because it will take only options (from Column F)
		                    for (int j = 5; j < cell.length; j++) {
		                    	System.out.println("in qtype2");
		                        xlsCell = sheet.getCell(j, i);
		                        String OptionValue = xlsCell.getContents().toString();
		                        System.out.println("Option Value: " + OptionValue);
		                        if (OptionValue.equals("") || OptionValue == null) {
		                            out.print("<p style='color: red'><b>Options cannot be empty. Please check the options.</b></p>");
		                        	break;
		                        }
		                        OptionCorrectness = 0;
		                        // Seting option correctness for General Question
		                        if (Ans.length() == 1) {
		                            if (OptionToken.indexOf(Ans) + 5 == j) {
		                                OptionCorrectness = 1;
		                            }
		                        }
		                        // Seting option correctness for Multiple Choice Question
		                        else {
		                            for (int k = 0; k < Ans.length(); k++) {
		                                OptionCorrectness = 0;
		                                if (OptionToken.indexOf(Character.toString(Ans.charAt(k))) + 5 == j) {
		                                    OptionCorrectness = 1;
		                                    break;
		                                }
		                            }
		                        }
		                        out.print("<br>"+"("+(ch++)+")&nbsp&nbsp");
		                        if(OptionCorrectness==1){
		                        	out.print("<label style='color: green'>"+OptionValue+"</label>");
		                        }
		                        else{
		                        	out.print("<label style='color: red'>"+OptionValue+"</label>");
		                        }
		    	                
		                    }
	                	}
	                	else
	                	{
	                		out.println("<p style='color: red'><b>Options cannot be less than 4 and greater than 6 for the multiple correct and single correct answers. Please check the options.");
	                		break;
	                	}
	                } 
	                // It will Execute for Numeric Questions
	                else if (QType == 3) {                    
	                        String OptionValue = Ans;
	                        out.print("<br><label style='color: green'>Correct Answer</label> : "+OptionValue);
	                } // It will Execute for True / False Questions
	                else {
	                    if (Ans.equals("true")) {
	                        out.println("<br><label style='color: green'>Correct Answer</label> : True");
	                    } else {
	                        out.println("<br><label style='color: green'>Correct Answer</label> : False");
	                    }

	                }// It will Execute for Yes / No Questions
	                /*else if (QType == 5) {
		                    if (Ans.equals("yes")) {
		                       out.println("<br><label style='color: green'>Correct Answer</label> : Yes");
		                    } else {
		                       out.println("<br><label style='color: green'>Correct Answer</label> : No");
		                    }

	                }*/
	                if(shuffle == 1)
	                	out.print("<br><br><b>Shuffle&nbsp&nbsp</b>: Yes");
	                else
	                	out.print("<br><br><b>Shuffle&nbsp&nbsp</b>: No");
	                
	                out.print("<br><b>Question Type&nbsp&nbsp</b> : ");
	                switch(QType){
	                case 1:out.println("Single Correct Answer");
	                	break;
	                case 2:out.println("Multiple correct answer");
	                	break;
	                case 3:out.println("Numeric Answer");
	                	break;
	                case 4:out.println("True/False");
	                	break;
	                /*case 5:out.println("Yes or No");
	                	break;*/
	                }
	                out.printf("<br><b>Question Credit</b> : %.2f\n",Credit);
	                System.out.println("--------------------------------");
	            }
	            return "Question uploaded  Successfully";

	        } catch (NumberFormatException ex) {
	            System.out.print("Wrong Credit value :" + ex);
	            out.print("<p style = 'color: red'><b>Wrong Credit Value!</b></p>");
	            return "Wrong Credit value";
	        } catch (Exception exec) {
	            System.out.print("Exception: " + exec);
	            out.print("<p style = 'color: red'><b>Wrong File Format!</b></p>");
	            return "Wrong File Format";
	        }
	 }
	 protected void doGet(HttpServletRequest request,HttpServletResponse response){
		 response.setContentType("text/html");
		 String url = request.getParameter("xls");
		 ServletContext context = getServletContext();
		String pathurl = context.getRealPath("/uploads");
		
		File file = new File(pathurl + "/" + url);
		System.out.println("Filename: " + file.getPath());
		 PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("---------------------------- " + getServletContext().getInitParameter("file"));
		 readQuestionXLSFile(out, file);
		 out.close();
	 }
	    
}