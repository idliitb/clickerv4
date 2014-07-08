var d_n,h,ins_id;

var xmlhttp;

//This method will get the XMLHTTP object for work with ajax
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

function search_result_course()
{
	var search=document.getElementById("search_box").value;
	if(search=="")
	{
	alert("enter the name!!");
	return false;
	}
	$("#my_table").remove();
	document.getElementById("addnew").style.visibility='hidden';
	var xmlhttp;
	if (window.XMLHttpRequest)
	  { 
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    document.getElementById("wrapper").innerHTML=xmlhttp.responseText;
	    }
	  }
	xmlhttp.open("GET","search.jsp?search="+search+"&type=course",true);
	xmlhttp.send();
}	
function add_new()
{	
	document.getElementById("hid7").value = 1;
	document.getElementById("hid8").value = 1;
	if(document.getElementById("hid11").value == 1 || document.getElementById("hid12").value == 1)
	{
	alert("Please save first");
	}
	else {
	var l = document.getElementById("count").value;
	/*for(var i=1;i<l;i++)
	{
		document.getElementById("e_"+i).removeAttribute("onClick");
	}*/
	//document.getElementById("addnew").removeAttribute("onClick");
	$('#my_table > tbody:last').after('<tr><td width= "21%"><input type="text" id="new_value_1" name="new_value_1"  size= "12"  style="border:none "/></td><td width= "21%"><input type="text" style="border:none " id="new_value_2" name="new_value_2" size= "10"/></td><td width= "20%"><input type="text" style="border:none " id="new_value_3" name="new_value_3" size= "8"/></td><td width= "7%"><select name="new_value_4" id="new_value_4"></select></td><td width= "6%"><img src="save.jpg" height="32" width="32" value = "s" onclick= "s_add()" alt="button" title = "Save"></td><td width="6%"><img src="del.png" height="37" width="37"value="cancel" title = "Cancel" onClick="window.location.reload()"/></td></tr>');
	$('#dept option').clone().appendTo('#new_value_4');
	document.getElementById("new_value_1").focus();
	}
	document.getElementById("hid11").value = 1;
}
function s_add()
{
	document.getElementById("hid").value = "2";
	if(document.getElementById("new_value_1").value== "")
	{
		alert("Please Enter the Course ID!!!");
		return false;
	}
	else if(document.getElementById("new_value_2").value== "")
	{
		alert("Please Enter the Course Name  !!!");
		return false;
	}
	else if(document.getElementById("new_value_3").value== "")
	{
		alert("Please Enter the Description !!!");
		return false;
	}
	else if(document.getElementById("new_value_4").value== "")
	{
		alert("Please Enter the Dept ID !!!");
		return false;
	}
	//alert("s_add");
	document.forms["my_form"].submit();
}

function edit_value_course(n)
{
	document.getElementById("hid7").value = 1;
	document.getElementById("hid12").value = 1;
	var l = document.getElementById("count").value;
	
	/*for(var i=1;i<l;i++)
	{
		document.getElementById("e_"+i).removeAttribute("onClick");
	}*/
	//document.getElementById("addnew").removeAttribute("onClick");
	//alert("check");
	
	if(document.getElementById("hid8").value == 1)
	{
	alert("Please save!!");
	}
else {
	
	d_id =  $('tr#check_'+n).find('td#td1_'+n).html();
	d_n =  $('tr#check_'+n).find('td#td2_'+n).html();
	h =  $('tr#check_'+n).find('td#td3_'+n).html();
	ins_id =  $('tr#check_'+n).find('td#td4_'+n).html();
	$('#my_table tr#check_'+n).append('<td width = "1%"><img src="save.jpg" height="32" width="32" value = "s" onclick= "save_values()" alt="Save" title = "Save"/></td>');
	$('#check_'+n+ ' td#td1_'+n).empty();
	$('#check_'+n+ ' td#td1_'+n).append('<input type="text" id="cid" name = "edit_txt1"  size= "12" style = "border:none; width:50px;" readonly/>');
	document.getElementById("cid").value = d_id;
	$('#check_'+n+ ' td#td2_'+n).empty();	
	$('#check_'+n+ ' td#td2_'+n).append('<input type="text" id="cname" name = "edit_txt2" size= "10" style = "border:none; width:150px;"/>');
	document.getElementById("cname").value = d_n;
	document.getElementById("cname").focus();
	$('#check_'+n+ ' td#td3_'+n).empty();
	$('#check_'+n+ ' td#td3_'+n).append('<input type="text" id="desc" size= "8" name = "edit_txt3" style = "border:none; width:150px;"/>');
	document.getElementById("desc").value = h;
	$('#check_'+n+ ' td#td4_'+n).empty();
	$('#check_'+n+ ' td#td4_'+n).append('<select name="edit_txt4" id="deptid" style = "width:90px;"></select>');
	$('#dept option').clone().appendTo('#deptid');
	//$('tr#check_'+n+ ' td#td4_'+n).fter('<td>hello</td>');
	}
	document.getElementById("hid8").value = 1;
}
function save_values()
{
	document.getElementById("hid").value = "1";
	if(document.getElementById("cid").value == "" )
	{
		alert("Please Enter the Course ID!!!");
		return false;
	}
	else if(document.getElementById("cname").value== "")
	{
		alert("Please Enter the Course Name  !!!");
		return false;
	}
	else if(document.getElementById("desc").value== "")
	{
		alert("Please Enter the Description !!!");
		return false;
	}
	else if(document.getElementById("deptid").value== "")
	{
		alert("Please Enter the Dept ID !!!");
		return false;
	}
	
	if(d_n == document.getElementById("cname").value && h == document.getElementById("desc").value && ins_id == document.getElementById("deptid").value)
		{
			
			var r=confirm("You are not done any changes. Do u want to close edit?");
			if (r==true)
			  {
				//document.forms["my_form"].submit();
				window.location = "./courses.jsp";
				return true;
			  }
			else
			  {
				return false;
			  }
		}
	
	
	document.forms["my_form"].submit();
}
function delete_value_course(a){
	
	if(document.getElementById("hid7").value == 1)
		{ 
			alert("Plese save first !!");
		}
	else {
	document.getElementById("hid").value = "3" ;
	var where_to= confirm("Do you really want to delete?");
	if (where_to != true)
	 {
		return false;
	}
	}
    var c_id =  $('tr#check_'+a).find('td#td1_'+a).html();
    /*var c_name =  $('tr#check_'+a).find('td#td2_'+a).html();
    var desc =  $('tr#check_'+a).find('td#td3_'+a).html();
    var d_id =  $('tr#check_'+a).find('td#td4_'+a).html();*/
    
  //  $('tr#check_'+a).remove();   
    
    getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resps = xmlhttp.responseText;
			alert(resps);
			window.location = "../../jsp/admin/courses.jsp";
		}
	};
	 document.getElementById("hid7").value = 0; // ajay
	xmlhttp.open("GET",	"../../jsp/admin/course_conn.jsp?hid=3&hid1="+encodeURIComponent(c_id), true);
	xmlhttp.send();
    
    
    
    
    //document.getElementById("hid1").value = c_id;
   // document.forms["my_form"].submit();      
    //document.getElementById("hid7").value = 0; // ajay
	
	
    }