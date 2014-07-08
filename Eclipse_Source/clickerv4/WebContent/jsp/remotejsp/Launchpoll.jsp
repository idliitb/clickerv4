<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
		function callrest1(sid,o1) {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//alert(xmlhttp.responseText);				
				}
			};			
			xmlhttp.open("POST", "http://localhost:8080/clickerv4/rest/quiz/poll" , true);	
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			xmlhttp.send('poll_res={"stuid":"1255","option":1}&courseId=CSEWS01&mode=remote');
			//xmlhttp.send('questiontext=this is testing of CSE101 54&studentid=54&courseid=CSE101');

			//xmlhttp.open("POST", "http://10.129.50.216:8080/clickerv4/rest/quiz/replydoubt", true);	
			//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			//xmlhttp.send('studentid=3303&courseId=DB');
			
		}
		
		
		
		function callrest2(sid,o1) {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//alert(xmlhttp.responseText);				
				}
			};			
			xmlhttp.open("POST", "http://localhost:8080/clickerv4/rest/quiz/poll" , true);	
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			xmlhttp.send('poll_res={"stuid":"1256","option":0}&courseId=CSEWS01&mode=remote');
			//xmlhttp.send('questiontext=this is testing of CSE101&studentid=1328&courseId=CSE101');

			//xmlhttp.open("POST", "http://10.129.50.216:8080/clickerv4/rest/quiz/replydoubt", true);	
			//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			//xmlhttp.send('studentid=3303&courseId=DB');
			
		}
		
		function callrest3(sid,o1) {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//alert(xmlhttp.responseText);				
				}
			};			
			xmlhttp.open("POST", "http://localhost:8080/clickerv4/rest/quiz/poll" , true);	
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			xmlhttp.send('poll_res={"stuid":"103","option":0}&courseId=CSEWS01&mode=remote');
			//xmlhttp.send('questiontext=this is testing of CSE101&studentid=1328&courseId=CSE101');

			//xmlhttp.open("POST", "http://10.129.50.216:8080/clickerv4/rest/quiz/replydoubt", true);	
			//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			//xmlhttp.send('studentid=3303&courseId=DB');
			
		}
		
		function callrest4(sid,o1) {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//alert(xmlhttp.responseText);				
				}
			};			
			xmlhttp.open("POST", "http://localhost:8080/clickerv4/rest/quiz/poll" , true);	
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			xmlhttp.send('poll_res={"stuid":"17","option":0}&courseId=CSEWS01&mode=remote');
			//xmlhttp.send('questiontext=this is testing of CSE101&studentid=1328&courseId=CSE101');

			//xmlhttp.open("POST", "http://10.129.50.216:8080/clickerv4/rest/quiz/replydoubt", true);	
			//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send('courseId=cse&response={"stu_id":"3490","quizid":"q2","options":[{"optiontext":"1"},{"optiontext":"0"},{"optiontext":"34"},{"optiontext":"#13"}],"marks":0}');
			//xmlhttp.send('studentid=3303&courseId=DB');
			
		}

		</script>
</head>
<body>
<input type="button" value="poll_yes" onclick="callrest1(3,'A')">
<input type="button" value="poll_no" onclick="callrest2(3,'A')">
<input type="button" value="poll_yes" onclick="callrest3(3,'A')">
<input type="button" value="poll_no" onclick="callrest4(3,'A')">
</body>
</html>