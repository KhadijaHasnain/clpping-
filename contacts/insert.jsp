<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="contactBean" class="it.vidiemme.clipping.beans.ContactBean" scope="request"/>
<jsp:setProperty name="contactBean" property="*"/>

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
		function reloadForm(){
			document.section_form.action = "<%=request.getContextPath()%>/contacts/insert.jsp";
			submitForm();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.section_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.section_form.country_id.focus();
			<%}else{%>
				document.section_form.general.focus();
			<%}%>
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/contacts/insert.jsp";
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
					<jsp:param name="section_help" value="contacts"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CONTACTS - ADD CONTACT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="section_form" action="<%=request.getContextPath()%>/manageContact.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
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
											<TD class="text_12_black"><B>Publication*</B></TD>
											<TD class="text_12_black"><INPUT type="hidden" name="publication_id" value="<%=contactBean.getPublication_id()%>"><%=DbUtils.getPublicationDescription(contactBean.getPublication_id())%></TD>
											<TD class="text_12_black" width="20%"><A href="javascript: selectPublication();">Select Publication</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>General</B></TD>
											<TD colspan="2"><INPUT type="text" name="general" value="<%=Utils.formatStringForView(contactBean.getGeneral())%>" class="input_text" maxlength="20"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>First Name</B></TD>
											<TD colspan="2"><INPUT type="text" name="firstname" value="<%=Utils.formatStringForView(contactBean.getFirstname())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Last Name*</B></TD>
											<TD colspan="2"><INPUT type="text" name="lastname" value="<%=Utils.formatStringForView(contactBean.getLastname())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Contact Type</B></TD>
											<TD colspan="2"><INPUT type="text" name="contacttype" value="<%=Utils.formatStringForView(contactBean.getContacttype())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Last Meeting Date</B></TD>
											<TD class="text_12_black">
												<INPUT type="text" name="lastmeetingdate" value="<%=contactBean.getLastmeetingdate()%>" class="input_text_small" maxlength="12">
												<A href="javascript: cal(document.section_form.lastmeetingdate)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Specifics</B></TD>
											<TD colspan="2"><INPUT type="text" name="specifics" value="<%=Utils.formatStringForView(contactBean.getSpecifics())%>" class="input_text" maxlength="20"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Address</B></TD>
											<TD colspan="2"><INPUT type="text" name="address" value="<%=Utils.formatStringForView(contactBean.getAddress())%>" class="input_text" maxlength="255"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>City</B></TD>
											<TD colspan="2"><INPUT type="text" name="city" value="<%=Utils.formatStringForView(contactBean.getCity())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>State</B></TD>
											<TD colspan="2"><INPUT type="text" name="state" value="<%=Utils.formatStringForView(contactBean.getState())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Postal Code</B></TD>
											<TD colspan="2"><INPUT type="text" name="postalcode" value="<%=Utils.formatStringForView(contactBean.getPostalcode())%>" class="input_text" maxlength="20"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD colspan="2"><INPUT type="text" name="country" value="<%=Utils.formatStringForView(contactBean.getCountry())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Work Phone</B></TD>
											<TD colspan="2"><INPUT type="text" name="workphone" value="<%=Utils.formatStringForView(contactBean.getWorkphone())%>" class="input_text" maxlength="30"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Fax Number</B></TD>
											<TD colspan="2"><INPUT type="text" name="faxnumber" value="<%=Utils.formatStringForView(contactBean.getFaxnumber())%>" class="input_text" maxlength="30"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>E mail Address</B></TD>
											<TD colspan="2"><INPUT type="text" name="emailname" value="<%=Utils.formatStringForView(contactBean.getEmailname())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Description</B></TD>
											<TD colspan="2">
												<TEXTAREA name="note" class="text_area"><%=Utils.formatStringForView(contactBean.getNote())%></TEXTAREA>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Contact by Phone</B></TD>
											<TD class="input_text" colspan="2">
												YES <INPUT type="radio" name="contactbyphone" value="1" <%=(contactBean.getContactbyphone().equals("1") || contactBean.getContactbyphone().equals(""))?"checked":""%> class="radio"> 
												NO <INPUT type="radio" name="contactbyphone" value="0" <%=contactBean.getContactbyphone().equals("0")?"checked":""%> class="radio">
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Contact by E mail</B></TD>
											<TD class="input_text" colspan="2">
												YES <INPUT type="radio" name="contactbyemail" value="1" <%=(contactBean.getContactbyemail().equals("1") || contactBean.getContactbyemail().equals(""))?"checked":""%> class="radio"> 
												NO <INPUT type="radio" name="contactbyemail" value="0" <%=contactBean.getContactbyemail().equals("0")?"checked":""%> class="radio">
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Related Geographical Area/Country</B></TD>
											<TD colspan="2"><INPUT type="text" name="contactgeographicregion" value="<%=Utils.formatStringForView(contactBean.getGeographic_region())%>" class="input_text" maxlength="50"></TD>
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