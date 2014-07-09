<!-- Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay -->
<%@page import="java.io.BufferedReader"%> 
<%@page import="java.io.FileReader"%> 
<%@page import="java.io.IOException"%> 
<%@page import="java.io.File"%> 
 <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.admin.Admindata" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>About Clicker</title>

<style>
	#linkgrd{
		background: -webkit-linear-gradient(#F8ECE0, #FAAC58);
		background: -o-linear-gradient(#F8ECE0, #FAAC58);
		background: -moz-linear-gradient(#F8ECE0, #FAAC58);
		background: linear-gradient(#F8ECE0, #FAAC58);
		margin-left:10px;
		
		}
</style>
</head>

<% BufferedReader br1 = null;
		String CurrentLine1=null;
		int tablecount1=0;
		String path1 = getServletContext().getRealPath("/");
		System.out.println("Path: " +path1);
		try {
			br1 = new BufferedReader(new FileReader(path1+"demot.txt"));
			
				CurrentLine1 = br1.readLine();
				System.out.println("Currentline : " +CurrentLine1);
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br1 != null)br1.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		} 
		Admindata ad1=new Admindata();
		tablecount1=ad1.getTables();
		
		
%>

<body style="width:700;height:400;">

<table style="width:670px;height:300;margin-left:10px;" border="0">
	<tr>
		<td style="width:250px;"><image src="New_Clicker02.png" style="margin-left:20px;"></td>
		
		<td>
		<div style="margin-bottom:30px;">
		<font style="font-size:35px; font-weight:bold; color: #42362C;letter-spacing: 2px;">CLICKER</font> 
		<br>
		<font style="color:#EC7A0E;font-weight:900;"><%= CurrentLine1%></font>
		
		<p style="color:#42362C;text-align:justify;">Clicker software is developed for educational institutes using, open-source technologies within <a href="http://www.iitb.ac.in" target="_blank">I.I.T Bombay</a>. The main idea of this software is to initiate an interaction between a faculty and a student using cutting edge technologies.
		<br><br>Total Number of Tables in aakashclicker is : <%=tablecount1%>
		</p>
		
		</div>
		</td>
	</tr>
</table>
		
		<br>
		
<table id="linkgrd" style="width:670px;height:50; ">
	<tr>
		<td style="width:250px;text-align:center;"><a href="#" >License</a></td>
		<td style="width:250px;text-align:center;"><a href="#">End User Rights</a></td>
		<td style="width:250px;text-align:center;"><a href="#">Check Updates</a></td>
	</tr>
</table>
		


</body>

</html>