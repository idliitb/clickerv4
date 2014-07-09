<!--Author: Dipti from Clicker Team, IDL LAB ,IIT Bombay -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>set maincenter</title>
</head>
<body >

<form id="Maincenterform" action="./Login" method="GET" onsubmit="return validateMainCenterID()">
						<br>Select MainCenter
						<br>
						<br> <select id="maincentername" name="maincentername">					
							<%
 				 			String[] maincentername = (String[])session.getAttribute("maincenterList");
	 	 		 	  	  	if(maincentername.length==0){%>
		 	 				<option>MainCenter not added</option>
							<%}
							else {%>
							<%for (int i=0; i<maincentername.length; i++){%>
							<option><%=maincentername[i]%></option>
							<%}}%>
						</select> <br>
						<br> <input  type="submit" value=" Set MainCenter " />
</form>
</body>
</html>