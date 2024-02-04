<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean,it.vidiemme.clipping.beans.ProductBean"%>

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
		function submitForm(){
			document.update_form.submit();
		}
		function setFocus(){
			<%if(user.getId_role().equals(Constants.idRoleAdmin) || (user.getId_role().equals(Constants.idRoleManager) && user.getAreas().size() > 1)){%>
				document.update_form.area_id.focus();
			<%}else{%>
				document.update_form.partnumberorname.focus();
			<%}%>
		}
		function backToSearchResult(){
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
String id_role = user.getId_role();

// Recupera i parametri per la ricerca
String area_id_search = (request.getParameter("area_id_search")==null)?"":request.getParameter("area_id_search");
String partnumberorname_search = (request.getParameter("partnumberorname_search")==null)?"":request.getParameter("partnumberorname_search");
String status_search = (request.getParameter("status_search")==null)?"":request.getParameter("status_search");
String pagina = (request.getParameter("pagina")==null)?"":request.getParameter("pagina");
String group = (request.getParameter("group")==null)?"":request.getParameter("group");

// Recupera l'id del product da modificare
String productId = (request.getParameter("product_id")==null)?"":request.getParameter("product_id");

ProductBean productBean = new ProductBean();
if(request.getAttribute("PRODUCT_BEAN") == null && !productId.equals("")){
	// è in modifica ma non è passato dalla servlet
	productBean = new ProductBean(productId);
}else if(request.getAttribute("PRODUCT_BEAN") != null){
	// è in modifica ed è passato dalla servlet
	productBean = (ProductBean)request.getAttribute("PRODUCT_BEAN");
}
// Ottiene dato l'id ad essa relativo, il nome dell'area a cui appartiene il product da modificare
String areaDescription = DbUtils.getAreaDescription(productBean.getArea_id());
String area_id = (request.getParameter("area_id")==null)?productBean.getArea_id():request.getParameter("area_id");
Vector areas = DbUtils.getAreas(user.getAreas());

String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="setFocus()">

<FORM name="search_form" action="<%=request.getContextPath()%>/products/searchResult.jsp" method="POST">
	<INPUT type="hidden" name="pagina" value="<%=pagina%>">
	<INPUT type="hidden" name="group" value="<%=group%>">
	<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
	<INPUT type="hidden" name="partnumberorname_search" value="<%=Utils.formatStringForView(partnumberorname_search)%>">
	<INPUT type="hidden" name="status_search" value="<%=status_search%>">
	
</FORM>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<%@ include file="/include/welcomeMessage.jsp" %>
				<TR>
					<TD class="text_13_blu"><B>PRODUCTS - MODIFY PRODUCT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="update_form" action="<%=request.getContextPath()%>/manageProduct.do" method="POST">
						<INPUT type="hidden" name="operation" value="update">
						<INPUT type="hidden" name="product_id" value="<%=productBean.getProduct_id()%>">
						<INPUT type="hidden" name="pagina" value="<%=pagina%>">
						<INPUT type="hidden" name="group" value="<%=group%>">
						<INPUT type="hidden" name="area_id_search" value="<%=area_id_search%>">
						<INPUT type="hidden" name="partnumberorname_search" value="<%=Utils.formatStringForView(partnumberorname_search)%>">
						<INPUT type="hidden" name="status_search" value="<%=status_search%>">
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
													<OPTION value="<%=areaId%>" <%=(areaId.equals(area_id))?"selected":""%>><%=areaDesc%></OPTION>
												<%}%>
												</SELECT>
											<%}else{%>
												<%=areaDescription%>
												<INPUT type="hidden" name="area_id" value="<%=productBean.getArea_id()%>">
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
											<TD class="text_12_black"><B>Archive*</B></TD>
											<TD>
												<SELECT name="status" class="select">
													<OPTION value=""></OPTION>
													<OPTION value="1" <%=(productBean.getStatus().equals("1"))?"selected":""%>>Archived</OPTION>
													<OPTION value="0" <%=(productBean.getStatus().equals("0"))?"selected":""%>>Not Archived</OPTION>
												</SELECT>
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