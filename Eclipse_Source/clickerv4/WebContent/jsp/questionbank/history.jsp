<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@ page import="java.sql.*" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>

<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<style type="text/css">
._css3m{
display:none
}
</style>


</head>

<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../includes/menuheader.jsp" %>
<%! String [ ] temp1, temp2, temp3, temp4;%>
<%
	Connection conn = null;
	DatabaseConnection db = new DatabaseConnection ( );
	conn = db.createDatabaseConnection ( );
	PreparedStatement st = null;
		
	int qid = -1, qtype = -1;
	qid = Integer.parseInt (request.getParameter ("qid"));
	
	String question = "", instructor = "", date = "", options = "";
	String delimiter = ";";
	
	st = conn.prepareStatement("select Question, Instructor, Date, OptionValue from questionshistory where QuestionID = ? ORDER BY Date asc");
	st.setInt(1, qid);
	
	try
	{
		
		ResultSet rs = st.executeQuery( );
			
		while (rs.next())
		{
			
			instructor += (rs.getString("Instructor")) + ";";
			question += (rs.getString ("Question")) + ";";
			date += (rs.getTimestamp("Date")) + ";";
			options += (rs.getString("OptionValue")) + ";";
		}
		
		temp1 = instructor.split(delimiter);
		temp2 = question.split (delimiter);
		temp3 = date.split(delimiter);
		temp4 = options.split(delimiter);
	}
	catch (Exception e)
	{
		out.println ("Fatal Error! Exiting due to " + e);
	}
	finally
	{
		db.closeLocalConnection(conn);
	}
	
%>

<table class="table1">
<tr >
<td style="margin:10px 0 0 0px">
<div class="ui-createquiz-text" >
<h2><label>History</label></h2></div>
</td>
</tr>

</table>
<br>
<table class="table1" style="margin-top:2px;width : 820px;overflow:auto;" border="1">
<tr style  = "font-size : 16px;"> 
<th> Instructor </th>
<th> Questions </th>
<th> Options </th>
<th> Date </th>   
</tr>
<%for(int i = 0; i < (temp2.length); i++)
	{%>
		<tr style = "font-size : 15px"> 
		<td> <%=temp1[i] %> </td> 
		<td> <%=temp2[i] %> </td>
		<td> <%=temp4[i] %>	</td>
		<td> <%=temp3[i] %> </td>
		</tr>
	<%} %>

</table>
<button class="ui-conductquiz-button" style="margin-left: 5px;" id="histback" type="button" onclick = "history.back( );">
	<span>Back</span>
</button>

<div style="margin-top:-370px;">
<%@ include file= "../includes/menufooter.jsp" %>
</div>
	 
</body>
</html>