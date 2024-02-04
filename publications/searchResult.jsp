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
			document.search_form.action="<%=request.getContextPath()%>/publications/search.jsp";
			document.search_form.submit();
		}
		function goToModifyPage(publicationId){
			document.search_form.action="<%=request.getContextPath()%>/publications/modify.jsp";
			document.search_form.publication_id.value=publicationId;
			document.search_form.submit();
		}
		function goToDelete(publicationId){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_PUBLICATION")%>")){
				document.search_form.action="<%=request.getContextPath()%>/managePublication.do";
				document.search_form.operation.value="delete";
				document.search_form.publication_id.value=publicationId;
				document.search_form.submit();
			}
		}
		function checkAll(){
			var i=0;
			var checked = false;
			if(document.search_form.check_all.checked == true){
				checked = true;
			}
			for(i=0; i < document.search_form.elements.length; i++){
				if(document.search_form.elements[i].type == "checkbox" && document.search_form.elements[i].name == "publications_id"){
					document.search_form.elements[i].checked = checked;
				}
			}
		}
		function goToChangeStatus(){
			var i=0;
			var checked =false;
			for(i=0; i < document.search_form.elements.length; i++){
				if(document.search_form.elements[i].type == "checkbox" && 
				   document.search_form.elements[i].name == "publications_id" && 
				   document.search_form.elements[i].checked == true){
					checked = true;
				}
			}
			if(!checked){
				alert("<%=ReadErrorLabelFile.getParameter("ALERT_ARCHIVE_PUBLICATION")%>");
			}else if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_ARCHIVE_PUBLICATION")%>")){
				document.search_form.action="<%=request.getContextPath()%>/managePublication.do";
				document.search_form.operation.value="archive";
				document.search_form.submit();
			}
		}
	</SCRIPT>
</HEAD>

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
String paging = "y";
Vector resultVector = DbUtils.getSearchPublications(area_id_search, name_search, last_rated_from_search, last_rated_to_search, audience_id_search, level_id_search, size_id_search, frequency_id_search, medium_id_search, country_id_search, status_search, user);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="publications"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - SEARCH PUBLICATION RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/publications/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
						<INPUT type="hidden" name="last_rated_from_search" value="<%=last_rated_from_search%>">
						<INPUT type="hidden" name="last_rated_to_search" value="<%=last_rated_to_search%>">
						<INPUT type="hidden" name="audience_id_search" value="<%=audience_id_search%>">
						<INPUT type="hidden" name="level_id_search" value="<%=level_id_search%>">
						<INPUT type="hidden" name="size_id_search" value="<%=size_id_search%>">
						<INPUT type="hidden" name="frequency_id_search" value="<%=frequency_id_search%>">
						<INPUT type="hidden" name="medium_id_search" value="<%=medium_id_search%>">
						<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
						<INPUT type="hidden" name="status_search" value="<%=status_search%>">
						<INPUT type="hidden" name="publication_id" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
									<%if(resultVector.size() > 0){%>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="change_status_button" value="Archive Selected" onclick="javascript:goToChangeStatus()" class="button">
									<%}%>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="90%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="text-valign:middle;width:10%;" style="text-align:center;">Select All
												<%if(resultVector.size() > 0){%>
												<INPUT type="checkbox" name="check_all" value="" class="checkbox" onclick="javascript:checkAll()">
												<%}%>
											</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:15%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:15%;">Country</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Date</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:30%;">Publication Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Audience</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String statusId = ((Hashtable)resultVector.elementAt(i)).get("status").toString();
											String audienceId = ((Hashtable)resultVector.elementAt(i)).get("audienceid").toString();
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String countryId = ((Hashtable)resultVector.elementAt(i)).get("countryid").toString();
											String audience = "";
											String country = "";
											String areaDesc = "";
											String publicationId = ((Hashtable)resultVector.elementAt(i)).get("publicationid").toString();
											String name = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String last_rated = Utils.formatDateForView(((Hashtable)resultVector.elementAt(i)).get("last_rated").toString());

											if(!audienceId.equals("")) audience = DbUtils.getAudienceDescription(audienceId);
											if(!areaId.equals("")) areaDesc = DbUtils.getAreaDescription(areaId);
											if(!countryId.equals("")) country = DbUtils.getCountryDescription(countryId);
										%>
										<TR>
											<TD class="<%=styleClass%>" style="text-align:center;">
												<%if(statusId.equals(Constants.notArchivedId+"")){%>
												<INPUT type="checkbox" name="publications_id" class="checkbox" value="<%=publicationId%>">
												<%}%>
											</TD>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=country%></TD>
											<TD class="<%=styleClass%>"><%=last_rated%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(name)%></TD>
											<TD class="<%=styleClass%>"><%=audience%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=publicationId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Publication"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=publicationId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Publication"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="8" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO PUBLICATIONS WITH THE SEARCHING PARAMETERS</B></TD>
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
									<%if(resultVector.size() > 0){%>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="change_status_button" value="Archive Selected" onclick="javascript:goToChangeStatus()" class="button">
									<%}%>
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