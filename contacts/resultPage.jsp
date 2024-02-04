<%@page contentType="text/html" import="it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id_search = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String publication_id_search = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
String firstname_search = (request.getParameter("firstname_search")==null)?"":request.getParameter("firstname_search");
String lastname_search = (request.getParameter("lastname_search")==null)?"":request.getParameter("lastname_search");
String city_search = (request.getParameter("city_search")==null)?"":request.getParameter("city_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

String backPage = (request.getAttribute("BACK_PAGE")==null)?"":request.getAttribute("BACK_PAGE").toString();
String message = (request.getAttribute("MSG")==null)?"GENERIC_ERROR":request.getAttribute("MSG").toString();
if(!message.equals("")) message = ReadErrorLabelFile.getParameter(message);

String contactId = (request.getParameter("contact_id")==null)?"":request.getParameter("contact_id");
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
	<INPUT type="hidden" name="contact_id" value="<%=contactId%>">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id" value="<%=area_id_search%>">
	<INPUT type="hidden" name="country_id" value="<%=country_id_search%>">
	<INPUT type="hidden" name="publication_id" value="<%=publication_id_search%>">
	<INPUT type="hidden" name="firstname_search" value="<%=Utils.formatStringForView(firstname_search)%>">
	<INPUT type="hidden" name="lastname_search" value="<%=Utils.formatStringForView(lastname_search)%>">
	<INPUT type="hidden" name="city_search" value="<%=Utils.formatStringForView(city_search)%>">
	<INPUT type="hidden" name="country_search" value="<%=Utils.formatStringForView(country_search)%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>CONTACTS - RESULT OPERATION PAGE</B></TD>
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
