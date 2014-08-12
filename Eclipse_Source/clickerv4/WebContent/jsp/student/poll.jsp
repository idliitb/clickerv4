<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/student.css">
<title>Insert title here</title>
</head>
<body>

<div>Timer</div>



<div class="ui-table_green" >
<br>
	<div class="questiondiv">Do you want class tomorrow ?</div>
<br>
	<div style=" margin-top:130px; height:150px; ">
	<br>
		<input type="radio" name="choice" value="yes" checked="checked" style="margin-left:-50px; width:4em; height:4em;"><label style="color: #FCF9F9; font-size:60px; margin-left:10px;">YES</label>
		
		
		
		<input type="radio" name="choice" value="no" style="margin-left:200px; width:4em; height:4em; "><label  style="color: #FCF9F9;  font-size:60px; margin-left:10px;">NO</label>
	</div>
<br>
	<div  style="margin-top:40px;">
		<button id="submit" type="submit" class="ui-loginbutton" onclick="window.location.href='home.jsp'">
		 	<span >Submit</span>
	 	</button>
	</div>
		
		
</div>

</body>
</html>