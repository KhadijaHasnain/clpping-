<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
			document.search_form.action="<%=request.getContextPath()%>/reports/newTextReport.jsp";
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
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

int yearFrom = Integer.parseInt(year_from);
int yearTo = Integer.parseInt(year_to);
int quarterFrom = Integer.parseInt(quarter_from);
int quarterTo = Integer.parseInt(quarter_to);
int contatoreQuadrimestreFrom = 1;
int contatoreQuadrimestreTo = 4;
if(yearFrom == yearTo) {
	contatoreQuadrimestreFrom = quarterFrom;
	contatoreQuadrimestreTo = quarterTo;
}

String count = "";
String score = "";
int k = 0;
Hashtable distinctSections = (request.getAttribute("distinctSections")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSections");
Enumeration distinctSectionsEnum = distinctSections.keys();
Hashtable distinctSectionsScore = (request.getAttribute("distinctSectionsScore")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsScore");
Hashtable distinctSectionsCount = (request.getAttribute("distinctSectionsCount")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsCount");
Hashtable yearScoreTotal = (request.getAttribute("yearScoreTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearScoreTotal");
Hashtable yearCountTotal = (request.getAttribute("yearCountTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearCountTotal");
Hashtable quarterScoreTotal = (request.getAttribute("quarterScoreTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("quarterScoreTotal");
Hashtable quarterCountTotal = (request.getAttribute("quarterCountTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("quarterCountTotal");
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
					<TD class="text_13_blu"><B>REPORTS - NEW TEXT REPORT RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/reportNewText.do" method="POST">
						<INPUT type="hidden" name="area_id" value="<%=area_id%>">
						<INPUT type="hidden" name="country_id" value="<%=country_id%>">
						<INPUT type="hidden" name="section" value="<%=section%>">
						<INPUT type="hidden" name="trend" value="<%=trend%>">
						<INPUT type="hidden" name="month_from" value="<%=month_from%>">
						<INPUT type="hidden" name="month_to" value="<%=month_to%>">
						<INPUT type="hidden" name="quarter_from" value="<%=quarter_from%>">
						<INPUT type="hidden" name="quarter_to" value="<%=quarter_to%>">
						<INPUT type="hidden" name="year_from" value="<%=year_from%>">
						<INPUT type="hidden" name="year_to" value="<%=year_to%>">
						<INPUT type="hidden" name="format" value="<%=format%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Report Form" onclick="javascript:backToSearch()" class="button">
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD class="text_13_blu" style="text-align:center;"><B>Quarterly Report</B></TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<TR>
											<TD class="td_table_title">Score (Points)</TD>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
												if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <= quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="td_table_title"><%=i%></TD>
											<%	}
											}%>
										<%}%>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="td_table_title"><%=i%></TD>
										<%}%>
										</TR>
										<TR>
											<TD class="td_table_title">&nbsp;</TD>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
												if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="td_table_title"><%=String.valueOf(j)+"Q"%></TD>
											<%	}
											}%>
										<%}%>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="td_table_title">YT</TD>
										<%}%>
										</TR>
										<%while(distinctSectionsEnum.hasMoreElements()) {
											String styleClass = (k%2 > 0)?"td_record_table1":"td_record_table2";
											k++;
											String id = distinctSectionsEnum.nextElement().toString();
											String name = distinctSections.get(id).toString();
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=name%></TD>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
												<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
													if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
														score = "";
														try{
															score = ((Hashtable)distinctSectionsScore.get(id)).get(i + "_" + j).toString();
														}catch(Exception e){}
												%>
												<TD class="<%=styleClass%>"><%=score%></TD>
												<%	}
												}%>
											<%}%>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="<%=styleClass%>"><B><%=(yearScoreTotal.get(id + "_" + i)==null)?"":yearScoreTotal.get(id + "_" + i)%></B></TD>
											<%}%>
										</TR>
										<%}
										String styleClass = (k%2 > 0)?"td_record_table1":"td_record_table2";
										%>
										<TR>
											<TD class="<%=styleClass%>"><B>TOTAL</B></TD>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
											if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="<%=styleClass%>"><B><%=(quarterScoreTotal.get(i + "_" + j)==null)?"":quarterScoreTotal.get(i + "_" + j)%></B></TD>
											<%	}
											}%>
											<%}%>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="<%=styleClass%>">&nbsp;</TD>
											<%}%>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<TR>
											<TD class="td_table_title">Number of clippings</TD>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
												if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="td_table_title"><%=i%></TD>
											<%	}
											}%>
										<%}%>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="td_table_title"><%=i%></TD>
										<%}%>
										</TR>
										<TR>
											<TD class="td_table_title">&nbsp;</TD>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
												if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="td_table_title"><%=String.valueOf(j)+"Q"%></TD>
											<%	}
											}%>
										<%}%>
										<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="td_table_title">YT</TD>
										<%}%>
										</TR>
										<%distinctSectionsEnum = distinctSections.keys();
										while(distinctSectionsEnum.hasMoreElements()) {
											styleClass = (k%2 > 0)?"td_record_table1":"td_record_table2";
											k++;
											String id = distinctSectionsEnum.nextElement().toString();
											String name = distinctSections.get(id).toString();
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=name%></TD>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
												<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
													if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
														count = "";
														try{
															count = ((Hashtable)distinctSectionsCount.get(id)).get(i + "_" + j).toString();
														}catch(Exception e){}
												%>
												<TD class="<%=styleClass%>"><%=count%></TD>
												<%	}
												}%>
											<%}%>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="<%=styleClass%>"><B><%=(yearCountTotal.get(id + "_" + i)==null)?"":yearCountTotal.get(id + "_" + i)%></B></TD>
											<%}%>
										</TR>
										<%}
										styleClass = (k%2 > 0)?"td_record_table1":"td_record_table2";
										%>
										<TR>
											<TD class="<%=styleClass%>"><B>TOTAL</B></TD>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<%for(int j = contatoreQuadrimestreFrom; j<=contatoreQuadrimestreTo; j++) {
											if( (i==yearFrom && j >= quarterFrom) || (i==yearTo && j <=quarterTo) || (i!=yearFrom && i != yearTo) ) {
											%>
											<TD class="<%=styleClass%>"><B><%=(quarterCountTotal.get(i + "_" + j)==null)?"":quarterCountTotal.get(i + "_" + j)%></B></TD>
											<%	}
											}%>
											<%}%>
											<%for(int i = yearFrom; i <= yearTo; i++) {%>
											<TD class="<%=styleClass%>">&nbsp;</TD>
											<%}%>
										</TR>
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