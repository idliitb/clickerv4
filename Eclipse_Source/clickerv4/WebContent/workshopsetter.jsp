<!-- Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>set workshop</title>
<link type="text/css" rel="stylesheet" href="css/createquiz.css">
<link type="text/css" rel="stylesheet" href="css/menuheader.css">
<link type="text/css" rel="stylesheet" href="css/menu.css">
<link type="text/css" rel="stylesheet" href="css/style.css">
<link href="inettuts.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	  $("#dialog").dialog({
		 open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
		 draggable: false, 
		 position: "center", 
		 modal:true,
	     closeOnEscape: false,
	     dialogClass: 'myPosition',
	     beforeclose: function(){ return false;}
	  });
      $("#dialog").css("visibility","visible"); 	
      $("#dialog").dialog(function(){
    	  $("#dialog").css("visibility","hidden"); 	
      }); 	
  });

function validateWorkshopID(){
	
	try{
		
		if(document.forms["workshopIDform"].elements["WorkshopID"].value=="Select Workshop"){
			alert("Select a valid Workshop");
			
			return false;
		}
		else{
			
			return true;
		}
	}
	catch(err){
		alert(err.message);
	}
}


</script>


</head>
<%
	if (session.getAttribute("CoordinatorID") == null) {
		request.setAttribute("Error", "Your session has expired.");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}

String maincentername=(String) session.getAttribute("maincentername");
String Coordinator=(String) session.getAttribute("CoordinatorID");

%>

<body onload="javascript:window.history.forward();">
	<%@ include file="../../jsp/includes/remotemenuheader.jsp"%>
	
	<table class="table1">
	<tr>
	<td>
	<div id="workshopsetter" style="height:540px;text-align:center;padding-top:10px" >
	<div id="dialog" style="visibility: hidden; background: white;">
	<form id="workshopIDform"  action="./MainCenterSetter" method="GET" onsubmit="return validateWorkshopID()">
						<br>Select WorkshopID of your Workshop<br> <br><select id="WorkshopID" name="WorkshopID">
							
							<%
							System.out.println("called in selct tag");
		 					String[] workshopList = (String[])session.getAttribute("workshopList");
					 		if(workshopList.length==0){%>
						 	<option>No workshop Available</option>
							<%}
							else {%>
							<%for (int i=0; i<workshopList.length; i++){%>
							<option><%=workshopList[i]%></option>
							<%}}%>
						</select> <br>
						<br> <input  class="ui-conductquiz-button" type="submit" value=" Set Workshop " />
	</form>
	</div>
	</div>
	</td>
	</tr>
	</table>
	
	<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>



</body>
</html>