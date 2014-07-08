<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashSet"%>
 <%@page import="clicker.v4.dashboard.*"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%

String CourseID = session.getAttribute("courseID").toString();;
// String CourseID = "CSE101";
// System.out.println("+===================================+");
String Data_load="[";

graphhelper GH = new graphhelper();


//GH.getstudentPersentage(CourseID,1);
HashSet<Integer> QuizID= new HashSet<Integer>();
QuizID = GH.getQuizid(CourseID);
int sam=QuizID.size();
//System.out.println("size of QuizID set=>"+sam);
float tt[] = new float[sam];
Iterator it = QuizID.iterator();
int k=0;
while (it.hasNext()){
	String nam=it.next().toString();
	int foo = Integer.parseInt(nam);
	//System.out.println("===>"+foo);
	tt[k]=GH.getstudentPersentage(CourseID, foo);
	k++;
}
int l=0;
Iterator it1 = QuizID.iterator();
while (it1.hasNext()){
	 String nam=it1.next().toString();
	 int ii=Integer.parseInt(nam);
	 String qname=GH.getQuizname(ii);					 
	 //System.out.println("Quiz ID:"+qname +"Percentage :"+tt[l]);
	 Data_load =Data_load+"{ label: '"+qname+"',y: "+tt[l]+"},";
	 l++;
}
Data_load=Data_load+"]";
//System.out.println(Data_load);
		

String data_detail="[{ label: 'sample mline', y: 50 },{ label: 'test', y: 20 },{ label: 'all type qustion', y: 38 },{ label: 'quiz 4', y: 45 }]";


%>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
  window.onload = function () {
	  var DD=<%=Data_load %>;
    var chart = new CanvasJS.Chart("chartContainer",
    {
      theme: "theme1",
      title:{
        text: "Student Performance",
      },
      axisX: {
    	label: "Quiz",
        interval:1,
        intervalType: "",
        
      },
      axisY:{
        includeZero: false
        
      },
      data: [
      {        
        type: "line",
        //lineThickness: 3,        
        dataPoints: DD
      },     
      
      ]
    });

chart.render();
}
</script>


</head>
<script type="text/javascript" src="canvasjs.min.js"></script>
<body >
<div id="chartContainer" style="height: 300px; width:500px;">
  </div>
</body>
</html>