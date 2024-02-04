<%@page contentType="text/html" import="it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String name_search = (request.getParameter("name_search")==null)?"":request.getParameter("name_search");
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

String backPage = (request.getAttribute("BACK_PAGE")==null)?"":request.getAttribute("BACK_PAGE").toString();
String message = (request.getAttribute("MSG")==null)?"":request.getAttribute("MSG").toString();
if(!message.equals("")) message = ReadErrorLabelFile.getParameter(message);

String divisionId = (request.getParameter("division_id")==null)?"":request.getParameter("division_id");
%>

<HTML>
<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		<%if(!backPage.equals("")){%>
			window.setTimeout('document.form_submit.submit();', 1500);
		<%}%>
	</SCRIPT>
</HEAD>

<BODY>

<FORM name="form_submit" method="POST" action="<%=request.getContextPath() + backPage%>">
	<INPUT type="hidden" name="division_id" value="<%=divisionId%>">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
	<INPUT type="hidden" name="status_search" value="<%=status_search%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>DIVISIONS - RESULT OPERATION PAGE</B></TD>
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
	<%@ include file="/include/footer.jsp" %>
</TABLE>

</BODY>

</HTML>
