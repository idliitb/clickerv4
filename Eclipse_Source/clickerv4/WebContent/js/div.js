function ShowPopup(divId, popupSetting, page) {

	var divElt = document.getElementById(divId);
	divElt.style.display = 'block';
	var element = divElt.parentElement;
	popupSetting = popupSetting || {};

	if (!popupSetting.width) {
		popupSetting.width = divElt.offsetWidth;
	};
	if (!popupSetting.height) {
		popupSetting.height = divElt.offsetHeight;
	};
	if (!popupSetting.title) {
		popupSetting.title = 'Dialog';
	};
	var table = document.createElement('table');
	table.setAttribute('id', 'table' + divId);
	table.setAttribute('cellspacing', '0');
	table.setAttribute('cellpadding', '0');
	var tr1 = document.createElement('tr');
	tr1.className = 'PopupHeader';
	var td1 = document.createElement('td');
	var table1 = document.createElement('table');
	var itr1 = document.createElement('tr');
	var itd1 = document.createElement('td');
	itd1.setAttribute('style',
			'width:'+popupSetting.width+'px;height:40px;background-color: #E46C0A;');
	var title_div = document.createElement("div");
	var wid=popupSetting.width-60;
	title_div.setAttribute('style',
			'width:'+wid+'px;height:40px;float:left;margin-top:15px;text-align:center;');
	var span1 = document.createElement('span');
	span1.innerHTML = popupSetting.title;
	span1.setAttribute('style',
			'font-size: 25px; font-weight: bold;background-color: #E46C0A');
	title_div.appendChild(span1);
	itd1.appendChild(title_div);
	var close_div = document.createElement("div");
	close_div.setAttribute('id', 'close_divID');
	close_div
			.setAttribute(
					'style',
					"height:40px;width:40px;margin-top:5px;background-image:url('../../img/Close_icon.png');float:right;");
	itd1.appendChild(close_div);
	itr1.appendChild(itd1);
	table1.appendChild(itr1);
	td1.appendChild(table1);
	tr1.appendChild(td1);
	table.appendChild(tr1);
	var tr2 = document.createElement('tr');
	var tdDynamic = document.createElement('td');
	tdDynamic.setAttribute('align', 'center');
	tdDynamic.setAttribute('style', 'padding-top: 10px; vertical-align:top;');
	var tempElt = document.createElement('div');
	tempElt.setAttribute('id', 'tempElt' + divElt.id);
	divElt.parentElement.insertBefore(tempElt, divElt);
	tdDynamic.appendChild(divElt);
	tr2.appendChild(tdDynamic);
	table.appendChild(tr2);
	var cssText = 'display: block; border:1px solid black;  z-index:92000; background-color:white; top:50%; left:50%;';
	cssText += 'width: ' + popupSetting.width + 'px; height: '
			+ popupSetting.height + 'px; margin-left: -'
			+ Math.round(popupSetting.width / 2) + 'px; margin-top: -'
			+ Math.round(popupSetting.height / 2) + 'px;';
	if (popupSetting.isFixed === true) {
		cssText += 'position: fixed;';
	} else {
		cssText += 'position: absolute;';
	}
	table.setAttribute('style', cssText);
	element.appendChild(table);
	var shadeElt = document.createElement('div');
	shadeElt.id = "ShadedBG";
	shadeElt.className = "ShadedBG";
	tempElt.appendChild(shadeElt);
	document.getElementById("close_divID").addEventListener("click",
			function() {
				ClosePopupDiv(divId, page);
			});
}

// Function to Close Div Popup
function ClosePopupDiv(divId, page) {
	if (page == 1) {		
		document.getElementById("register").disabled = false;
		document.getElementById("login_table").style.opacity = 1;
	} else if (page == 0){				
		document.getElementById("homemaintable").style.opacity = 1;		
		document.getElementById("homemaintable").style.pointerEvents = "visible";		
	}else if (page == 2){
		document.getElementById("main_container").style.opacity = 1;
		document.getElementById("main_container").style.pointerEvents = "visible";
	}
	var table = document.getElementById('table' + divId);
	if(table!=null){
		//var element = table.parentElement;
		var divElt = document.getElementById(divId);
		divElt.style.display = 'none';
		var tempElt = document.getElementById('tempElt' + divId);
		tempElt.parentElement.insertBefore(divElt, tempElt);
		table.parentElement.removeChild(table);
		table.setAttribute('style', 'display: none');
		tempElt.parentElement.removeChild(tempElt);
	}
}
