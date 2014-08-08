/*
 * Author : Rajavel and Dipti ,Clicker Lab
 * This Java Script file is used for quiz response
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

/*
 * ...................All below function are all for High chart for Normal quiz  ..................
 */


function showResponsesDialog(QuestionID) {	
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("ResponseDialog").innerHTML = xmlhttp.responseText;
			document.getElementById("ResponseDialog").style.visibility = 'visible';
			document.getElementById("ResponseDialog").title ="Responses";
			$("#ResponseDialog").dialog({height: 400, width: 600, modal: true});
		}
	};	
	xmlhttp.open("GET", "../../jsp/quiz/responsehelper.jsp?helpContent=responseDialog&quiztype=normalquiz&questionid="+QuestionID, true);
	xmlhttp.send();
}



/* This display the individual question chart on click of question bar of highcharts overall response
 * along with question detail at one side and at other it show chart and once click on chart it display table with student response
 */

function getHighChart(instrid, questionID,ChartType){
	var qid=questionID-1;
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var quiz = xmlhttp.responseText;
			var quizJson = JSON.parse(quiz);
			var images="";
			var questiondetail="";
			
			questiondetail += "<div style='width: 560px; height: 230px; background-color:white;'>Question : "+(qid+1)+"<br/><br/> "+quizJson.questions[qid].text.replace(/</g,"&lt;") +"<ol>";
				for(var j=0;j<quizJson.questions[qid].options.length;j++){
					questiondetail += "<li>" +quizJson.questions[qid].options[j].optiontext.replace(/</g,"&lt;")+ "</li>";
				}
				questiondetail +="</div>";
				images += "</ol><img style='width: 440px; height: 250px;' alt='No Response...' src='../../"+instrid+"/Chart"+qid+".jpeg?"+new Date().getTime()+"' onclick='showResponsesDialog("+quizJson.questions[qid].id+")'>";
			
			document.getElementById("questiondetails").innerHTML = questiondetail;	
			document.getElementById("Questionchart").innerHTML = images;	
			
		}
	};
	xmlhttp.open("GET", "../../generateResponseChart?quiztype=normalquiz&charttype="+ChartType, false);
	xmlhttp.send();
}


/*
 * This below functions are used for reloading the chart again after some interval , 
 * so that if an later response are received then they can also be included in chart.
 */

var reloadnormalhighchartmqcount=0;
var reloadnormalhighchartcount=0;
function updateNormalHighChart(instrid, questionids,isShowAns){
	reloadnormalhighchart=setInterval(function(){getNewNormalHighChart(instrid, questionids, isShowAns);},5000);
}

function getNewNormalHighChart(instrid, questionids, isShowAns){
	reloadnormalhighchartmqcount++;
	if(reloadnormalhighchartmqcount>=2){
		document.getElementById("loading").innerHTML = "";
		clearInterval(reloadnormalhighchart);
	}
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var chartString = xmlhttp.responseText;
			var stringArray=chartString.split("@");
			reloadoverallGraph(questionids,stringArray[0],stringArray[1],stringArray[2],instrid, isShowAns);
		
		}
	};
	xmlhttp.open("GET", "../../jsp/quiz/responsehelper.jsp?helpContent=responseCount&quiztype=normalquiz&questionid=null", false);
	xmlhttp.send();
}




/*
 * This below function display the overall response for all question of a particular quiz using highchart
 */

function overallGraph(questionids,rightcount,wrongcount,noresponsecount,instrid, isShowAns){
	//Calculation for overall quiz performance
	var rightans=rightcount.split(",");
	var wrongans=wrongcount.split(",");
	var noresponseans=noresponsecount.split(",");
	var righttotal=0,wronganstotal=0;	
	for(var p=0;p<rightans.length;p++){
		righttotal+=parseInt(rightans[p]);
		wronganstotal+=(parseInt(wrongans[p])+parseInt(noresponseans[p])+parseInt(rightans[p]));
		
	}
	var totalcorrect=0;
	var totalwrong=0;	
	totalcorrect= Math.round(((righttotal/wronganstotal)*100)*100)/100 ;
	totalwrong =Math.round((100- totalcorrect)*100)/100;
	var ChartType="withoutcorrect";
	if(isShowAns){overallQuizPerformance(totalcorrect,totalwrong);ChartType="withcorrect";}
	document.getElementById("showCorrectAnsChart").checked=isShowAns;	
	var questions =questionids.split("@") ;
	var rightarray=JSON.parse("[" + rightcount + "]");
	var wrongarray=JSON.parse("[" + wrongcount + "]");
	var noresponsearray=JSON.parse("[" + noresponsecount + "]");
	var questiontext="";
	for(var i=0;i<questions.length-1;i++){
		if(i==questions.length-2){
			questiontext+="Q."+[i+1]+"";
			
		}else if(i==0){
			questiontext+="Q."+[i+1]+",";
		}
		else{
			questiontext+="Q."+[i+1]+",";
		}
		
	}
		var x_axis_id=questiontext.split(",");
		if(isShowAns){
			Highcharts.setOptions({
				colors: ['#00FF00', '#FF0000 ','#C0C0C0 ']
			});
		}else{
			Highcharts.setOptions({
				colors: ['#FF0000', '#FF0000 ','#C0C0C0 ']
			});
		}
		var options = {chart: {
                type: 'column',
            },
            title: {
                text: '',
                style: {
                    fontWeight: 'bold',
                    fontSize: '26px',
                    color: '#000000'
                }
      
            },
            xAxis: {
                categories: x_axis_id,
                title: {
                    text: 'Questions',
                    style: {
 	                   
	                    fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
	                }
                },
                labels: {
                    style: {
                    	fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Responses',
                    style: {
	 	                   
	                    fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
	                }
                },
                labels: {
                    style: {
                    	fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
                    }
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        fontSize: '16px',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -70,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                	if(isShowAns){
	                    return '<b>'+ this.x +'</b><br/>'+
	                        this.series.name +': '+ this.y +'<br/>'+
	                        'Total: '+ this.point.stackTotal;
	               	}else{
	               		return '<b>'+ this.x +'</b><br/>'+	                        
	                        'Total: '+ this.point.stackTotal;	                		
	                }
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                        style: {
                            textShadow: '0 0 3px black, 0 0 3px black',
                            fontWeight: 'bold',
	                        fontSize: '14px'
                        }
                    }
                },
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function() {
	                        	var qid=this.category.split(".");
	                        		getHighChart(instrid, qid[1], ChartType);
	                        	
	                        }
	                    }
	                }
	            }
	            
	            },
	            series: [{
	                name: 'Right',
	                data: rightarray
	            }, {
	                name: 'Wrong',
	                data: wrongarray
	            },{
	                name: 'No Response',
	                data: noresponsearray
	            }]
	        };
		if(!isShowAns){
			options.legend["enabled"]=false;
		}
		$('#overallchart').highcharts(options);	    
	    updateNormalHighChart(instrid, questionids, isShowAns); // call for reload of chart
	   
}


/*
 * This below function ic created inorder to reload highchart again with new values in case of new response received
 *  It display the overall response for all question of a particular quiz using highchart as above function
 */

function reloadoverallGraph(questionids,rightcount,wrongcount,noresponsecount,instrid, isShowAns){
	
	//Calculation for overall quiz performance
	var rightans=rightcount.split(",");
	var wrongans=wrongcount.split(",");
	var noresponseans=noresponsecount.split(",");
	var righttotal=0,wronganstotal=0;
	
	for(var p=0;p<rightans.length;p++){
		righttotal+=parseInt(rightans[p]);
		wronganstotal+=(parseInt(wrongans[p])+parseInt(noresponseans[p])+parseInt(rightans[p]));
		
	}
	var totalcorrect=0;
	var totalwrong=0;	
	totalcorrect= Math.round(((righttotal/wronganstotal)*100)*100)/100 ;
	totalwrong =Math.round((100- totalcorrect)*100)/100;	
	var ChartType="withoutcorrect";
	if(isShowAns){overallQuizPerformance(totalcorrect,totalwrong);ChartType="withcorrect";}
	var questions =questionids.split("@") ;
	var rightarray=JSON.parse("[" + rightcount + "]");
	var wrongarray=JSON.parse("[" + wrongcount + "]");
	var noresponsearray=JSON.parse("[" + noresponsecount + "]");
	var questiontext="";
	for(var i=0;i<questions.length-1;i++){
		if(i==questions.length-2){
			questiontext+="Q."+[i+1]+"";
			
		}else if(i==0){
			questiontext+="Q."+[i+1]+",";
		}
		else{
			questiontext+="Q."+[i+1]+",";
		}
		
	}
		var x_axis_id=questiontext.split(",");
		if(isShowAns){
			Highcharts.setOptions({
				colors: ['#00FF00', '#FF0000 ','#C0C0C0 ']
			});
		}else{
			Highcharts.setOptions({
				colors: ['#FF0000', '#FF0000 ','#C0C0C0 ']
			});
		}
		var options ={
            chart: {
                type: 'column',
            },
            title: {
                text: '',
                style: {
                    fontWeight: 'bold',
                    fontSize: '26px',
                    color: '#000000'
                }
      
            },
            xAxis: {
                categories: x_axis_id,
                title: {
                    text: 'Questions',
                    style: {
 	                   
	                    fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
	                }
                },
                labels: {
                    style: {
                    	fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Responses',
                    style: {
	 	                   
	                    fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
	                }
                },
                labels: {
                    style: {
                    	fontWeight: 'bold',
	                    fontSize: '16px',
	                    color: '#000000'
                    }
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        fontSize: '16px',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -70,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {                    
                    if(isShowAns){
	                    return '<b>'+ this.x +'</b><br/>'+
	                        this.series.name +': '+ this.y +'<br/>'+
	                        'Total: '+ this.point.stackTotal;
	               	}else{
	               		return '<b>'+ this.x +'</b><br/>'+	                        
	                        'Total: '+ this.point.stackTotal;	                		
	                }
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                        style: {
                            textShadow: '0 0 3px black, 0 0 3px black',
                            fontWeight: 'bold',
	                        fontSize: '14px'
                        }
                    }
                },
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function() {
	                        	var qid=this.category.split(".");
	                        		getHighChart(instrid, qid[1],ChartType);
	                        	
	                        }
	                    }
	                }
	            }
	            
	            },
	            series: [{
	                name: 'Right',
	                data: rightarray
	            }, {
	                name: 'Wrong',
	                data: wrongarray
	            },{
	                name: 'No Response',
	                data: noresponsearray
	            }]
	        };
		if(!isShowAns){
			options.legend["enabled"]=false;
		}
		$('#overallchart').highcharts(options);
	    //updateNormalHighChart(instrid, questionids); // call for reload of chart
	   
}


/*
 * This below function show the semi pie chart for displaying the overall performance of quiz in percentage 
 * as correct and wrong percentage
 */

function overallQuizPerformance(totalcorrect,totalwrong){
	Highcharts.setOptions({
	  colors: ['#00FF00','#FF0000 ']
	});	
   $('#performance').highcharts({
       chart: {
           plotBackgroundColor: null,
           plotBorderWidth: 0,
           plotShadow: false
       },
       title: {
           text: 'Overall Quiz Performance',
           align: 'center',
           verticalAlign: 'middle',
           y: 50,
	    style: {fontSize: '16px',fontFamily: 'Arial, Helvetica, Sans-Serif',color:'black',fontWeight:'bold'}
       },
	 tooltip: {
		 formatter: function() {
	            return this.point.name + " (" + this.percentage + "%)";
	        }
       },
       plotOptions: {
           pie: {
        	   
                   size: 150,
              
               dataLabels: {
                   enabled: true,
                   distance: -20,
                   style: {fontSize: '10px',fontFamily: 'Arial, Helvetica, Sans-Serif',color:'white',fontWeight:'bold'}
               },  
               startAngle: -90,
               endAngle: 90,
               center: ['50%', '55%']
           }
       },
       series: [{
           type: 'pie',
           name: 'Response',
           innerSize: '30%',
           data: [                  
              ['Correct',totalcorrect],['Wrong',totalwrong]
           ]
       }]
   });
   if(isNaN(totalcorrect)||isNaN(totalwrong)){
	   totalcorrect=0;
	   totalwrong=0;
   }
   var percentage="<div style='width:20px; height:20px;background-color: #00FF00;border:5px ; float:left ;'></div><div style=' float:left'>&nbsp;&nbsp;&nbsp;Correct:<b> "+totalcorrect+" "+"%"+"</b></div><br><br><div style='width:20px; height:20px;background-color: #FF0000;border:5px ; float:left ;'></div><div style=' float:left'>&nbsp;&nbsp;&nbsp;Wrong:<b> "+totalwrong+" "+"%"+"</b></div>";
   document.getElementById("percentage").innerHTML = percentage;
}

function showCAnsChart(showCorrectAnsChart){
	if(showCorrectAnsChart.checked){
		window.location = "../../jsp/quiz/newresponsechart.jsp?isShowAns=true";
	}else{
		window.location = "../../jsp/quiz/newresponsechart.jsp?isShowAns=false";
	}
}