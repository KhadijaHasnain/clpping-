<%@page contentType="text/html" import="java.util.Vector,java.util.Hashtable,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
// Setta il tipo di accesso per effettuare il controllo sulla login dell'utente
String accessType = "1";

%>
<%@ include file="/include/checkLoggedUserRole.jsp" %>

<jsp:useBean id="userBean" class="it.vidiemme.clipping.beans.UserBean" scope="session"/>
<jsp:setProperty name="userBean" property="*"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function backToSearch(){
			document.search_form.action="<%=request.getContextPath()%>/clippings/search.jsp";
			document.search_form.submit();
		}
		function goToModifyPage(clipping_id){
			document.search_form.action="<%=request.getContextPath()%>/clippings/modify.jsp";
			document.search_form.clipping_id.value=clipping_id;
			document.search_form.submit();
		}
		function goToDelete(clipping_id){
			if(confirm("<%=ReadErrorLabelFile.getParameter("CONFIRM_DELETE_CLIPPING")%>")){
				document.search_form.action="<%=request.getContextPath()%>/manageClipping.do";
				document.search_form.operation.value="delete";
				document.search_form.clipping_id.value=clipping_id;
				document.search_form.submit();
			}
		}
		function goToInsert(){
			document.location.href="<%=request.getContextPath()%>/clippings/insert.jsp";
		}
		function exportExcel(){
			document.search_form.action="<%=request.getContextPath()%>/clippings/searchResultXLS.jsp";
			document.search_form.submit();
			document.search_form.action="<%=request.getContextPath()%>/clippings/searchResult.jsp";
		}
		function orderdate(orderdate){
			document.search_form.ordering.value = 'datepublished ' + orderdate;
			document.search_form.submit();
		}
		function orderscore(orderscore){
			document.search_form.ordering.value = 'score ' + orderscore;
			document.search_form.submit();
		}
	</SCRIPT>
</HEAD>

<%
// Recupera i parametri per la ricerca
String[] country_id_search = (request.getParameterValues("country_id_search")==null)?new String[0]:request.getParameterValues("country_id_search");
String[] area_id_search = (request.getParameterValues("area_id_search")==null)?new String[0]:request.getParameterValues("area_id_search");
if(area_id_search.length > 0 && area_id_search[0].contains(","))
	area_id_search = area_id_search[0].split(",");
if(country_id_search.length > 0 && country_id_search[0].contains(","))
	country_id_search = country_id_search[0].split(",");

String publication_id_search = (request.getParameter("publication_id_search")==null)?"":request.getParameter("publication_id_search");
String audience_id_search = (request.getParameter("audience_id_search")==null)?"":request.getParameter("audience_id_search");
String title_search = (request.getParameter("title_search")==null)?"":request.getParameter("title_search");
String fieldstory_id_search = (request.getParameter("fieldstory_id_search")==null)?"":request.getParameter("fieldstory_id_search");
String datepublished_from_search = (request.getParameter("datepublished_from_search")==null)?"":request.getParameter("datepublished_from_search");
String datepublished_to_search = (request.getParameter("datepublished_to_search")==null)?"":request.getParameter("datepublished_to_search");
String lengthofarticle_id_search = (request.getParameter("lengthofarticle_id_search")==null)?"":request.getParameter("lengthofarticle_id_search");
String tone_id_search = (request.getParameter("tone_id_search")==null)?"":request.getParameter("tone_id_search");
String graphic_id_search = (request.getParameter("graphic_id_search")==null)?"":request.getParameter("graphic_id_search");
String cover_id_search = (request.getParameter("cover_id_search")==null)?"":request.getParameter("cover_id_search");
String score_search = (request.getParameter("score_search")==null)?"":request.getParameter("score_search");
String ordering = (request.getParameter("ordering")==null)?"":request.getParameter("ordering");
String paging = "y";

//aggiunto da giovanni il 18/02/2010 ricerca admin per area multipla
Vector resultVector = DbUtils.getSearchClippings(area_id_search, country_id_search, publication_id_search, audience_id_search, title_search, fieldstory_id_search, datepublished_from_search, datepublished_to_search, lengthofarticle_id_search, tone_id_search, graphic_id_search, cover_id_search, score_search, "", user);

String area_checked = "";
String country_checked = "";
for (int i = 0; i < area_id_search.length; i++) {
	area_checked += i<area_id_search.length-1?area_id_search[i]+",":area_id_search[i];
}
for (int i = 0; i < country_id_search.length; i++) {
	country_checked += i<country_id_search.length-1?country_id_search[i]+",":country_id_search[i];
}

double scoreNum = 0d;
for(int z = 0; z < resultVector.size(); z++){
	try {
		scoreNum += Double.parseDouble(((Hashtable)resultVector.elementAt(z)).get("score").toString());
	} catch (Exception e) {
	}
}
%>

<BODY>

<%@ include file="/include/paginazioneJAVA.jsp" %>

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<jsp:include page="/include/welcomeMessage.jsp">
					<jsp:param name="section_help" value="clippings"/>
				</jsp:include>
				<TR>
					<TD class="text_13_blu"><B>CLIPPINGS - SEARCH CLIPPING RESULT</B></TD>
				</TR>
				<TR>
					<TD>
						<FORM name="search_form" action="<%=request.getContextPath()%>/clippings/searchResult.jsp" method="POST">
						<INPUT type="hidden" name="operation" value="">
						<INPUT type="hidden" name="area_id_search" value="<%=area_checked%>">
						<INPUT type="hidden" name="country_id_search" value="<%=country_checked%>">
						<INPUT type="hidden" name="publication_id_search" value="<%=publication_id_search%>">
						<INPUT type="hidden" name="audience_id_search" value="<%=audience_id_search%>">
						<INPUT type="hidden" name="title_search" value="<%=Utils.formatStringForView(title_search)%>">
						<INPUT type="hidden" name="fieldstory_id_search" value="<%=fieldstory_id_search%>">
						<INPUT type="hidden" name="datepublished_from_search" value="<%=datepublished_from_search%>">
						<INPUT type="hidden" name="datepublished_to_search" value="<%=datepublished_to_search%>">
						<INPUT type="hidden" name="lengthofarticle_id_search" value="<%=fieldstory_id_search%>">
						<INPUT type="hidden" name="tone_id_search" value="<%=tone_id_search%>">
						<INPUT type="hidden" name="graphic_id_search" value="<%=graphic_id_search%>">
						<INPUT type="hidden" name="cover_id_search" value="<%=cover_id_search%>">
						<INPUT type="hidden" name="score_search" value="<%=score_search%>">
						<INPUT type="hidden" name="clipping_id" value="">
						<INPUT type="hidden" name="ordering" value="<%=ordering%>">
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="exort_xls_button" value="Export Excel" onclick="javascript:exportExcel()" class="button">
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align: center" class="text_13_blu">
									Total Clipping: <B><%=resultVector.size()%></B>
								</TD>
							</TR>
							<TR>
								<TD style="text-align: center" class="text_13_blu">
									Total Score: <B><%=Utils.round(scoreNum+"")%></B>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR>
								<TD>
									<TABLE width="97%" border="0" cellspacing="1" cellpadding="3" align="center" class="table_records">
										<INPUT type="hidden" name="pagina" value="<%=pagina%>">
										<INPUT type="hidden" name="group" value="<%=group%>">
										<TR>
											<TD class="td_table_title" style="vertical-align: middle;width:10%;">Area/Country</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:32%;">Clipping Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:15%;">Publication Title</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:7%;">Audience</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:9%;">
												<DIV style="position:relative;height: 18px;top:3px">
													Date
													<%if(ordering.equals("") || ordering.equals("score DESC") || ordering.equals("score ASC")){%>
													<a href="javascript:orderdate('ASC');"><img alt="" style="border:none;position:absolute;top:2px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_off_up.gif"/></a>
													<a href="javascript:orderdate('DESC');"><img alt="" style="border:none;position:absolute;bottom:4px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_off_down.gif"/></a>
													<%}else if(ordering.equals("datepublished DESC")){%>
													<a href="javascript:orderdate('ASC');"><img alt="" style="border:none;position:absolute;top:2px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_off_up.gif"/></a>
													<img alt="" style="border:none;position:absolute;bottom:4px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_on_down.gif"/>
													<%}else if(ordering.equals("datepublished ASC")){%>
													<img alt="" style="border:none;position:absolute;top:2px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_on_up.gif"/>
													<a href="javascript:orderdate('DESC');"><img alt="" style="border:none;position:absolute;bottom:4px;left:68px;" src="<%=request.getContextPath()%>/images/arrow_off_down.gif"/></a>
													<%}%>
												</DIV>
											</TD>
											<TD class="td_table_title" style="vertical-align: middle;width:7%;">
												<DIV style="position:relative;height: 18px;top:3px">
													Score
													<%if(ordering.equals("") || ordering.equals("datepublished DESC") || ordering.equals("datepublished ASC")){%>
													<a href="javascript:orderscore('ASC');"><img alt="" style="border:none;position:absolute;top:2px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_off_up.gif"/></a>
													<a href="javascript:orderscore('DESC');"><img alt="" style="border:none;position:absolute;bottom:4px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_off_down.gif"/></a>
													<%}else if(ordering.equals("score DESC")){%>
													<a href="javascript:orderscore('ASC');"><img alt="" style="border:none;position:absolute;top:2px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_off_up.gif"/></a>
													<img alt="" style="border:none;position:absolute;bottom:4px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_on_down.gif"/>
													<%}else if(ordering.equals("score ASC")){%>
													<img alt="" style="border:none;position:absolute;top:2px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_on_up.gif"/>
													<a href="javascript:orderscore('DESC');"><img alt="" style="border:none;position:absolute;bottom:4px;left:40px;" src="<%=request.getContextPath()%>/images/arrow_off_down.gif"/></a>
													<%}%>
												</DIV>
											</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Modify</TD>
											<TD class="td_table_title" style="text-align:center;vertical-align: middle;width:5%;">Delete</TD>
										</TR>
										<%for(int i = startpage; (i < endpage && i < resultVector.size()); i++){
											String styleClass = (i%2 > 0)?"td_record_table1":"td_record_table2";
											String title = ((Hashtable)resultVector.elementAt(i)).get("title").toString();
											String area = ((Hashtable)resultVector.elementAt(i)).get("area_code").toString();
											String country = ((Hashtable)resultVector.elementAt(i)).get("country_code").toString();
											String publication = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
											String audience = ((Hashtable)resultVector.elementAt(i)).get("audience").toString();
											String datepublished = ((Hashtable)resultVector.elementAt(i)).get("datepublished").toString();
											String score = ((Hashtable)resultVector.elementAt(i)).get("score").toString();
											String clippingId = ((Hashtable)resultVector.elementAt(i)).get("clippingid").toString();
										%>
										<TR>
											<TD class="<%=styleClass%>"><%=area + ((country.equals(""))?"":" / " + country)%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatStringForView(title)%></TD>
											<TD class="<%=styleClass%>"><%=publication%></TD>
											<TD class="<%=styleClass%>"><%=audience%></TD>
											<TD class="<%=styleClass%>"><%=Utils.formatDateForView(datepublished)%></TD>
											<TD class="<%=styleClass%>"><%=score%></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToModifyPage('<%=clippingId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_matita.gif" border="0" alt="Modify Clipping"></A></TD>
											<TD class="<%=styleClass%>_img"><A href="javascript:goToDelete('<%=clippingId%>');"><IMG src="<%=request.getContextPath()%>/images/icona_cestino.gif" border="0" alt="Delete Clipping"></A></TD>
										</TR>
										<%}%>
										<%if(resultVector.size() == 0){%>
										<TR>
											<TD height="80" class="text_14_red" colspan="6" style="text-align:center;vertical-align:middle;"><B>THERE ARE NO CLIPPINGS WITH THE SEARCHING PARAMETERS</B></TD>
										</TR>
										<%}%>
									</TABLE>
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align: center" class="text_13_blu">
									Total Clipping: <B><%=resultVector.size()%></B>
								</TD>
							</TR>
							<TR>
								<TD style="text-align: center" class="text_13_blu">
									Total Score: <B><%=Utils.round(scoreNum+"")%></B>
								</TD>
							</TR>
							<TR><TD><%@ include file="/include/paginazioneHTML.jsp" %></TD></TR>
							<TR><TD>&nbsp;</TD></TR>
							<TR>
								<TD style="text-align:center;">
									<INPUT type="button" name="back_search_button" value="Back To Search" onclick="javascript:backToSearch()" class="button">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<INPUT type="button" name="exort_xls_button" value="Export Excel" onclick="javascript:exportExcel()" class="button">
								</TD>
							</TR>
							<TR><TD>&nbsp;</TD></TR>
							<!-- <TR>
								<TD class="text_12_black" style="text-align:center;">
									<B>THE SEARCH GENERATES MAXIMUM <%=Constants.resultForClippingSearch%> RESULTS</B>
								</TD>
							</TR> -->
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