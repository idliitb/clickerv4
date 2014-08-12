<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Quiz Questions</title>
  <link type="text/css" rel="stylesheet" href="../../css/student.css">
  <link rel="stylesheet" href="../../js/jquery-ui.css">
  <script src="../../js/jquery-1.9.1.js"></script>
  <script src="../../js/jquery-ui.js"></script>

  <script>
  $(function() {
    $( "#tabs" ).tabs();
  });
  </script>
  <style>
  #tabs{
 
  width:1750px;
  height:750px;  
  margin-top:10px;
  margin-left:-230px;
  
  
  
  }
  #tabs li{
  background-color:#9bbb59;
  }
  
  </style>
</head>
<body>
 <table id="timertable" style="margin-left:-230px; height: 100px; width:1755px;" border="0">
 <tr>
 <td>Total Question : 10</td>
 <td>timer</td>
 <td>Attempted : 4</td>
 </tr>
 
 </table>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">Q1</a></li>
    <li><a href="#tabs-2">Q2</a></li>
    <li><a href="#tabs-3">Q3</a></li>
    <li><a href="#tabs-1">Q4</a></li>
    <li><a href="#tabs-2">Q5</a></li>
    <li><a href="#tabs-3">Q6</a></li>
    <li><a href="#tabs-1">Q7</a></li>
    <li><a href="#tabs-2">Q8</a></li>
    <li><a href="#tabs-3">Q9</a></li>
 
  </ul>
  <div id="tabs-1">
    <p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
  </div>
  <div id="tabs-2">
    <p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
  </div>
  <div id="tabs-3">
    <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
    <p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
  </div>
</div>
<div style="margin-top:20px; margin-left:-230px; height: 100px; width:1755px;">

	<button id="deselect" type="submit" class="ui-loginbutton" style=" float:left;" onclick="window.location.href='home.jsp'">
		 	<span >Deselect</span>
	 </button>
	 		
	 <button id="submit" type="submit" class="ui-loginbutton" style="float:right;" onclick="window.location.href='home.jsp'">
		 	<span >Submit</span>
	 </button>
	 		
</div>


 
 
</body>
</html>