
ctr=0;
function loadQuestions(InstID, courseid){
	
	//alert("course: " + courseid);
	var xmlhttp, selector;
	var search = encodeURIComponent(document.getElementById("searchbox").value);
	if(document.getElementById("allquest").checked)
		selector = 01;
	else
		selector = 00;
	var val = (document.getElementById("questiontype").options[document.getElementById("questiontype").selectedIndex].value);
	//alert("qtype: " + val);
	var InstrID=InstID;
	if(window.XMLHttpRequest){
		xmlhttp=new XMLHttpRequest();
	}
	else{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{

		if(xmlhttp.readyState==4 && xmlhttp.status==200){

			document.getElementById("select1").innerHTML=xmlhttp.responseText;
			//removing options from select box 1 that are common in both select boxes
			var selectBox1 = document.getElementById("select1");
			var selectBox2 = document.getElementById("select2");
			var i,j;
			for(i=selectBox2.options.length-1;i>=0;i--){
				for(j=selectBox1.options.length-1;j>=0;j--){
					if(selectBox1.options[j].value==selectBox2.options[i].value)
						selectBox1.removeChild(selectBox1.options[j]);
				}
			}
		}
	}
	//alert("search" + encodeURIComponent(document.getElementById("searchbox").value));
	if(selector == 00)
		xmlhttp.open("GET","../../retrieveQuestions?question="+search + "&qtype=" + val+"&InstrID="+InstrID + "&selector=00&courseid=" + encodeURIComponent(courseid),true);
	else
		xmlhttp.open("GET","../../retrieveQuestions?question="+encodeURIComponent(document.getElementById("searchbox").value) + "&qtype=" + val+"&InstrID="+InstrID + "&selector=01&courseid=" + encodeURIComponent(courseid),true);
	xmlhttp.send();
}
function loadOptions(choice){
	var xmlhttp;
	if(window.XMLHttpRequest){
		xmlhttp=new XMLHttpRequest();
	}
	else{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			document.getElementById("optionsDiv").innerHTML=xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET","../../retrieveOptions?questionID="+(document.getElementById("select"+choice).options[document.getElementById("select"+choice).selectedIndex].value),true);
	xmlhttp.send();

}
function clearOptions(){
	document.getElementById("optionsDiv").innerHTML="";
}
function addOrRemove(choice){
	try{
		var i;
		var flag=false;
		var selectBox=document.getElementById("select"+choice);
		var secondBox=1+(choice%2);
		for(i=selectBox.options.length-1;i>=0;i--){
			if(selectBox.options[i].selected){
				flag=true;
				break;
			}
		}	
		if(!flag){
			alert("Select a question first");
			return;
		}
		if(choice==1){
			ctr++;
			document.getElementById("count").value=ctr;
		}
		var createdOption=document.createElement("option");
		createdOption.setAttribute("value", selectBox.options[selectBox.selectedIndex].value);
		createdOption.setAttribute("id", selectBox.options[selectBox.selectedIndex].value);



		if(choice==1){
			addHiddenField(selectBox.options[selectBox.selectedIndex].value);
		}
		else{
			for(i=selectBox.options.length-1;i>=0;i--){
				if(selectBox.options[i].selected)
					removeHiddenField(i+1);
			}	
		}
		createdOption.setAttribute("name", selectBox.options[selectBox.selectedIndex].value);
		createdOption.innerHTML=selectBox.options[selectBox.selectedIndex].text;
		document.getElementById("select"+secondBox).appendChild(createdOption);
		for(i=selectBox.options.length-1;i>=0;i--){
			if(selectBox.options[i].selected)
				selectBox.remove(i);
		}
		if(choice==2){
			ctr--;
			document.getElementById("count").value=ctr;
		}
	}catch(err){
		alert(err.message);
	}
}
function addHiddenField(val){
	try{
		var hiddenField=document.createElement("input");
		hiddenField.setAttribute("type","hidden");

		hiddenField.setAttribute("name", ""+ctr);
		hiddenField.setAttribute("id", "hidden"+ctr);
		hiddenField.setAttribute("value",""+val);
		var before=document.getElementById("createqbtn1");
		var par=before.parentNode;
		par.insertBefore(hiddenField,before);
	}catch(err){
		alert(err.message);
	}
}
function removeHiddenField(val){
	var i;
	for(i=val;i<ctr;i++)
	{	
		document.getElementById("hidden"+i).value=document.getElementById("hidden"+(i+1)).value;
	}
	var field=document.getElementById("hidden"+ctr);
	var par=field.parentNode;
	par.removeChild(field);
}


