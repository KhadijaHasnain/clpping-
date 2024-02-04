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
			document.section_form.action="<%=request.getContextPath()%>/contacts/searchResult.jsp";
			document.section_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.section_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.section_form.country_id.focus();
			<%}else{%>
				document.section_form.firstname_search.focus();
			<%}%>
		}
		function reloadForm(){
			document.section_form.action="<%=request.getContextPath()%>/contacts/search.jsp";
			document.section_form.submit();
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/contacts/insert.jsp";
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/contacts/search.jsp";
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
	</SCRIPT>
</HEAD>

<%
String area_id_search = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id_search = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String publication_id_search = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
String firstname_search = (request.getParameter("firstname_search")==null)?"":request.getParameter("firstname_search");
String lastname_search = (request.getParameter("lastname_search")==null)?"":request.getParameter("lastname_search");
String city_search = (request.getParameter("city_search")==null)?"":request.getParameter("city_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");

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

String id_role = user.getId_role();

Vector areas = DbUtils.getAreas(user.getAreas());
Vector countries = new Vector();

if(request.getParameter("area_id")!=null){
	id_area = request.getParameter("area_id").toString();
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
					<jsp:param name="section_help" value="contacts"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CONTACTS - SEARCH CONTACT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="section_form" action="<%=request.getContextPath()%>/contacts/search.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area</B></TD>
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
											<%if(id_role.equals(Constants.idRoleEndUser) && user.getCountries().size() == 1){%>
												<INPUT type="hidden" name="country_id" value="<%=id_country%>">
												<%=countryDescription%>	
											<%}else{%>
												<SELECT name="country_id" class="select_text_small">
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
											<TD class="text_12_black"><B>Publication</B></TD>
											<TD class="text_12_black"><INPUT type="hidden" name="publication_id" value="<%=publication_id_search%>"><%=DbUtils.getPublicationDescription(publication_id_search)%></TD>
											<TD width="20%"  class="text_12_black"><A href="javascript: selectPublication();">Select Publication</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>First Name</B></TD>
											<TD colspan="2"><INPUT type="text" name="firstname_search" value="<%=Utils.formatStringForView(firstname_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Last Name</B></TD>
											<TD colspan="2"><INPUT type="text" name="lastname_search" value="<%=Utils.formatStringForView(lastname_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>City</B></TD>
											<TD colspan="2"><INPUT type="text" name="city_search" value="<%=Utils.formatStringForView(city_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD colspan="2"><INPUT type="text" name="country_search" value="<%=Utils.formatStringForView(country_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Contact" onclick="javascript:submitForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_contact_button" value="Enter Contact" onclick="javascript:goToInsert()" class="button">
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