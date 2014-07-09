<!--Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay

This file create a UI to show doubt which are saved in database after search and date value are selected

 -->

<%@ page import="clicker.v4.raisehand.RaiseHandRowData,java.util.*"%>
<%ArrayList<RaiseHandRowData> list = (ArrayList<RaiseHandRowData>)request.getAttribute("records"); %>
<%for(RaiseHandRowData rdata:list){%>
<div class="doubtWrap">
	<div class="doubtTextDiv">
		<br> <label style="margin-left: 5px;"> <%=rdata.getComment()%>
		</label>
	</div>
	<table class="studentInfo">
		<tr>
			<td style="width: 150px"><b>RollNo.</b></td>
			<td><%=rdata.getStudentID()%></td>
		</tr>
		<tr>
			<td style="width: 150px"><b>Student Name</b></td>
			<td><%=rdata.getName()%></td>
		</tr>
		<tr>
			<td style="width: 150px"><b>Semester</b></td>
			<td><%=rdata.getSemester()%></td>
		</tr>
	</table>
	<div class="emailDiv">
		<label style="padding-left: 5px; display: table-cell;"><b>Mark
				for Delete</b></label> <input type="hidden" class="email"
			value="<%=rdata.getEmail()%>"> <input type="checkbox"
			name="reply" class="checks"
			value="<%=rdata.getRaiseHandTimeStamp()%>" />
	</div>
	<table class="timeStampDiv">
		<tr>
			<td style="width: 100px"><b>TimeStamp</b></td>
			<td style="font-size: small;"><%=rdata.getRaiseHandTimeStamp()%></td>
		</tr>
	</table>
</div>
<%}%>