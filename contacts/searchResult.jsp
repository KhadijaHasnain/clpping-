<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

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
	<SCRIPT language="javascript">
		function backToSearch(){
			document.search_form.action="<%=request.getContextPath()%>/contacts/search.jsp";
			document.search_form.submit();
		}

		function goToModifyPage(contact_id){
			document.search_form.action="<%=request.getContextPath()%>/contacts/modify.jsp";
			document.search_form.contact_id.value=contact_id;
			document.search_form.submit();
		}

		function goToDelete(contact_id){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_CONTACT")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageContact.do";
				document.search_form.operation.value="delete";
				document.search_form.contact_id.value=contact_id;
				document.search_form.submit();
			}
		}
		
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/contacts/insert.jsp";
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
String country_id_search = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
String publication_id_search = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
String firstname_search = (request.getParameter("firstname_search")==null)?"":request.getParameter("firstname_search");
String lastname_search = (request.getParameter("lastname_search")==null)?"":request.getParameter("lastname_search");
String city_search = (request.getParameter("city_search")==null)?"":request.getParameter("city_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchContacts(publication_id_search, firstname_search, lastname_search, city_search, country_search);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>CONTACTS - SEARCH CONTACT RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/contacts/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id" value="<%=area_id_search%>">
						<INPUT type="hidden" name="country_id" value="<%=country_id_search%>">
						<INPUT type="hidden" name="publication_id" value="<%=publication_id_search%>">
						<INPUT type="hidden" name="firstname_search" value="<%=Utils.formatStringForView(firstname_search)%>">
						<INPUT type="hidden" name="lastname_search" value="<%=Utils.formatStringForView(lastname_search)%>">
						<INPUT type="hidden" name="city_search" value="<%=Utils.formatStringForView(city_search)%>">
						<INPUT type="hidden" name="country_search" value="<%=Utils.formatStringForView(country_search)%>">
						<INPUT type="hidden" name="contact_id" value="">
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
											<TD class="td_table_title" style="vertical-align: middle;width:20%;">First Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:20%;">Last Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:30%;">Publication Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">City</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Country</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String firstname = ((Hashtable)resultVector.elementAt(i)).get("firstname").toString();
											String lastname = ((Hashtable)resultVector.elementAt(i)).get("lastname").toString();
											String publicationId = ((Hashtable)resultVector.elementAt(i)).get("publicationid").toString();
											String city = ((Hashtable)resultVector.elementAt(i)).get("city").toString();
											String country = ((Hashtable)resultVector.elementAt(i)).get("country").toString();
											String contactId = ((Hashtable)resultVector.elementAt(i)).get("contactid").toString();
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=firstname.equals("")?"--":firstname%></TD>
											<TD class="<%=styleClass%>"><%=lastname%></TD>
											<TD class="<%=styleClass%>"><%=DbUtils.getPublicationDescription(publicationId)%></TD>
											<TD class="<%=styleClass%>"><%=(city.equals(""))?"--":city%></TD>
											<TD class="<%=styleClass%>"><%=(country.equals(""))?"--":country%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=contactId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Contact"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=contactId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Contact"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="7" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO CONTACTS WITH THE SEARCHING PARAMETERS</B></TD>
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