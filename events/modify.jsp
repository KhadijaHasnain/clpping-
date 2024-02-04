<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean,it.vidiemme.clipping.beans.EventBean"%>

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
			document.update_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.update_form.area_id.focus();
			<%}else{%>
				document.update_form.eventtitle.focus();
			<%}%>
		}
		function backToSearchResult(){
			document.search_form.submit();
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
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id dell'event da modificare
String eventId = (request.getParameter("event_id")==null)?"":request.getParameter("event_id");

EventBean eventBean = new EventBean();
if(request.getAttribute("EVENT_BEAN") == null && !eventId.equals("")){
	// è in modifica ma non è passato dalla servlet
	eventBean = new EventBean(eventId);
}else if(request.getAttribute("EVENT_BEAN") != null){
	// è in modifica ed è passato dalla servlet
	eventBean = (EventBean)request.getAttribute("EVENT_BEAN");
}

// Ottiene dato l'id ad essa relativo, il nome dell'area a cui appartiene l'event da modificare
String areaDescription = DbUtils.getAreaDescription(eventBean.getArea_id());
String area_id = (request.getParameter("area_id")==null)?eventBean.getArea_id():request.getParameter("area_id");
Vector areas = DbUtils.getAreas(user.getAreas());
Vector types = DbUtils.getTypes();

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/events/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="eventtitle_search" value="<%=Utils.formatStringForView(eventtitle_search)%>">
	<INPUT type="hidden" name="eventtype_id_search" value="<%=eventtype_id_search%>">
	<INPUT type="hidden" name="prref_search" value="<%=Utils.formatStringForView(prref_search)%>">
	<INPUT type="hidden" name="productorsubject_search" value="<%=Utils.formatStringForView(productorsubject_search)%>">
	<INPUT type="hidden" name="eventdate_from_search" value="<%=eventdate_from_search%>">
	<INPUT type="hidden" name="eventdate_to_search" value="<%=eventdate_to_search%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="events"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>EVENTS - MODIFY EVENT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="update_form" action="<%=request.getContextPath()%>/manageEvent.do" method="POST">
						<INPUT type="hidden" name="reload" value="true">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="event_id" value="<%=eventBean.getEvent_id()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="eventtitle_search" value="<%=Utils.formatStringForView(eventtitle_search)%>">
						<INPUT type="hidden" name="eventtype_id_search" value="<%=eventtype_id_search%>">
						<INPUT type="hidden" name="prref_search" value="<%=Utils.formatStringForView(prref_search)%>">
						<INPUT type="hidden" name="productorsubject_search" value="<%=productorsubject_search%>">
						<INPUT type="hidden" name="eventdate_from_search" value="<%=eventdate_from_search%>">
						<INPUT type="hidden" name="eventdate_to_search" value="<%=eventdate_to_search%>">
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
												<SELECT name="area_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(area_id))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											<%}else{%>
												<%=areaDescription%>
												<INPUT type="hidden" name="area_id" value="<%=area_id%>">
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Title*</B></TD>
											<TD><INPUT type="text" name="eventtitle" value="<%=Utils.formatStringForView(eventBean.getEventtitle())%>" class="input_text" maxlength="255"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Type*</B></TD>
											<TD width="75%" class="text_12_black">
												<SELECT name="eventtype_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < types.size(); i++){
														String typeId = ((Hashtable)types.elementAt(i)).get("eventtypeid").toString();
														String typeDesc = ((Hashtable)types.elementAt(i)).get("description").toString();
													%>
													<OPTION value="<%=typeId%>" <%=(typeId.equals(eventBean.getEventtype_id()))?"selected":""%>><%=typeDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Event Date*</B></TD>
											<TD class="text_12_black">
												<INPUT type="text" name="eventdate" value="<%=eventBean.getEventdate()%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.update_form.eventdate)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Pr Ref*</B></TD>
											<TD><INPUT type="text" name="prref" value="<%=Utils.formatStringForView(eventBean.getPrref())%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Product or Subject*</B></TD>
											<TD><INPUT type="text" name="productorsubject" value="<%=Utils.formatStringForView(eventBean.getProductorsubject())%>" class="input_text" maxlength="255"></TD>
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