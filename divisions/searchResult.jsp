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
			document.search_form.action="<%=request.getContextPath()%>/divisions/search.jsp";
			document.search_form.submit();
		}

		function goToModifyPage(division_id){
			document.search_form.action="<%=request.getContextPath()%>/divisions/modify.jsp";
			document.search_form.division_id.value=division_id;
			document.search_form.submit();
		}

		function goToDelete(division_id){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_DIVISION")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageDivision.do";
				document.search_form.operation.value="delete";
				document.search_form.division_id.value=division_id;
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
				if(document.search_form.elements[i].type == "checkbox" && 
				   document.search_form.elements[i].name == "divisions_id"){
					document.search_form.elements[i].checked = checked;
				}
			}
		}

		function goToChangeStatus(){
			var i=0;
			var checked =false;
			for(i=0; i < document.search_form.elements.length; i++){
				if(document.search_form.elements[i].type == "checkbox" && 
				   document.search_form.elements[i].name == "divisions_id" && 
				   document.search_form.elements[i].checked == true){
					checked = true;
				}
			}
			if(!checked){
				alert("<%=ReadErrorLabelFile.getParameter("ALERT_ARCHIVE_DIVISION")%>");
			}else if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_ARCHIVE_DIVISION")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageDivision.do";
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
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchDivisions(area_id_search, name_search, status_search, user);
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
					<TD class="text_13_blu"><B>DIVISIONS - SEARCH DIVISION RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/divisions/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
						<INPUT type="hidden" name="status_search" value="<%=status_search%>">
						<INPUT type="hidden" name="division_id" value="">
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
									<TABLE width="97%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="text-valign:middle;width:10%;" style="text-align:center;">Select All
												<%if(resultVector.size() > 0){%>
												<INPUT type="checkbox" name="check_all" value="" onclick="javascript:checkAll()">
												<%}%>
											</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:12%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:34%;">Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:34%;">Description</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String name = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String description = ((Hashtable)resultVector.elementAt(i)).get("description").toString();
											String statusId = ((Hashtable)resultVector.elementAt(i)).get("status").toString();
											String divisionId = ((Hashtable)resultVector.elementAt(i)).get("divisionid").toString();
											
											String areaDesc = DbUtils.getAreaDescription(areaId);
										%>
										<TR>
											<TD class="<%=styleClass%>" style="text-align:center;">
												<%if(statusId.equals(Constants.notArchivedId+"")){%>
												<INPUT type="checkbox" name="divisions_id" value="<%=divisionId%>">
												<%}%>
											</TD>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(name)%></TD>
											<TD class="<%=styleClass%>"><%=description%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=divisionId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Division"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=divisionId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Division"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="6" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO DIVISIONS WITH THE SEARCHING PARAMETERS</B></TD>
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