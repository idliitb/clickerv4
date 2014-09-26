<%@page import="clicker.v4.wrappers.*"%>
 <%@page import= "com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String RepliedAnswer=request.getParameter("repliedDoubt");
System.out.println("Value from replied answer::::::"+RepliedAnswer);
Gson gson = new Gson();
RepliedRaiseHand repliedans=gson.fromJson(RepliedAnswer, RepliedRaiseHand.class);

%>    
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body{
	position:relative;
	text-align:center;
	width:100%;
	height:100%;
	margin:auto;
	background-color: #404040;
	}
#main_container{
margin:auto;
width:1320px;
height:627px;

}
#replytable{
	width:1183px;
	float:left;
	border: 1px  black;
	}
.thdiv{
background-color: #9bbb59;
width:1184px;
height:50px; 
font-size:25px;
text-align:center;
margin-left:70px;
float:left;
margin-top:20px;
}

#replytable td{
background-color: #FFFFFF;
height:40px; 
font-size:22px;
text-align:center;
}
.ui-loginbutton{
	background:#E46C0A;
	color: balck;
	height:60px;
	width:210px;
	border-radius:10px;
	font-size:25px;	 
	float:left;
	margin-left:550px;
	margin-top:15px;
}
</style>
<title>Reply</title>
</head>
<body>
<div id="main_container">
	<font size=25px; color="#ffffff" style="margin-top:5px;float:left; margin-left:550px;">Queries</font>

	<div class="thdiv">
		<table border="0" style="margin-top:10px; width:1185px;">
		<tr>
			<th style="width:100px;">Q.No.</th>
			<th style="width:549px;">Query Raised</th>
			<th style="width:549px;">Reply from Instructor</th>
			
		</tr>
		</table>
	</div>
	
	<div style="width:1198px; height:400px; float:left; margin-left:70px;overflow:auto;">
		<table id="replytable">
		<%for(int i=0;i<repliedans.getDoubtText().size();i++){ %>
		<tr>
			<td style="width:100px;"><%=i+1%></td>
			<td style="width:549px;"><%=repliedans.getDoubtText().get(i)%></td>
			<td style="width:549px;"><%=repliedans.getReplyText().get(i)%></td>
		</tr>
		<% }%>
		</table>
	</div>
	
	<button id="cancel" type="submit" class="ui-loginbutton" onclick="window.location.href='raisehand.jsp'">
		 	<span >Cancel</span>
	 </button>

</div>
</body>
</html>