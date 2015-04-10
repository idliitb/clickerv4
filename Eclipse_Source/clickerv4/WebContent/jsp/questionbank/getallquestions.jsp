<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

    <%@ page import ="clicker.v4.questionbank.*" %>
    <%@ page import ="clicker.v4.databaseconn.*" %>
<%

System.out.println("Here in GET");
GetAllQuestions gaq=new GetAllQuestions();
int archive = 1, quest_type = Integer.parseInt(request.getParameter("question_type")), selector = Integer.parseInt(request.getParameter("selector"));
String InstrID=request.getParameter("InstrID"), courseid = request.getParameter("courseid");

if(request.getParameter("archived")!=null)
	gaq.setAllQuestions(archive);
int math_select = 1;

if(quest_type == 5)
{
	math_select = 2;
	quest_type = 1;
}
else if(quest_type == 6)
{
	math_select = 2;
	quest_type = 2;
}
else if(quest_type == 7)
{
	math_select = 2;
	quest_type = 3;
}
else if(quest_type == 8)
{
	math_select = 2;
	quest_type = 4;
}
System.out.println("IID: " + InstrID + " question type: " + quest_type + " math_select: " + math_select);
String quest=gaq.getAllQuestions(quest_type,InstrID, courseid, selector, math_select);
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
