<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "2";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function backToSearch(){
			document.search_form.action="<%=request.getContextPath()%>/countries/search.jsp";
			document.search_form.submit();
		}

		function goToModifyPage(country_id){
			document.search_form.action="<%=request.getContextPath()%>/countries/modify.jsp";
			document.search_form.country_id.value=country_id;
			document.search_form.submit();
		}

		function goToDelete(country_id){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_COUNTRY")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageCountry.do";
				document.search_form.operation.value="delete";
				document.search_form.country_id.value=country_id;
				document.search_form.submit();
			}
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchCountries(area_id_search, country_search);
%>

<BODY>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="countries"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>COUNTRIES - SEARCH COUNTRY RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/countries/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="country_search" value="<%=country_search%>">
						<INPUT type="hidden" name="country_id" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="97%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="vertical-align: middle;width:15%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:34%;">Country</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:34%;">Description</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:7%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:7%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String country = ((Hashtable)resultVector.elementAt(i)).get("country").toString();
											String countryId = ((Hashtable)resultVector.elementAt(i)).get("countryid").toString();
											String description = ((Hashtable)resultVector.elementAt(i)).get("description").toString();
											String areaDesc = DbUtils.getAreaDescription(areaId);
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(country)%></TD>
											<TD class="<%=styleClass%>"><%=description%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=countryId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Country"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=countryId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Country"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="5" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO COUNTRIES WITH THE SEARCHING PARAMETERS</B></TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
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