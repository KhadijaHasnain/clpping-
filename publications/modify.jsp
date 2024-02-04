<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean,it.vidiemme.clipping.beans.PublicationBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="publicationBean" class="it.vidiemme.clipping.beans.PublicationBean" scope="request"/>
<jsp:setProperty name="publicationBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.update_form.submit();
		}
		function reloadForm(){
			document.update_form.action="<%=request.getContextPath()%>/publications/modify.jsp";
			submitForm();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.update_form.area_id.focus();
			<%}else{%>
				document.update_form.name.focus();
			<%}%>
		}
		function backToSearchResult(){
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
String id_role = user.getId_role();

// Recupera i parametri per la ricerca
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
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id della publication da modificare
String publicationId = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
String formReloaded = (request.getParameter("reload")==null)?"":request.getParameter("reload");

if(!formReloaded.equals("true")){
	publicationBean = new PublicationBean(publicationId);
}

// Ottiene dato l'id ad essa relativo, il nome dell'area a cui appartiene la publication da modificare
String areaDescription = DbUtils.getAreaDescription(publicationBean.getArea_id());
String area_id = (request.getParameter("area_id")==null)?publicationBean.getArea_id():request.getParameter("area_id");
Vector areas = DbUtils.getAreas(user.getAreas());
Vector audiences = DbUtils.getAudiences();
Vector levels = DbUtils.getLevels();
Vector sizes = DbUtils.getSizes();
Vector frequencies = DbUtils.getFrequencies();
Vector mediums = DbUtils.getMediums();
Vector countries = DbUtils.getCountries(area_id, user.getCountries(), "");

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/publications/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
	<INPUT type="hidden" name="last_rated_from_search" value="<%=last_rated_from_search%>">
	<INPUT type="hidden" name="last_rated_to_search" value="<%=last_rated_to_search%>">
	<INPUT type="hidden" name="audience_id_search" value="<%=audience_id_search%>">
	<INPUT type="hidden" name="level_id_search" value="<%=level_id_search%>">
	<INPUT type="hidden" name="size_id_search" value="<%=size_id_search%>">
	<INPUT type="hidden" name="frequency_id_search" value="<%=frequency_id_search%>">
	<INPUT type="hidden" name="medium_id_search" value="<%=medium_id_search%>">
	<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
	<INPUT type="hidden" name="status_search" value="<%=status_search%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="publications"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - MODIFY PUBLICATION</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="update_form" action="<%=request.getContextPath()%>/managePublication.do" method="POST">
						<INPUT type="hidden" name="reload" value="true">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="publication_id" value="<%=publicationBean.getPublication_id()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="last_rated_from_search" value="<%=last_rated_from_search%>">
						<INPUT type="hidden" name="last_rated_to_search" value="<%=last_rated_to_search%>">
						<INPUT type="hidden" name="audience_id_search" value="<%=audience_id_search%>">
						<INPUT type="hidden" name="level_id_search" value="<%=level_id_search%>">
						<INPUT type="hidden" name="size_id_search" value="<%=size_id_search%>">
						<INPUT type="hidden" name="frequency_id_search" value="<%=frequency_id_search%>">
						<INPUT type="hidden" name="medium_id_search" value="<%=medium_id_search%>">
						<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
						<INPUT type="hidden" name="status_search" value="<%=status_search%>">
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
											<TD width="75%" class="text_12_black">
											<%if(areas.size() > 1){%>
												<SELECT name="area_id" class="select" onchange="javascript:reloadForm()">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(area_id))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											<%}else{%>
												<%=areaDescription%>
												<INPUT type="hidden" name="area_id" value="<%=publicationBean.getArea_id()%>">
											<%}%>
											 </TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Name*</B></TD>
											<TD><INPUT type="text" name="name" value="<%=Utils.formatStringForView(publicationBean.getName())%>" class="input_text" maxlength="60"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date*</B></TD>
											<TD class="text_12_black">
												<INPUT type="text" name="last_rated" value="<%=publicationBean.getLast_rated()%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.update_form.last_rated)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Audience*</B></TD>
											<TD>
												<SELECT name="audience_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < audiences.size(); i++){
														String audienceId = ((Hashtable)audiences.elementAt(i)).get("audienceid").toString();
														String audienceDesc = ((Hashtable)audiences.elementAt(i)).get("audience").toString();
													%>
													<OPTION value="<%=audienceId%>" <%=(audienceId.equals(publicationBean.getAudience_id()))?"selected":""%>><%=audienceDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Level Of Press*</B></TD>
											<TD>
												<SELECT name="level_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < levels.size(); i++){
														String levelId = ((Hashtable)levels.elementAt(i)).get("levelid").toString();
														String levelDesc = ((Hashtable)levels.elementAt(i)).get("level").toString();
													%>
													<OPTION value="<%=levelId%>" <%=(levelId.equals(publicationBean.getLevel_id()))?"selected":""%>><%=levelDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Size*</B></TD>
											<TD>
												<SELECT name="size_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < sizes.size(); i++){
														String sizeId = ((Hashtable)sizes.elementAt(i)).get("sizeid").toString();
														String sizeDesc = ((Hashtable)sizes.elementAt(i)).get("size").toString();
													%>
													<OPTION value="<%=sizeId%>" <%=(sizeId.equals(publicationBean.getSize_id()))?"selected":""%>><%=sizeDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Frequency*</B></TD>
											<TD>
												<SELECT name="frequency_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < frequencies.size(); i++){
														String frequencyId = ((Hashtable)frequencies.elementAt(i)).get("frequencyid").toString();
														String frequencyDesc = ((Hashtable)frequencies.elementAt(i)).get("frequency").toString();
													%>
													<OPTION value="<%=frequencyId%>" <%=(frequencyId.equals(publicationBean.getFrequency_id()))?"selected":""%>><%=frequencyDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Medium*</B></TD>
											<TD>
												<SELECT name="medium_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < mediums.size(); i++){
														String mediumId = ((Hashtable)mediums.elementAt(i)).get("mediumid").toString();
														String mediumDesc = ((Hashtable)mediums.elementAt(i)).get("medium").toString();
													%>
													<OPTION value="<%=mediumId%>" <%=(mediumId.equals(publicationBean.getMedium_id()))?"selected":""%>><%=mediumDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Notes</B></TD>
											<TD>
												<TEXTAREA name="description" rows="5" cols="50"><%=publicationBean.getDescription()%></TEXTAREA>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country<%=(user.getId_role().equals(Constants.idRoleEndUser))?"*":""%></B></TD>
											<TD class="text_12_black">
											<%if(id_role.equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
												<INPUT type="hidden" name="country_id" value="<%=user.getCountries().firstElement()%>">
												<%=DbUtils.getCountryDescription(user.getCountries().firstElement().toString())%>
											<%}else{%>
												<SELECT name="country_id" class="select_text_small">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < countries.size(); i++){
														String countryId = ((Hashtable)countries.elementAt(i)).get("countryid").toString();
														String countryDesc = ((Hashtable)countries.elementAt(i)).get("country").toString();
													%>
													<OPTION value="<%=countryId%>" <%=(countryId.equals(publicationBean.getCountry_id()))?"selected":""%>><%=countryDesc%></OPTION>
													<%}%>
												</SELECT>
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Archive*</B></TD>
											<TD>
												<SELECT name="status" class="select">
													<OPTION value=""></OPTION>
													<OPTION value="1" <%=(publicationBean.getStatus().equals("1"))?"selected":""%>>Archived</OPTION>
													<OPTION value="0" <%=(publicationBean.getStatus().equals("0"))?"selected":""%>>Not Archived</OPTION>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD colspan="2" class="text_12_black">* Required fields</TD>
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