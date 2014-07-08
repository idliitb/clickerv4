/*
 * Author : Rajavel, Clicker Lab
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

function createDOMElementIDClassStyle(ele, id, eleclass, style){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eleclass);
	element.setAttribute('style',style);
	return element;
}

function createDOMElementClassStyle(ele, eleclass, style){
	var element = document.createElement(ele);
	element.setAttribute('class',eleclass);
	element.setAttribute('style',style);
	return element;
}

function createDOMElementIDStyle(ele, id, style){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('style',style);
	return element;
}

function createDOMElementIDClass(ele, id, eclass){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eclass);
	return element;
}

function createDOMElementClass(ele, eleclass){
	var element = document.createElement(ele);
	element.setAttribute('class',eleclass);
	return element;
}

function createDOMElementID(ele, id){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	return element;
}

function createDOMElementImg(ele, src){
	var element = document.createElement(ele);
	element.setAttribute('src',src);
	return element;
}

function createDOMElement(ele){
	var element = document.createElement(ele);
	return element;
}

var arrowcontainer="", contentcontainer="";
function loadDOMCoursesData(insid){
	//loadAllDeptChart();
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText.split("~&~");
			for(var i=0;i<resp.length-1;i++){
				var cid=resp[i].split("~^~")[0].trim();
				var courseresponse=resp[i].split("~^~")[1];
				var table=createDOMElementClassStyle('table', 'table1',  'margin-top: 10px;');
				var tr1=createDOMElement('tr');
				var td1=createDOMElement('td');
				var div1=createDOMElementClassStyle('div','ui-header-text', 'text-align:left;');
				var h2=document.createElement("h2");
				var h2node=document.createTextNode("Course ID : "+cid);
				h2.appendChild(h2node);				
				div1.appendChild(h2);
				var div2=createDOMElementClass('div','notebox');
				div2.onclick=changeActive.bind(div2, cid+"nq", cid, insid, courseresponse.split("~$~")[1].split("@#@")[0]);
				var tempdiv1=createDOMElementIDClass('div',cid+"nq_head" ,'boxhead');
				tempdiv1.innerHTML = 'Normal quiz';
				var tempdiv2=createDOMElementIDClass('div',cid+"nq" ,'boxnote');
				tempdiv2.innerHTML = '00';
				div2.appendChild(tempdiv1);
				div2.appendChild(tempdiv2);
				var div3=createDOMElementClass('div','notebox');
				div3.onclick=changeActive.bind(div3, cid+"iq", cid, insid, courseresponse.split("~$~")[1].split("@#@")[1]);
				tempdiv1=createDOMElementIDClass('div',cid+"iq_head" ,'boxhead');
				tempdiv1.innerHTML = 'Instant quiz';
				tempdiv2=createDOMElementIDClass('div',cid+"iq" ,'boxnote');
				tempdiv2.innerHTML = '00';
				div3.appendChild(tempdiv1);
				div3.appendChild(tempdiv2);
				var div4=createDOMElementClass('div','notebox');
				div4.onclick=changeActive.bind(div4, cid+"p", cid, insid, courseresponse.split("~$~")[1].split("@#@")[3]);
				tempdiv1=createDOMElementIDClass('div',cid+"p_head" ,'boxhead');
				tempdiv1.innerHTML = 'Poll';
				tempdiv2=createDOMElementIDClass('div',cid+"p" ,'boxnote');
				tempdiv2.innerHTML = '00';				
				div4.appendChild(tempdiv1);
				div4.appendChild(tempdiv2);
				var div5=createDOMElementClass('div','notebox');
				div5.onclick=changeActive.bind(div5, cid+"ts", cid, insid, courseresponse.split("~$~")[1].split("@#@")[2]);
				tempdiv1=createDOMElementIDClass('div',cid+"ts_head" ,'boxhead');
				tempdiv1.innerHTML = 'Total Student';
				tempdiv2=createDOMElementIDClass('div',cid+"ts" ,'boxnote');
				tempdiv2.innerHTML = '00';
				div5.appendChild(tempdiv1);
				div5.appendChild(tempdiv2);
				td1.appendChild(div1);
				td1.appendChild(div2);
				td1.appendChild(div3);
				td1.appendChild(div4);
				td1.appendChild(div5);
				var td2 = createDOMElement('td');
				td2.setAttribute('rowspan',2);
				td2.setAttribute('align','center');
				td2.setAttribute('style','width: 490px;');
				tempdiv1=createDOMElementIDStyle('div',cid+"qpChart" , "margin: auto; width:450px;height:170px;");
				tempdiv2=createDOMElementID('div',cid+"p" );
				var img1=createDOMElementImg('img','../../img/loading.gif' );
				tempdiv1.appendChild(img1);
				td2.appendChild(tempdiv1);
				td2.appendChild(tempdiv2);
				tr1.appendChild(td1);
				tr1.appendChild(td2);
				var tr2 = createDOMElementID('tr',cid+"_arrowcontainer");
				var tr3 = createDOMElementID('tr',cid+"_contentcontainer");
				var h1=document.createElement("h1");
				var h1node=document.createTextNode(resp[i].split("~^~")[2]);
				h1.appendChild(h1node);
				table.appendChild(h1);
				table.appendChild(tr1);
				table.appendChild(tr2);
				table.appendChild(tr3);				
				document.getElementById("HODDashboard").appendChild(table);
				quizData(courseresponse,insid, cid);
			}
			arrowcontainer="<td><div class='downarrow_div'>"+
			"<img id='nq_arrow' style='visibility: visible;' class='downarrow' src='../../img/downarrow.png'></img>"+			
			"</div><div class='downarrow_div'>"+
			"<img id='iq_arrow' class='downarrow' src='../../img/downarrow.png'></img>"+			
			"</div>	<div class='downarrow_div'>"+
			"<img id='p_arrow' class='downarrow' src='../../img/downarrow.png'></img>"+			
			"</div><div class='downarrow_div'>"+
			"<img id='ts_arrow' class='downarrow' src='../../img/downarrow.png'></img>"+			
			"</div></td>";
			contentcontainer="<td colspan='2'>"+
			"<div id='nqcontent_div' class='boxcontainer' style='display: block'><img src='../../img/loading.gif'/></div>"+
			"<div id='iqcontent_div' class='boxcontainer'></div>"+
			"<div id='pcontent_div' class='boxcontainer'></div>"+
			"<div id='tscontent_div' class='boxcontainer'></div>"+
			"</td>";			
		}
	};	
	xmlhttp.open("GET", "../../jsp/dashboard/principalreportdashboardhelper.jsp?helpcontent=coursedata", true);
	xmlhttp.send();	
}

//This is for showing line chart of each department
function loadAllDeptChart(){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText.split("~#~");		
			for(var i=1;i<resp.length;i++){
				var chartdata = resp[i].split("~$~")[0];
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
				var div = createDOMElementIDStyle('div', i+'deptChart', 'width:450px;height: 240px;float: left;margin : 10px 10px 10px 30px;');
				document.getElementById("AllDeptChart").appendChild(div);
				$('#' +i + 'deptChart').highcharts({
					    title: {
			                text: 'Overall Quiz Preformance',
			                x: -20 //center
			            },
			            xAxis: {
			                categories: [],
			                min:1,
			                tickInterval:xtickinterval
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
			            series: [{
			                name: 'Normal Quiz',
			                data: nqchartdata
			            }, {
			                name: 'Instant Quiz',
			                data: iqchartdata
			            }]
			    });	
			}			
		}
	};	
	xmlhttp.open("GET", "../../jsp/dashboard/principalreportdashboardhelper.jsp?helpcontent=alldeptchartedata", false);
	xmlhttp.send();	
}

function quizData(resp,insid,cid){	
	getXMLhttp();
	var response = resp.split("~$~")[1];
	var chartdata = resp.split("~$~")[0];
	/*$("#tempdiv").load("../../QuizLineChart?chartdata="+chartdata+"&cid="+cid,function(){
		document.getElementById(cid+"qpChart").innerHTML = "<img src='../../"+insid+"/"+cid+"qpchart.png'/>";
	});*/
	var iqchartdata = chartdata.split("~@~")[1].split("~!~").map(Number);
	var nqchartdata = chartdata.split("~@~")[0].split("~!~").map(Number);
	var maxquiz=nqchartdata.length;
	if(maxquiz<iqchartdata.length){
		maxquiz=iqchartdata.length;
	}	
	var xtickinterval=1;
	var nqseriesdata=[], iqseriesdata=[];
	if(maxquiz>15){
		xtickinterval =Math.round(maxquiz/10);
	}
	quizdetails = response.split("@#@")[0].split("$#$");
	if(quizdetails[0]<=9){
		document.getElementById(cid+"nq").innerHTML = "0"+quizdetails[0];
	}else{
		document.getElementById(cid+"nq").innerHTML = quizdetails[0];
	}
	var ti=0;
	var prod = {};
	prod['qid'] = "";     
    prod['qts'] = "";
    prod['cid'] = cid;
    prod['qtype'] = "normalquiz";					  
    prod['y'] = Number(nqchartdata[ti++]);
    nqseriesdata.push(prod);
	for(var i=1;i<quizdetails.length;i++){
		var timestamps = quizdetails[i].split("~!~");
		for(var j=2;j<timestamps.length;j++){
			var prod = {};
		    prod['qid'] = timestamps[1];     
		    prod['qts'] = timestamps[j];
		    prod['cid'] = cid;
		    prod['qtype'] = "normalquiz";					   
		    prod['y'] = Number(nqchartdata[ti++]);
			nqseriesdata.push(prod);
		}		
	}
	quizdetails = response.split("@#@")[1].split("$#$");
	if(quizdetails[0]<=9){
		document.getElementById(cid+"iq").innerHTML = "0"+quizdetails[0];
	}else{
		document.getElementById(cid+"iq").innerHTML = quizdetails[0];
	}
	ti=0;
	var prod = {};
	prod['qid'] = "";     
    prod['qts'] = "";  
    prod['cid'] = cid;
    prod['qtype'] = "instantquiz";
    prod['y'] = Number(iqchartdata[ti++]);
    iqseriesdata.push(prod);
	for(var i=1;i<quizdetails.length;i++){
		var timestamps = quizdetails[i].split("~!~");
		for(var j=2;j<timestamps.length;j++){
			var prod = {};
			prod['qid'] = timestamps[1];     
		    prod['qts'] = timestamps[j];
		    prod['cid'] = cid;
		    prod['qtype'] = "instantquiz";
		    prod['y'] = Number(iqchartdata[ti++]);
			iqseriesdata.push(prod);
		}
	}
	quizdetails = response.split("@#@")[2].split("$#$");
	var quizcount = quizdetails[0].split("@@");
	if(quizcount[0]<=9){
		document.getElementById(cid+"ts").innerHTML = "0"+quizcount[0];
	}else{
		document.getElementById(cid+"ts").innerHTML = quizcount[0];
	}
	quizdetails = response.split("@#@")[3].split("$#$");
	if(quizdetails[0]<=9){
		document.getElementById(cid+"p").innerHTML = "0"+quizdetails[0];
	}else{
		document.getElementById(cid+"p").innerHTML = quizdetails[0];
	}
	$('#'+cid + 'qpChart').highcharts({
            title: {
                text: cid+' Overall Quiz Preformance',
                x: -20 //center
            },
            xAxis: {
                categories: [],
                min:1,
                tickInterval:xtickinterval
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
                            	quizReport(event.point.qid,event.point.qts,"QuizResponse",event.point.cid);
                            }else{
                            	instantQuizReport(event.point.qid,event.point.qts,event.point.cid);
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

var previousSelect="";
var previouscid="";
function changeActive(req, cid, insid, contentdetails){
	var quizdetails=contentdetails.split("$#$");
	if(previousSelect!=""){
		document.getElementById(previousSelect).style.background="gray";
		document.getElementById(previousSelect+ "_head").style.background="gray";
	}
	document.getElementById(req).style.background="#9bbb59";
	document.getElementById(req + "_head").style.background="#9bbb59";
	previousSelect=req;
	if(previouscid!=""){
		document.getElementById(previouscid+"_arrowcontainer").innerHTML="";
		document.getElementById(previouscid+"_contentcontainer").innerHTML="";
	}
	document.getElementById(cid+"_arrowcontainer").innerHTML=arrowcontainer;
	document.getElementById(cid+"_contentcontainer").innerHTML=contentcontainer;
	previouscid=cid;	
	var mnu=req.substring(cid.length,req.length);
	document.getElementById("nq_arrow").style.visibility="hidden";
	document.getElementById("iq_arrow").style.visibility="hidden";
	document.getElementById("ts_arrow").style.visibility="hidden";
	document.getElementById("p_arrow").style.visibility="hidden";
	document.getElementById(mnu+"_arrow").style.visibility="visible";	
	document.getElementById("nqcontent_div").style.display="none";
	document.getElementById("iqcontent_div").style.display="none";
	document.getElementById("tscontent_div").style.display="none";
	document.getElementById("pcontent_div").style.display="none";
	document.getElementById(mnu+"content_div").style.display="block";
	if(mnu=="nq"){
		document.getElementById("qtype").style.visibility="visible";
	}else{
		document.getElementById("qtype").style.visibility="hidden";
	}
	var quizzes="";
	if(mnu=="nq"){
		for(var i=1;i<quizdetails.length;i++){
			var timestamps = quizdetails[i].split("~!~");
			quizzes += "<div class='mybox'><div class='myboxhead' onclick='quizReport(\""+timestamps[1]+"\",\"\""+",\""+"QuizDetail"+"\", \""+cid+"\")'>"+timestamps[0] + "</div>" ;
			for(var j=2;j<timestamps.length;j++){
				quizzes += "<div class='myboxnote' onclick='quizReport(\""+timestamps[1]+"\",\""+timestamps[j]+"\",\""+"QuizResponse"+"\", \""+cid+"\")'>"+timestamps[j]+"</div>";
			}
			quizzes += "</div>";
		}
		document.getElementById("nqcontent_div").innerHTML = quizzes;
	}else if(mnu=="iq"){
		for(var i=1;i<quizdetails.length;i++){
			var timestamps = quizdetails[i].split("~!~");
			quizzes += "<div class='mybox'><div class='myboxhead1'>"+timestamps[0] +"<br><br>"+timestamps[1] + "</div>" ;
			for(var j=2;j<timestamps.length;j++){
				quizzes += "<div class='myboxnote' onclick='instantQuizReport(\""+timestamps[1]+"\",\""+timestamps[j]+"\", \""+cid+"\")'>"+timestamps[j]+"</div>";
			}
			quizzes += "</div>";
		}
		document.getElementById("iqcontent_div").innerHTML = quizzes; 
	}else if(mnu=="ts"){
		var quizcount = quizdetails[0].split("@@");
		for(var i=1;i<quizdetails.length;i++){
			var timestamps = quizdetails[i].split("~!~");
			var w=(timestamps[4]/quizcount[1]*100) / 100 * 130;
			quizzes += "<div class='mybox'><div class='myboxhead1'>"+timestamps[0] + " - " + timestamps[1] +"</div>" ;
			quizzes += "<div class='myboxnote' onclick='studentNormalQuizReport(\""+timestamps[0]+"\",\""+insid+"\", \""+cid+"\")'>"+timestamps[2]+"</div>";
			quizzes += "<div class='myboxnote' onclick='studentInstantQuizReport(\""+timestamps[0]+"\",\""+insid+"\", \""+cid+"\")'>"+timestamps[3]+"</div>";
			quizzes += "<div class='studprogbar' title='Attempted Quiz : "+timestamps[4] + " / " + quizcount[1]+"'><div class='insidebar' style='width:"+w+"px;'></div></div><div class='attemptedquiz'>"+timestamps[4] + " / " + quizcount[1]+"</div>";
			quizzes += "</div>";
		}
		//document.getElementById("tscontent_div").innerHTML = "<div class='dashboard_icon' onclick='attendanceList()'><img src='../../img/attendance.png' title='Attendance'></div>";
		//document.getElementById("tscontent_div").innerHTML += "<div class='dashboard_icon' onclick='queryList()'><img src='../../img/query.png' title='Query'></div>";
		//document.getElementById("tscontent_div").innerHTML += "<div class='dashboard_icon' onclick='studentList()'><img src='../../img/report.png' title='Student List'></div>" + quizzes;
		document.getElementById("tscontent_div").innerHTML=quizzes;
	}else if(mnu=="p"){
		for(var i=1;i<quizdetails.length;i++){
			var resp = quizdetails[i].split("~!~");
			quizzes += "<div class='pollbox' onclick='pollReport(\""+resp[1]+"\", \""+cid+"\")'><div class='pollboxhead'>"+resp[0] + "</div>" ;
			for(var j=2;j<resp.length;j++){
				quizzes += "<div class='pollboxnote'>"+resp[j]+"</div>";
			}
			quizzes += "</div>";
		}
		document.getElementById("pcontent_div").innerHTML = quizzes;
	}		
}

function quizReport(quizid, qts, reportname, cid) {
	if(reportname=="QuizDetail"){
		generateQuizReport(quizid, qts, reportname, cid);
	}else{
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				generateQuizReport(quizid, qts, reportname, cid);
			}
		};
		var reporttype = document.getElementsByName('reporttype');
		for(var i = 0; i < reporttype.length; i++){
		    if(reporttype[i].checked){
		    	reportname = reporttype[i].value;
		    }
		}
		xmlhttp.open("GET", "../../Chart?report=quizreport&qid="+ quizid + "&qts="+qts + "&charttype="+reportname+"Chart&cid="+cid, false);
		xmlhttp.send();
	}
}

function generateQuizReport(quizid, qts, reportname,cid){
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
	xmlhttp.open("GET", "../../Report?report=quizreport&qid="+ quizid + "&qts="+qts + "&reportname="+reportname+"&cid="+cid, true);
	xmlhttp.send();
}

function instantQuizReport(qid, qts, cid) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generateInstantQuizReport(qid, qts, cid);			
		}
	};
	xmlhttp.open("GET", "../../Chart?charttype=InstantQuizResponseChart&qid="+ qid+"&cid="+cid, false);
	xmlhttp.send();	
}

function generateInstantQuizReport(qid, qts, cid){
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
	xmlhttp.open("GET", "../../Report?report=instantquizreportnew&qid="+ qid + "&qts="+qts+"&cid="+cid, true);
	xmlhttp.send();
}


function pollReport(pid, cid) {	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generatePollReport(pid, cid);			
		}
	};
	xmlhttp.open("GET", "../../Chart?charttype=PollResponseChart&pid="+ pid+"&cid="+cid, false);
	xmlhttp.send();	
}

function generatePollReport(pid, cid){
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
	xmlhttp.open("GET", "../../Report?report=pollreport&pid="+ pid+"&cid="+cid, true);
	xmlhttp.send();
}

function studentNormalQuizReport(sid, iid, cid){
	$("#tempdiv").load("../../studentPerformanceChart?sid="+sid+ "&qtype=nquiz&cid="+cid, function(){
		$("#dlg_body").load("../../Report?sid="+sid + "&report=studreport&cid="+cid, function(){
			document.getElementById("dlg_body").innerHTML = "<img src='../../"+iid+"/studResult.png?"+new Date()+"' />" + document.getElementById("quizreport").innerHTML;
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

function studentInstantQuizReport(sid, iid, cid){
	$("#tempdiv").load("../../studentPerformanceChart?sid="+sid + "&qtype=iquiz&cid="+cid, function(){
		$("#dlg_body").load("../../Report?sid="+sid + "&report=studreport&cid="+cid, function(){
			document.getElementById("dlg_body").innerHTML = "<img src='../../"+iid+"/studResult.png?"+new Date()+"' />";
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title : "Instant Quiz Report",
				height : 500,
				width : 850,
				draggable : false,
				modal : true
			});
		});	
	});	
}


function studentList(){
	$("#dlg_body").load("../../Report?report=corusereport&ats=&reportname=StudentList&date=", function(){
			document.getElementById("quizreport").style.visibility = 'visible';
			$("#quizreport").dialog({
				title: "Student List",
				height : 500,
				width : 850,
				draggable : false,
				modal : true
			});
	});		
}


function queryList(){
	document.getElementById("dlg_header_att").style.display ="none";
	document.getElementById("dlg_header_query").style.display ="block";
	document.getElementById("dlg_body1").innerHTML="";
	document.getElementById("quizreport1").style.visibility = 'visible';
	$("#quizreport1").dialog({
		title: "Raisehand Report",
		height : 500,
		width : 850,
		draggable : false,
		modal : true
	});	
}

function studentQuery(date){
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	var querydates = document.getElementById("hide_querydates").innerHTML;
	if(querydates.indexOf(date)==-1){
		alert("No query is available on this day");
		return false;
	}
	$("#dlg_body1").load("../../Report?report=corusereport&ats=&reportname=StudentQuery&date=" +date, function(){
		
	});
}

function attendanceList(){
	document.getElementById("dlg_header_query").style.display ="none";
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
	xmlhttp.open("GET",	"../../jsp/dashboard/hodreportdashboardhelper.jsp?helpcontent=atteninfo&cid="+ encodeURIComponent(courseID) + "&date="+date, true);	
	xmlhttp.send();	
}

function attendanceReport(cid, date, session){
	if(session==''){
		alert("select Proper session");
		return;
	}
	$("#tempdiv").load("../../Chart?charttype=Attendance&cid=" + encodeURIComponent(cid) + "&date=" + date + "&session="+session, function(){
		$("#dlg_body1").load("../../Report?report=corusereport&session="+ session + "&reportname=Attendance&date=" +date, function(){
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