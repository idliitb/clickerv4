/*
 * Author : rajavel, Clicker Team, IDL Lab - IIT Bombay  
 * This Java Script file is used for report information
 */

var xmlhttp;

// This method will get the XMLHTTP object for work with ajax
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

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function quizData(insid){	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText.split("~$~")[1];
			var chartdata = xmlhttp.responseText.split("~$~")[0];
			/*$("#qpChart1").load("../../QuizLineChart?chartdata="+chartdata,function(){
				document.getElementById("qpChart").innerHTML = "<img src='../../"+insid+"/qpchart.png'/>";
			});*/
			var iqchartdata = chartdata.split("~@~")[1].split("~!~").map(Number);
			var nqchartdata = chartdata.split("~@~")[0].split("~!~").map(Number);
			var maxquiz=nqchartdata.length;
			if(maxquiz<iqchartdata.length){
				maxquiz=iqchartdata.length;
			}	
			var xtickinterval=1;
			if(maxquiz>15){
				xtickinterval =Math.round(maxquiz/10);
			}
			var quizzes = "";
			quizdetails = response.split("@#@")[0].split("$#$");
			if(quizdetails[0]<=9){
				document.getElementById("nq").innerHTML = "0"+quizdetails[0];
			}else{
				document.getElementById("nq").innerHTML = quizdetails[0];
			}
			var nqseriesdata=[];
			var ti=0;
			var prod = {};
			prod['qid'] = "";     
		    prod['qts'] = "";
		    prod['qtype'] = "normalquiz";					  
	        prod['y'] = Number(nqchartdata[ti++]);
	        nqseriesdata.push(prod);
			for(var i=1;i<quizdetails.length;i++){
				var timestamps = quizdetails[i].split("~!~");
				quizzes += "<div class='mybox'><div class='myboxhead' onclick='quizReport(\""+timestamps[1]+"\",\"\""+",\""+"QuizDetail"+"\")'>"+timestamps[0] + "</div>" ;
				for(var j=2;j<timestamps.length;j++){
					quizzes += "<div class='myboxnote' onclick='quizReport(\""+timestamps[1]+"\",\""+timestamps[j]+"\",\""+"QuizResponse"+"\")'>"+timestamps[j]+"</div>";
					var prod = {};
				    prod['qid'] = timestamps[1];     
				    prod['qts'] = timestamps[j];
				    prod['qtype'] = "normalquiz";					   
				    prod['y'] = Number(nqchartdata[ti++]);
					nqseriesdata.push(prod);
				}
				quizzes += "</div>";
			}
			document.getElementById("nqcontent_div").innerHTML = quizzes;
			quizdetails = response.split("@#@")[1].split("$#$");
			if(quizdetails[0]<=9){
				document.getElementById("iq").innerHTML = "0"+quizdetails[0];
			}else{
				document.getElementById("iq").innerHTML = quizdetails[0];
			}
			quizzes="";
			var iqseriesdata=[];
			ti=0;
			var prod = {};
			prod['qid'] = "";     
		    prod['qts'] = "";  
	        prod['qtype'] = "instantquiz";
	        prod['y'] = Number(iqchartdata[ti++]);
	        iqseriesdata.push(prod);
			for(var i=1;i<quizdetails.length;i++){
				var timestamps = quizdetails[i].split("~!~");
				quizzes += "<div class='mybox'><div class='myboxhead1'>"+timestamps[0] +"<br><br>"+timestamps[1] + "</div>" ;
				for(var j=2;j<timestamps.length;j++){
					quizzes += "<div class='myboxnote' onclick='instantQuizReport(\""+timestamps[1]+"\",\""+timestamps[j]+"\")'>"+timestamps[j]+"</div>";
					var prod = {};
					prod['qid'] = timestamps[1];     
				    prod['qts'] = timestamps[j];
				    prod['qtype'] = "instantquiz";
				    prod['y'] = Number(iqchartdata[ti++]);
					iqseriesdata.push(prod);
				}
				quizzes += "</div>";
			}
			document.getElementById("iqcontent_div").innerHTML = quizzes; 
			quizdetails = response.split("@#@")[2].split("$#$");
			var quizcount = quizdetails[0].split("@@");
			if(quizcount[0]<=9){
				document.getElementById("ts").innerHTML = "0"+quizcount[0];
			}else{
				document.getElementById("ts").innerHTML = quizcount[0];
			}
			quizzes="";
			for(var i=1;i<quizdetails.length;i++){
				var timestamps = quizdetails[i].split("~!~");
				var w=(timestamps[4]/quizcount[1]*100) / 100 * 130;				
				quizzes += "<div class='mybox'><div class='myboxhead1'>"+timestamps[0] + " - " + timestamps[1] +"</div>" ;
				quizzes += "<div class='myboxnote' onclick='participantNormalQuizReport(\""+timestamps[0]+"\",\""+insid+"\")'>"+timestamps[2]+"</div>";
				quizzes += "<div class='myboxnote' onclick='participantInstantQuizReport(\""+timestamps[0]+"\",\""+insid+"\")'>"+timestamps[3]+"</div>";
				quizzes += "<div class='studprogbar' title='Attempted Quiz : "+timestamps[4] + " / " + quizcount[1]+"'><div class='insidebar' style='width:"+w+"px;'></div></div><div class='attemptedquiz'>"+timestamps[4] + " / " + quizcount[1]+"</div>";
				quizzes += "</div>";
			}
			document.getElementById("tscontent_div").innerHTML = "<div class='dashboard_icon' onclick='attendanceList()'><img src='../../img/attendance.png' title='Attendance'></div>";
			document.getElementById("tscontent_div").innerHTML += "<div class='dashboard_icon' onclick='participantList()'><img src='../../img/report.png' title='Participant List'></div>" + quizzes; 
			
			quizdetails = response.split("@#@")[3].split("$#$");
			if(quizdetails[0]<=9){
				document.getElementById("p").innerHTML = "0"+quizdetails[0];
			}else{
				document.getElementById("p").innerHTML = quizdetails[0];
			}
			quizzes="";
			for(var i=1;i<quizdetails.length;i++){
				var resp = quizdetails[i].split("~!~");
				quizzes += "<div class='pollbox' onclick='pollReport(\""+resp[1]+"\")'><div class='pollboxhead'>"+resp[0] + "</div>" ;
				for(var j=2;j<resp.length;j++){
					quizzes += "<div class='pollboxnote'>"+resp[j]+"</div>";
				}
				quizzes += "</div>";
			}
			document.getElementById("pcontent_div").innerHTML = quizzes; 
			$('#qpChart').highcharts({
	            title: {
	                text: 'Overall Quiz Preformance',
	                x: -20 //center
	            },
	            xAxis: {
	                categories: [],
	                tickInterval:xtickinterval,
	                min:1
	            },
	            yAxis: {
	                title: {
	                    text: 'Performance %'
	                },
	                plotLines: [{
	                    value: 0,
	                    width: 1,
	                    color: '#808080'
	                }],
	                min:0,
	                max:100,
	                tickInterval:25
	            },
	            tooltip: {
	                valueSuffix: '%'
	            },
	            legend: {
	                layout: 'horizontal',
	                align: 'center',
	                verticalAlign: 'bottom',
	                borderWidth: 0
	            },
	            
	            plotOptions: {
	                series: {
	                    allowPointSelect: true,
	                    events: {
	                        click: function (event) {
	                            if(event.point.qtype=="normalquiz"){
	                            	quizReport(event.point.qid,event.point.qts,"QuizResponse");
	                            }else{
	                            	instantQuizReport(event.point.qid,event.point.qts);
	                            }
	                        }
	                    }
	                }
	            },
	            series: [{
	                name: 'Normal Quiz',
	                data: nqseriesdata	                
	            }, {
	                name: 'Instant Quiz',
	                data: iqseriesdata
	            }]
			});
		}
	};
	document.getElementById("iq").style.background="gray";
	document.getElementById("ts").style.background="gray";
	document.getElementById("p").style.background="gray";
	document.getElementById("iq_head").style.background="gray";
	document.getElementById("ts_head").style.background="gray";
	document.getElementById("p_head").style.background="gray";
	document.getElementById("nq").style.background="#9bbb59";
	document.getElementById("nq_head").style.background="#9bbb59";
	document.getElementById("iq_arrow").style.visibility="hidden";
	document.getElementById("ts_arrow").style.visibility="hidden";
	document.getElementById("p_arrow").style.visibility="hidden";
	document.getElementById("nq_arrow").style.visibility="visible";
	xmlhttp.open("GET", "../../jsp/dashboard/rcreportdashboardhelper.jsp?helpcontent=quizdata", true);
	xmlhttp.send();	
}

function changeActive(req){
	document.getElementById("nq").style.background="gray";
	document.getElementById("iq").style.background="gray";
	document.getElementById("ts").style.background="gray";
	document.getElementById("p").style.background="gray";
	document.getElementById("nq_head").style.background="gray";
	document.getElementById("iq_head").style.background="gray";
	document.getElementById("ts_head").style.background="gray";
	document.getElementById("p_head").style.background="gray";
	document.getElementById(req).style.background="#9bbb59";
	document.getElementById(req + "_head").style.background="#9bbb59";
	document.getElementById("nq_arrow").style.visibility="hidden";
	document.getElementById("iq_arrow").style.visibility="hidden";
	document.getElementById("ts_arrow").style.visibility="hidden";
	document.getElementById("p_arrow").style.visibility="hidden";
	document.getElementById(req+"_arrow").style.visibility="visible";	
	document.getElementById("nqcontent_div").style.display="none";
	document.getElementById("iqcontent_div").style.display="none";
	document.getElementById("tscontent_div").style.display="none";
	document.getElementById("pcontent_div").style.display="none";
	document.getElementById(req+"content_div").style.display="block";
	if(req=="nq"){
		document.getElementById("qtype").style.visibility="visible";
	}else{
		document.getElementById("qtype").style.visibility="hidden";
	}
}


function quizReport(quizid, qts, reportname) {
	if(reportname=="QuizDetail"){
		generateQuizReport(quizid, qts, reportname);
	}else{
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				generateQuizReport(quizid, qts, reportname);
			}
		};
		var reporttype = document.getElementsByName('reporttype');
		for(var i = 0; i < reporttype.length; i++){
		    if(reporttype[i].checked){
		    	reportname = reporttype[i].value;
		    }
		}
		xmlhttp.open("GET", "../../ChartRemote?report=quizreport&qid="+ quizid + "&qts="+qts + "&charttype="+reportname+"Chart", false);
		xmlhttp.send();
	}
}

function generateQuizReport(quizid, qts, reportname){
	getXMLhttp();
	if(reportname!="QuizDetail"){
		var reporttype = document.getElementsByName('reporttype');
		for(var i = 0; i < reporttype.length; i++){
		    if(reporttype[i].checked){
		    	reportname = reporttype[i].value;
		    }
		}
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("dlg_body").innerHTML = response;
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title : "Normal Quiz Report",
				height : 500,
				width : 750,
				draggable : false,
				modal : true
			});
		}
	};
	xmlhttp.open("GET", "../../RemoteReport?report=quizreport&qid="+ quizid + "&qts="+qts + "&reportname="+reportname, true);
	xmlhttp.send();
}

function instantQuizReport(qid, qts) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generateInstantQuizReport(qid, qts);			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=InstantQuizResponseChart&qid="+ qid, false);
	xmlhttp.send();	
}

function generateInstantQuizReport(qid, qts){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("dlg_body").innerHTML = response;
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title : "Instant Quiz Report",
				height : 500,
				width : 750,
				draggable : false,
				modal : true
			});
		}
	};
	xmlhttp.open("GET", "../../RemoteReport?report=instantquizreportnew&qid="+ qid + "&qts="+qts, true);
	xmlhttp.send();
}


function pollReport(pid) {	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generatePollReport(pid);			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=PollResponseChart&pid="+ pid, false);
	xmlhttp.send();	
}

function generatePollReport(pid){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("dlg_body").innerHTML = response;
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title : "Poll Report",
				height : 500,
				width : 650,
				draggable : false,
				modal : true
			});
		}
	};
	xmlhttp.open("GET", "../../RemoteReport?report=pollreport&pid="+ pid, true);
	xmlhttp.send();
}

function participantNormalQuizReport(pid, iid){
	$("#tempdiv").load("../../participantPerformanceChart?pid="+pid+ "&qtype=nquiz", function(){
		$("#dlg_body").load("../../RemoteReport?pid="+pid + "&report=partcipantreport", function(){
			document.getElementById("dlg_body").innerHTML = "<img src='../../"+iid+"/participantResult.png?"+new Date()+"' />" + document.getElementById("quizreport").innerHTML;
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title : "Normal Quiz Report",
				height : 500,
				width : 850,
				draggable : false,
				modal : true
			});
		});	
	});	
}

function participantInstantQuizReport(pid, iid){
	$("#tempdiv").load("../../participantPerformanceChart?pid="+pid + "&qtype=iquiz", function(){
		document.getElementById("dlg_body").innerHTML = "<img src='../../"+iid+"/participantResult.png?"+new Date()+"' />";
		document.getElementById("quizreport").style.visibility = 'visible';
		$("#quizreport").dialog({
			title : "Instant Quiz Report",
			height : 500,
			width : 850,
			draggable : false,
			modal : true
		});			
	});	
}


function participantList(){
	$("#dlg_body").load("../../RemoteReport?report=corusereport&ats=&reportname=ParticipantList&date=", function(){
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title: "Participant List",
				height : 500,
				width : 850,
				draggable : false,
				modal : true
			});
	});		
}

function attendanceList(){
	document.getElementById("dlg_header_att").style.display ="block";
	document.getElementById("dlg_body1").innerHTML="";
	document.getElementById("quizreport1").style.visibility = 'visible';
	$("#quizreport1").dialog({
		title: "Attendance Report",
		height : 500,
		width : 850,
		draggable : false,
		modal : true
	});
}

function fillAttenDetail(courseID, atdates, date) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resps = xmlhttp.responseText;
			document.getElementById("att_ts").innerHTML = resps;
			var attendancetimestamp=document.getElementById("attendancetimestamp");
			var atttimestamplen = attendancetimestamp.length;
			if(atdates.indexOf(date)==-1){
				alert("No Attendance is available on this day");
				return false;
			}
			if(atttimestamplen<=1){
				document.getElementById("att_ts").style.display="none";
			}
			else if (atttimestamplen==2){
				document.getElementById("att_ts").style.display="none";
				var session =  attendancetimestamp.options[1].text;
				attendanceReport(courseID, date, session);
			}
			else if (atttimestamplen>2){
				document.getElementById("att_ts").style.display="block";
			}
		}
	};
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET",	"../../jsp/dashboard/rcreportdashboardhelper.jsp?helpcontent=atteninfo&cid="+ encodeURIComponent(courseID) + "&date="+date, true);	
	xmlhttp.send();	
}

function attendanceReport(cid, date, session){
	if(session==''){
		alert("select Proper session");
		return;
	}
	$("#tempdiv").load("../../ChartRemote?charttype=RemoteAttendance&cid=" + encodeURIComponent(cid) + "&date=" + date + "&session="+session, function(){
		$("#dlg_body1").load("../../RemoteReport?report=corusereport&session="+ session + "&reportname=Attendance&date=" +date, function(){
			document.getElementById("quizreport1").style.visibility = 'visible';
			document.getElementById("quizreport1").title ="Attendance";
			$("#quizreport1").dialog({
				height : 500,
				width : 850,
				draggable : false,
				modal : true
			});
		});	
	});	
}