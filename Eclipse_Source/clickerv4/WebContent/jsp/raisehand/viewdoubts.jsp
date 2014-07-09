<!-- Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
this is used to display doubt text and time stamp of select student ID
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="clicker.v4.raisehand.RaiseHandRowData,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../css/saveddoubts.css" rel="stylesheet" type="text/css" />
<title>View Doubt</title>
</head>

<%ArrayList<RaiseHandRowData> list = (ArrayList<RaiseHandRowData>)request.getAttribute("studentData"); %>
<%for(RaiseHandRowData rdata:list){
%>

<input type="hidden" id= "email" name="email" class="email"
			value="<%=rdata.getEmail()%>">
<input type="hidden" id= "timestamp" name="timestamp"
			value="<%=rdata.getRaiseHandTimeStamp()%>">
<input type="hidden" id= "studentID" name="studentID"
			value="<%=rdata.getStudentID()%>">
<br>
<div class="doubtWrap" style="text-align: center; margin-left: 40px;height:350px ">
<div class="doubtTextDiv" style="width: 600px ;height:30px;overflow:auto;">
		<label style="margin-left: 5px;">Student ID :- <%=rdata.getStudentID()%>
		</label><label style="margin-left: 5px;">TimeStamp :- <%=rdata.getRaiseHandTimeStamp()%>
		</label>
	</div>
	<div class="doubtTextDiv" style="width: 600px ;height:120px;overflow:auto;">
		<br><label style="margin-left: 5px;"><%=rdata.getComment()%>
		</label>
	</div>
	<br>
	<br>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>
				Already Discussed in class </b></label><input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='1' />
	</div>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>Reply to sender</b></label> 
		 <input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='2' />
	</div>
	<div class="emailDiv">
		<label style="padding-left: 1px; display: table-cell;"><b>
				Delete this doubt</b></label><input type="radio"
			id ="checkselect" name="checkselect" class="checks"
			value='3' />
	</div>
	<div style="height: 50px; float: left;"></div>
	<input class="buttons" style=" padding-left: 20px;padding-top: 0px" type="button"
				value="  Submit    " id="submit" onclick="selected();"></input>
</div>




<%}%>
</html>