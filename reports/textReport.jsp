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
			document.section_form.action="<%=request.getContextPath()%>/reportText.do";
			document.section_form.submit();
		}
		function reloadForm(){
			document.section_form.action="<%=request.getContextPath()%>/reports/textReport.jsp";
			document.section_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.section_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.section_form.country_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1)){%>
				document.section_form.section_id.focus();
			<%}%>	
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/reports/textReport.jsp";
		}
		function selectPublication(){
			var user_area = document.section_form.area_id.value;
			var user_country = document.section_form.country_id.value;
			if(user_area == "") {
				alert("<%=ReadErrorLabelFile.getParameter("AREA_REQUIRED")%>");
			} else{
				document.section_form.action="<%=request.getContextPath()%>/reports/textReport.jsp";
				openWindow('<%=request.getContextPath()%>/publications/searchPopup.jsp?area_id_search='+user_area+'&country_id_search='+user_country,700,500);		
			}
		}
		function selectEvent(){
			var user_area = document.section_form.area_id.value;
			if(user_area == "") {
				alert("<%=ReadErrorLabelFile.getParameter("AREA_REQUIRED")%>");
			} else{
				document.section_form.action="<%=request.getContextPath()%>/reports/textReport.jsp";
				openWindow('<%=request.getContextPath()%>/events/searchPopup.jsp?area_id_search='+user_area,700,500);		
			}
		}
	</SCRIPT>
</HEAD>

<%
String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String section_id = (request.getParameter("section_id")==null)?"":request.getParameter("section_id");
String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
String publication_id = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
String event_id = (request.getParameter("event_id")==null)?"":request.getParameter("event_id");
String medium_id = (request.getParameter("medium_id")==null)?"":request.getParameter("medium_id");
String time = (request.getParameter("time")==null)?"":request.getParameter("time");
String date_from = (request.getParameter("date_from")==null)?"":request.getParameter("date_from");
String date_to = (request.getParameter("date_to")==null)?"":request.getParameter("date_to");
String format = (request.getParameter("format")==null)?"":request.getParameter("format");
String paging = (request.getParameter("paging")==null)?"":request.getParameter("paging");
String id_area = "";
String id_country = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(user.getCountries().size() == 1){
	id_country = user.getCountries().firstElement().toString();
}else{
	id_country = request.getParameter("country_id")==null?"":request.getParameter("country_id");
}
String areaDescription = DbUtils.getAreaDescription(id_area);
String countryDescription = DbUtils.getCountryDescription(id_country);

Vector areas = DbUtils.getAreas(user.getAreas());
Vector countries = new Vector();
Vector publications = new Vector();
Vector events = new Vector();
Vector sections = DbUtils.getSections();
Vector audiences = DbUtils.getAudiences();
Vector mediums = DbUtils.getMediums();

if(request.getParameter("area_id")!=null){
	id_area = request.getParameter("area_id").toString();
	countries = DbUtils.getCountriesForAdminSearch(id_area);	
}else{
	countries = DbUtils.getCountries(id_area, user.getCountries(), "");
}

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="reports"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>REPORTS - TEXT REPORT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="section_form" action="<%=request.getContextPath()%>/reports/textReport.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR>
								<TD class="text_14_red" style="text-align:center;vertical-align:middle;">
									<%=(error.equals(""))?"&nbsp;":"<B>"+error+"</B>"%>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area*</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
											<%if(areas.size() > 1){%>
												<SELECT name="area_id" class="select" onchange="javascript:reloadForm()">
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
												<INPUT type="hidden" name="area_id" value="<%=id_area%>">
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD class="text_12_black" colspan="2">
											<%if(user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
												<INPUT type="hidden" name="country_id" value="<%=user.getCountries().firstElement()%>">
												<%=DbUtils.getCountryDescription(user.getCountries().firstElement().toString())%>
											<%}else{%>
												<SELECT name="country_id" class="select" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < countries.size(); i++){
														String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
														String countryDesc = ((Hashtable)countries.elementAt(i)).get("country").toString();
													%>
													<OPTION value="<%=countryId%>" <%=(countryId.equals(country_id))?"selected":""%>><%=countryDesc%></OPTION>
													<%}%>
												</SELECT>
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Section*</B></TD>
											<TD class="text_12_black" colspan="2">
											<SELECT name="section_id" class="select" onchange="javascript:reloadForm()">
												<OPTION value=""></OPTION>
												<%for(int i=0; i < sections.size(); i++){
													String sectionId = ((Hashtable)sections.elementAt(i)).get("sectionid").toString();
													String sectionDesc = ((Hashtable)sections.elementAt(i)).get("name").toString();
												%>
												<OPTION value="<%=sectionId%>" <%=(sectionId.equals(section_id))?"selected":""%>><%=sectionDesc%></OPTION>
												<%}%>
											</SELECT>
											</TD>
										</TR>
										<%if(section_id.equals("1")){%>
										<TR>
											<TD class="text_12_black"><B>Audience</B></TD>
											<TD class="text_12_black" colspan="2">
												<SELECT name="audience_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < audiences.size(); i++){
														String audienceId = ((Hashtable)audiences.elementAt(i)).get("audienceid").toString();
														String audienceDesc = ((Hashtable)audiences.elementAt(i)).get("audience").toString();
													%>
													<OPTION value="<%=audienceId%>" <%=(audienceId.equals(audience_id))?"selected":""%>><%=audienceDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<%}else if(section_id.equals("3")){%>
										<TR>
											<TD class="text_12_black"><B>Event</B></TD>
											<TD class="text_12_black">
												<SELECT name="event_id" class="select">
													<OPTION value=""></OPTION>
													<%events = DbUtils.getEvents(id_area);%>
													<%for(int i=0; i < events.size(); i++){
														String eventId = ((Hashtable)events.elementAt(i)).get("eventid").toString();
														String eventDesc = ((Hashtable)events.elementAt(i)).get("eventtitle").toString();
													%>
													<OPTION value="<%=eventId%>" <%=(eventId.equals(event_id))?"selected":""%>><%=eventDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<%}else if(section_id.equals("5")){%>
										<TR>
											<TD class="text_12_black"><B>Publication</B></TD>
											<TD class="text_12_black">
												<SELECT name="publication_id" class="select">
													<OPTION value=""></OPTION>
													<%publications = DbUtils.getPublications(id_area, id_country, "");%>
													<%for(int i=0; i < publications.size(); i++){
														String publicationId = ((Hashtable)publications.elementAt(i)).get("publicationid").toString();
														String publicationDesc = ((Hashtable)publications.elementAt(i)).get("name").toString();
													%>
													<OPTION value="<%=publicationId%>" <%=(publicationId.equals(publication_id))?"selected":""%>><%=publicationDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<%}else if(section_id.equals("6")){%>
										<TR>
											<TD class="text_12_black"><B>Medium</B></TD>
											<TD class="text_12_black" colspan="2">
												<SELECT name="medium_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < mediums.size(); i++){
														String mediumId = ((Hashtable)mediums.elementAt(i)).get("mediumid").toString();
														String mediumDesc = ((Hashtable)mediums.elementAt(i)).get("medium").toString();
													%>
													<OPTION value="<%=mediumId%>" <%=(mediumId.equals(medium_id))?"selected":""%>><%=mediumDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<%}%>
										<TR>
											<TD class="text_12_black"><B>Time*</B></TD>
											<TD class="text_12_black" colspan="2">
												<SELECT name="time" class="select" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<OPTION value="all_time" <%=(time.equals("all_time"))?"selected":""%>>ALL TIME</OPTION>
													<OPTION value="current_month" <%=(time.equals("current_month"))?"selected":""%>>CURRENT MONTH</OPTION>
													<OPTION value="last_month" <%=(time.equals("last_month"))?"selected":""%>>LAST MONTH</OPTION>
													<OPTION value="from_to" <%=(time.equals("from_to"))?"selected":""%>>FROM TO</OPTION>
												</SELECT>
											</TD>
										</TR>
										<%if(time.equals("from_to")){%>
										<TR>
											<TD class="text_12_black"><B>Date*</B></TD>
											<TD class="text_12_black">
												From&nbsp;
												<INPUT type="text" name="date_from" value="<%=date_from%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.section_form.date_from)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<INPUT type="text" name="date_to" value="<%=date_to%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.section_form.date_to)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
											</TD>
											<TD width="20%" class="text_12_black"><%=Constants.STRINGdateFormat%></TD>
										</TR>
										<%}%>
										<TR>
											<TD class="text_12_black"><B>Format*</B></TD>
											<TD class="text_12_black" colspan="2">
												<SELECT name="format" class="select" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<OPTION value="web" <%=(format.equals("web"))?"selected":""%>>WEB</OPTION>
													<OPTION value="excel" <%=(format.equals("excel"))?"selected":""%>>EXCEL</OPTION>
												</SELECT>
											</TD>
										</TR>
										<%if(format.equals("web")){%>
										<TR>
											<TD class="text_12_black"><B>Paging</B></TD>
											<TD class="text_12_black" colspan="2">
												<SELECT name="paging" class="select">
													<OPTION value="y" <%=(!paging.equals("n"))?"selected":""%>>Yes</OPTION>
													<OPTION value="n" <%=(paging.equals("n"))?"selected":""%>>No</OPTION>
												</SELECT>
											</TD>
										</TR>
										<%}%>
										<TR>
											<TD colspan="3" class="text_12_black">* Required fields</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Submit" class="button" onclick="javascript:submitForm()">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" class="button" onclick="javascript:resetForm()">
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