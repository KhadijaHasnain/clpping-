<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "2";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="countryBean" class="it.vidiemme.clipping.beans.CountryBean" scope="request"/>
<jsp:setProperty name="countryBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String visualMode = (request.getParameter("visual_mode")==null)?"":request.getParameter("visual_mode");
String userArea = (request.getParameter("user_area")==null)?"":request.getParameter("user_area");
String resultPage = (request.getParameter("result_page")==null)?"":request.getParameter("result_page");

Vector areas = DbUtils.getAreas(user.getAreas());

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function submitForm(){
			document.insert_form.submit();
		}
		function setFocus(){
			<%if(visualMode.equals("")) {%>
			document.insert_form.area_id.focus();
			<%}else{%>
			document.insert_form.country.focus();
			<%}%>
		}
		function resetForm(){
			document.insert_form.area_id.value = "";
			document.insert_form.country.value = "";		
			document.insert_form.description.value = "";
		}
		
		<%if(visualMode.equals("popup") && resultPage.equals("true")){%>
		opener.document.user_form.operation.value= "reload";
		opener.document.user_form.submit();
		closeWindow();
		<%}%>
	</SCRIPT>
</HEAD>

<BODY onload="setFocus()">
	
<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" <%=(visualMode.equals(""))?"class=\"main\"":""%>>
	<%if(visualMode.equals("")) {%>
	<%@ include file="/include/header.jsp" %>
	<%}%>
	<TR>
		<TD <%=(visualMode.equals(""))?"class=\"td_content\"":""%>>
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%if(visualMode.equals("")) {%>
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="countries"/>
				</jsp:include>
				<%}%>
				<TR>
					<TD class="text_13_blu"><B>COUNTRIES - ADD COUNTRY</B></TD>
				</TR>	
				<TR>
					<TD>
						<FORM name="insert_form" action="<%=request.getContextPath()%>/manageCountry.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
						<INPUT type="hidden" name="visual_mode" value="<%=visualMode%>">
						<INPUT type="hidden" name="user_area" value="<%=userArea%>">
						<INPUT type="hidden" name="country_id" value="">
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
												<%if(userArea.equals("")) {%>
												<SELECT name="area_id" class="select">
													<OPTION value=""></OPTION>
													<%for(int i=0; i < areas.size(); i++){
														String areaId = ((Hashtable)areas.elementAt(i)).get("areaid").toString();
														String areaDesc = ((Hashtable)areas.elementAt(i)).get("area").toString();
													%>
													<OPTION value="<%=areaId%>" <%=(areaId.equals(countryBean.getArea_id()))?"selected":""%>><%=areaDesc%></OPTION>
													<%}%>
												</SELECT>
												<%} else {%>
												<INPUT type="hidden" name="area_id" value="<%=userArea%>"><%=DbUtils.getAreaDescription(userArea)%>
												<%}%>
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
									<INPUT type="button" name="reset_form_button" value="Reset" class="button" onclick="javascript:resetForm()">
									<%if(visualMode.equals("popup")){%>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<INPUT type="button" name="close_window_button" value="Close Window" class="button" onclick="javascript:closeWindow()">
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
	<%if(visualMode.equals("")) {%>
	<%@ include file="/include/footer.jsp" %>
	<%}%>
</TABLE>

</BODY>

</HTML>
