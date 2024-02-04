<%@page contentType="text/html" import="java.util.*,java.math.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
	<SCRIPT language="javascript">
		function backToSearch(){
			document.search_form.action="<%=request.getContextPath()%>/reports/graphicReport.jsp";
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String type = (request.getParameter("type")==null)?"":request.getParameter("type");
String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
String type_graph = (request.getParameter("type_graph")==null)?"":request.getParameter("type_graph");
String image_title = (request.getParameter("image_title")==null)?"St Report":request.getParameter("image_title");
String label_x = (request.getParameter("label_x")==null)?"Label X":request.getParameter("label_x");
String label_y = (request.getParameter("label_y")==null)?"Label Y":request.getParameter("label_y");
String year_type = (request.getParameter("year_type")==null)?"":request.getParameter("year_type");

boolean styleFlag = false;
String count = "";
String styleClass = "";
Hashtable audienceHash = null;

Hashtable<String, Hashtable> resultHash = (session.getAttribute("resultHash")==null)?new Hashtable():(Hashtable)session.getAttribute("resultHash");
ArrayList<String> monthList = (session.getAttribute("monthList")==null)?new ArrayList():(ArrayList)session.getAttribute("monthList");
ArrayList<String> audienceList = (session.getAttribute("audienceList")==null)?new ArrayList():(ArrayList)session.getAttribute("audienceList");
%>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="reports"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>REPORTS - GRAPHIC REPORT RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/reports/graphicReport.jsp" method="POST">
						<INPUT type="hidden" name="type" value="<%=type%>">
						<INPUT type="hidden" name="area_id" value="<%=area_id%>">
						<INPUT type="hidden" name="country_id" value="<%=country_id%>">
						<INPUT type="hidden" name="audience_id" value="<%=audience_id%>">
						<INPUT type="hidden" name="month_from" value="<%=month_from%>">
						<INPUT type="hidden" name="month_to" value="<%=month_to%>">
						<INPUT type="hidden" name="year_from" value="<%=year_from%>">
						<INPUT type="hidden" name="year_to" value="<%=year_to%>">
						<INPUT type="hidden" name="type_graph" value="<%=type_graph%>">
						<INPUT type="hidden" name="image_title" value="<%=image_title%>">
						<INPUT type="hidden" name="label_x" value="<%=label_x%>">
						<INPUT type="hidden" name="label_y" value="<%=label_y%>">
						<INPUT type="hidden" name="year_type" value="<%=year_type%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Report Form" onclick="javascript:backToSearch()" class="button">
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD class="text_13_blu" style="text-align:center;"><B>Graphic Report</B></TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<%if(type_graph.equals("verticalBar")){%>
										<img src="<%=request.getContextPath()%>/VerticalBarChart.do">
									<%}else if(type_graph.equals("horizontalBar")){%>
										<img src="<%=request.getContextPath()%>/HorizontalBarChart.do">
									<%}else if(type_graph.equals("stackedVerticalBar")){%>
										<img src="<%=request.getContextPath()%>/StackedVerticalBarChart.do">
									<%}else if(type_graph.equals("line")){%>
										<img src="<%=request.getContextPath()%>/LineChart.do">
									<%}%>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<TR>
											<TD class="td_table_title">Audience</TD>
											<%if(type.equals("1")){%>
											<TD class="td_table_title">Number of Clippings</TD>
											<%}else if(type.equals("2")){%>
											<TD class="td_table_title">Number of Points</TD>
											<%}%>
											<TD class="td_table_title">Month</TD>
										</TR>
										<%if(year_type.equals("selected")){	
											for(String audience:audienceList){
												audienceHash = resultHash.get(audience);
												for(String month:monthList) {
													styleClass = styleFlag?"td_record_table1":"td_record_table2";
													count = audienceHash.get(month).toString();
													if(type.equals("2")){
														count = Utils.round(count);
													}
													styleFlag = !styleFlag;
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=audience%></TD>
											<TD class="<%=styleClass%>"><%=count%></TD>
											<TD class="<%=styleClass%>"><%=month%></TD>
										</TR>
										<%	}
										}
										}else{
											for(String month:monthList){
												styleClass = styleFlag?"td_record_table1":"td_record_table2";
												for(String audience:audienceList) {
													//styleClass = styleFlag?"td_record_table1":"td_record_table2";
													audienceHash = resultHash.get(audience);
													count = audienceHash.get(month).toString();
													if(type.equals("2")){
														count = Utils.round(count);
													}
													//styleFlag = !styleFlag;
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=audience%></TD>
											<TD class="<%=styleClass%>"><%=count%></TD>
											<TD class="<%=styleClass%>"><%=month%></TD>
										</TR>
										<%		}%>
										<!--<TR><TD colspan="3" class="<%//=styleClass%>">&nbsp;</TD></TR>-->
											<%
											styleFlag = !styleFlag;
											}%>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Report Form" onclick="javascript:backToSearch()" class="button"><B>
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