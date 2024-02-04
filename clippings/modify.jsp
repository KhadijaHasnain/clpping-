<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.*"%>

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
			document.section_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.section_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.section_form.country_id.focus();
			<%}else{%>
				document.section_form.publication_id.focus();
			<%}%>
		}
		function reloadForm(){
			document.section_form.operation.value = "reload";
			submitForm();
		}
		function backToSearchResult(){
			document.search_form.submit();
		}
		function selectPublication(){
			var user_area = document.section_form.area_id.value;
			var user_country = document.section_form.country_id.value;
			if(user_area == "") {
				alert("<%=ReadErrorLabelFile.getParameter("AREA_REQUIRED")%>");
			} else{
				openWindow('<%=request.getContextPath()%>/publications/searchPopup.jsp?area_id_search='+user_area+'&country_id_search='+user_country,700,500);		
			}
		}
		function selectEvent(){
			var user_area = document.section_form.area_id.value;
			if(user_area == "") {
				alert("<%=ReadErrorLabelFile.getParameter("AREA_REQUIRED")%>");
			} else{
				openWindow('<%=request.getContextPath()%>/events/searchPopup.jsp?area_id_search='+user_area,700,500);		
			}
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String country_id_search = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");
String publication_id_search = (request.getParameter("publication_id_search")==null)?"":request.getParameter("publication_id_search");
String title_search = (request.getParameter("title_search")==null)?"":request.getParameter("title_search");
String fieldstory_id_search = (request.getParameter("fieldstory_id_search")==null)?"":request.getParameter("fieldstory_id_search");
String datepublished_from_search = (request.getParameter("datepublished_from_search")==null)?"":request.getParameter("datepublished_from_search");
String datepublished_to_search = (request.getParameter("datepublished_to_search")==null)?"":request.getParameter("datepublished_to_search");
String lengthofarticle_id_search = (request.getParameter("lengthofarticle_id_search")==null)?"":request.getParameter("lengthofarticle_id_search");
String tone_id_search = (request.getParameter("tone_id_search")==null)?"":request.getParameter("tone_id_search");
String graphic_id_search = (request.getParameter("graphic_id_search")==null)?"":request.getParameter("graphic_id_search");
String cover_id_search = (request.getParameter("cover_id_search")==null)?"":request.getParameter("cover_id_search");
String score_search = (request.getParameter("score_search")==null)?"":request.getParameter("score_search");
String ordering = (request.getParameter("ordering")==null)?"":request.getParameter("ordering");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id del clipping da modificare
String clippingId = (request.getParameter("clipping_id")==null)?"":request.getParameter("clipping_id");
ClippingBean clippingBean = new ClippingBean();
if(request.getAttribute("CLIPPING_BEAN") == null && !clippingId.equals("")){
	// è in modifica ma non è passato dalla servlet
	clippingBean = new ClippingBean(clippingId);
}else if(request.getAttribute("CLIPPING_BEAN") != null){
	// è in modifica ed è passato dalla servlet
	clippingBean = (ClippingBean)request.getAttribute("CLIPPING_BEAN");
}

String id_area = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String id_country = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
PublicationBean publication = new PublicationBean();

if(!clippingBean.getPublication_id().equals("")){
	publication = new PublicationBean(clippingBean.getPublication_id());
}
if(id_area.equals("") && id_country.equals("") && !clippingBean.getPublication_id().equals("")){
	id_area = publication.getArea_id();
	id_country = publication.getCountry_id();
}
	
String areaDescription = DbUtils.getAreaDescription(id_area);
String countryDescription = DbUtils.getCountryDescription(id_country);

String id_role = user.getId_role();

Vector areas = DbUtils.getAreas(user.getAreas());
Vector countries = DbUtils.getCountries(id_area, user.getCountries(), "");
if(!id_area.equals(publication.getArea_id()) && id_country.equals(publication.getCountry_id()) && !countries.contains(id_country)){
    id_country = "";
}
Vector publications = DbUtils.getPublicationsNotArchived(id_area, id_country, "");
Vector events = DbUtils.getEvents(id_area);
Vector fieldStories = DbUtils.getFieldStories();
Vector lengths = DbUtils.getLengths();
Vector tones = DbUtils.getTones();
Vector graphics = DbUtils.getGraphics();
Vector covers = DbUtils.getCovers();

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/clippings/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
	<INPUT type="hidden" name="publication_id_search" value="<%=publication_id_search%>">
	<INPUT type="hidden" name="title_search" value="<%=Utils.formatStringForView(title_search)%>">
	<INPUT type="hidden" name="fieldstory_id_search" value="<%=fieldstory_id_search%>">
	<INPUT type="hidden" name="datepublished_from_search" value="<%=datepublished_from_search%>">
	<INPUT type="hidden" name="datepublished_to_search" value="<%=datepublished_to_search%>">
	<INPUT type="hidden" name="lengthofarticle_id_search" value="<%=fieldstory_id_search%>">
	<INPUT type="hidden" name="tone_id_search" value="<%=tone_id_search%>">
	<INPUT type="hidden" name="graphic_id_search" value="<%=graphic_id_search%>">
	<INPUT type="hidden" name="cover_id_search" value="<%=cover_id_search%>">
	<INPUT type="hidden" name="score_search" value="<%=score_search%>">
	<INPUT type="hidden" name="ordering" value="<%=ordering%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="clippings"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CLIPPINGS - MODIFY CLIPPING</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="section_form" action="<%=request.getContextPath()%>/manageClipping.do" method="POST">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="clipping_id" value="<%=clippingBean.getClipping_id()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
						<INPUT type="hidden" name="publication_id_search" value="<%=publication_id_search%>">
						<INPUT type="hidden" name="title_search" value="<%=Utils.formatStringForView(title_search)%>">
						<INPUT type="hidden" name="fieldstory_id_search" value="<%=fieldstory_id_search%>">
						<INPUT type="hidden" name="datepublished_from_search" value="<%=datepublished_from_search%>">
						<INPUT type="hidden" name="datepublished_to_search" value="<%=datepublished_to_search%>">
						<INPUT type="hidden" name="lengthofarticle_id_search" value="<%=fieldstory_id_search%>">
						<INPUT type="hidden" name="tone_id_search" value="<%=tone_id_search%>">
						<INPUT type="hidden" name="graphic_id_search" value="<%=graphic_id_search%>">
						<INPUT type="hidden" name="cover_id_search" value="<%=cover_id_search%>">
						<INPUT type="hidden" name="score_search" value="<%=score_search%>">
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
											<%if(user.getAreas().size() > 1 || areas.size() > 1 || id_role.equals(Constants.idRoleAdmin)){%>
												<SELECT name="area_id" class="select" onchange="javascript: reloadForm();">
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
											<TD class="text_12_black"><B>Country<%=(user.getId_role().equals(Constants.idRoleEndUser))?"*":""%></B></TD>
											<TD class="text_12_black" colspan="2">
											<%if(id_role.equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
												<INPUT type="hidden" name="country_id" value="<%=id_country%>">
												<%=countryDescription%>	
											<%}else{%>
												<SELECT name="country_id" class="select_text_small" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < countries.size(); i++){
														String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
														String countryDesc = ((Hashtable)countries.elementAt(i)).get("country").toString();
													%>
													<OPTION value="<%=countryId%>" <%=(countryId.equals(id_country))?"selected":""%>><%=countryDesc%></OPTION>
													<%}%>
												</SELECT>
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Publication*</B></TD>
											<TD class="text_12_black">
												<SELECT name="publication_id" class="select_text_small">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < publications.size(); i++){
														String publicationId = ((Hashtable)publications.elementAt(i)).get("publicationid").toString();
														String publicationDesc = ((Hashtable)publications.elementAt(i)).get("name").toString();
													%>
													<OPTION value="<%=publicationId%>" <%=(publicationId.equals(clippingBean.getPublication_id()))?"selected":""%>><%=publicationDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Title*</B></TD>
											<TD colspan="2"><INPUT type="text" name="title" value="<%=Utils.formatStringForView(clippingBean.getTitle())%>" class="input_text" maxlength="255"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Type of Story</B></TD>
											<TD colspan="2">
												<SELECT name="fieldstory_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < fieldStories.size(); i++){
														String fieldStoryId = ((Hashtable)fieldStories.elementAt(i)).get("fieldstoryid").toString();
														String fieldStoryDesc = ((Hashtable)fieldStories.elementAt(i)).get("fieldstory").toString();
													%>
													<OPTION value="<%=fieldStoryId%>" <%=(fieldStoryId.equals(clippingBean.getFieldstory_id()))?"selected":""%>><%=fieldStoryDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date*</B></TD>
											<TD class="text_12_black" colspan="2">
												<INPUT type="text" name="datepublished" value="<%=clippingBean.getDatepublished()%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.section_form.datepublished)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Length of Article*</B></TD>
											<TD colspan="2">
												<SELECT name="lengthofarticle_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < lengths.size(); i++){
														String lengthId = ((Hashtable)lengths.elementAt(i)).get("lengthid").toString();
														String lengthDesc = ((Hashtable)lengths.elementAt(i)).get("length").toString();
													%>
													<OPTION value="<%=lengthId%>" <%=(lengthId.equals(clippingBean.getLengthofarticle_id()))?"selected":""%>><%=lengthDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Tone*</B></TD>
											<TD colspan="2">
												<SELECT name="tone_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < tones.size(); i++){
														String toneId = ((Hashtable)tones.elementAt(i)).get("toneid").toString();
														String toneDesc = ((Hashtable)tones.elementAt(i)).get("tone").toString();
													%>
													<OPTION value="<%=toneId%>" <%=(toneId.equals(clippingBean.getTone_id()))?"selected":""%>><%=toneDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Graphic*</B></TD>
											<TD colspan="2">
												<SELECT name="graphic_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < graphics.size(); i++){
														String graphicId = ((Hashtable)graphics.elementAt(i)).get("graphicid").toString();
														String graphicDesc = ((Hashtable)graphics.elementAt(i)).get("graphic").toString();
													%>
													<OPTION value="<%=graphicId%>" <%=(graphicId.equals(clippingBean.getGraphic_id()))?"selected":""%>><%=graphicDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Cover*</B></TD>
											<TD colspan="2">
												<SELECT name="cover_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < covers.size(); i++){
														String coverId = ((Hashtable)covers.elementAt(i)).get("coverid").toString();
														String coverDesc = ((Hashtable)covers.elementAt(i)).get("cover").toString();
													%>
													<OPTION value="<%=coverId%>" <%=(coverId.equals(clippingBean.getCover_id()))?"selected":""%>><%=coverDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Event</B></TD>
											<TD class="text_12_black">
												<SELECT name="event_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < events.size(); i++){
														String eventId = ((Hashtable)events.elementAt(i)).get("eventid").toString();
														String eventDesc = ((Hashtable)events.elementAt(i)).get("eventtitle").toString();
													%>
													<OPTION value="<%=eventId%>" <%=(eventId.equals(clippingBean.getEvent_id()))?"selected":""%>><%=eventDesc%></OPTION>
													<%}%>
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
									<INPUT type="button" name="submit_form_button" value="Submit" class="button" onclick="javascript:submitForm()">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="back_search_result_button" value="Back To Search Result" onclick="javascript:backToSearchResult()" class="button">
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