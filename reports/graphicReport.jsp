<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<%
String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);

String type = (request.getParameter("type")==null)?"":request.getParameter("type");
String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
String type_graph = (request.getParameter("type_graph")==null)?"":request.getParameter("type_graph");
String image_title = "";
if(!type.equals("3"))
	image_title = (request.getParameter("image_title")==null)?"ST Report":request.getParameter("image_title");
else
	image_title = (request.getParameter("image_title")==null)?"ST Report (Value * 100)":request.getParameter("image_title");
String label_x = (request.getParameter("label_x")==null)?"Label X":request.getParameter("label_x");
String label_y = (request.getParameter("label_y")==null)?"Label Y":request.getParameter("label_y");
String trendoption = (request.getParameter("trendoption")==null)?"":request.getParameter("trendoption");
String year_type = (request.getParameter("year_type")==null)?"":request.getParameter("year_type");

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
Vector audiences = DbUtils.getAudiences();
Vector countries = new Vector();
if(request.getParameter("area_id")!=null){
	id_area = request.getParameter("area_id").toString();
	countries = DbUtils.getCountriesForAdminSearch(id_area);	
}else{
	countries = DbUtils.getCountries(id_area, user.getCountries(), "");
}

String pageTitle = "Scoring in N° of CLIPPINGS";
if(type.equals("2")) {
	pageTitle = "Scoring in N° of POINTS";
}else if(type.equals("3")) {
	pageTitle = "TREND";
}
%>

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			<%if(!type.equals("3")){%>
			document.report_form.action="<%=request.getContextPath()%>/graphicReport.do";
			<%}else{%>
			document.report_form.action="<%=request.getContextPath()%>/trendReport.do";
			<%}%>
			document.report_form.submit();
		}
		function reloadForm(){
			document.report_form.action="<%=request.getContextPath()%>/reports/graphicReport.jsp";
			document.report_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.report_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.report_form.country_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1)){%>
				document.report_form.audience_id.focus();
			<%}%>
			
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/reports/graphicReport.jsp";
		}
	</SCRIPT>
</HEAD>

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
					<TD class="text_13_blu"><B>REPORTS - <%=pageTitle%></B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="report_form" action="<%=request.getContextPath()%>/reports/graphicReport.jsp" method="POST">
						<INPUT type="hidden" name="type" value="<%=type%>">
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
											<TD class="text_12_black"><B>Audience</B></TD>
											<TD>
												<SELECT name="audience_id" class="select">
													<OPTION value="">Total</OPTION>
													<%for(int i=0; i < audiences.size(); i++){
														String audienceId = ((Hashtable)audiences.elementAt(i)).get("audienceid").toString();
														String audienceDesc = ((Hashtable)audiences.elementAt(i)).get("audience").toString();
													%>
													<OPTION value="<%=audienceId%>" <%=(audienceId.equals(audience_id))?"selected":""%>><%=audienceDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date*</B><!--<FONT size=1>&nbsp;(max 12 months)</FONT>--></TD>
											<TD class="text_12_black">From&nbsp;
												<SELECT name="month_from" class="select_month">
													<OPTION value=""></OPTION>
													<OPTION value="01" <%=(month_from.equals("01"))?"selected":""%>>January</OPTION>
													<OPTION value="02" <%=(month_from.equals("02"))?"selected":""%>>February</OPTION>
													<OPTION value="03" <%=(month_from.equals("03"))?"selected":""%>>March</OPTION>
													<OPTION value="04" <%=(month_from.equals("04"))?"selected":""%>>April</OPTION>
													<OPTION value="05" <%=(month_from.equals("05"))?"selected":""%>>May</OPTION>
													<OPTION value="06" <%=(month_from.equals("06"))?"selected":""%>>June</OPTION>
													<OPTION value="07" <%=(month_from.equals("07"))?"selected":""%>>July</OPTION>
													<OPTION value="08" <%=(month_from.equals("08"))?"selected":""%>>August</OPTION>
													<OPTION value="09" <%=(month_from.equals("09"))?"selected":""%>>September</OPTION>
													<OPTION value="10" <%=(month_from.equals("10"))?"selected":""%>>October</OPTION>
													<OPTION value="11" <%=(month_from.equals("11"))?"selected":""%>>November</OPTION>
													<OPTION value="12" <%=(month_from.equals("12"))?"selected":""%>>December</OPTION>
												</SELECT>
												<SELECT name="year_from" class="select_year">
													<OPTION value=""></OPTION>
													<%for (int i=1999; i<=2020; i++){%>
														<OPTION value="<%=i%>" <%=(year_from.equals(String.valueOf(i)))?"selected":""%>><%=i%></OPTION>
													<%}%>
												</SELECT>		   
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<SELECT name="month_to" class="select_month">
													<OPTION value=""></OPTION>
													<OPTION value="01" <%=(month_to.equals("01"))?"selected":""%>>January</OPTION>
													<OPTION value="02" <%=(month_to.equals("02"))?"selected":""%>>February</OPTION>
													<OPTION value="03" <%=(month_to.equals("03"))?"selected":""%>>March</OPTION>
													<OPTION value="04" <%=(month_to.equals("04"))?"selected":""%>>April</OPTION>
													<OPTION value="05" <%=(month_to.equals("05"))?"selected":""%>>May</OPTION>
													<OPTION value="06" <%=(month_to.equals("06"))?"selected":""%>>June</OPTION>
													<OPTION value="07" <%=(month_to.equals("07"))?"selected":""%>>July</OPTION>
													<OPTION value="08" <%=(month_to.equals("08"))?"selected":""%>>August</OPTION>
													<OPTION value="09" <%=(month_to.equals("09"))?"selected":""%>>September</OPTION>
													<OPTION value="10" <%=(month_to.equals("10"))?"selected":""%>>October</OPTION>
													<OPTION value="11" <%=(month_to.equals("11"))?"selected":""%>>November</OPTION>
													<OPTION value="12" <%=(month_to.equals("12"))?"selected":""%>>December</OPTION>
												</SELECT>
												<SELECT name="year_to" class="select_year">
													<OPTION value=""></OPTION>
													<%for (int i=1999; i<=2020; i++){%>
														<OPTION value="<%=i%>" <%=(year_to.equals(String.valueOf(i)))?"selected":""%>><%=i%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Diagram Type:</B></TD>
											<TD class="text_12_black">
												<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
													<%if(!type.equals("3")){%>
													<TR>
														<TD>
															<INPUT type="radio" name="type_graph" value="verticalBar" <%=(type_graph.equals("verticalBar") || type_graph.equals(""))?"checked":""%> class="radio">Vertical Bar
														</TD>
													</TR>
													<TR>
														<TD>
															<INPUT type="radio" name="type_graph" value="horizontalBar" <%=type_graph.equals("horizontalBar")?"checked":""%> class="radio">Horizontal Bar
														</TD>
													</TR>
													<TR>
														<TD>
															<INPUT type="radio" name="type_graph" value="stackedVerticalBar" <%=type_graph.equals("stackedVerticalBar")?"checked":""%> class="radio">Stacked Vertical Bar
														</TD>
													</TR>
													<TR>
														<TD>
															<INPUT type="radio" name="type_graph" value="line" <%=type_graph.equals("line")?"checked":""%> class="radio">Line
														</TD>
													</TR>
													<%}else{%>
													<TR>
														<TD>
															<INPUT type="radio" name="type_graph" value="line" <%=(type_graph.equals("") || type_graph.equals("line"))?"checked":""%> class="radio">Line
														</TD>
													</TR>
													<%}%>
												</TABLE> 
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Image Title:</B></TD>
											<TD class="text_12_black"><INPUT type="text" name="image_title" value="<%=image_title%>" class="input_text"></TD>
										<TR>
										<TR>
											<TD class="text_12_black"><B>Axis Label:</B></TD>
											<TD class="text_12_black">
												<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
													<TR>
														<TD>
															<INPUT type="text" name="label_x" value="<%=label_x%>" class="input_text">
														</TD>
													</TR>
													<TR>
														<TD>
															<INPUT type="text" name="label_y" value="<%=label_y%>" class="input_text">
														</TD>
													</TR>
												</TABLE>
											</TD>
										</TR>
										<%if(type.equals("3")) {%>
										<TR>
											<TD class="text_12_black"><B>Trend Option*:</B></TD>
											<TD class="text_12_black">
												<INPUT type="checkbox" name="trendoption" value="ANNUAL" <%=trendoption.equals("ANNUAL")?"checked":""%> class="checkbox">Annual&nbsp;&nbsp;&nbsp;
												<INPUT type="checkbox" name="trendoption" value="SEMIANNUAL" <%=trendoption.equals("SEMIANNUAL")?"checked":""%> class="checkbox">Halfyear&nbsp;&nbsp;&nbsp;
												<INPUT type="checkbox" name="trendoption" value="QUARTERLY" <%=trendoption.equals("QUARTERLY")?"checked":""%> class="checkbox">Quarterly&nbsp;&nbsp;&nbsp;
											</TD>
										</TR>
										<%} else {%>
										<TR>
											<TD class="text_12_black"><B>Year:</B></TD>
											<TD class="text_12_black">
												<INPUT type="radio" name="year_type" value="selected" <%=(year_type.equals("selected") || year_type.equals(""))?"checked":""%> class="radio">Selected Year&nbsp;&nbsp;&nbsp;
												<INPUT type="radio" name="year_type" value="selected_previous" <%=year_type.equals("selected_previous")?"checked":""%> class="radio">Selected Year vs previous
											</TD>
										</TR>
										<%}%>
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
									<!--<INPUT type="button" name="reset_form_button" value="Reset" class="button" onclick="javascript:resetForm()">-->
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