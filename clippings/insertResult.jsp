<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean,it.vidiemme.clipping.beans.ClippingBean,it.vidiemme.clipping.beans.PublicationBean,it.vidiemme.clipping.beans.EventBean"%>

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
			document.date_form.submit();
		}
		function backToEnterClipping(){
			submitForm();
		}
	
	</SCRIPT>
</HEAD>

<%
// Recupera l'id del clipping di cui visualizzare il dettaglio
String clippingId = (request.getAttribute("CLIPPINGID")==null)?"":request.getAttribute("CLIPPINGID").toString();
ClippingBean clippingBean = new ClippingBean(clippingId);
PublicationBean publicationBean = new PublicationBean(clippingBean.getPublication_id());
EventBean eventBean = new EventBean(clippingBean.getEvent_id());

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>


<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="clippings"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CLIPPINGS - SUMMARY INSERT PAGE</B></TD>
				</TR>
				<TR>
					<TD>
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
						<FORM name="date_form" action="<%=request.getContextPath()%>/clippings/insert.jsp" method="POST">
						<INPUT type="hidden" name="datePublishedClipping" value="<%=clippingBean.getDatepublished()%>">                                                
						</FORM>
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
											<TD class="text_12_black"><B>Area</B></TD>
											<TD class="text_12_black"><%=DbUtils.getAreaDescription(publicationBean.getArea_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD class="text_12_black"><%=(publicationBean.getCountry_id().equals(""))?"":DbUtils.getCountryDescription(publicationBean.getCountry_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Publication Title</B></TD>
											<TD class="text_12_black"><%=Utils.formatStringForView(publicationBean.getName())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Clipping Title</B></TD>
											<TD class="text_12_black"><%=Utils.formatStringForView(clippingBean.getTitle())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Type of Story</B></TD>
											<TD class="text_12_black"><%=(clippingBean.getFieldstory_id().equals(""))?"":DbUtils.getFieldstoryDescription(clippingBean.getFieldstory_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Date</B></TD>
											<TD class="text_12_black"><%=clippingBean.getDatepublished()%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Length of Article</B></TD>
											<TD class="text_12_black"><%=DbUtils.getLengthDescription(clippingBean.getLengthofarticle_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Tone</B></TD>
											<TD class="text_12_black"><%=DbUtils.getToneDescription(clippingBean.getTone_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Graphic</B></TD>
											<TD class="text_12_black"><%=DbUtils.getGraphicDescription(clippingBean.getGraphic_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Cover</B></TD>
											<TD class="text_12_black"><%=(clippingBean.getCover_id().equals(""))?"":DbUtils.getCoverDescription(clippingBean.getCover_id())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Event</B></TD>
											<TD class="text_12_black"><%=Utils.formatStringForView(eventBean.getEventtitle())%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Score</B></TD>
											<TD class="text_12_black"><%=clippingBean.getScore()%></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_insert_button" value="Back To Enter Clipping" onclick="javascript:backToEnterClipping()" class="button">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<%@ include file="/include/footer.jsp" %>
</TABLE>

</BODY>

</HTML>