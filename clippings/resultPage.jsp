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
String country_id_search = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");
String title_search = (request.getParameter("title_search")==null)?"":request.getParameter("title_search");
String fieldstory_id_search = (request.getParameter("fieldstory_id_search")==null)?"":request.getParameter("fieldstory_id_search");
String datepublished_from_search = (request.getParameter("datepublished_from_search")==null)?"":request.getParameter("datepublished_from_search");
String datepublished_to_search = (request.getParameter("datepublished_to_search")==null)?"":request.getParameter("datepublished_to_search");
String lengthofarticle_id_search = (request.getParameter("lengthofarticle_id_search")==null)?"":request.getParameter("lengthofarticle_id_search");
String tone_id_search = (request.getParameter("tone_id_search")==null)?"":request.getParameter("tone_id_search");
String graphic_id_search = (request.getParameter("graphic_id_search")==null)?"":request.getParameter("graphic_id_search");
String cover_id_search = (request.getParameter("cover_id_search")==null)?"":request.getParameter("cover_id_search");
String score_search = (request.getParameter("score_search")==null)?"":request.getParameter("score_search");
String ordering = (request.getParameter("ordering")==null)?"":request.getParameter("ordering");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

String backPage = (request.getAttribute("BACK_PAGE")==null)?"":request.getAttribute("BACK_PAGE").toString();
String message = (request.getAttribute("MSG")==null)?"GENERIC_ERROR":request.getAttribute("MSG").toString();
if(!message.equals("")) message = ReadErrorLabelFile.getParameter(message);

String clippingId = (request.getParameter("clipping_id")==null)?"":request.getParameter("clipping_id");
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
	<INPUT type="hidden" name="clipping_id" value="<%=clippingId%>">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
	<INPUT type="hidden" name="title_search" value="<%=Utils.formatStringForView(title_search)%>">
	<INPUT type="hidden" name="fieldstory_id_search" value="<%=fieldstory_id_search%>">
	<INPUT type="hidden" name="datepublished_from_search" value="<%=datepublished_from_search%>">
	<INPUT type="hidden" name="datepublished_to_search" value="<%=datepublished_to_search%>">
	<INPUT type="hidden" name="lengthofarticle_id_search" value="<%=lengthofarticle_id_search%>">
	<INPUT type="hidden" name="tone_id_search" value="<%=tone_id_search%>">
	<INPUT type="hidden" name="graphic_id_search" value="<%=graphic_id_search%>">
	<INPUT type="hidden" name="cover_id_search" value="<%=cover_id_search%>">
	<INPUT type="hidden" name="score_search" value="<%=score_search%>">
	<INPUT type="hidden" name="ordering" value="<%=ordering%>">
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="clippings"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CLIPPINGS - RESULT OPERATION PAGE</B></TD>
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
