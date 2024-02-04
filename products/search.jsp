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
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function startSearch(){
			document.search_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.search_form.area_id_search.focus();
			<%}else{%>
				document.search_form.partnumberorname_search.focus();
			<%}%>
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
			document.search_form.area_id_search.value = "";
			<%}%>
			document.search_form.partnumberorname_search.value = "";
			document.search_form.status_search.value = "";
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/products/insert.jsp";
		}
	</SCRIPT>
</HEAD>

<%
String partnumberorname_search = (request.getParameter("partnumberorname_search")==null)?"":request.getParameter("partnumberorname_search");
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");

String id_area = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(id_area.equals(""))
	id_area = area_id_search;
String areaDescription = DbUtils.getAreaDescription(id_area);

Vector areas = DbUtils.getAreas(user.getAreas());


%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>PRODUCTS - SEARCH PRODUCT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/products/searchResult.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area</B></TD>
											<TD width="75%" class="text_12_black">
												<%if(areas.size() > 1){%>
													<SELECT name="area_id_search" class="select">
														<OPTION value=""></OPTION>
														<%for(int i=0; i < areas.size(); i++){
															String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
															String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
														%>
														<OPTION value="<%=areaId%>" <%=(areaId.equals(id_area))?"selected":""%>><%=areaDesc%></OPTION>
													<%}%>
													</SELECT>
												<%}else{%>
													<%=areaDescription%>
													<INPUT type="hidden" name="area_id_search" value="<%=id_area%>">
												<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Part Number or Name</B></TD>
											<TD><INPUT type="text" name="partnumberorname_search" value="<%=Utils.formatStringForView(partnumberorname_search)%>" class="input_text" maxlength="60"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Archive</B></TD>
											<TD>
												<SELECT name="status_search" class="select">
													<OPTION value=""></OPTION>
													<OPTION value="1" <%=(status_search.equals("1"))?"selected":""%>>Archived</OPTION>
													<OPTION value="0" <%=(status_search.equals("0"))?"selected":""%>>Not Archived</OPTION>
												</SELECT>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Products" onclick="javascript:startSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_product_button" value="Enter Product" onclick="javascript:goToInsert()" class="button">
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