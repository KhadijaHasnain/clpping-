<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="eventBean" class="it.vidiemme.clipping.beans.EventBean" scope="request"/>
<jsp:setProperty name="eventBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.insert_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.insert_form.area_id.focus();
			<%}else{%>
				document.insert_form.eventtitle.focus();
			<%}%>
		}
		function goToSearch(){
			document.location.href="<%=request.getContextPath()%>/events/search.jsp";
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
			document.insert_form.area_id.value = "";
			<%}%>
			document.insert_form.eventtitle.value = "";
			document.insert_form.eventtype_id.value = "";
			document.insert_form.eventdate.value = "";
			document.insert_form.prref.value = "";
			document.insert_form.productorsubject.value = "";
		}
	</SCRIPT>
</HEAD>

<%
String id_area = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(id_area.equals(""))
	id_area = eventBean.getArea_id();
String areaDescription = DbUtils.getAreaDescription(id_area);

Vector areas = DbUtils.getAreas(user.getAreas());
Vector types = DbUtils.getTypes();

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
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
					<TD class="text_13_blu"><B>EVENTS - ADD EVENT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="insert_form" action="<%=request.getContextPath()%>/manageEvent.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
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
												<A href="javascript: cal(document.insert_form.eventdate)"><IMG border="0" alt="Insert date" src="<%=request.getContextPath()%>/images/calendar.gif"/></A>&nbsp;&nbsp;&nbsp;<%=Constants.STRINGdateFormat%>
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
									<INPUT type="button" name="reset_form_button" value="Reset" class="button" onclick="javascript:resetForm()">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="search_event_button" value="Search Event" onclick="javascript:goToSearch()" class="button">
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