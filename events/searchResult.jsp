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
			document.search_form.action="<%=request.getContextPath()%>/events/search.jsp";
			document.search_form.submit();
		}
		function goToModifyPage(eventId){
			document.search_form.action="<%=request.getContextPath()%>/events/modify.jsp";
			document.search_form.event_id.value=eventId;
			document.search_form.submit();
		}
		function goToDelete(eventId){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_EVENT")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageEvent.do";
				document.search_form.operation.value="delete";
				document.search_form.event_id.value=eventId;
				document.search_form.submit();
			}
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String eventtitle_search = (request.getParameter("eventtitle_search")==null)?"":request.getParameter("eventtitle_search");
String eventtype_id_search = (request.getParameter("eventtype_id_search")==null)?"":request.getParameter("eventtype_id_search");
String prref_search = (request.getParameter("prref_search")==null)?"":request.getParameter("prref_search");
String productorsubject_search = (request.getParameter("productorsubject_search")==null)?"":request.getParameter("productorsubject_search");
String eventdate_from_search = (request.getParameter("eventdate_from_search")==null)?"":request.getParameter("eventdate_from_search");
String eventdate_to_search = (request.getParameter("eventdate_to_search")==null)?"":request.getParameter("eventdate_to_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchEvents(area_id_search, eventtitle_search, eventtype_id_search, prref_search, productorsubject_search, eventdate_from_search, eventdate_to_search, user);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="events"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>EVENTS - SEARCH EVENT RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/events/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="eventtitle_search" value="<%=Utils.formatStringForView(eventtitle_search)%>">
						<INPUT type="hidden" name="eventtype_id_search" value="<%=eventtype_id_search%>">
						<INPUT type="hidden" name="prref_search" value="<%=Utils.formatStringForView(prref_search)%>">
						<INPUT type="hidden" name="productorsubject_search" value="<%=Utils.formatStringForView(productorsubject_search)%>">
						<INPUT type="hidden" name="eventdate_from_search" value="<%=eventdate_from_search%>">
						<INPUT type="hidden" name="eventdate_to_search" value="<%=eventdate_to_search%>">
						<INPUT type="hidden" name="event_id" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="97%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="vertical-align: middle;width:16%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:50%;">Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:14%;">Type</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Date</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String eventtitle = ((Hashtable)resultVector.elementAt(i)).get("eventtitle").toString();
											String eventtypeId = ((Hashtable)resultVector.elementAt(i)).get("eventtypeid").toString();
											String eventdate = ((Hashtable)resultVector.elementAt(i)).get("eventdate").toString();
											String areaDesc = "";
											String typeDesc = "";
											String eventId = ((Hashtable)resultVector.elementAt(i)).get("eventid").toString();

											if(!areaId.equals("")) areaDesc = DbUtils.getAreaDescription(areaId);
											if(!eventtypeId.equals("")) typeDesc = DbUtils.getTypeDescription(eventtypeId);
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(eventtitle)%></TD>
											<TD class="<%=styleClass%>"><%=typeDesc%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatDateForView(eventdate)%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=eventId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Event"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=eventId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Event"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="6" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO EVENTS WITH THE SEARCHING PARAMETERS</B></TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
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