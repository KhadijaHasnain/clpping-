<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "3";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="userBean" class="it.vidiemme.clipping.beans.UserBean" scope="request"/>
<jsp:setProperty name="userBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.user_form.submit();
		}
		function reloadForm(){
			document.user_form.action = "<%=request.getContextPath()%>/users/insert.jsp";
			submitForm();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin)){%>
				document.user_form.id_role.focus();
			<%}else{%>
				document.user_form.username.focus();
			<%}%>
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/users/insert.jsp";
		}
		function insertCountry(area_id){
			openWindow('<%=request.getContextPath()%>/countries/insert.jsp?visual_mode=popup&user_area='+area_id,600,350);
		}
	</SCRIPT>
</HEAD>

<%
Vector areas = DbUtils.getAreas(user.getAreas());
Vector roles = DbUtils.getRoles();
String area_id = "";

if (request.getParameter("area")!=null){
	area_id = request.getParameter("area").toString();
}else if(user.getId_role().equals(Constants.idRoleManager)){
	userBean.setId_role(Constants.idRoleEndUser);
	if(user.getAreas().size() == 1)
		area_id = user.getAreas().firstElement().toString();
}
Vector vectorCountries = DbUtils.getCountries(area_id, new Vector(), "");

// per il ripopolamento dei countries checckati dopo il controllo della servlet
if(request.getAttribute("USER_BEAN") != null){
	userBean = (UserBean)request.getAttribute("USER_BEAN");
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
					<jsp:param name="section_help" value="users"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>USERS - ADD USER</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="user_form" action="<%=request.getContextPath()%>/manageUser.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
						<INPUT type="hidden" name="user_id" value="">
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
											<TD width="25%" class="text_12_black"><B>Role*</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
												<%if(user.getId_role().equals(Constants.idRoleAdmin)){%>
												<SELECT name="id_role" class="select" onchange="javascript: reloadForm();">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < roles.size(); i++){
														String roleId = ((Hashtable)roles.elementAt(i)).get("roleid").toString();
														String roleDesc = ((Hashtable)roles.elementAt(i)).get("role").toString();
													%>
													<OPTION value="<%=roleId%>" <%=(roleId.equals(userBean.getId_role()))?"selected":""%>><%=roleDesc%></OPTION>
													<%}%>
												</SELECT>
												<%}else{%>
												<INPUT type="hidden" name="id_role" value="<%=Constants.idRoleEndUser%>"><%=DbUtils.getRoleDescription(Constants.idRoleEndUser)%>
												<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Username*</B></TD>
											<TD colspan="2"><INPUT type="text" name="username" value="<%=Utils.formatStringForView(userBean.getUsername())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<%if(userBean.getId_role().equals(Constants.idRoleEndUser) || userBean.getId_role().equals(Constants.idRoleManager)){%>
											<TD width="25%" class="text_12_black"><B>Area*</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
												<%if(userBean.getId_role().equals(Constants.idRoleEndUser) && areas.size() > 1){%>
												<SELECT name="area" class="select" <%=(userBean.getId_role().equals(Constants.idRoleEndUser))?"onchange=\"javascript: reloadForm();\"":""%>>
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(area_id))?"selected":""%>><%=areaDesc%></OPTION>
													<%}%>
												</SELECT>
												<%}else if(areas.size() > 1) {%>
												<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
													<%
													for(int i = 0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String area = ((Hashtable)areas.elementAt(i)).get("area").toString();
														String checked = (userBean.getAreas().contains(areaId))?"checked":"";
													%>
													<TR>
														<TD width="5%">
															<INPUT type="checkbox" name="area" value="<%=areaId%>" <%=checked%>>
														</TD>
														<TD width="45%"><%=area%></TD>
														<%if((i+1) < areas.size()) {%>
														<TD width="5%">
															<%
															i++;
															areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
															area = ((Hashtable)areas.elementAt(i)).get("area").toString();
															checked = (userBean.getAreas().contains(areaId))?"checked":"";
															%>
															<INPUT type="checkbox" name="area" value="<%=areaId%>" <%=checked%>>
														</TD>
														<TD width="45%"><%=area%></TD>
														<%} else {%>
														<TD width="5%"></TD>
														<TD width="45%"></TD>
														<%}%>
													</TR>
													<%}%>
												</TABLE>
												<%}else if(areas.size() == 1) {%>
												<INPUT type="hidden" name="area" value="<%=area_id%>"><%=DbUtils.getAreaDescription(area_id)%>
												<%}%>
											</TD>
											<%}%>
										</TR>
										<TR>
											<%if((userBean.getId_role().equals(Constants.idRoleEndUser) || user.getId_role().equals(Constants.idRoleManager)) && !area_id.equals("")){%>
											<TD width="25%" class="text_12_black"><B>Country*</B></TD>
											<TD class="text_12_black" width="50%">
												<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
													<%
													for(int i = 0; i < vectorCountries.size(); i++){
														String country_id = ((Hashtable)vectorCountries.elementAt(i)).get("countryid").toString();
														String used = ((Hashtable)vectorCountries.elementAt(i)).get("used").toString();
														String country = ((Hashtable)vectorCountries.elementAt(i)).get("country").toString();
														String checked = (userBean.getCountries().contains(country_id))?"checked":"";
													%>
													<TR>
														<TD width="5%">
															<%if(used.equals("0")){%>
															<INPUT type="checkbox" name="country" value="<%=country_id%>" <%=checked%>>
															<%}else{%>
															<IMG src="<%=request.getContextPath()%>/images/icona_delete.gif" alt="">
															<%}%>
														</TD>
														<TD width="45%"><%=country%></TD>
														<%if((i+1) < vectorCountries.size()) {%>
														<TD width="5%">
															<%
															i++;
															country_id = ((Hashtable)vectorCountries.elementAt(i)).get("countryid").toString();
															used = ((Hashtable)vectorCountries.elementAt(i)).get("used").toString();
															country = ((Hashtable)vectorCountries.elementAt(i)).get("country").toString();
															checked = (userBean.getCountries().contains(country_id))?"checked":"";
															%>
															<%if(used.equals("0")){%>
															<INPUT type="checkbox" name="country" value="<%=country_id%>" <%=checked%>>
															<%}else{%>
															<IMG src="<%=request.getContextPath()%>/images/icona_delete.gif" alt="">
															<%}%>
														</TD>
														<TD width="45%"><%=country%></TD>
														<%} else {%>
														<TD width="5%"></TD>
														<TD width="45%"></TD>
														<%}%>
													</TR>
													<%}%>
													<%if(vectorCountries.size() == 0){%>
													<TR>
														<TD class="text_12_red" style="text-align:center;"><B>NO COUNTRIES AVAILABLE<BR>PLEASE INSERT ONE</B></TD>
													</TR>
													<%}%>
												</TABLE>
											</TD>
											<TD class="text_12_black" width="25%"><A href="javascript: insertCountry('<%=area_id%>');">Add Country</A></TD>
											<%}%>
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
