<%--
      @author Gobinath
DESCREPTION: this page is loaded in the participant page in remote mode
			 
USE        : it display the list of participant for the remote center

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import ="clicker.v4.admin.*" %>

<% 
	int wscount = Integer.parseInt(request.getParameter("wscount"));
	String workshopid = request.getParameter("workshopid");
	System.out.println("Workshop ID: " + workshopid);
	int j = 1, z = 0;
	List<String> storeall = new ArrayList<String>( );
	System.out.println("ws count: " + wscount);
	
	if(wscount > 0)
	{
		storeall = new GetParticipantList( ).participantlist(workshopid);
		System.out.println("store all size: " + storeall.size());
	}%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="updateparticipantlist.js"></script>
</head>
<body>
<%if(wscount > 0)
{ if(storeall.size() > 0){%>
<table class="table1">
<tr >
<td style="margin:10px 0 0 0px">
<div class="ui-createquiz-text" >
<h2><label>Participant Information</label></h2></div>
</td>
</tr>

</table>

<div style="width:820px; height : 420px; overflow:auto; margin-left: 220px;">
<table class="table1" id = "participanttable" style="margin-top:2px; width : 820px;overflow:auto;" border="1">
<tr style  = "font-size : 16px;"> 
<th> Participant ID </th>
<th> Participant Name </th>
 
</tr>
<%for(int i = 0; i < (storeall.size( )); i++)
	{
		if(((storeall.get(i)).equals("start")))
		{ z = i; System.out.println(" Z: " + z);%>
			<tr id = "rc_tr<%=i %>" style = "font-size : 15px"> 
			
		<%}
		else if(!(storeall.get(i)).equals("end") && !((storeall.get(i)).equals("start")))
		{ System.out.println("info: " + storeall.get(i) + " i: " + i);
			System.out.println("J: " + j);%>
			<td id = "rc_td<%=j++ %><%=z%>"> <%= storeall.get(i)%> </td>
								
		<%}
		else
		{%>
			<td id = "edit<%=i%>"> <button type = "button" onclick = "edit('<%=i%>','<%=j%>' )">
									<span>Edit</span></button> </td>
			<td id = "del<%=i %>">	<button type = "button" onclick = "del_entry('<%=i%>', '<%=j%>')">
									<span>Delete</span></button></td>
			</tr>
	  <% j = 1;}
	}%>

</table>
</div>
<%}else{%>
	<p style = "font-size: 30px; color: red;"> No Participants are added for this Workshop</p>
<%}}
else
{%>
	<p style = "font-size: 30px; color: red;"> Participant List cannot be displayed as there are no active workshops</p>
<%} %>


</body>
</html>