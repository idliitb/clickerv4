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

//This method is used to trim the empty spaces in a string
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

// This method is used to create the DOM element with id, style and class
function createDOMElementIDClassStyle(ele, id, eleclass, style){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eleclass);
	element.setAttribute('style',style);
	return element;
}

// This method is used to create the DOM element with style and class
function createDOMElementClassStyle(ele, eleclass, style){
	var element = document.createElement(ele);
	element.setAttribute('class',eleclass);
	element.setAttribute('style',style);
	return element;
}

//This method is used to create the DOM element with id and style
function createDOMElementIDStyle(ele, id, style){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('style',style);
	return element;
}

// This method is used to create the DOM element with id and class
function createDOMElementIDClass(ele, id, eclass){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eclass);
	return element;
}

// This method is used to create the DOM element with class
function createDOMElementClass(ele, eleclass){
	var element = document.createElement(ele);
	element.setAttribute('class',eleclass);
	return element;
}

// This method is used to create the DOM element with id
function createDOMElementID(ele, id){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	return element;
}

// This method is used to create the DOM element for img
function createDOMElementImg(ele, src){
	var element = document.createElement(ele);
	element.setAttribute('src',src);
	return element;
}

// This method is used to create the DOM element with style
function createDOMElementStyle(ele, style){
	var element = document.createElement(ele);
	element.setAttribute('style',style);
	return element;
}

// This method is used to create simple DOM element
function createDOMElement(ele){
	var element = document.createElement(ele);
	return element;
}

// This method is used to create the DOM element for input tag
function createDOMInputElement(type, name, id, value, style, eleclass){
	var element = document.createElement("INPUT");
	element.setAttribute("type", type);	
	element.setAttribute('name', name);	
	element.setAttribute('id', id);
	element.setAttribute('value',value);
	element.setAttribute('style',style);
	element.setAttribute('class',eleclass);
	element.setAttribute('onchange',"checkboxlimit()");
	return element;
}

// This method is used to validate the number of check box checked
function checkboxlimit(){
	var checkgroup = document.getElementsByName("compare");
	var limit =2;
	var checkedcount=0;	
	for (var i=0; i<checkgroup.length; i++){
		checkedcount+=(checkgroup[i].checked)? 1 : 0;
		if (checkedcount>limit){
			alert("You can only select maximum of "+limit+" courses");
			checkgroup[i].checked=false;
			checkedcount--;
		}
	}
}

var arrowcontainer="", contentcontainer="";
// This method is used to load the all workshops report data in report page
function loadDOMWorkshopData(insid){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText.split("~&~");
			var noofcourses =resp.length-1; 
			for(var i=0;i<noofcourses;i++){
				var wid=resp[i].split("~^~")[0].trim();
				var courseresponse=resp[i].split("~^~")[1];
				var table=createDOMElementClassStyle('table', 'table1',  'margin-top: 10px;');
				var tr1=createDOMElement('tr');
				var td1=createDOMElement('td');
				var div1=createDOMElementClassStyle('div','ui-header-text', 'text-align:left;');
				var h2=document.createElement("h2");
				h2.setAttribute("style", "display: inline;");
				var h2node=document.createTextNode("Workshop ID : "+wid);
				h2.appendChild(h2node);
				div1.appendChild(h2);
				/*if(noofcourses>=2){
					var checkbox = createDOMInputElement("checkbox", "compare", "cb_"+wid, wid, "display: inline;", "coursecompare");
					var cblabel = document.createElement('label');
					cblabel.htmlFor = "cb_"+wid;
					cblabel.appendChild(document.createTextNode('Compare'));
					var innerdiv_div1;
					innerdiv_div1 = createDOMElementStyle("div", "display:inline");
					innerdiv_div1.appendChild(checkbox);
					innerdiv_div1.appendChild(cblabel);
					div1.appendChild(innerdiv_div1);		
					document.getElementById("comparecoursebtn").style.display="inline";
				}*/
				var hiddendiv = createDOMElementIDStyle("div", wid + "_performance", "display:none");
				div1.appendChild(hiddendiv);
				var div2=createDOMElementClass('div','notebox');
				div2.onclick=changeActive.bind(div2, wid+"nq", wid, insid, courseresponse.split("~$~")[1].split("@#@")[0]);
				var tempdiv1=createDOMElementIDClass('div',wid+"nq_head" ,'boxhead');
				tempdiv1.innerHTML = 'Normal quiz';
				var tempdiv2=createDOMElementIDClass('div',wid+"nq" ,'boxnote');
				tempdiv2.innerHTML = '00';
				div2.appendChild(tempdiv1);
				div2.appendChild(tempdiv2);
				var div3=createDOMElementClass('div','notebox');
				div3.onclick=changeActive.bind(div3, wid+"iq", wid, insid, courseresponse.split("~$~")[1].split("@#@")[1]);
				tempdiv1=createDOMElementIDClass('div',wid+"iq_head" ,'boxhead');
				tempdiv1.innerHTML = 'Instant quiz';
				tempdiv2=createDOMElementIDClass('div',wid+"iq" ,'boxnote');
				tempdiv2.innerHTML = '00';
				div3.appendChild(tempdiv1);
				div3.appendChild(tempdiv2);
				var div4=createDOMElementClass('div','notebox');
				div4.onclick=changeActive.bind(div4, wid+"p", wid, insid, courseresponse.split("~$~")[1].split("@#@")[3]);
				tempdiv1=createDOMElementIDClass('div',wid+"p_head" ,'boxhead');
				tempdiv1.innerHTML = 'Poll';
				tempdiv2=createDOMElementIDClass('div',wid+"p" ,'boxnote');
				tempdiv2.innerHTML = '00';				
				div4.appendChild(tempdiv1);
				div4.appendChild(tempdiv2);
				var div5=createDOMElementClass('div','notebox');
				div5.onclick=changeActive.bind(div5, wid+"ts", wid, insid, courseresponse.split("~$~")[1].split("@#@")[2]);
				tempdiv1=createDOMElementIDClass('div',wid+"ts_head" ,'boxhead');
				tempdiv1.innerHTML = 'Participants';
				tempdiv2=createDOMElementIDClass('div',wid+"ts" ,'boxnote');
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
				tempdiv1=createDOMElementIDStyle('div',wid+"qpChart" , "margin: auto; width:450px;height:170px;");
				tempdiv2=createDOMElementID('div',wid+"p" );
				var img1=createDOMElementImg('img','../../img/loading.gif' );
				tempdiv1.appendChild(img1);
				td2.appendChild(tempdiv1);
				td2.appendChild(tempdiv2);
				tr1.appendChild(td1);
				tr1.appendChild(td2);
				var tr2 = createDOMElementID('tr',wid+"_arrowcontainer");
				var tr3 = createDOMElementID('tr',wid+"_contentcontainer");
				table.appendChild(tr1);
				table.appendChild(tr2);
				table.appendChild(tr3);				
				document.getElementById("Dashboard").appendChild(table);
				quizData(courseresponse,insid, wid);
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
	xmlhttp.open("GET", "../../jsp/dashboard/rcreportdashboardhelper.jsp?helpcontent=workshopsdata", true);
	xmlhttp.send();
}


//This method is used to get the quiz details for a course and a instructor with chart
function quizData(resp,insid,cid){	
	getXMLhttp();
	var response = resp.split("~$~")[1];
	var chartdata = resp.split("~$~")[0];
	/*$("#tempdiv").load("../../QuizLineChart?chartdata="+chartdata+"&cid="+cid,function(){
		document.getElementById(cid+"qpChart").innerHTML = "<img src='../../"+insid+"/"+cid+"qpchart.png'/>";
	});*/
	document.getElementById(cid+"_performance").innerHTML=chartdata;
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
                text: cid+' Overall Quiz Performance',
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
// This method is used to change the active buttons (poll , quiz, instant quiz or student)
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
			if(timestamps[2]!="No.of Normal Quiz : 0"){
				quizzes += "<div class='myboxnote' onclick='participantNormalQuizReport(\""+timestamps[0]+"\",\""+insid+"\", \""+cid+"\")'>"+timestamps[2]+"</div>";
			}else{
				quizzes += "<div class='myboxnote1'>"+timestamps[2]+"</div>";
			}if(timestamps[3]!="No.of Instant Quiz : 0"){
				quizzes += "<div class='myboxnote' onclick='participantInstantQuizReport(\""+timestamps[0]+"\",\""+insid+"\", \""+cid+"\")'>"+timestamps[3]+"</div>";
			}else{
				quizzes += "<div class='myboxnote1'>"+timestamps[3]+"</div>";
			}
			quizzes += "<div class='studprogbar' title='Attempted Quiz : "+timestamps[4] + " / " + quizcount[1]+"'><div class='insidebar' style='width:"+w+"px;'></div></div><div class='attemptedquiz'>"+timestamps[4] + " / " + quizcount[1]+"</div>";
			quizzes += "</div>";
		}
		var icons = "<div class='dashboard_icon' onclick='attendanceList(\""+cid+"\")'><img src='../../img/attendance.png' title='Attendance'></div>";
		//icons += "<div class='dashboard_icon' onclick='queryList(\""+cid+"\")'><img src='../../img/query.png' title='Query'></div>";
		icons += "<div class='dashboard_icon' onclick='participantList(\""+cid+"\")'><img src='../../img/report.png' title='Student List'></div>";
		//document.getElementById("dlg_header_query").innerHTML = "Select Date : <input type='text' id='studentQuery_datepicker' style='width: 85px;' onchange='studentQuery(this.value, \""+cid+"\")'/>";
		document.getElementById("dlg_header_att_dp").innerHTML = "Select Date : <input type='text' id='courseAtt_datepicker' style='width: 85px;' onchange='fillAttenDetail(this.value, \""+cid+"\")'/>";
		document.getElementById("tscontent_div").innerHTML=icons + quizzes;
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


//This method is used to request for generate quiz respons chart 
function quizReport(quizid, qts, reportname, wid) {
	if(reportname=="QuizDetail"){
		generateQuizReport(quizid, qts, reportname, wid);
	}else{
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				generateQuizReport(quizid, qts, reportname, wid);
			}
		};
		var reporttype = document.getElementsByName('reporttype');
		for(var i = 0; i < reporttype.length; i++){
		    if(reporttype[i].checked){
		    	reportname = reporttype[i].value;
		    	break;
		    }
		}
		xmlhttp.open("GET", "../../ChartRemote?report=quizreport&qid="+ quizid + "&qts="+qts + "&charttype="+reportname+"Chart"+ "&wid="+wid, false);
		xmlhttp.send();
	}
}

//This method is used to request for generate quiz respons report 
function generateQuizReport(quizid, qts, reportname, wid){
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
	xmlhttp.open("GET", "../../RemoteReport?report=quizreport&qid="+ quizid + "&qts="+qts + "&reportname="+reportname+ "&wid="+wid, true);
	xmlhttp.send();
}

//This method is used to request for generate instant quiz respons chart 
function instantQuizReport(qid, qts,wid) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generateInstantQuizReport(qid, qts,wid);			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=InstantQuizResponseChart&qid="+ qid+ "&wid="+wid, false);
	xmlhttp.send();	
}

//This method is used to request for generate quiz respons report 
function generateInstantQuizReport(qid, qts,wid){
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
	xmlhttp.open("GET", "../../RemoteReport?report=instantquizreportnew&qid="+ qid + "&qts="+qts+ "&wid="+wid, true);
	xmlhttp.send();
}

//This method is used to request for generate poll respons chart 
function pollReport(pid, wid) {	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generatePollReport(pid, wid);			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=PollResponseChart&pid="+ pid+ "&wid="+wid, false);
	xmlhttp.send();	
}

//This method is used to request for generate quiz respons report 
function generatePollReport(pid,wid){
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
	xmlhttp.open("GET", "../../RemoteReport?report=pollreport&pid="+ pid+ "&wid="+wid, true);
	xmlhttp.send();
}

//This method is used to request for generate participant normal quiz performance chart and report 
function participantNormalQuizReport(pid, iid, wid){
	$("#tempdiv").load("../../participantPerformanceChart?pid="+pid+ "&qtype=nquiz"+ "&wid="+wid, function(){
		$("#dlg_body").load("../../RemoteReport?pid="+pid + "&report=partcipantreport" + "&wid="+wid, function(){
			document.getElementById("dlg_body").innerHTML = document.getElementById("quizreport").innerHTML;
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

//This method is used to request for generate participant instant quiz  performance chart and report
function participantInstantQuizReport(pid, iid, wid){
	$("#tempdiv").load("../../participantPerformanceChart?pid="+pid + "&qtype=iquiz"+ "&wid="+wid, function(){
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

//This method is used to request for get participant list
function participantList(wid){
	$("#dlg_body").load("../../RemoteReport?report=corusereport&ats=&reportname=ParticipantList&date="+"&wid="+wid, function(){
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

var datestring = "";
//This method is used to highlight the quiz conducted date in a datepicker 
function highlightDays(date) {
	var att_dates= datestring.split(",");
	for (var i = 0; i < att_dates.length-1; i++) {
		if (att_dates[i].trim() == date.formatYYYYMMDD().trim()) {
			return [true, 'highlight', 'Select'];
     }
 }
 return [true, ''];
} 
//This method is used to conver the date format as YYYYMMDD
Date.prototype.formatYYYYMMDD=function(){
 var dd = this.getDate(), mm = this.getMonth()+1, yyyy = this.getFullYear();
 if(dd<10){
   dd = '0' + dd;
 }
 if(mm<10){
   mm = '0'+ mm;
 }
return String(yyyy + "-" + mm + "-" + dd);
};

// This method is usd to get the attendance list
function attendanceList(cid){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var calendarDate = xmlhttp.responseText;
			datestring = calendarDate.split("@")[0];
			var date = calendarDate.split("@")[1];
			var syyyy = parseInt(date.split("-")[0]);
			var smm = parseInt(date.split("-")[1]);
			var sdd = parseInt(date.split("-")[2]);						
			date = calendarDate.split("@")[2];
			var eyyyy = parseInt(date.split("-")[0]);
			var emm = parseInt(date.split("-")[1]);
			var edd = parseInt(date.split("-")[2]);			
			$("#courseAtt_datepicker").datepicker({
					changeMonth: true,
					changeYear: true,
					beforeShowDay: highlightDays
			});
			$( "#courseAtt_datepicker" ).datepicker( "option", "minDate", new Date(syyyy, smm-1, sdd));
			$( "#courseAtt_datepicker" ).datepicker( "option", "maxDate", new Date(eyyyy, emm-1, edd));
			document.getElementById("dlg_header_query").style.display ="none";
			document.getElementById("dlg_header_att").style.display ="block";
			document.getElementById("dlg_body1").innerHTML="";
			document.getElementById("quizreport1").style.visibility = 'visible';
			$("#quizreport1").dialog({
				title: "Attendance Report",
				height : 500,
				width : 750,
				draggable : false,
				modal : true
			});			
		}
	};
	xmlhttp.open("POST", "../../jsp/dashboard/rcreportdashboardhelper.jsp?helpcontent=getCalendarDate&wid="+ encodeURIComponent(cid) + "&dateType=attendanceTakenDate", true);	
	xmlhttp.send();	
}


// This method is used to fill the attendance detail
function fillAttenDetail(date, courseid) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resps = xmlhttp.responseText;
			document.getElementById("att_ts").innerHTML = resps;
			var attendancetimestamp=document.getElementById("attendancetimestamp");
			var atttimestamplen = attendancetimestamp.length;
			if(datestring.indexOf(date)==-1){
				alert("No Attendance is available on this day");
				return false;
			}
			if(atttimestamplen<=1){
				document.getElementById("att_ts").style.display="none";
			}
			else if (atttimestamplen==2){
				document.getElementById("att_ts").style.display="none";
				var session =  attendancetimestamp.options[1].text;
				attendanceReport(courseid, date, session);
			}
			else if (atttimestamplen>2){
				document.getElementById("att_ts").style.display="block";
			}
		}
	};
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("POST", "../../jsp/dashboard/rcreportdashboardhelper.jsp?helpcontent=atteninfo&wid="+ encodeURIComponent(courseid) + "&date="+date, true);	
	xmlhttp.send();	
}

// This method is used to request for attendance chart and report for coruse
function attendanceReport(cid, date, session){
	if(session==''){
		alert("select Proper session");
		return;
	}
	$("#tempdiv").load("../../ChartRemote?charttype=RemoteAttendance&cid=" + encodeURIComponent(cid) + "&date=" + date + "&session="+session + "&wid="+cid, function(){
		$("#dlg_body1").load("../../RemoteReport?report=corusereport&session="+ session + "&reportname=Attendance&date=" +date+"&wid="+cid, function(){
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