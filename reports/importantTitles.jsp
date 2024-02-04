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
			document.report_form.submit();
		}
		function reloadForm(){
			document.report_form.action="<%=request.getContextPath()%>/reports/importantTitles.jsp";
			submitForm();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.report_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.report_form.country_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1)){%>
				document.report_form.score_min.focus();
			<%}%>
			
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/reports/importantTitles.jsp";
		}
	</SCRIPT>
</HEAD>

<%
String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);

String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String score_min = (request.getParameter("score_min")==null)?"":request.getParameter("score_min");
String score_max = (request.getParameter("score_max")==null)?"":request.getParameter("score_max");
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
					<jsp:param name="section_help" value="reports"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>REPORTS - IMPORTANT TITLES REPORT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="report_form" action="<%=request.getContextPath()%>/reportImportantTitles.do" method="POST">
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
												<SELECT name="country_id" class="select_text_small">
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
											<TD class="text_12_black"><B>Score*</B></TD>
											<TD class="text_12_black" colspan="2">
												>&nbsp;
												<INPUT type="text" name="score_min" value="<%=score_min%>" class="input_text_small" maxlength="38">
												&nbsp;&nbsp;&nbsp;&nbsp;<&nbsp;
												<INPUT type="text" name="score_max" value="<%=score_max%>" class="input_text_small" maxlength="38">
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date*</B></TD>
											<TD class="text_12_black">
												From&nbsp;
												<INPUT type="text" name="date_from" value="<%=date_from%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.report_form.date_from)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<INPUT type="text" name="date_to" value="<%=date_to%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.report_form.date_to)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
											</TD>
											<TD width="20%" class="text_12_black"><%=Constants.STRINGdateFormat%></TD>
										</TR>
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