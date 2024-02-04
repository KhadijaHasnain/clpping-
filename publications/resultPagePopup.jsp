<%@page contentType="text/html" import="it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<HTML>

<%
String message = (request.getAttribute("MSG")==null)?"":request.getAttribute("MSG").toString();
String publicationId = (request.getAttribute("PUBLICATION_ID")==null)?"":request.getAttribute("PUBLICATION_ID").toString();
String countryId = (request.getAttribute("COUNTRY_ID")==null)?"":request.getAttribute("COUNTRY_ID").toString();
if(!message.equals("")) message = ReadErrorLabelFile.getParameter(message);
%>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function test(){
			opener.document.section_form.operation.value="reload";
			opener.document.section_form.country_id.value='<%=countryId%>';
			var oOption = opener.window.document.createElement("OPTION");
			opener.window.document.section_form.publication_id.options.add(oOption);
			oOption.innerText = "";
			oOption.value = '<%=publicationId%>';
			opener.window.document.section_form.publication_id.value="<%=publicationId%>";
			opener.document.section_form.submit();
			closeWindow();
		}
		window.setTimeout('test();', 1500);
	</SCRIPT>
</HEAD>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	<TR>
		<TD>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - RESULT OPERATION PAGE</B></TD>
				</TR>
				<TR>
					<TD>
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR>
								<TD height="100" class="text_14_red" style="text-align:center;vertical-align:middle;"><B><%=message%></B></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>

</BODY>

</HTML>
