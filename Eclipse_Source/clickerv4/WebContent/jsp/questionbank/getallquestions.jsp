<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

    <%@ page import ="clicker.v4.questionbank.*" %>
    <%@ page import ="clicker.v4.databaseconn.*" %>
<%

System.out.println("Here in GET");
GetAllQuestions gaq=new GetAllQuestions();
int archive = 1, quest_type = Integer.parseInt(request.getParameter("question_type")), selector = Integer.parseInt(request.getParameter("selector"));
String InstrID=request.getParameter("InstrID"), courseid = request.getParameter("courseid");
System.out.println("IID: " + InstrID);
if(request.getParameter("archived")!=null)
	gaq.setAllQuestions(archive);
String quest=gaq.getAllQuestions(quest_type,InstrID, courseid, selector);
%>
<%
response.setContentType("text/plain");
if (quest != "")
	out.print(quest);
else
{
	//JOptionPane.showMessageDialog(null,"Questions in the selected question type is not present", "alert", JOptionPane.ERROR_MESSAGE);
	System.out.println("Value is not present");
	out.print("");
}
%>
