<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<%
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String name_search = (request.getParameter("name_search")==null)?"":request.getParameter("name_search");

String areaDesc = DbUtils.getAreaDescription(area_id_search);
%>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.search_form.submit();
		}
		function setFocus(){
			document.search_form.name_search.focus()
		}
		function resetForm(){
			document.search_form.name_search.value = "";
		}
	</SCRIPT>
</HEAD>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	<TR>
		<TD>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>DIVISIONS - SEARCH DIVISION</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/divisions/searchResultPopup.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD class="text_12_black"><B>Area</B></TD>
											<TD class="text_12_black"><INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>" class="input_text"><%=areaDesc%></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Name</B></TD>
											<TD><INPUT type="text" name="name_search" value="<%=Utils.formatStringForView(name_search)%>" class="input_text" maxlength="50"></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Division" onclick="javascript:submitForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="close_window_button" value="Close Window" class="button" onclick="javascript:closeWindow()">
								</TD>
							</TR>
						</TABLE>
						</FORM>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>

</BODY>

</HTML>