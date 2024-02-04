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
		function startSearch(){
			document.search_form.submit();
		}
		function resetForm(){
			document.search_form.role_id_search.value = "";	
			document.search_form.area_id_search.value = "";
		}
		function reloadForm(){
			document.search_form.action="<%=request.getContextPath()%>/users/search.jsp";
			document.search_form.submit();
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/users/insert.jsp";
		}
		function setFocus(){
			document.search_form.role_id_search.focus();
		}
	</SCRIPT>
</HEAD>

<%
if(user.getId_role().equals(Constants.idRoleManager)){
	response.sendRedirect(request.getContextPath() + "/users/searchResult.jsp");
	return;
}

// Recupera i parametri per la ricerca
String role_id_search = (request.getParameter("role_id_search")==null)?"":request.getParameter("role_id_search");
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");

Vector areas = DbUtils.getAreas(user.getAreas());
Vector roles = DbUtils.getRoles();

String roleId = "";
String roleDesc = "";
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="users"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>USERS - SEARCH USER</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/users/searchResult.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Role</B></TD>
											<TD width="75%" class="text_12_black">
												<SELECT name="role_id_search" class="select" onchange="javascript: reloadForm();">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < roles.size(); i++){
														roleId = ((Hashtable)roles.elementAt(i)).get("roleid").toString();
														roleDesc = ((Hashtable)roles.elementAt(i)).get("role").toString();
													%>
													<OPTION value="<%=roleId%>" <%=(roleId.equals(role_id_search))?"selected":""%>><%=roleDesc%></OPTION>
													<%}%>
												</SELECT>
											</TD>
										</TR>
										<%if(!role_id_search.equals(Constants.idRoleAdmin)){%>
										<TR>
											<TD width="25%" class="text_12_black"><B>Area</B></TD>
											<TD width="75%" class="text_12_black">
												<SELECT name="area_id_search" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(area_id_search))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											</TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search User" onclick="javascript:startSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_user_button" value="Enter User" onclick="javascript:goToInsert()" class="button">
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
