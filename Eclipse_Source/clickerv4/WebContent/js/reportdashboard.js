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

function createDOMElementStyle(ele, style){
	var element = document.createElement(ele);
	element.setAttribute('style',style);
	return element;
}

function createDOMElement(ele){
	var element = document.createElement(ele);
	return element;
}

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
function loadDOMCoursesData(insid, instrType){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText.split("~&~");
			var noofcourses =resp.length-1; 
			for(var i=0;i<noofcourses;i++){
				var cid=resp[i].split("~^~")[0].trim();
				var courseresponse=resp[i].split("~^~")[1];
				var table=createDOMElementClassStyle('table', 'table1',  'margin-top: 10px;');
				var tr1=createDOMElement('tr');
				var td1=createDOMElement('td');
				var div1=createDOMElementClassStyle('div','ui-header-text', 'text-align:left;');
				var h2=document.createElement("h2");
				h2.setAttribute("style", "display: inline;");
				var h2node=document.createTextNode("Course ID : "+cid);
				h2.appendChild(h2node);
				div1.appendChild(h2);
				if(noofcourses>=2){
					var checkbox = createDOMInputElement("checkbox", "compare", "cb_"+cid, cid, "display: inline;", "coursecompare");
					var cblabel = document.createElement('label');
					cblabel.htmlFor = "cb_"+cid;
					cblabel.appendChild(document.createTextNode('Compare'));
					var innerdiv_div1;
					innerdiv_div1 = createDOMElementStyle("div", "display:inline");
					innerdiv_div1.appendChild(checkbox);
					innerdiv_div1.appendChild(cblabel);
					div1.appendChild(innerdiv_div1);		
					document.getElementById("comparecoursebtn").style.display="inline";
				}
				var hiddendiv = createDOMElementIDStyle("div", cid + "_performance", "display:none");
				div1.appendChild(hiddendiv);
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
				table.appendChild(tr1);
				table.appendChild(tr2);
				table.appendChild(tr3);				
				document.getElementById("Dashboard").appendChild(table);
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
	xmlhttp.open("GET", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=coursedata&instrType="+instrType, true);
	xmlhttp.send();
}

function loadDOMPrincipalCoursesData(insid){
	//loadAllDeptChart();
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText.split("~&~");
			var noofcourses = resp.length-1;
			for(var i=0;i<noofcourses;i++){
				var cid=resp[i].split("~^~")[0].trim();
				var courseresponse=resp[i].split("~^~")[1];
				var table=createDOMElementClassStyle('table', 'table1',  'margin-top: 10px;');
				var tr1=createDOMElement('tr');
				var td1=createDOMElement('td');
				var div1=createDOMElementClassStyle('div','ui-header-text', 'text-align:left;');
				var h2=document.createElement("h2");
				h2.setAttribute("style", "display: inline;");
				var h2node=document.createTextNode("Course ID : "+cid);
				h2.appendChild(h2node);
				div1.appendChild(h2);
				if(noofcourses>=2){
					var checkbox = createDOMInputElement("checkbox", "compare", "cb_"+cid, cid, "display: inline;", "coursecompare");
					var cblabel = document.createElement('label');
					cblabel.htmlFor = "cb_"+cid;
					cblabel.appendChild(document.createTextNode('Compare'));
					var innerdiv_div1;
					innerdiv_div1 = createDOMElementStyle("div", "display:inline");
					innerdiv_div1.appendChild(checkbox);
					innerdiv_div1.appendChild(cblabel);
					div1.appendChild(innerdiv_div1);		
					document.getElementById("comparecoursebtn").style.display="inline";
				}
				var hiddendiv = createDOMElementIDStyle("div", cid + "_performance", "display:none");
				div1.appendChild(hiddendiv);
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
				document.getElementById("Dashboard").appendChild(table);
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
	xmlhttp.open("GET", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=coursedata&instrType=principal", true);
	xmlhttp.send();	
}

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
		var icons = "<div class='dashboard_icon' onclick='attendanceList(\""+cid+"\")'><img src='../../img/attendance.png' title='Attendance'></div>";
		icons += "<div class='dashboard_icon' onclick='queryList(\""+cid+"\")'><img src='../../img/query.png' title='Query'></div>";
		icons += "<div class='dashboard_icon' onclick='studentList(\""+cid+"\")'><img src='../../img/report.png' title='Student List'></div>";
		document.getElementById("dlg_header_query").innerHTML = "Select Date : <input type='text' id='studentQuery_datepicker' style='width: 85px;' onchange='studentQuery(this.value, \""+cid+"\")'/>";
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


function studentList(cid){
	$("#dlg_body").load("../../Report?report=corusereport&ats=&reportname=StudentList&cid="+cid, function(){
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

var datestring = "";
function highlightDays(date) {
	var att_dates= datestring.split(",");
	for (var i = 0; i < att_dates.length-1; i++) {
		if (att_dates[i].trim() == date.formatYYYYMMDD().trim()) {
			return [true, 'highlight', 'Select'];
        }
    }
    return [true, ''];
} 
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

function queryList(cid){
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
			document.getElementById("dlg_header_att").style.display ="none";
			document.getElementById("dlg_header_query").style.display ="block";
			$("#studentQuery_datepicker").datepicker({
					changeMonth: true,
					changeYear: true,
					beforeShowDay: highlightDays
			});
			$( "#studentQuery_datepicker" ).datepicker( "option", "minDate", new Date(syyyy, smm-1, sdd));
			$( "#studentQuery_datepicker" ).datepicker( "option", "maxDate", new Date(eyyyy, emm-1, edd));
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
	};
	xmlhttp.open("POST", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=getCalendarDate&cid="+ encodeURIComponent(cid) + "&dateType=raiseHandDate", true);	
	xmlhttp.send();	
}

function studentQuery(date, cid){
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	if(datestring.indexOf(date)==-1){
		alert("No query is available on this day");
		return false;
	}
	$("#dlg_body1").load("../../Report?report=corusereport&ats=&reportname=StudentQuery&date=" +date + "&cid="+cid, function(){
		
	});
}

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
				width : 850,
				draggable : false,
				modal : true
			});			
		}
	};
	xmlhttp.open("POST", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=getCalendarDate&cid="+ encodeURIComponent(cid) + "&dateType=attendanceTakenDate", true);	
	xmlhttp.send();	
}

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
	xmlhttp.open("POST", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=atteninfo&cid="+ encodeURIComponent(courseid) + "&date="+date, true);	
	xmlhttp.send();	
}

function attendanceReport(cid, date, session){
	if(session==''){
		alert("select Proper session");
		return;
	}
	$("#tempdiv").load("../../Chart?charttype=Attendance&cid=" + encodeURIComponent(cid) + "&date=" + date + "&session="+session, function(){
		$("#dlg_body1").load("../../Report?report=corusereport&session="+ session + "&reportname=Attendance&date=" +date + "&cid=" + encodeURIComponent(cid), function(){
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

function compareCourses(){
	var checkgroup = document.getElementsByName("compare");
	var checkedcount=0;	
	var courses = "";
	var coursesPerformances = "";
	for (var i=0; i<checkgroup.length; i++){
		if(checkgroup[i].checked){
			checkedcount++;
			courses +=checkgroup[i].value + "@";
			coursesPerformances += document.getElementById(checkgroup[i].value + "_performance").innerHTML + "@#@";
		}
	}
	if (checkedcount<2){
		alert("You have to select minimum of 2 courses");
		return false;
	}
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resp = xmlhttp.responseText;
			var avgDate = resp.split("@#@");
			var comparearray=new Array(4);
			for (i=0; i <4; i++){
				comparearray[i]=new Array(6);
			}
			var perf= coursesPerformances.split("@#@");
			for(var i=0;i<avgDate.length-1;i++){
				var Cdata = avgDate[i].split("@!@");
				var avg=0;
				var cperf = perf[i].split("~@~");
				if(i==1)i=i+2;
				for(var j=0;j<Cdata.length-1;j++){
					var Qdata = Cdata[j].split("~!~");
					for(var k=0;k<Qdata.length;k++){
						if(k==0)
						{							
							comparearray[k][j+i]=Qdata[k];
						}else if(k==1){
							if(Qdata[k]!="null"){
								comparearray[k][j+i]=Qdata[k].split(",").length;
								comparearray[k+1][j+i]=Qdata[k].split(",")[0];								
							}else{
								comparearray[k][j+i]= " - ";
								comparearray[k+1][j+i]= " - ";
							}
						}
						var qperf = cperf[k].split("~!~");
						var sum=0;
						for(var l=1;l<qperf.length;l++){
							sum += parseInt(qperf[l]);
						}
						avg = Math.round((sum / (qperf.length-1)) * 100) / 100;
						if(!isNaN(avg))
						{
							comparearray[3][k+i]=avg;
						}else{
							comparearray[3][k+i]=0;
						}
					}
				}
			}
			comparearray[3][2]=" - ";comparearray[3][5]=" - ";
			var response = "<table id='ccomparetable' border=1 style='margin-left:20px;'><tr><th rowspan=2>Performances</th><th colspan=3>"+courses.split("@")[0]+"</th><th colspan=3>"+courses.split("@")[1]+"</th></tr>";
			response += "<tr><th>Normal Quiz</th><th>Instant Quiz</th><th>Poll</th><th>Normal Quiz</th><th>Instant Quiz</th><th>Poll</th></tr>";
			for(var i=0;i<4;i++){
				if(i==0)response += "<tr><td> Average Student Participation </td>";
				else if(i==1)response += "<tr><td> Number of Days Clicker Used </td>";
				else if(i==2)response += "<tr><td> Last date of Clicker Used </td>";
				else if(i==3)response += "<tr><td> Average Student Performance </td>";
				for(var j=0;j<6;j++){
					response += "<td> "+comparearray[i][j]+" </td>";
				}
				response += "</tr>";
			}
			response += "</table>";
			document.getElementById("compareTable").innerHTML = response;
			
			$('#compareChart1').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text: 'Average Student Performance'
		        },
		        subtitle: {
		            text: 'Course Comparative Analysis'
		        },
		        xAxis: {
		            categories: [
		                'Normal Quiz',
		                'Instant Quiz'
		            ]
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: 'Performance (%)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		                '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: courses.split("@")[0],
		            data: [comparearray[3][0], comparearray[3][1]]

		        }, {
		            name: courses.split("@")[1],
		            data: [comparearray[3][3], comparearray[3][4]]
		        }]
		    });
			
			$('#compareChart2').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text: 'Average Student Participation'
		        },
		        subtitle: {
		            text: 'Course Comparative Analysis'
		        },
		        xAxis: {
		            categories: [
		                'Normal Quiz',
		                'Instant Quiz'
		            ]
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: 'Perticipation (%)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		                '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: courses.split("@")[0],
		            data: [parseInt(comparearray[0][0]), parseInt(comparearray[0][1])]

		        }, {
		            name: courses.split("@")[1],
		            data: [parseInt(comparearray[0][3]), parseInt(comparearray[0][4])]
		        }]
		    });

			document.getElementById("courseCompareDiv").style.visibility = 'visible';
			$("#courseCompareDiv").dialog({
				title : "Course Comparative Analysis",
				height : 540,
				width : 810,
				draggable : false,
				modal : true
			});			
		}
	};	
	xmlhttp.open("GET", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=comparecourses&courses="+courses, true);
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
	xmlhttp.open("GET", "../../jsp/dashboard/reportdashboardhelper.jsp?helpcontent=alldeptchartedata", false);
	xmlhttp.send();	
}
