<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*;"%>

<%
String[] area_id_search = request.getParameter("area_id_search")==null?new String[0]:request.getParameter("area_id_search").split(",");
String[] country_id_search = request.getParameter("country_checked")==null?new String[0]:request.getParameter("country_checked").split(",");
Vector selectedCountries = new Vector();
for (int j = 0; j < country_id_search.length; j++) {
	selectedCountries.add(country_id_search[j]);
}
Vector countries = DbUtils.getCountriesByAreas(area_id_search);
Iterator<String> areasEnum = null;
Enumeration<String> countriesEnum = null;
TreeMap<String,Hashtable<String,String>> areasCountries = new TreeMap();
for(int i=0; i < countries.size(); i++){
	String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
	String countryCode = ((Hashtable)countries.elementAt(i)).get("country_code").toString();
    String area = ((Hashtable)countries.elementAt(i)).get("area").toString();
	if(!areasCountries.containsKey(area)) {
		areasCountries.put(area, new Hashtable<String,String>());
	}
	areasCountries.get(area).put(countryId, countryCode);
}
areasEnum = areasCountries.keySet().iterator();
String checked = "";
%>


<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<%while(areasEnum.hasNext()) {
		String areaDesc = areasEnum.next();
		Hashtable countriesList = areasCountries.get(areaDesc);
		countriesEnum = countriesList.keys();
	%>
	<tr height="60px">
		<td width="25%" height="60px">
			<fieldset>
			<legend align="center"><b><%=areaDesc%></b></legend>
			<table width="100%" height="60px" border="0" cellpadding="0" cellspacing="0">
			<%while(countriesEnum.hasMoreElements()) {
				String countryId = countriesEnum.nextElement();
				String countryCode = countriesList.get(countryId).toString();
				checked = (selectedCountries.contains(countryId))?"checked":"";
			%>
				<tr>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%if(countriesEnum.hasMoreElements()) {
						countryId = countriesEnum.nextElement();
						countryCode = countriesList.get(countryId).toString();
						checked = (selectedCountries.contains(countryId))?"checked":"";
					%>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%} else {%>
					<td width="50%">&nbsp;</td>
					<%}%>
				</tr>
			<%}%>
			</table>
			</fieldset>
		</td>
		<%if(areasEnum.hasNext()) {
			areaDesc = areasEnum.next();
			countriesList = areasCountries.get(areaDesc);
			countriesEnum = countriesList.keys();
		%>
		<td width="25%" height="60px">
			<fieldset>
			<legend align="center"><b><%=areaDesc%></b></legend>
			<table width="100%" height="60px" border="0" cellpadding="0" cellspacing="0">
			<%while(countriesEnum.hasMoreElements()) {
				String countryId = countriesEnum.nextElement();
				String countryCode = countriesList.get(countryId).toString();
				checked = (selectedCountries.contains(countryId))?"checked":"";
			%>
				<tr>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%if(countriesEnum.hasMoreElements()) {
						countryId = countriesEnum.nextElement();
						countryCode = countriesList.get(countryId).toString();
						checked = (selectedCountries.contains(countryId))?"checked":"";
					%>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%} else {%>
					<td width="50%">&nbsp;</td>
					<%}%>
				</tr>
			<%}%>
			</table>
			</fieldset>
		</td>
		<%} else {%>
		<td width="25%">&nbsp;</td>
		<%}%>
		<%if(areasEnum.hasNext()) {
			areaDesc = areasEnum.next();
			countriesList = areasCountries.get(areaDesc);
			countriesEnum = countriesList.keys();
		%>
		<td width="25%" height="60px">
			<fieldset>
			<legend align="center"><b><%=areaDesc%></b></legend>
			<table width="100%" height="60px" border="0" cellpadding="0" cellspacing="0">
			<%while(countriesEnum.hasMoreElements()) {
					String countryId = countriesEnum.nextElement();
					String countryCode = countriesList.get(countryId).toString();
					checked = (selectedCountries.contains(countryId))?"checked":"";
				%>
				<tr>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%if(countriesEnum.hasMoreElements()) {
						countryId = countriesEnum.nextElement();
						countryCode = countriesList.get(countryId).toString();
						checked = (selectedCountries.contains(countryId))?"checked":"";
					%>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%} else {%>
					<td width="50%">&nbsp;</td>
					<%}%>
				</tr>
			<%}%>
			</table>
			</fieldset>
		</td>
		<%} else {%>
		<td width="25%">&nbsp;</td>
		<%}%>
		<%if(areasEnum.hasNext()) {
			areaDesc = areasEnum.next();
			countriesList = areasCountries.get(areaDesc);
			countriesEnum = countriesList.keys();
		%>
		<td width="25%" height="60px">
			<fieldset>
			<legend align="center"><b><%=areaDesc%></b></legend>
			<table width="100%" height="60px" border="0" cellpadding="0" cellspacing="0">
			<%while(countriesEnum.hasMoreElements()) {
				String countryId = countriesEnum.nextElement();
				String countryCode = countriesList.get(countryId).toString();
				checked = (selectedCountries.contains(countryId))?"checked":"";
			%>
				<tr>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%if(countriesEnum.hasMoreElements()) {
						countryId = countriesEnum.nextElement();
						countryCode = countriesList.get(countryId).toString();
						checked = (selectedCountries.contains(countryId))?"checked":"";
					%>
					<td width="50%">
						<input value="<%=countryId%>" <%=checked%> name="country_id_search" type="checkbox" /><%=countryCode%>
					</td>
					<%} else {%>
					<td width="50%">&nbsp;</td>
					<%}%>
				</tr>
			<%}%>
			</table>
			</fieldset>
		</td>
		<%} else {%>
		<td width="25%">&nbsp;</td>
		<%}%>
	</tr>
	<tr><td height="5px"></td></tr>
<%}%>
<%if(areasCountries.size() <= 0) {%>
<tr>
	<td>
		<table width="100%" border="0" height="70px" cellpadding="0" cellspacing="0">
			<tr>
				<td style="text-align: center; vertical-align: middle"><b>SELECT AREAS</b></td>
			</tr>
		</table>
	</td>
</tr>
<%}%>
</table>