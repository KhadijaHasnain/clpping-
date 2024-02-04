<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
			document.insert_form.submit();
		}
		function setFocus(){
			document.insert_form.name.focus();
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
			document.insert_form.area_id.value = "";
			<%}%>
			document.insert_form.name.value = "";
			document.insert_form.last_rated.value = "";
			document.insert_form.audience_id.value = "";
			document.insert_form.level_id.value = "";
			document.insert_form.size_id.value = "";
			document.insert_form.frequency_id.value = "";
			document.insert_form.medium_id.value = "";
			document.insert_form.description.value = "";
			<%if(!user.getId_role().equals(Constants.idRoleEndUser) || user.getCountries().size() != 1){%>
			document.insert_form.country_id.value = "";
			<%}%>
		}
	</SCRIPT>
</HEAD>

<%
String id_area = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String id_country = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");

if(id_area.equals("")){
	id_area = publicationBean.getArea_id();
}else{
	publicationBean.setArea_id(id_area);
}
if(id_country.equals("")){
	id_country = publicationBean.getCountry_id();
}else{
	publicationBean.setCountry_id(id_country);
}

String id_role = user.getId_role();
String areaDescription = DbUtils.getAreaDescription(id_area);

Vector areas = DbUtils.getAreas(user.getAreas());
Vector audiences = DbUtils.getAudiences();
Vector levels = DbUtils.getLevels();
Vector sizes = DbUtils.getSizes();
Vector frequencies = DbUtils.getFrequencies();
Vector mediums = DbUtils.getMediums();
Vector countries = DbUtils.getCountries(id_area, user.getCountries(), "");

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	<TR>
		<TD>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - ADD PUBLICATION</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="insert_form" action="<%=request.getContextPath()%>/managePublication.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
						<INPUT type="hidden" name="visualmode" value="popup">
						<INPUT type="hidden" name="status" value="0">
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
											<TD width="75%" class="text_12_black"><INPUT type="hidden" name="area_id" value="<%=publicationBean.getArea_id()%>"><%=areaDescription%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Name*</B></TD>
											<TD><INPUT type="text" name="name" value="<%=Utils.formatStringForView(publicationBean.getName())%>" class="input_text" maxlength="60"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date*</B></TD>
											<TD class="text_12_black">
												<INPUT type="text" name="last_rated" value="<%=publicationBean.getLast_rated()%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.insert_form.last_rated)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
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
												<TEXTAREA name="description" class="text_area"><%=publicationBean.getDescription()%></TEXTAREA>
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
</TABLE>

</BODY>

</HTML>