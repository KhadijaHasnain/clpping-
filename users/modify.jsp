<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "3";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String role_id_search = (request.getParameter("role_id_search")==null)?"":request.getParameter("role_id_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id dello user da modificare
String userId = (request.getParameter("user_id")==null)?"":request.getParameter("user_id");

UserBean userBean = new UserBean();
if(request.getAttribute("USER_BEAN") == null && !userId.equals("")){
	// è in modifica ma non è passato dalla servlet
	userBean = new UserBean(userId);
}else if(request.getAttribute("USER_BEAN") != null){
	// è in modifica ed è passato dalla servlet
	userBean = (UserBean)request.getAttribute("USER_BEAN");
}

Vector areas = DbUtils.getAreas(user.getAreas());
Vector roles = DbUtils.getRoles();
String area_id = "";


if (request.getParameter("area")!=null){
	area_id = request.getParameter("area").toString();
}else if(user.getId_role().equals(Constants.idRoleManager)){
	if(user.getAreas().size() == 1)
		area_id = user.getAreas().firstElement().toString();
}
if(userBean.getId_role().equals(Constants.idRoleEndUser)) {
	area_id = userBean.getAreas().firstElement().toString();
}
Vector vectorCountries = vectorCountries = DbUtils.getCountries(area_id, new Vector(), userBean.getId_user());	

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>
	
<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.user_form.submit();
		}
		function setFocus(){
			<%if(userBean.getId_role().equals(Constants.idRoleEndUser) && (user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1))){%>
				document.user_form.area.focus();
			<%}%>
		}
		function reloadForm(){
			document.user_form.operation.value = "reload";
			submitForm();
		}
		function backToSearchResult(){
			document.search_form.submit();
		}
		function insertCountry(area_id){
			openWindow('<%=request.getContextPath()%>/countries/insert.jsp?visual_mode=popup&user_area='+area_id,600,350);
		}
	</SCRIPT>
</HEAD>



<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/users/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="role_id_search" value="<%=role_id_search%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="users"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>USERS - MODIFY USER</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="user_form" action="<%=request.getContextPath()%>/manageUser.do" method="POST">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="user_id" value="<%=userBean.getId_user()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="role_id_search" value="<%=role_id_search%>">
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
												<INPUT type="hidden" name="id_role" value="<%=userBean.getId_role()%>"><%=DbUtils.getRoleDescription(userBean.getId_role())%>
											</TD>
										</TR>
										<TR>
											<TD width="25%" class="text_12_black"><B>Username*</B></TD>
											<TD width="75%" class="text_12_black" colspan="2"><INPUT type="hidden" name="username" value="<%=Utils.formatStringForView(userBean.getUsername())%>"><%=Utils.formatStringForView(userBean.getUsername())%></TD>
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
													<OPTION value="<%=areaId%>" <%=(userBean.getAreas().contains(areaId))?"selected":""%>><%=areaDesc%></OPTION>
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
											<%if((userBean.getId_role().equals(Constants.idRoleEndUser) || user.getId_role().equals(Constants.idRoleManager)) && userBean.getAreas().size() > 0){%>
											<TD width="25%" class="text_12_black"><B>Country*</B></TD>
											<TD width="50%" class="text_12_black">
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