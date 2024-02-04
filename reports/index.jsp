<%@page contentType="text/html" import="it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
</HEAD>

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
					<TD class="text_13_blu"><B>REPORTS</B></TD>		
				</TR>
				<TR>
					<TD>
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD class="text_12_black"><B>TEXT REPORT:</B></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/newTextReport.jsp">NEW TEXT REPORT</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/importantTitles.jsp">IMPORTANT TITLES REPORT</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/textReport.jsp">TEXT REPORT</A></TD>
										</TR>
										<TR><TD>&nbsp;</TD></TR>
										<TR>
											<TD class="text_12_black"><B>GRAPHIC REPORT:</B></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/graphicReport.jsp?type=1">Scoring in N° of CLIPPINGS</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/graphicReport.jsp?type=2">Scoring in N° of POINTS</A></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><A href="<%=request.getContextPath()%>/reports/graphicReport.jsp?type=3">TREND</A></TD>
										</TR>
									</TABLE>
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