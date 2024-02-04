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
			document.search_form.submit();
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/events/insert.jsp";
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.search_form.area_id_search.focus();
			<%}else{%>
				document.search_form.eventtitle_search.focus();
			<%}%>
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
			document.search_form.area_id_search.value = "";
			<%}%>
			document.search_form.eventtitle_search.value = "";
			document.search_form.eventtype_id_search.value = "";
			document.search_form.prref_search.value = "";
			document.search_form.productorsubject_search.value = "";
			document.search_form.eventdate_from_search.value = "";
			document.search_form.eventdate_to_search.value = "";
		}
	</SCRIPT>
</HEAD>

<%
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String eventtitle_search = (request.getParameter("eventtitle_search")==null)?"":request.getParameter("eventtitle_search");
String eventtype_id_search = (request.getParameter("eventtype_id_search")==null)?"":request.getParameter("eventtype_id_search");
String prref_search = (request.getParameter("prref_search")==null)?"":request.getParameter("prref_search");
String productorsubject_search = (request.getParameter("productorsubject_search")==null)?"":request.getParameter("productorsubject_search");
String eventdate_from_search = (request.getParameter("eventdate_from_search")==null)?"":request.getParameter("eventdate_from_search");
String eventdate_to_search = (request.getParameter("eventdate_to_search")==null)?"":request.getParameter("eventdate_to_search");

String id_area = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(id_area.equals(""))
	id_area = area_id_search;
String areaDescription = DbUtils.getAreaDescription(id_area);

Vector areas = DbUtils.getAreas(user.getAreas());
Vector types = DbUtils.getTypes();
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="events"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>EVENTS - SEARCH EVENT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/events/searchResult.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
											<%if(areas.size() > 1){%>
												<SELECT name="area_id_search" class="select">
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
												<INPUT type="hidden" name="area_id_search" value="<%=id_area%>">
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Title</B></TD>
											<TD colspan="2"><INPUT type="text" name="eventtitle_search" value="<%=Utils.formatStringForView(eventtitle_search)%>" class="input_text" maxlength="255"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Type</B></TD>
											<TD width="75%" class="text_12_black" colspan="2">
												<SELECT name="eventtype_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < types.size(); i++){
														String typeId = ((Hashtable)types.elementAt(i)).get("eventtypeid").toString();
														String typeDesc = ((Hashtable)types.elementAt(i)).get("description").toString();
													%>
													<OPTION value="<%=typeId%>" <%=(typeId.equals(eventtype_id_search))?"selected":""%>><%=typeDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Pr Ref</B></TD>
											<TD colspan="2"><INPUT type="text" name="prref_search" value="<%=Utils.formatStringForView(prref_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Product or Subject</B></TD>
											<TD colspan="2"><INPUT type="text" name="productorsubject_search" value="<%=Utils.formatStringForView(productorsubject_search)%>" class="input_text" maxlength="255"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date</B></TD>
											<TD class="text_12_black">
												From&nbsp;
												<INPUT type="text" name="eventdate_from_search" value="<%=eventdate_from_search%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.search_form.eventdate_from_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
												&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;
												<INPUT type="text" name="eventdate_to_search" value="<%=eventdate_to_search%>" class="input_text_small" maxlength="11">
												<A href="javascript: cal(document.search_form.eventdate_to_search)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>
											</TD>
											<TD width="20%" class="text_12_black"><%=Constants.STRINGdateFormat%></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Event" onclick="javascript:submitForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_event_button" value="Enter Event" onclick="javascript:goToInsert()" class="button">
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