<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
    <TITLE><%=Constants.pageTitle%></TITLE>
    <LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
    <SCRIPT src="<%=request.getContextPath()%>/js/ajax.js"></SCRIPT>
    <SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
    <SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
    <SCRIPT language="javascript">
        function submitForm(){
            if(document.section_form.format.value == 'web')
                document.section_form.action="<%=request.getContextPath()%>/clippings/searchResult.jsp";
            else
                document.section_form.action="<%=request.getContextPath()%>/clippings/searchResultXLS.jsp";
            document.section_form.submit();
        }
        function setFocus(){
            <%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
                document.section_form.area_id_search[0].focus();
            <%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
                document.section_form.country_id_search.focus();
            <%}else{%>
                document.section_form.audience_id_search.focus();
            <%}%>
        }
        function reloadForm(){
            document.section_form.action="<%=request.getContextPath()%>/clippings/search.jsp";
            document.section_form.submit();
        }
        function goToInsert(){
            document.location.href="<%=request.getContextPath()%>/clippings/insert.jsp";
        }
        function resetForm(){
            document.location.href = "<%=request.getContextPath()%>/clippings/search.jsp";
        }
    </SCRIPT>
</HEAD>

<%
String[] area_id_search = (request.getParameterValues("area_id_search")==null)?new String[0]:request.getParameterValues("area_id_search");
String[] country_id_search = (request.getParameterValues("country_id_search")==null)?new String[0]:request.getParameterValues("country_id_search");
if(area_id_search.length > 0 && area_id_search[0].contains(","))
	area_id_search = area_id_search[0].split(",");
if(country_id_search.length > 0 && country_id_search[0].contains(","))
	country_id_search = country_id_search[0].split(",");

Vector searchedAreasVector = new Vector();
Vector searchedCountriesVector = new Vector();
for (int i = 0; i < area_id_search.length; i++) {
	searchedAreasVector.add(area_id_search[i]);
}
for (int i = 0; i < country_id_search.length; i++) {
	searchedCountriesVector.add(country_id_search[i]);
}

String publication_id_search = (request.getParameter("publication_id_search")==null)?"":request.getParameter("publication_id_search");
String audience_id_search = (request.getParameter("audience_id_search")==null)?"":request.getParameter("audience_id_search");
String title_search = (request.getParameter("title_search")==null)?"":request.getParameter("title_search");
String fieldstory_id_search = (request.getParameter("fieldstory_id_search")==null)?"":request.getParameter("fieldstory_id_search");
String datepublished_from_search = (request.getParameter("datepublished_from_search")==null)?"":request.getParameter("datepublished_from_search");
String datepublished_to_search = (request.getParameter("datepublished_to_search")==null)?"":request.getParameter("datepublished_to_search");
String lengthofarticle_id_search = (request.getParameter("lengthofarticle_id_search")==null)?"":request.getParameter("lengthofarticle_id_search");
String tone_id_search = (request.getParameter("tone_id_search")==null)?"":request.getParameter("tone_id_search");
String graphic_id_search = (request.getParameter("graphic_id_search")==null)?"":request.getParameter("graphic_id_search");
String cover_id_search = (request.getParameter("cover_id_search")==null)?"":request.getParameter("cover_id_search");
String score_search = (request.getParameter("score_search")==null)?"":request.getParameter("score_search");
String format = (request.getParameter("format")==null)?"":request.getParameter("format");
String id_role = user.getId_role();
String areaDescription = "";
String countryDescription = "";
if(user.getAreas().size() == 1){
	area_id_search = new String[1];
	area_id_search[0] = user.getAreas().firstElement().toString();
	areaDescription = DbUtils.getAreaDescription(area_id_search[0]);
}
if(user.getCountries().size() == 1){
	country_id_search = new String[1];
    country_id_search[0] = user.getCountries().firstElement().toString();
	countryDescription = DbUtils.getCountryDescription(country_id_search[0]);
}

Vector areas = DbUtils.getAreas(user.getAreas());
Vector countries = DbUtils.getCountriesByAreas(area_id_search);
Vector publications = DbUtils.getPublicationsByAreas(area_id_search, country_id_search, audience_id_search);
Vector fieldStories = DbUtils.getFieldStories();
Vector lengths = DbUtils.getLengths();
Vector tones = DbUtils.getTones();
Vector graphics = DbUtils.getGraphics();
Vector covers = DbUtils.getCovers();
Vector audiences = DbUtils.getAudiences();

Vector selectedCountries = new Vector();
for (int j = 0; j < country_id_search.length; j++) {
	selectedCountries.add(country_id_search[j]);
}
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

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
    <%@ include file="/include/header.jsp" %>
    <TR>
        <TD class="td_content">
            <TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
                <jsp:include page="/include/welcomeMessage.jsp">
                    <jsp:param name="section_help" value="clippings"/>
                </jsp:include>
                <TR>
                    <TD class="text_13_blu"><B>CLIPPINGS - SEARCH CLIPPING</B></TD>
                </TR>
                <TR>
                    <TD>
                        <FORM name="section_form" action="<%=request.getContextPath()%>/clippings/search.jsp" method="POST">
                        <INPUT type="hidden" name="operation" value="">
                        <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                            <TR><TD>&nbsp;</TD></TR>
                                <TR>
									<TD>
										<TABLE width="90%" border="0" cellspacing="0" cellpadding="6" align="center" id="search_form">
											<TR>
												<TD width="20%" class="text_12_black"><B>Area</B></TD>
												<TD width="80%" class="text_12_black" colspan="2" align="left">
												<%if(id_role.equals(Constants.idRoleAdmin)){%>
													  <ul style="padding: 0px; list-style: none; margin: 0px;">
														<%for(int i=0; i < areas.size(); i++) {
															checked = "";
															String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
															String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
															if(searchedAreasVector.contains(areaId))
																checked = "checked";
														%>
														<li style="display:inline-block;float: left; width:140px; list-style: none;"><input title="<%=areaDesc%>" value="<%=areaId%>" <%=checked%> name="area_id_search" type="checkbox" onclick="javascript:popolaCountry(document.section_form.area_id_search,document.section_form.country_id_search);"/><%=areaDesc%></li>
														<%}%>
													  </ul>
												<%}else if(areas.size() > 1 && !id_role.equals(Constants.idRoleAdmin)){%>
													<SELECT name="area_id_search" class="select" onchange="javascript:reloadForm()">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < areas.size(); i++){
															String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
															String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
														%>
														<OPTION value="<%=areaId%>" <%=(searchedAreasVector.contains(areaId))?"selected":""%>><%=areaDesc%></OPTION>
														<%}%>
													</SELECT>
												 <%} else {%>
													<%=areaDescription%>
													<INPUT type="hidden" name="area_id_search" value="<%=area_id_search[0]%>">
												<%}%>
												</TD>
											</TR>
											<TR height="85px">
												<TD class="text_12_black"><B>Country</B></TD>
												<TD class="text_12_black" colspan="2" id="country">
												<%if(id_role.equals(Constants.idRoleAdmin)){%>
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
													<tr><td height="5px"><!-- --></td></tr>
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
												<%}else if(id_role.equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
													<INPUT type="hidden" name="country_id_search" value="<%=country_id_search[0]%>">
													<%=countryDescription%>
												<%}else if(!id_role.equals(Constants.idRoleAdmin)){%>
													<SELECT name="country_id_search" class="select" onchange="javascript:reloadForm()">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < countries.size(); i++){
															String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
															String countryDesc = ((Hashtable)countries.elementAt(i)).get("country").toString();
															if(!user.getCountries().contains(countryId) && !id_role.equals(Constants.idRoleManager)){
																continue;
															}
														%>
														<OPTION value="<%=countryId%>" <%=(searchedCountriesVector.contains(countryId))?"selected":""%>><%=countryDesc%></OPTION>
														<%}%>
													</SELECT>
												<%}else{%>
													
												<%}%>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Audience</B></TD>
												<TD colspan="2">
													<SELECT name="audience_id_search" class="select" onchange="javascript:reloadForm()">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < audiences.size(); i++){
															String audienceId = ((Hashtable)audiences.elementAt(i)).get("audienceid").toString();
															String audienceDesc = ((Hashtable)audiences.elementAt(i)).get("audience").toString();
														%>
														<OPTION value="<%=audienceId%>" <%=(audienceId.equals(audience_id_search))?"selected":""%>><%=audienceDesc%></OPTION>
													<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Publication</B></TD>
												<TD class="text_12_black" colspan="2" id="publication">
													<SELECT name="publication_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < publications.size(); i++){
															String publicationId = ((Hashtable)publications.elementAt(i)).get("publicationid").toString();
															String publicationDesc = ((Hashtable)publications.elementAt(i)).get("name").toString();
														%>
														<OPTION value="<%=publicationId%>" <%=(publicationId.equals(publication_id_search))?"selected":""%>><%=publicationDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Title</B></TD>
												<TD colspan="2"><INPUT type="text" name="title_search" value="<%=Utils.formatStringForView(title_search)%>" class="input_text" maxlength="255"></TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Type of Story</B></TD>
												<TD colspan="2">
													<SELECT name="fieldstory_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < fieldStories.size(); i++){
															String fieldStoryId = ((Hashtable)fieldStories.elementAt(i)).get("fieldstoryid").toString();
															String fieldStoryDesc = ((Hashtable)fieldStories.elementAt(i)).get("fieldstory").toString();
														%>
														<OPTION value="<%=fieldStoryId%>" <%=(fieldStoryId.equals(fieldstory_id_search))?"selected":""%>><%=fieldStoryDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Date</B></TD>
												<TD class="text_12_black">
													From&nbsp;
													<INPUT type="text" name="datepublished_from_search" value="<%=datepublished_from_search%>" class="input_text_small" maxlength="12">
													<A href="javascript: cal(document.section_form.datepublished_from_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
													&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
													<INPUT type="text" name="datepublished_to_search" value="<%=datepublished_to_search%>" class="input_text_small" maxlength="12">
													<A href="javascript: cal(document.section_form.datepublished_to_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
												</TD>
												<TD width="20%" class="text_12_black"><%=Constants.STRINGdateFormat%></TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Length of Article</B></TD>
												<TD colspan="2">
													<SELECT name="lengthofarticle_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < lengths.size(); i++){
															String lengthId = ((Hashtable)lengths.elementAt(i)).get("lengthid").toString();
															String lengthDesc = ((Hashtable)lengths.elementAt(i)).get("length").toString();
														%>
														<OPTION value="<%=lengthId%>" <%=(lengthId.equals(lengthofarticle_id_search))?"selected":""%>><%=lengthDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Tone</B></TD>
												<TD colspan="2">
													<SELECT name="tone_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < tones.size(); i++){
															String toneId = ((Hashtable)tones.elementAt(i)).get("toneid").toString();
															String toneDesc = ((Hashtable)tones.elementAt(i)).get("tone").toString();
														%>
														<OPTION value="<%=toneId%>" <%=(toneId.equals(tone_id_search))?"selected":""%>><%=toneDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Graphic</B></TD>
												<TD colspan="2">
													<SELECT name="graphic_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < graphics.size(); i++){
															String graphicId = ((Hashtable)graphics.elementAt(i)).get("graphicid").toString();
															String graphicDesc = ((Hashtable)graphics.elementAt(i)).get("graphic").toString();
														%>
														<OPTION value="<%=graphicId%>" <%=(graphicId.equals(graphic_id_search))?"selected":""%>><%=graphicDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Cover</B></TD>
												<TD colspan="2">
													<SELECT name="cover_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < covers.size(); i++){
															String coverId = ((Hashtable)covers.elementAt(i)).get("coverid").toString();
															String coverDesc = ((Hashtable)covers.elementAt(i)).get("cover").toString();
														%>
														<OPTION value="<%=coverId%>" <%=(coverId.equals(cover_id_search))?"selected":""%>><%=coverDesc%></OPTION>
														<%}%>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Score</B></TD>
												<TD colspan="2"><INPUT type="text" name="score_search" value="<%=score_search%>" class="input_text" maxlength="38"></TD>
											</TR>
											<TR>
												<TD class="text_12_black"><B>Format*</B></TD>
												<TD class="text_12_black" colspan="2" >
													<SELECT name="format" class="select">
														<OPTION value="web" <%=(format.equals("web"))?"selected":""%>>WEB</OPTION>
														<OPTION value="excel" <%=(format.equals("excel"))?"selected":""%>>EXCEL</OPTION>
													</SELECT>
												</TD>
											</TR>
											<TR>
												<TD colspan="3" class="text_12_black">* Required fields</TD>
											</TR>
										</TABLE>
									</TD>
                                </TR>
                                <TR><TD>&nbsp;</TD></TR>
                                <TR>
									<TD style="text-align:center;">
										<INPUT type="button" name="submit_form_button" value="Search Clipping" onclick="javascript:submitForm()" class="button">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<INPUT type="button" name="enter_clipping_button" value="Enter Clipping" onclick="javascript:goToInsert()" class="button">
									</TD>
                                </TR>
                        </TABLE>
                        </FORM>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <%@ include file="/include/footer.jsp" %>
</TABLE>

</BODY>

</HTML>