<!--Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay

This is used to create a form which is used to send reply back to student for their particular doubt

-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function trimfield(str) 
{ 
    return str.replace(/^\s+|\s+$/g,''); 
}

function validate()
{
     var obj1 = document.replyForm.content;
         if(trimfield(obj1.value) == '') 
         {      
           alert("Please Enter Reply!");
           obj1.focus();
           return false;       
         }

           alert("clear");
           return true;
           $('input[name=checkselect]:checked').unchecked;
  
}
</script>
</head>
<%
String TimeStamp=request.getParameter("TimeStamp");
String StudentID=request.getParameter("StudentID");
%>
<body style="text-align: center;">
<h2>Reply Doubt</h2>
<form  name="replyForm" id="replyForm" action="../../raiseHandReplied" method="post">
<input type="hidden" name ="timestamp" id="timestamp" value="<%=TimeStamp%>"/>
<input type="hidden" name ="studentid" id="studentid" value="<%=StudentID%>"/>
		<table style="width:35%;font-weight: bold;margin-left: 10px;border: 1px">
			<tr>
				<td>Write below your explanation :</td>
			<tr>
				<td><textarea rows="8" cols="45"  id ="content" name="content" style="overflow: auto;"></textarea> </td>
			</tr>
			<tr style="height: 40px">
				<td colspan="2" align="center"><input type="submit" style="width: 50%" height="20%" onclick="return validate();" value="Send to Student"/></td>
			</tr>
		</table>		
	</form>
</body>
</html>