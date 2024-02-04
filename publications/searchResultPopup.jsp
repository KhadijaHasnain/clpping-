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
			document.search_form.action="<%=request.getContextPath()%>/publications/searchPopup.jsp";
			document.search_form.submit();
		}
		function getPublicationIdSelected(){
			var i=0;
			var publicationId = "";
			for(i=0; i < document.search_form.elements.length; i++){
				if(document.search_form.elements[i].type == "radio" && 
				   document.search_form.elements[i].name == "publications_id" && 
				   document.search_form.elements[i].checked == true){
					publicationId = document.search_form.elements[i].value;
				}
			}
			
			return publicationId;
		}
		function AssociatesPublication(country_id){
			var publicationId = getPublicationIdSelected();
			var countryId = country_id;
			if(publicationId == "") {
				alert("<%=ReadErrorLabelFile.getParameter("PUBLICATION_REQUIRED")%>")
			} else if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_ASSOCIATES_PUBLICATION")%>")){
				opener.document.section_form.operation.value= "reload";
				opener.document.section_form.publication_id.value = publicationId;
				opener.document.section_form.country_id.value = countryId;
				opener.document.section_form.submit();
				closeWindow();
			}
		}
		function insertPublication(){
			var area_id = document.search_form.area_id_search.value;
			var country_id = document.search_form.country_id_search.value;
			document.location.href = '<%=request.getContextPath()%>/publications/insertPopup.jsp?area_id_search='+area_id+'&country_id_search='+country_id;
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String country_id_search = (request.getParameter("country_id_search")==null)?"":request.getParameter("country_id_search");
String name_search = (request.getParameter("name_search")==null)?"":request.getParameter("name_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchPublications(area_id_search, name_search, "", "", "", "", "", "", "", country_id_search, "0", user);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	<TR>
		<TD>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>PUBLICATIONS - SEARCH PUBLICATION RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/publications/searchResultPopup.jsp" method="POST">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="country_id_search" value="<%=country_id_search%>">
						<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="add_publication_button" value="Add Publication" onclick="javascript:insertPublication()" class="button">
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="90%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="vertical-align: middle;width:3%;">&nbsp;</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:47%;">Publication Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:25%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:25%;">Country</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String publicationId = ((Hashtable)resultVector.elementAt(i)).get("publicationid").toString();
											String name = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String countryId = ((Hashtable)resultVector.elementAt(i)).get("countryid").toString();
											String areaDesc = "";
											String country = "";
											
											if(!areaId.equals("")) areaDesc = DbUtils.getAreaDescription(areaId);
											if(!countryId.equals("")) country = DbUtils.getCountryDescription(countryId);
										%>
										<TR>
											<TD class="<%=styleClass%>">
												<INPUT type="radio" name="publications_id" class="radio" value="<%=publicationId%>" onclick="javascript:AssociatesPublication('<%=countryId%>')">
											</TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(name)%></TD>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=country%></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="4" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO PUBLICATIONS WITH THE SEARCHING PARAMETERS</B></TD>
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
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="add_publication_button" value="Add Publication" onclick="javascript:insertPublication()" class="button">
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