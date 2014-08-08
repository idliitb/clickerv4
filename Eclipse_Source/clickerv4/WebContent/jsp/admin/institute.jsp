
<%--
      @author Gobinath
DESCREPTION: it is the one time display page when the admin is login the admin want to 
             insert their institution details 
			 
USE        : to add the institution details  

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Institution</title>
</head>
<script type="text/javascript" src="../../js/department_course.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<link rel="stylesheet" media="all" type="text/css" href="../../jsp/newMenu/dropdown.css" />
<script>

<%
int count=0;
DatabaseConnection dbconn1 = new DatabaseConnection();
Connection conn1 = dbconn1.createDatabaseConnection();
Statement st1 = conn1.createStatement();
String inst_name=null;
try {
	int i = 0;
	String query1 = "SELECT instiID FROM institution;";
	//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
	System.out.println(query1);
	ResultSet rs = st1.executeQuery(query1);
	while (rs.next()) {
		i++;					
	}
	count=i;	
	if(i==1)
	{
		System.out.println("------------>"+i);
		 // window.location.assign("../../jsp/admin/institute.jsp");
	}

		//out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
		//System.out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);


} catch (Exception e) {
	e.printStackTrace();
}
finally
{
	dbconn1.closeLocalConnection(conn1);
}

%>


function check_int()
{
	var inst_count=document.getElementById("instcount").value;	
	if(inst_count=="2")
		window.location.assign("../../jsp/admin/department.jsp");
	}
function trimfield(str) 
{ 
	 	return str.replace(/^\s+|\s+$/g,''); 
}
function validate( )
{
	{
		//alert("in check1");
		var inst_name = document.getElementById("inst_name").value;
		var inst_address = document.getElementById("inst_address").value;	
		
		 if(inst_name == null || trimfield(inst_name) == '')
		{
			alert("Please fill Center Name");
			return false;
		}
		
		else if(inst_address == null || trimfield(inst_address) == '' || inst_address < 0)
		{
			alert("City field cannot be empty. Please fill this field");
			return false;
		}
		else
			return true;
	}
	
}</script>


<body onload="check_int();">
<%@ include file= "../includes/menuheader.jsp" %>
<input id="instcount"  style="visibility:hidden; width:220px;  font-size:15px; color:black" type="text" name="centerid" value = '<%=count%>' /> 
<form class="form-4"  method="post" name = "addinstitute" action="../../AddInstitute" onsubmit = "return validate()">
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; font-size: 25px;">Add Institute</label></div>
	<div style="margin-top:30px">
	<table  style="height:150px;margin:auto; " border='0'>
		
		<tr align="left">
			<td style="height:20px;width:260px;">
				<label style=" color: #e46c0a;font-size:18px">Institute Name</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="inst_name"  style="width:220px;  font-size:15px; color:black" type="text" name="inst_name" required tabindex="1"  placeholder="Institute Name"/>
			</td>
		</tr>
		<tr align="left">
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Institute Address</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="inst_address"  style="width:220px;  font-size:15px; color:black" type="text" name="inst_address" required tabindex="2"  placeholder="Enter Address"/>
			</td>
		</tr>
		
				
	</table>
	</div>
</div>	
	<div style="margin-top:20px">	
		<button name = "submit" style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="submit" type="submit" tabindex="7" >
		<span>Submit</span>
		</button>
	</div>
</form>

<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>