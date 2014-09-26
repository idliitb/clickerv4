<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String instructorID = (String) session.getAttribute("InstructorID");
	String Coordinator=(String)session.getAttribute("CoordinatorID");
	
	if (!(instructorID != null && Coordinator == null) && !(Coordinator != null && instructorID == null)) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
	}
	
	String war_version = getServletContext().getInitParameter("war_version");
	String db_version = getServletContext().getInitParameter("db_version");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Clickerv4</title>

<script>
function download_link()
{
	document.getElementById("downloadlink").submit( );
}
</script>
</head>
<body onload = "">
<div id="soft" class="sub-content">
	<form action="http://www.it.iitb.ac.in/clicker/generateupdatedwar" id = "downloadlink" method = "post">
				<table id="read_me" border = '0'>
					<tr>
						<td colspan="2"><font style="color: red;font-size: x-large;font-weight: bold;">Latest Update is available</font> </td>
					</tr>
					<tr>
						<td width="75px"><b>Step 1</b></td>
						<td><a href="#" onclick = "download_link( );">Press to download the
								clicker.zip and Save the file in Desktop</a></td>
					</tr>
					<tr>
						<td width="75px"><b>Step 2</b></td>
						<td>Extract the "clicker.zip" file by right-click on
							"clicker.zip" and select "Extract Here" option.</td>
					</tr>
					<tr>
						<td width="75px"><b>Step 3</b></td>
						<td>Go to clicker folder from command line<br> Press
							"Ctrl+Alt+t" on keyboard, it will open terminal and type the
							commend.<br> cd Desktop [ENTER]<br> cd clicker<br>
							chmod +x Install.sh<br> sudo ./Install.sh
						</td>
					</tr>
					
				</table>
		<input type = "hidden" name = "war_version_check" value = "<%=war_version %>"/>
		<input type = "hidden" name = "db_version_check" value = "<%= db_version %>" />
		
		
	</form>
			</div>
</body>
</html>