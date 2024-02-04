<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.search_form.submit();
		}
		function reloadForm(){
			document.search_form.action="<%=request.getContextPath()%>/publications/search.jsp";
			submitForm();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.search_form.area_id_search.focus();
			<%}else{%>
				document.search_form.name_search.focus();
			<%}%>
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/publications/insert.jsp";
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.search_form.area_id_search.value = "";
			<%}%>
			document.search_form.name_search.value = "";
			document.search_form.last_rated_from_search.value = "";
			document.search_form.last_rated_to_search.value = "";
			document.search_form.audience_id_search.value = "";
			document.search_form.level_id_search.value = "";
			document.search_form.size_id_search.value = "";
			document.search_form.frequency_id_search.value = "";
			document.search_form.medium_id_search.value = "";
			<%if(!user.getId_role().equals(Constants.idRoleEndUser) || user.getCountries().size() != 1){%>
				document.search_form.country_id_search.value = "";
			<%}%>
			document.search_form.status_search.value = "";
		}
	</SCRIPT>
</HEAD>

<%
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String name_search = (request.getParameter("name_search")==null)?"":request.getParameter("name_search");
String last_rated_from_search = (request.getParameter("last_rated_from_search")==null)?"":request.getParameter("last_rated_from_search");
String last_rated_to_search = (request.getParameter("last_rated_to_search")==null)?"":request.getParameter("last_rated_to_search");
String audience_id_search = (request.getParameter("audience_id_search")==null)?"":request.getParameter("audience_id_search");
String level_id_search = (request.getParameter("level_id_search")==null)?"":request.getParameter("level_id_search");
String size_id_search = (request.getParameter("size_id_search")==null)?"":request.getParameter("size_id_search");
String frequency_id_search = (request.getParameter("frequency_id_search")==null)?"":request.getParameter("frequency_id_search");
String medium_id_search = (request.getParameter("medium_id_search")==null)?"":request.getParameter("medium_id_search");
String country_id_search = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");

String id_area = "";
String id_country = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(user.getCountries().size() == 1){
	id_country = user.getCountries().firstElement().toString();
}else{
	id_country = request.getParameter("country_id_search")==null?"":request.getParameter("country_id_search");
}
String areaDescription = DbUtils.getAreaDescription(id_area);
String countryDescription = DbUtils.getCountryDescription(id_country);

Vector areas = DbUtils.getAreas(user.getAreas());
Vector countries = new Vector();
Vector audiences = DbUtils.getAudiences();
Vector levels = DbUtils.getLevels();
Vector sizes = DbUtils.getSizes();
Vector frequencies = DbUtils.getFrequencies();
Vector mediums = DbUtils.getMediums();
if(request.getParameter("area_id_search")!=null){
	id_area = request.getParameter("area_id_search").toString();
	countries = DbUtils.getCountriesForAdminSearch(id_area);	
}else{
	countries = DbUtils.getCountries(id_area, user.getCountries(), "");
}
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="publications"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - SEARCH PUBLICATION</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/publications/searchResult.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
											<%if(areas.size() > 1){%>
												<SELECT name="area_id_search" class="select" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(id_area))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											<%}else{%>
												<%=areaDescription%>
												<INPUT type="hidden" name="area_id_search" value="<%=id_area%>">
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Name</B></TD>
											<TD colspan="2"><INPUT type="text" name="name_search" value="<%=Utils.formatStringForView(name_search)%>" class="input_text" maxlength="60"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date</B></TD>
											<TD class="text_12_black">
												From&nbsp;
												<INPUT type="text" name="last_rated_from_search" value="<%=last_rated_from_search%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.search_form.last_rated_from_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<INPUT type="text" name="last_rated_to_search" value="<%=last_rated_to_search%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.search_form.last_rated_to_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
											</TD>
											<TD width="20%" class="text_12_black"><%=Constants.STRINGdateFormat%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Audience</B></TD>
											<TD colspan="2">
												<SELECT name="audience_id_search" class="select">
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
											<TD class="text_12_black"><B>Level Of Press</B></TD>
											<TD colspan="2">
												<SELECT name="level_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < levels.size(); i++){
														String levelId = ((Hashtable)levels.elementAt(i)).get("levelid").toString();
														String levelDesc = ((Hashtable)levels.elementAt(i)).get("level").toString();
													%>
													<OPTION value="<%=levelId%>" <%=(levelId.equals(level_id_search))?"selected":""%>><%=levelDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Size</B></TD>
											<TD colspan="2">
												<SELECT name="size_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < sizes.size(); i++){
														String sizeId = ((Hashtable)sizes.elementAt(i)).get("sizeid").toString();
														String sizeDesc = ((Hashtable)sizes.elementAt(i)).get("size").toString();
													%>
													<OPTION value="<%=sizeId%>" <%=(sizeId.equals(size_id_search))?"selected":""%>><%=sizeDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Frequency</B></TD>
											<TD colspan="2">
												<SELECT name="frequency_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < frequencies.size(); i++){
														String frequencyId = ((Hashtable)frequencies.elementAt(i)).get("frequencyid").toString();
														String frequencyDesc = ((Hashtable)frequencies.elementAt(i)).get("frequency").toString();
													%>
													<OPTION value="<%=frequencyId%>" <%=(frequencyId.equals(frequency_id_search))?"selected":""%>><%=frequencyDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Medium</B></TD>
											<TD colspan="2">
												<SELECT name="medium_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < mediums.size(); i++){
														String mediumId = ((Hashtable)mediums.elementAt(i)).get("mediumid").toString();
														String mediumDesc = ((Hashtable)mediums.elementAt(i)).get("medium").toString();
													%>
													<OPTION value="<%=mediumId%>" <%=(mediumId.equals(medium_id_search))?"selected":""%>><%=mediumDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD class="text_12_black" colspan="2">
											<%if(user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
												<INPUT type="hidden" name="country_id_search" value="<%=user.getCountries().firstElement()%>">
												<%=DbUtils.getCountryDescription(user.getCountries().firstElement().toString())%>
											<%}else{%>
												<SELECT name="country_id_search" class="select_text_small">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < countries.size(); i++){
														String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
														String countryDesc = ((Hashtable)countries.elementAt(i)).get("country").toString();
													%>
													<OPTION value="<%=countryId%>" <%=(countryId.equals(country_id_search))?"selected":""%>><%=countryDesc%></OPTION>
													<%}%>
												</SELECT>
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Archive</B></TD>
											<TD colspan="2">
												<SELECT name="status_search" class="select">
													<OPTION value=""></OPTION>
													<OPTION value="1" <%=(status_search.equals("1"))?"selected":""%>>Archived</OPTION>
													<OPTION value="0" <%=(status_search.equals("0"))?"selected":""%>>Not Archived</OPTION>
												</SELECT>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Publication" onclick="javascript:submitForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_publication_button" value="Enter Publication" onclick="javascript:goToInsert()" class="button">
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