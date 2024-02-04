function changePage(form, page){
	form.pagina.value = page;
	form.submit();
}

function changeGroup(form, group, page){
	form.pagina.value = page;
	form.group.value = group;
	form.submit();
}

function cal(datafield) {
	setDateField(datafield);
	top.newWin=window.open("<%=request.getContextPath()%>/js/calendar/calendar.html","cal","toolbar=no,location=no,directories=no,status=no,resizable=no,menubar=no,scrollbars=no,width=250,height=250");
}

function openWindow(Path,w,h){
	var defparam="left=100,top=100,toolbar=no,location=no,directories=no,status=no,resizable=no,dependent=yes,menubar=no,scrollbars=yes";
	var customparam = defparam + ",width="+w+",height="+h+",titlebar=no";
	searchWin = window.open(Path,"",customparam);
}

function closeWindow(){
	self.close();
	return true;
}

function popolaCountry(area_id, country_id)
{
    var ajax = assegnaXMLHttpRequest();
    if(ajax) {
        var area_def = "";
		var country_def = "";
        var area = area_id;
		var country = country_id;
        for(var i=0; i < area.length; i++)
            if(area[i].checked){
                area_def += ","+area[i].value;
            }
        area_def = area_def.substring(1);
		if(country!=null){
			for(var i=0; i < country.length; i++)
				if(country[i].checked){
					country_def += ","+country[i].value;
				}
			country_def = country_def.substring(1);
		}

        ajax.open("get", '<%=request.getContextPath()%>/include/getCountries.jsp?area_id_search='+area_def+'&country_checked='+country_def, true);
        ajax.setRequestHeader("connection", "close");
        ajax.onreadystatechange = function() {
            if(ajax.readyState == 4)
            {
                varresult = ajax.responseText;
				td_country = document.getElementById('country');
                if(varresult!='')
                    td_country.innerHTML = varresult;
            }
        }
        ajax.send(null);
    }
}