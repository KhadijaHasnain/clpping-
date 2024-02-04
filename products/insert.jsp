<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";
%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="productBean" class="it.vidiemme.clipping.beans.ProductBean" scope="request"/>
<jsp:setProperty name="productBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.insert_form.area_id.focus();
			<%}else{%>
				document.insert_form.partnumberorname.focus();
			<%}%>
		}
		function resetForm(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
			document.insert_form.area_id.value = "";
			<%}%>
			document.insert_form.partnumberorname.value = "";
			document.insert_form.description.value = "";
		}
	</SCRIPT>
</HEAD>

<%
String id_area = "";
if(user.getAreas().size() == 1)
	id_area = user.getAreas().firstElement().toString();
if(id_area.equals(""))
	id_area = productBean.getArea_id();
String id_role = user.getId_role();
String areaDescription = DbUtils.getAreaDescription(id_area);

Vector areas = DbUtils.getAreas(user.getAreas());

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">
<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>PRODUCTS - ADD PRODUCT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="insert_form" action="<%=request.getContextPath()%>/manageProduct.do" method="POST">
						<INPUT type="hidden" name="operation" value="insert">
						<INPUT type="hidden" name="status" value="0">
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
											<%if(areas.size() > 1){%>
												<SELECT name="area_id" class="select">
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
												<INPUT type="hidden" name="area_id" value="<%=id_area%>">
											<%}%>
											</TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Part Number or Name*</B></TD>
											<TD><INPUT type="text" name="partnumberorname" value="<%=Utils.formatStringForView(productBean.getPartnumberorname())%>" class="input_text" maxlength="60"></TD>
										</TR>
										<TR>
											<TD class="text_12_black"><B>Description</B></TD>
											<TD>
												<TEXTAREA name="description" rows="5" cols="50"><%=productBean.getDescription()%></TEXTAREA>
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