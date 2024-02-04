<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "3";
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
			document.search_form.action="<%=request.getContextPath()%>/users/search.jsp";
			document.search_form.submit();
		}

		function goToModifyPage(user_id){
			document.search_form.action="<%=request.getContextPath()%>/users/modify.jsp";
			document.search_form.user_id.value=user_id;
			document.search_form.submit();
		}

		function goToDelete(user_id){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_USER")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageUser.do";
				document.search_form.operation.value="delete";
				document.search_form.user_id.value=user_id;
				document.search_form.submit();
			}
		}
		
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/users/insert.jsp";
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String role_id_search = (request.getParameter("role_id_search")==null)?"":request.getParameter("role_id_search");
String paging = "y";
Vector resultVector = DbUtils.getSearchUsers(area_id_search, role_id_search, user);
%>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<BODY>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="users"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>USERS - SEARCH USER RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/users/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="role_id_search" value="<%=role_id_search%>">
						<INPUT type="hidden" name="user_id" value="">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<%if(user.getId_role().equals(Constants.idRoleAdmin)){%>
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
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
											<TD class="td_table_title" style="vertical-align: middle;width:17%;">Role</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:18%;">Area</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:28%;">Country</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:20%;">Username</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:7%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:7%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											// istanzia il bean user con l'id dello user trovato per prelevare e visualizzare l'area a cui risulta associato
											UserBean userCicle = new UserBean(((Hashtable)resultVector.elementAt(i)).get("userid").toString());
											String roleDesc = DbUtils.getRoleDescription(userCicle.getId_role());
											String countries = "";
											for(int j=0; j < userCicle.getCountries().size(); j++){
												if(j > 0)
													countries += ", ";
												countries += DbUtils.getCountryDescription(userCicle.getCountries().elementAt(j).toString());
											}
											String areas = "";
											for(int k=0; k < userCicle.getAreas().size(); k++){
												if(k > 0)
													areas += ", ";
												areas += DbUtils.getAreaDescription(userCicle.getAreas().elementAt(k).toString());
											}
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=roleDesc%></TD>
											<TD class="<%=styleClass%>"><%=(areas.equals(""))?"--":areas%></TD>
											<TD class="<%=styleClass%>"><%=(countries.equals(""))?"--":countries%></TD>
											<TD class="<%=styleClass%>"><B><%=userCicle.getUsername()%></B></TD>
											<%if(userCicle.getId_role().equals(Constants.idRoleAdmin)){%>
												<TD class="<%=styleClass%>_img">&nbsp;</TD>
											<%}else{%>
												<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=userCicle.getId_user()%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify User"></A></TD>
											<%}%>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=userCicle.getId_user()%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete User"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="6" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO USERS WITH THE SEARCHING PARAMETERS</B></TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<%if(user.getId_role().equals(Constants.idRoleAdmin)){%>
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
									<%}else if(user.getId_role().equals(Constants.idRoleManager)){%>
									<INPUT type="button" name="go_to_insert_button" value="Enter User" onclick="javascript:goToInsert()" class="button">
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