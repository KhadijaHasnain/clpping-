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
String last_rated_from_search = (request.getParameter("last_rated_from_search")==null)?"":request.getParameter("last_rated_from_search");
String last_rated_to_search = (request.getParameter("last_rated_to_search")==null)?"":request.getParameter("last_rated_to_search");
String audience_id_search = (request.getParameter("audience_id_search")==null)?"":request.getParameter("audience_id_search");
String level_id_search = (request.getParameter("level_id_search")==null)?"":request.getParameter("level_id_search");
String size_id_search = (request.getParameter("size_id_search")==null)?"":request.getParameter("size_id_search");
String frequency_id_search = (request.getParameter("frequency_id_search")==null)?"":request.getParameter("frequency_id_search");
String medium_id_search = (request.getParameter("medium_id_search")==null)?"":request.getParameter("medium_id_search");
String country_id_search = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

String backPage = (request.getAttribute("BACK_PAGE")==null)?"":request.getAttribute("BACK_PAGE").toString();
String message = (request.getAttribute("MSG")==null)?"GENERIC_ERROR":request.getAttribute("MSG").toString();
if(!message.equals("")) message = ReadErrorLabelFile.getParameter(message);

String publicationId = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
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
	<INPUT type="hidden" name="publication_id" value="<%=publicationId%>">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="last_rated_from_search" value="<%=last_rated_from_search%>">
	<INPUT type="hidden" name="last_rated_to_search" value="<%=last_rated_to_search%>">
	<INPUT type="hidden" name="audience_id_search" value="<%=audience_id_search%>">
	<INPUT type="hidden" name="level_id_search" value="<%=level_id_search%>">
	<INPUT type="hidden" name="size_id_search" value="<%=size_id_search%>">
	<INPUT type="hidden" name="frequency_id_search" value="<%=frequency_id_search%>">
	<INPUT type="hidden" name="medium_id_search" value="<%=medium_id_search%>">
	<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
	<INPUT type="hidden" name="status_search" value="<%=status_search%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class=\"td_content\"":"">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="publications"/>
				</jsp:include>
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
	<%@ include file="/include/footer.jsp" %>
</TABLE>

</BODY>

</HTML>
