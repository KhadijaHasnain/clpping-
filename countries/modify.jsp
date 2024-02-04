<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean,it.vidiemme.clipping.beans.CountryBean"%>

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
		function submitForm(){
			document.update_form.submit();
		}
		function setFocus(){
			document.update_form.area_id.focus();
		}
		function backToSearchResult(){
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String country_search = (request.getParameter("country_search")==null)?"":request.getParameter("country_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id del country da modificare
String countryId = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");

CountryBean countryBean = new CountryBean();
if(request.getAttribute("COUNTRY_BEAN") == null && !countryId.equals("")){
	// è in modifica ma non è passato dalla servlet
	countryBean = new CountryBean(countryId);
}else if(request.getAttribute("COUNTRY_BEAN") != null){
	// è in modifica ed è passato dalla servlet
	countryBean = (CountryBean)request.getAttribute("COUNTRY_BEAN");
}

String areaDescription = DbUtils.getAreaDescription(countryBean.getArea_id());
Vector areas = DbUtils.getAreas(user.getAreas());

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/countries/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="country_search" value="<%=Utils.formatStringForView(country_search)%>">	
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="countries"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>COUNTRIES - MODIFY COUNTRY</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="update_form" action="<%=request.getContextPath()%>/manageCountry.do" method="POST">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="country_id" value="<%=countryBean.getCountry_id()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="country_search" value="<%=Utils.formatStringForView(country_search)%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR>
								<TD class="text_14_red" style="text-align:center;vertical-align:middle;">
									<%=(error.equals(""))?"&nbsp;":"<B>"+error+"</B>"%>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD>
									<TABLE width="70%" border="0" cellspacing="0" cellpadding="6" align="center">
										<TR>
											<TD width="25%" class="text_12_black"><B>Area*</B></TD>
											<TD width="75%" class="text_12_black">
												<SELECT name="area_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(countryBean.getArea_id()))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
										
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Country*</B></TD>
											<TD><INPUT type="text" name="country" value="<%=Utils.formatStringForView(countryBean.getCountry())%>" class="input_text" maxlength="100"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Description</B></TD>
											<TD>
												<TEXTAREA name="description" rows="5" cols="50"><%=countryBean.getDescription()%></TEXTAREA>
											</TD>
										</TR>
										<TR>
											<TD colspan="2" class="text_12_black">* Required fields</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="submit_form_button" value="Submit" class="button" onclick="javascript:submitForm()">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="back_search_result_button" value="Back To Search Result" onclick="javascript:backToSearchResult()" class="button">
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
