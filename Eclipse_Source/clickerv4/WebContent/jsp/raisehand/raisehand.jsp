<!-- Author: Dipti.G  from Clicker Team, IDL LAB -IIT Bombay

This is used to display main raise hand module with list of active and pending doubt for that course
 -->


<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="clicker.v4.raisehand.*" %>
<%@page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Raise Hand</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/switch.css">
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/raisehand.js"></script>
<style type="text/css">
.opt{
    
    background-color: #9bbb59;
   
    border-radius:10px;    
    height:16px;
    text-align:center;
    font-size:20px;
    padding: 5px;
    margin-top: 3px;  
   
}
.selectwindow{
	background-color: #ffffff;
}
._css3m{
display:none
}
</style>
<script type="text/javascript">
var xmlhttp;
function selected(){
$(document).ready(function(){
	
			 if ($('input[type="radio"]').is(":checked")) {
				 var val= $('input[name=checkselect]:checked').val();
				 if(val=='1'){
					 $.post("../../raiseHandDiscussed?timeStamp="+document.getElementById('timestamp').value+"&StudentID="+document.getElementById('studentID').value);
					 document.getElementById("raiseques").innerHTML = "";
					 var x=document.getElementById("pendingraise");
					 x.remove(x.selectedIndex);
					 var y=document.getElementById("activeraise");
					 y.remove(y.selectedIndex);
					 }
				 else if(val=='2')
					 {
					 if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
							xmlhttp = new XMLHttpRequest();
						} else if (window.ActiveXObject) { // IE
							try {
								xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
							} catch (e) {
								try {
									xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
								} catch (e) {
								}
							}
						}
					 xmlhttp.onreadystatechange=function()
						{
							if (xmlhttp.readyState==4 && xmlhttp.status==200)
							{
								document.getElementById("emailDiv").innerHTML=xmlhttp.responseText;
								document.getElementById("emailDiv").style.visibility = 'visible';
								document.getElementById("emailDiv").title ="WRITE REPLY FOR DOUBT";
								$("#emailDiv").dialog({height: 350, width: 440, modal: true ,
							        close: function(ev, ui) { 
							        	document.getElementById("raiseques").innerHTML = "";
							        	location.href="raisehand.jsp";
								        },});
							}
						};	
						xmlhttp.open("GET", "replydoubt.jsp?TimeStamp="+document.getElementById('timestamp').value+"&StudentID="+document.getElementById('studentID').value, true);
						xmlhttp.send();
					 }
				 else{
						if(confirm('Are you sure, you want to delete?')){
					 $.post("../../deleteDoubtServlet?timeStamp="+document.getElementById('timestamp').value);
					 document.getElementById("raiseques").innerHTML = "";
					 var x=document.getElementById("pendingraise");
					 x.remove(x.selectedIndex);
					 var y=document.getElementById("activeraise");
					 y.remove(y.selectedIndex);
					 }
				 }
			    }else{
			    	alert("Please select record"); 
			    }
		
});
}

</script>

<script type="text/javascript">

function activeraiseHand(){
	$(document).ready(function() {
	    setInterval(function() {
	    	 jQuery.get("activeraisehand.jsp", function (response) {
	        	if(response!=null){
	        		$('#activeraisehanddiv').load("activeraisehand.jsp");	
	        	}
	    	});
	    }, 1000);
	});
	}  
     
</script>
</head>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/menuheader.jsp" %>
<script type="text/javascript">activeraiseHand();</script>
<table class="table1">
<tr>
<td>
<div class="ui-createquiz-text" style="font-weight: bold;font-size: 24px">
Raise hand
</div>
</td>
</tr>
</table>
<div id="raisehanddisplay">
<div id="hideRaiseHand">
<table class="table1">
<tr>
<td>
<button style="float: right" class="ui-createquiz-button" id="createqbtn1" type="button" onclick="location.href='../../retrieveRecords'">
<span>View saved doubts</span>
</button>
</td>
</tr>
</table>
<table class="table1" style="margin-top:2px;">
<tr>
<td>
 <div class="iphone-toggle-buttons" style="margin-left:400px; height:20px">
<!--<ul>
<label for="checkbox-0"><input type="checkbox" name="checkbox-0" id="checkbox-0" /><span>checkbox 0</span></label>
</ul> -->
</div>  
<div style="margin-left:445px;margin-top:-20px;">	
</div>
</td>
</tr>
</table>
<%
String CourseID=session.getAttribute("courseID").toString();
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
Statement st =conn.createStatement();	
//Global.raisehandcounter.put(CourseID,0);
%>
<table class="table1" style="margin-top:2px;" border="1" >
<tr >
<td >
<div style=" margin: 0px 0 0 0px;width:226;" >
<label style="font-size:20px;font-weight:bold; ;width: 250px;color:#e46c0a ">Active RaiseHand</label>

<div id="activeraisehanddiv" style="width: 250px; height:150px;">
</div>
<label style="font-size:20px;font-weight:bold; ;width: 250px;color:#e46c0a ">Pending RaiseHand</label>
<%
ResultSet rs2=null;
try{	
		String query2="SELECT DISTINCT stu.StudentID,rh.RaiseTimeStamp FROM student as stu,studentcourse as stuCou,raisehand as rh WHERE rh.StudentID=stu.StudentID AND rh.StudentID=stuCou.StudentID AND rh.CourseID='"+CourseID+"'"+"AND rh.RepliedDoubt=1 ORDER BY rh.RaiseTimeStamp DESC";
		//System.out.println("query1==>"+query2);
		rs2=st.executeQuery(query2);

%>
<select class= "selectwindow" size="5" multiple="multiple" name="pendingraise" id="pendingraise" style="width: 250px; height:150px;" onchange="loadPendingDoubts('Pending');">
<%while(rs2.next())
		{
			
		
			String studentID = rs2.getString(1);
			String TimeStamp=rs2.getString(2);
			 %>

<option class= "opt" value="<%=studentID+"@"+TimeStamp+"@"+1+"@"+CourseID%>"><%=studentID %></option>
<%
//System.out.println(studentID);
}

}
catch(Exception e)
{
out.println(e);
}finally{
	rs2.close();
	st.close();
	dbconn.closeLocalConnection(conn);
}

%>
</select>
</div>
</td>

<td>
<div id="emailDiv" style="visibility:hidden;" title="Response"></div>
<div id="raiseques" style="font-size: 18px; height:350px; width:700px; text-align:center;"></div>

</td>
</tr>
</table>
</div>
</div><br>
<div style="margin:-615px 0 0 0px;">
<%@ include file= "../../jsp/includes/menufooter.jsp" %>
</div>
</body>
</html>