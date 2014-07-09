<!-- Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay

this is used to create a page showing student doubt without filtering raise hand.  
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="clicker.v4.raisehand.*,java.util.*"%>
<%@page import="java.sql.*"%>
<%

	String InstructorID = (String) session.getAttribute("InstructorID");
	String CourseID=(String) session.getAttribute("courseID");
	//System.out.println("scuhdusgc dc..........."+CourseID);
	//System.out.println("Instructor ID is.......... : " + InstructorID);

	if (InstructorID == null) {
		request.setAttribute("Error",
				"Your session has expired.");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
	}
%>
<html>
<head>
<base href="./jsp/raisehand/saveddoubts.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../css/saveddoubts.css" rel="stylesheet" type="text/css" />
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<title>Saved Doubts</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/switch.css">
<style type="text/css">
._css3m{
display:none
}
</style>
<script type="text/javascript">$(document).ready(function(){
	fillContent();
	$("#delete").click(function(){
		
		 if ($('input[type="checkbox"]').is(":checked")) {
		    	$(":checkbox:checked").each(
		    			function(){
		    				$.post("../../deleteDoubtServlet?timeStamp="+$(this).val());
		    				$(this).parent().parent().remove();
		    			}
		    		);
		    }else{
		    	alert("Please select records to be deleted"); 
		    }

	
	});
	function fillContent(){
		$.get("../../retrieveRecords?text="+$("#textBox").val()+"&date="+$("#date").val()+"&CourseID="+encodeURIComponent($("#CourseID").val()),function(result){
			$("#doubts").html(result);
		});
	}
	$("#textBox").keyup(function(){
		fillContent();
	});
	$("#date").change(function(){
		fillContent();
	});
	
});
</script>
</head>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/menuheader.jsp" %>
<table class="table1">
<tr>
<td>
<div class="ui-createquiz-text" style="font-weight: bold;font-size: 24px" >
<lable>Raise hand</lable></div>
</td>
</tr>
<tr>
<td align="center">
		<div style="min-height: 500px; margin-bottom: 20px; float: center">
			<%ArrayList<RaiseHandRowData> list = (ArrayList<RaiseHandRowData>)request.getAttribute("records"); 
			RaiseHandHelper rhh=new RaiseHandHelper();
			ArrayList<String> datelist= rhh.retrieveDate(session.getAttribute("courseID").toString());
			%>
			<table class="table1"style="width: 600px; margin-top: 30px;">
				<tr>
					<td><label style="font-size: medium;"><b>Search Doubt
								</b></label></td>
					<td><input type="hidden" id="CourseID" name="CourseID" value="<%=CourseID%>"></input>
					<input type="text" id="textBox"
						style="width: 400px; margin-left: 25px;"></td>
				</tr>
				<tr style="visibility: hidden;">
					<td><label style="font-size: medium;"><b>Search By
								Date</b></label></td>
					<td><select id="date" style="width: 200px; margin-left: 25px;">
							<option value="1">All Time</option>
						<%
						for(int i=0;i<datelist.size();i++){
							String[] date=datelist.get(i).split(" ");
							//System.out.println("timestamp....."+date[0]);
							%>
							<option value="<%=date[0]%>"><%=date[0]%></option>
							<%							
						}
							%>
					</select></td>
				</tr>
			</table>
			<input
				class="buttons" type="button" value="   Delete Selected Doubts  "
				id="delete">
				<br>
			<div id="doubts" style="height: 400px; width: 800px; overflow: auto;">

			</div>
		</div>
		</td>
		</tr>
		</table>
		<br>
		<div style="margin:-615px 0 0 0px;">
		<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>	
</body>
</html>