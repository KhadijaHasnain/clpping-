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
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/calendar/calendar.js"></SCRIPT>
	<SCRIPT language="javascript">
		function startSearch(){
			document.search_form.submit();
		}
		function setFocus(){
			document.search_form.area_id_search.focus();
		}
		function resetForm(){
			document.search_form.area_id_search.value = "";
			document.search_form.country_search.value = "";
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/countries/insert.jsp";
		}

	</SCRIPT>
</HEAD>

<%
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");

Vector areas = DbUtils.getAreas(user.getAreas());
%>

<BODY onload="setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="countries"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>COUNTRIES - SEARCH COUNTRY</B></TD>
				</TR>	
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/countries/searchResult.jsp" method="POST">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
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
										<TR>
											<TD class="text_12_black"><B>Country</B></TD>
											<TD><INPUT type="text" name="country_search" value="<%=Utils.formatStringForView(country_search)%>" class="input_text" maxlength="60"></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Search Country" onclick="javascript:startSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="reset_form_button" value="Reset" onclick="javascript:resetForm()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="enter_country_button" value="Enter Country" onclick="javascript:goToInsert()" class="button">
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
