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
			document.search_form.submit();
		}
		function getDivisionIdSelected(){
			var i=0;
			var divisionId = "";
			for(i=0; i < document.search_form.elements.length; i++){
				if(document.search_form.elements[i].type == "radio" && 
				   document.search_form.elements[i].name == "divisions_id" && 
				   document.search_form.elements[i].checked == true){
					divisionId = document.search_form.elements[i].value;
				}
			}
			return divisionId;
		}
		function AssociatesDivision(){
			var divisionId = getDivisionIdSelected();
			if(divisionId == "") {
				alert("<%=ReadErrorLabelFile.getParameter("DIVISION_REQUIRED")%>")
			} else if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_ASSOCIATES_DIVISION")%>")){
				opener.document.section_form.operation.value= "reload";
				opener.document.section_form.division_id.value = divisionId;
				opener.document.section_form.submit();
				closeWindow();
			}
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String name_search = (request.getParameter("name_search")==null)?"":request.getParameter("name_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchDivisions(area_id_search, name_search, "0", user);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	<TR>
		<TD>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>DIVISIONS - SEARCH DIVISION RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/divisions/searchPopup.jsp" method="POST">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="name_search" value="<%=Utils.formatStringForView(name_search)%>">
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
											<TD class="td_table_title" style="vertical-align: middle;width:3%;">&nbsp;</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:40%;">Division Name</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:20%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:37%;">Description</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String divisionId = ((Hashtable)resultVector.elementAt(i)).get("divisionid").toString();
											String name = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
											String description = ((Hashtable)resultVector.elementAt(i)).get("description").toString();
											String areaDesc = "";
											
											if(!areaId.equals("")) areaDesc = DbUtils.getAreaDescription(areaId);
										%>
										<TR>
											<TD class="<%=styleClass%>">
												<INPUT type="radio" name="divisions_id" class="radio" value="<%=divisionId%>" onclick="javascript:AssociatesDivision()">
											</TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(name)%></TD>
											<TD class="<%=styleClass%>"><%=areaDesc%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(description)%></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="4" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO DIVISIONS WITH THE SEARCHING PARAMETERS</B></TD>
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
</TABLE>

</BODY>

</HTML>