<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for displaying timer and poll question at remote centre.
-->
<%@ page import="clicker.v4.global.Global" %>
<%@ page import="clicker.v4.poll.*"  %>
<%@page import="clicker.v4.rest.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../../js/remotequiz.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/poll.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
</head>

<%
String Coordinator = (String) session.getAttribute("CoordinatorID");
String WorkshopID=(String) session.getAttribute("WorkshopID");

RemoteDBHelper rdh= new RemoteDBHelper();
int participantcount=rdh.getNoofParticipant(WorkshopID);

String MainCenterURL=(String)session.getAttribute("MainCenterURL");
System.out.println("main center url is ----"+MainCenterURL);

JSONReadandparse js=new JSONReadandparse();
String url="http://"+MainCenterURL+"/clicker/rest/quiz/poll/"+WorkshopID;
JSONReadandparse reader = new JSONReadandparse();

//storing all info in Poll java 
Poll json = reader.readPollJsonFromUrl(url,WorkshopID);

int pollid=json.getpollid();
String pollquestion =json.getpollquestion();
String launchtime =json.getlaunchtime();
String currenttime1 =json.getcurrenttime();
String polltime=json.getquizTime();
int pollidnew=0;
long time=0;
String  ltime=null;
if(pollid==0 && pollquestion.equals("") && launchtime.equals("") && polltime.equals("")){
	System.out.println("poll not launched at main centre");
	response.sendRedirect("../home/remotehome.jsp");
}

//Calendar cal = Calendar.getInstance();
//String currenttime1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
else
{
		long pollt=Long.parseLong(polltime);
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		  Date d1 = null;
		  Date d2 = null;
		  
		
			try {
				d1 = format.parse(currenttime1);
				d2 = format.parse(launchtime);
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			long time_difference = d1.getTime() - d2.getTime();
			System.out.println("Time Difference-------------------"+time_difference);
			long diff_sec =time_difference/1000;
			
			//if diff is less than 8 sec
			if(diff_sec < 8)
			{
				time= pollt;
				String currenttime  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
				json.setlaunchtime(currenttime);
				json.setcurrenttime(currenttime);
			}
			
			else{
			
				time = pollt-(diff_sec);
				System.out.println("remaining time is -------------------"+time +" seconds");
				String newpolltime=Long.toString(time);
				json.setquizTime(newpolltime);
				System.out.println("new poll time is : "+newpolltime);
				String currenttime  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
				json.setlaunchtime(currenttime);
				json.setcurrenttime(currenttime);
			}
			
		 RemoteDBHelper dbh=new RemoteDBHelper();
			      
			     //insert pollquestion
			      try {
			    	ltime =json.getlaunchtime();
					dbh.insertRemotePollDetails(json,WorkshopID,ltime);
					pollidnew=dbh.getpollidnew(ltime, WorkshopID);
					json.setpollid(pollidnew);
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("Problem in saving entry in database");
				}
		
		Global.workshoppolljsonobject.put(WorkshopID, json);
		
		Global.workshopresponsepollobject.put(WorkshopID,"@@");
		int count = 0;
		Global.remotecountresponsepoll.put(WorkshopID, count);

}
%>
<script type="text/javascript">
var secs;
function countdown() {
	secs = document.getElementById("timehidden").value;
	down=setInterval(function(){Decrement();},1000);
}
var rep = 0;
function Decrement()
{
	if (document.getElementById) {
		seconds = document.getElementById("seconds");		
		seconds.value = getseconds();
	}
	secs=secs-1;
	if(secs<0)
	{
		document.getElementById("timer").style.visibility='hidden';
		clearInterval(down);
		down1=setInterval(function(){showC();},3000);
	}
}
var old_count=0;
var cnt=0;
//totalstudent is count of students who attended the poll 
var totalstudentattended=0;	
//rflag to decide which response Dialog box to show yes , no ,or no response 
var rflag = null;
// number of students registered in course 
var totalstudents=0;
var notattendedcount=0;
var yesrespopnse, noresponse,blankresponse=0;
var launchtime=null;

function showC(){
	
	cnt++;
		//alert("time "+cnt+" old count is : "+old_count);
		var xmlhttp;
		
		if (window.XMLHttpRequest)
  			{// code for IE7+, Firefox, Chrome, Opera, Safari
 	 		xmlhttp=new XMLHttpRequest();
  			}
		else
  			{// code for IE6, IE5
 		 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  			}
	
		xmlhttp.onreadystatechange=function()
	  	{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    		{	
					var res_count = xmlhttp.responseText;
					//alert("old :"+old_count);
					//alert("res_count :"+res_count);
					// step 1 :taking response from student first time 	
					var xmlHttp2;
					xmlHttp2=new XMLHttpRequest();
					xmlHttp2.onreadystatechange=function()
						{
							if (xmlHttp2.readyState==4 && xmlHttp2.status==200)
				    		{	
								 var res=xmlHttp2.responseText;
								  var splittedres = res.split("@");
								  totalstudents=splittedres[0];
								  totalstudentattended=splittedres[1];
								  //totalstudentattended='3'; 
								  notattendedcount=totalstudents-totalstudentattended;
								  yesrespopnse= Math.round((splittedres[2]/totalstudentattended)*100);
								  noresponse=  Math.round((splittedres[3]/totalstudentattended)*100);
								  blankresponse=  Math.round((splittedres[4]/totalstudentattended)*100);
								//drawing chart 
									$('#response').highcharts({
											        chart: {
											            plotBackgroundColor: null,
											            plotBorderWidth: 0,
											            plotShadow: false,
											            type: 'pie',
											        },
											        
											        title: {
											            text: 'POLL<br>RESPONSE',
											            align: 'center',
											            verticalAlign: 'middle',
											            y: -20
											        },
											        plotOptions: {
											                pie: {
											                    shadow: true,
											                    
											                },
													        series: {
												                cursor: 'pointer',
												                point: {
												                    events: {
												                        click: function() {
												                            
												                            var areaname = this.name;
												                            if(areaname=='YES')
												                            {
												                                rflag="1";
												                            	showPollResponsesDialog(rflag,"response");
												                            }
												                            else if(areaname=='NO')
												                            {
												                            	rflag="0";
												                            	showPollResponsesDialog(rflag,"response");
												                            }
												                            else if(areaname=='NO RESPONSE')
												                            {
												                            	rflag="2";
												                            	showPollResponsesDialog(rflag,"response");
												                            }
												                        }
												                    }
												                }
												            }
											            },
											         tooltip: {
											                formatter: function() {
											                    return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
											                }
											            },
											          series: [{
											                name: 'Response',
											                data: [
											                       {
													                    name: 'YES',
													                   y: parseInt(yesrespopnse), 
													                   //y:33,
													                   //color:' #31B404'A5DF00,
													                   color:' #A5DF00',
													                    selected: true,	                    
													                    
													                },
												                
												                    
												                    {
													                    name: 'NO',
													                    y:  parseInt(noresponse), 
													                  // y:33, 
													                    //color:'#DF0101',
													                    color:'#ff3232',
													                },
													                
													                {
													                    name: 'NO RESPONSE',
													                    y:  parseInt(blankresponse), 
													                  	//y:33, 
													                   // color:'#FFBF00', 
													                    color:'#848484',
													                },
												               
												                
												           		 ],
												                size: '100%',
												                innerSize: '40%',
												                showInLegend:true,
												                dataLabels: 
												                {
												                	
												                    enabled: true,
												                      style: {
												                        fontWeight: 'bold',
												                        color: 'white',
												                        fontSize:'20px',
												                        textShadow: '0px 1px 2px black',
												                        
												                    },
												                      distance: -55,
												                      formatter: function() {
												                    	  var aname = this.point.name;													                         
																          if(this.y!='0'){
																        	  if(aname=='YES')
												                    		  	return splittedres[2]+'<br>('+this.y+'%)';
												                    		  else if(aname=='NO')
												                    			  return splittedres[3]+'<br>('+this.y+'%)';
												                    		  else
												                    			  return splittedres[4]+'<br>('+this.y+'%)';
												                    			  
												                    	  }
												                    		  
												                    		
												                },
												               },
												            
													            
											            }]
											        });
									    		
							}
							
						}
						xmlHttp2.open("GET","remotepollresponse.jsp?pollquestion="+encodeURIComponent(document.getElementById("pollquestionhidden").value),false);
						xmlHttp2.send();
						
						
						//step 2: checking whether response count is equal to old count to display chart and refresh 
						
						if(old_count!=res_count)
						{
							old_count=res_count;
						}
					
						else{// if old count== res count or res count == 0 
							if(totalstudentattended=='0')
					   		  {
					   		  	document.getElementById('response').innerHTML = "<div style=\"color:red;text-align:center; margin-top:80px; font-size:20px;\">NO RESPONSES...</div>";	   		  
					   		  }
						rep++;
						//alert("idle : "+rep);
							if(rep==4){
								clearInterval(down1);
								$('#container').highcharts({
							        chart: {
							            plotBackgroundColor: null,
							            plotBorderWidth: null,
							            plotShadow: false,
							            borderColor: '#EBBA95',
							            borderWidth: 2,
							            
							        },	
							        title: {
							            text: null,
							        },
							        tooltip: {
						                formatter: function() {
						                    return '<b>'+ this.point.name +'</b>: '+ this.y ;
						                }
						            },
							        plotOptions: {
							            pie: {
							               
							                startAngle: -90,
							                endAngle: 90,
							                center: ['50%', '75%']
							            },
							            series: {
							                cursor: 'pointer',
							                point: {
							                    events: {
							                        click: function() {
							                            
							                            var areaname = this.name;
							                            if(areaname=='Attended')
							                            {
							                                rflag="Attended";
							                            	showPollResponsesDialog(rflag,"stats");
							                            }
							                            else if(areaname=='Not Attended')
							                            {
							                            	rflag="Not Attended";
							                            	showPollResponsesDialog(rflag,"stats");
							                            }
							                            
							                        }
							                    }
							                }
							            }
							        },
							        series: [{
							            type: 'pie',
							            size: '130%',
							            innerSize: '40%',
							            data: [
							                {
							                    name: 'Attended',		                  
							                   	y:parseInt(totalstudentattended),
							                   // color:'#FFBF00', 
							                   	color:'#0066CC'
							                },
							                {
							                    name: 'Not Attended',		                  
							                   	y:parseInt(notattendedcount),
							                    //color:'#B18904', 
							                   	color:'#66A3E0',
							                },
							               
							                
							            ],
								        dataLabels: 
						                {
						                	
						                    enabled: true,
						                      style: {
						                        fontWeight: 'bold',
						                        color: 'white',
						                        fontSize:'20px',
						                        textShadow: '0px 1px 2px black',
						                        
						                    },
						                      distance: -25,
						                       formatter: function() {
						                    return this.y ;
						                },
						                },
							        showInLegend:true,
							        }]
							    });
							  document.getElementById("reset").style.visibility = "visible";
								//$('#response').load("remotepollresponse.jsp?pollquestion="+encodeURIComponent(document.getElementById("pollquestionhidden").value),true);
								var xmlHttp=null;
								xmlHttp=new XMLHttpRequest();
								xmlHttp.open("GET","responsejson.jsp?pollquestion="+encodeURIComponent(document.getElementById("pollquestionhidden").value),false);
								xmlHttp.send(null);
								readMainCenter();
							}
					}
				}
	  	}
		
 	xmlhttp.open("GET","../../remotepollresponsecount",false);
	xmlhttp.send();
		
}

	
function getseconds() {
	return secs;
	}
	
function reset1(){

	window.location.href="../home/remotehome.jsp";
}
function getXMLhttp() {
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
}
function showPollResponsesDialog(rflag,charttype) {	
	launchtime=document.getElementById("launchtimehidden").value;
	 var replacedltime = launchtime.replace("/", "-");
	
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("ResponseDialog").innerHTML = xmlhttp.responseText;
			document.getElementById("ResponseDialog").style.visibility = 'visible';
			document.getElementById("ResponseDialog").title ="Responses";
			document.getElementById("ResponseDialog").position ="top";
			$("#ResponseDialog").dialog({height: 450, width: 350, position: ['center', 'top'], modal: true});
		}
	};	
	xmlhttp.open("GET", "remotepollresponsetable.jsp?rflag="+rflag+"&chart="+charttype+"&launchtime="+escape(replacedltime), true);
	xmlhttp.send();
}
</script>


<body onload="countdown();" class="ui-Mainbody" style="width:100%; height:100%; text-align: center; ">
<%@ include file="../../jsp/includes/remotemenuheader.jsp"%>

<form class="form-4" >

	<table class="table1">
		<tr >
		<td >
		<div class="ui-header-text" >
		<h2><lable>Poll</lable></h2></div>
		</td>
		</tr>
		
		<tr >
		<td  >
		<div id="poll_QuestionDiv" style="overflow:auto; height:90px;width:600px;margin-left:220px;text-align:center;">
								<%=pollquestion %><br>
		</div>
		</td>
		</tr>
	</table>
	
	
	
	
	
	<table class="table1" style="margin-top:2px; background-color:#ffffff;" overflow="true"   border="1">
		<tr >
			<td >
				<div id="chart_div" style="width: 1030px; height: 470px;background-color:#ffffff;">
					<div id="response" style="width: 500px; height: 460px; margin:auto; margin-left:250px; background-color:#ffffff;  float:left">
					<script src="../../js/highcharts.js"></script>
						<div id="timer" name="timer" style="text-align:center;">
							<b style="font-size:20px; color:#e46c0a;">Countdown</b> 
							</br><input type="text" id="seconds" style="width:50px; height:65px; font-size:36px">
							</br><b style="font-size:17px; color:#e46c0a;">seconds</b> 
						</div>
					</div>
					
					<div id="ResponseDialog" style="display: none;" ></div>
		
					<div id="container" style="margin-top:100px; width: 250px; height: 250px; margin: auto; float:right;"></div>
			
					<button class="ui-createquiz-button" style="float:right; margin-top:100px;margin-right:80px; width:80px; visibility:hidden ;" id="reset" type="button" onclick="reset1();">
						<span><font size="4px" >Reset</font></span>
					</button>
				</div>
			</td>
		</tr>
	</table>

	<input type="hidden" value="<%=pollquestion%>" id="pollquestionhidden"/>
	<input type="hidden" value="<%=time%>" id="timehidden"/>
	<input type="hidden" value="<%=ltime%>" id="launchtimehidden"/>
	<input type="hidden" value="<%=participantcount%>" id="totalcounthidden"/>
	<input type="hidden" id="dialog"/>
</form>

<div style="margin-top:-600px;">
<center><%@ include file= "../../jsp/includes/menufooter.jsp" %></center>
</div>
</body>
</html>