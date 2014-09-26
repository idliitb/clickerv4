<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for displaying timer and results of poll.
-->
<%--
@Credit - Highcharts
	http://api.highcharts.com/highcharts
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="clicker.v4.global.Global" %>
    <%@ page import="clicker.v4.poll.*" %>
    <%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.util.Calendar" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body onload="countdown();">
<% 
String courseId=(String)session.getAttribute("courseID");
String pollquestion= request.getParameter("pollquestion");
Global.responsepollobject.put(courseId,"@@");
PollHelper phelp = new PollHelper();
int count=phelp.studentcount(courseId);
Calendar cal = Calendar.getInstance();
String launchtime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cal.getTime());
System.out.println("your poll launchtime is:"+launchtime);
String currenttime=launchtime;
String quizTime="60";

//launchtime = launchtime.replace('/','-');
String launchtime1=launchtime.replace('/','-');
//saving poll question in database
phelp.savepollquestion(pollquestion,courseId,launchtime1);

int pollid=phelp.getpollidnew(launchtime1, courseId);
session.setAttribute("pollid", pollid);
System.out.println("pollquestion saved in local databse--------->>>"+session.getAttribute("pollid").toString());




Callpolljson ob=new Callpolljson();
//int pollid1=1;
ob.callpolljson(pollid,courseId,pollquestion,launchtime,currenttime,quizTime);


%>
<script type="text/javascript">
var secs=60;
var rep = 0;
function countdown() {
	down=setInterval(function(){Decrement();},1000);
}

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
		down1=setInterval(function(){showC();},5000);
	}
}

// totalstudent is count of students who attended the poll 
var totalstudentattended=0;	
//rflag to decide which response Dialog box to show yes , no ,or no response 
var rflag = null;
// number of students registered in course 
var totalstudents=document.getElementById('totalcounthidden').value;
var notattendedcount=0;
function showC(){
	rep++;
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
		  var res=xmlhttp.responseText;
		  var splittedres = res.split("@");
		  totalstudentattended=splittedres[0];
		  //totalstudentattended='3';
		  
		  notattendedcount=totalstudents-totalstudentattended;
		  var yesrespopnse= Math.round((splittedres[1]/totalstudentattended)*100);
		  var noresponse=  Math.round((splittedres[2]/totalstudentattended)*100);
		  var blankresponse=  Math.round((splittedres[3]/totalstudentattended)*100);
		  // checking responbses whether 0 or more and displaying chart accordingly  
	   	  if(totalstudentattended=='0')
	   		  {
	   			document.getElementById('response').innerHTML = "<div style=\"color:red;text-align:center; margin-top:80px; font-size:20px;\">NO RESPONSES...</div>";	   		  
	   		  }
	   	  else{
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
				                    		  	return splittedres[1]+'<br>('+this.y+'%)';
				                    		  else if(aname=='NO')
				                    			  return splittedres[2]+'<br>('+this.y+'%)';
				                    		  else
				                    			  return splittedres[3]+'<br>('+this.y+'%)';
				                    			  
				                    	  }
				                    		  
				                    		
				                },
				                },
				            
					            
			            }]
			        });
	    		}
		}
	}
	xmlhttp.open("GET","pollresponseshow.jsp?pollquestion="+encodeURIComponent(document.getElementById("pollquestionhidden").value)+"&rep="+rep,true);
	xmlhttp.send();
	if(rep==3)
	{
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
	}
	
}	

function getseconds() {
	return secs;
	}
	
function reset1(){

	window.location.href="poll.jsp";
}

function showPollResponsesDialog(rflag,charttype) {	
	launchtime=document.getElementById("launchtimehidden").value;
	 //var replacedltime = launchtime.replace('/','-');
	
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("ResponseDialog").innerHTML = xmlhttp.responseText;
			document.getElementById("ResponseDialog").style.visibility = 'visible';
			document.getElementById("ResponseDialog").title ="Responses";
			document.getElementById("ResponseDialog").position ="top";
			$("#ResponseDialog").dialog({height: 400, width: 320, position: ['center', 'top'], modal: true});
		}
	};	
	xmlhttp.open("GET", "pollresponsetable.jsp?rflag="+rflag+"&chart="+charttype+"&launchtime="+launchtime, true);
	xmlhttp.send();
}
</script>


<div id="ResponseDialog" style="display: none;" ></div>

<div id="response" style="margin-top:50px;width: 500px; height: 460px; margin:auto; margin-left:250px; background-color:#ffffff;  float:left">
<script src="../../js/highcharts.js"></script>
	<div id="timer" name="timer" style="text-align:center;">
		<b style="font-size:20px; color:#e46c0a;">Countdown</b> 
		</br><input type="text" id="seconds" style="width:50px; height:65px; font-size:36px">
		</br><b style="font-size:17px; color:#e46c0a;">seconds</b> 
	</div>
	<script>countdown();</script>
</div>

<div id="container" style="margin-top:100px; width: 250px; height: 250px; margin: auto; float:right;"></div>

<button class="ui-createquiz-button" style="float:right; margin-top:100px;margin-right:80px; width:80px; visibility:hidden ;" id="reset" type="button" onclick="reset1();">
	<span><font size="4px" >Reset</font></span>
</button>
<input type="hidden" value="<%=count%>" id="totalcounthidden"/>
<input type="hidden" value="<%=launchtime%>" id="launchtimehidden"/>
<input type="hidden" value="<%=pollquestion%>" id="pollquestionhidden"/>
</body>
</html>