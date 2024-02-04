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
			if(document.report_form.trend[0].checked == true) {
				document.report_form.action = "<%=request.getContextPath()%>/reportNewTextMonthly.do";
			} else if(document.report_form.trend[1].checked == true) {
				document.report_form.action = "<%=request.getContextPath()%>/reportNewTextQuarterly.do";
			} else {
				document.report_form.action = "<%=request.getContextPath()%>/reportNewTextYearly.do";
			}
			document.report_form.submit();
		}
		function reloadForm(){
			document.report_form.action="<%=request.getContextPath()%>/reports/newTextReport.jsp";
			document.report_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.report_form.area_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() > 1) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() == 1)){%>
				document.report_form.country_id.focus();
			<%}else if((user.getId_role().equals(Constants.idRoleEndUser) && user.getCountries().size() == 1)){%>
				document.report_form.section.focus();
			<%}%>
			
		}
		function resetForm(){
			document.location.href = "<%=request.getContextPath()%>/reports/newTextReport.jsp";
		}
	</SCRIPT>
</HEAD>

<%
String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);

String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String section = (request.getParameter("section")==null)?"":request.getParameter("section");
String trend = (request.getParameter("trend")==null)?"":request.getParameter("trend");
String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
String quarter_from = (request.getParameter("quarter_from")==null)?"":request.getParameter("quarter_from");
String quarter_to = (request.getParameter("quarter_to")==null)?"":request.getParameter("quarter_to");
String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
String format = (request.getParameter("format")==null)?"":request.getParameter("format");
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
					<TD class="text_13_blu"><B>REPORTS - NEW TEXT REPORT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="report_form" action="<%=request.getContextPath()%>/reportNewText.do" method="POST">
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
													<OPTION value="<%=areaId%>" <%=(areaId.equals(id_area))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											<%}else{%>
												<%=areaDescription%>
												<INPUT type="hidden" name="area_id" value="<%=id_area%>">
											<%}%>
											</TD>
										</TR>
										<%if(!section.equals("press_release")){%>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD class="text_12_black">
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
										<%}%>
										<TR>
											<TD class="text_12_black"><B>Section*</B></TD>
											<TD class="text_12_black">
											<SELECT name="section" class="select" onchange="javascript:reloadForm()">
												<OPTION value=""></OPTION>
												<OPTION value="press_release" <%=(section.equals("press_release"))?"selected":""%>>Press Release</OPTION>
												<OPTION value="publication" <%=(section.equals("publication"))?"selected":""%>>Publication</OPTION>
												<OPTION value="rank_of_media" <%=(section.equals("rank_of_media"))?"selected":""%>>Rank of Media</OPTION>
												<OPTION value="type_of_media" <%=(section.equals("type_of_media"))?"selected":""%>>Type of Media</OPTION>
												<OPTION value="type_of_story" <%=(section.equals("type_of_story"))?"selected":""%>>Type of Story</OPTION>
											</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Period Option*</B></TD>
											<TD class="text_12_black">
												MONTHLY <INPUT type="radio" name="trend" value="monthly" <%=(trend.equals("monthly") || trend.equals(""))?"checked":""%> class="radio" onclick="javascript:reloadForm()"> 
												QUARTERLY <INPUT type="radio" name="trend" value="quarterly" <%=trend.equals("quarterly")?"checked":""%> class="radio" onclick="javascript:reloadForm()">
												YEARLY <INPUT type="radio" name="trend" value="yearly" <%=trend.equals("yearly")?"checked":""%> class="radio" onclick="javascript:reloadForm()">
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Interval Date*</B></TD>
											<TD class="text_12_black">
												From&nbsp;
												<%if(trend.equals("monthly") || trend.equals("")){%>
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
												<%}else if(trend.equals("quarterly")){%>
												<SELECT name="quarter_from" class="select_year">
													<OPTION value="01" <%=(quarter_from.equals("01"))?"selected":""%>>1Q</OPTION>
													<OPTION value="02" <%=(quarter_from.equals("02"))?"selected":""%>>2Q</OPTION>
													<OPTION value="03" <%=(quarter_from.equals("03"))?"selected":""%>>3Q</OPTION>
													<OPTION value="04" <%=(quarter_from.equals("04"))?"selected":""%>>4Q</OPTION>
												</SELECT>
												<%}%>
												<SELECT name="year_from" class="select_year">
													<OPTION value=""></OPTION>
													<%for (int i=1999; i<=2020; i++){%>
														<OPTION value="<%=i%>" <%=(year_from.equals(String.valueOf(i)))?"selected":""%>><%=i%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black">&nbsp;</TD>
											<TD class="text_12_black">
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<%if(trend.equals("monthly") || trend.equals("")){%>
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
												<%}else if(trend.equals("quarterly")){%>
												<SELECT name="quarter_to" class="select_year">
													<OPTION value="01" <%=(quarter_to.equals("01"))?"selected":""%>>1Q</OPTION>
													<OPTION value="02" <%=(quarter_to.equals("02"))?"selected":""%>>2Q</OPTION>
													<OPTION value="03" <%=(quarter_to.equals("03"))?"selected":""%>>3Q</OPTION>
													<OPTION value="04" <%=(quarter_to.equals("04"))?"selected":""%>>4Q</OPTION>
												</SELECT>
												<%}%>
												<SELECT name="year_to" class="select_year">
													<OPTION value=""></OPTION>
													<%for (int i=1999; i<=2020; i++){%>
														<OPTION value="<%=i%>" <%=(year_to.equals(String.valueOf(i)))?"selected":""%>><%=i%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Format*</B></TD>
											<TD class="text_12_black">
												<SELECT name="format" class="select">
													<OPTION value=""></OPTION>
													<OPTION value="web" <%=(format.equals("web"))?"selected":""%>>WEB</OPTION>
													<OPTION value="excel" <%=(format.equals("excel"))?"selected":""%>>EXCEL</OPTION>
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