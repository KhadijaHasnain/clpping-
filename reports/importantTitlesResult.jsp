<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
			document.search_form.action="<%=request.getContextPath()%>/reports/importantTitles.jsp";
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String score_min = (request.getParameter("score_min")==null)?"":request.getParameter("score_min");
String score_max = (request.getParameter("score_max")==null)?"":request.getParameter("score_max");
String date_from = (request.getParameter("date_from")==null)?"":request.getParameter("date_from");
String date_to = (request.getParameter("date_to")==null)?"":request.getParameter("date_to");
String format = (request.getParameter("format")==null)?"":request.getParameter("format");
String paging = (request.getParameter("paging")==null)?"":request.getParameter("paging");

Vector resultVector = (request.getAttribute("results")==null)?new Vector():(Vector)request.getAttribute("results");
%>

<BODY>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="reports"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>REPORTS - IMPORTANT TITLES REPORT RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/reportImportantTitles.do" method="POST">
						<INPUT type="hidden" name="area_id" value="<%=area_id%>">
						<INPUT type="hidden" name="country_id" value="<%=country_id%>">
						<INPUT type="hidden" name="score_min" value="<%=score_min%>">
						<INPUT type="hidden" name="score_max" value="<%=score_max%>">
						<INPUT type="hidden" name="date_from" value="<%=date_from%>">
						<INPUT type="hidden" name="date_to" value="<%=date_to%>">
						<INPUT type="hidden" name="format" value="<%=format%>">
						<INPUT type="hidden" name="paging" value="<%=paging%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Report Form" onclick="javascript:backToSearch()" class="button">
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="97%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:30%;">Publication Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Date Published</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:32%;">Clipping Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Score</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:8%;">Tone</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String publication = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String datepublished = ((Hashtable)resultVector.elementAt(i)).get("datepublished").toString();
											String clipping = ((Hashtable)resultVector.elementAt(i)).get("title").toString();
											String score = ((Hashtable)resultVector.elementAt(i)).get("score").toString();
											String toneId = ((Hashtable)resultVector.elementAt(i)).get("toneid").toString();
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=DbUtils.getAreaDescription(areaId)%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(publication)%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatDateForView(datepublished)%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(clipping)%></TD>
											<TD class="<%=styleClass%>"><%=score%></TD>
											<TD class="<%=styleClass%>"><%=DbUtils.getToneDescription(toneId)%></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="6" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO RESULTS WITH THE SEARCHING PARAMETERS</B></TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Report Form" onclick="javascript:backToSearch()" class="button">								</TD>
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