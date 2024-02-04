<%@page contentType="text/html" import="it.vidiemme.clipping.utils.Constants,it.vidiemme.clipping.utils.ReadErrorLabelFile,it.vidiemme.clipping.beans.UserBean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>
	<TITLE><%=Constants.pageTitle%></TITLE>
	<LINK href="<%=request.getContextPath()%>/js/style.css" rel="stylesheet" type="text/css">
	<SCRIPT src="<%=request.getContextPath()%>/js/functions.jsp"></SCRIPT>
	<SCRIPT language="javascript">
		function setFocus(){
			document.login_form.username.focus();
		}
	</SCRIPT>
</HEAD>

<%
UserBean user = new UserBean();
String error = (request.getAttribute("ERROR")==null)?"":request.getAttribute("ERROR").toString();
if(!error.equals("")) error = ReadErrorLabelFile.getParameter(error);
%>

<BODY onload="javascript: setFocus()">

<TABLE width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="main">
	<%@ include file="/include/header.jsp" %>
	<TR>
		<TD class="td_content">
			<FORM name="login_form" action="<%=request.getContextPath()%>/login.do" method="POST">
			<TABLE cellpadding="0" cellspacing="15" border="0" width="100%">
				<TR>
					<TD class="text_13_blu"><B>LOGIN</B></TD>
				</TR>
				<TR>
					<TD>
						<TABLE width="40%" cellpadding="0" cellspacing="10" border="0" align="center">
							<TR>
								<TD colspan="2" class="text_14_red" style="text-align:center;">
									<%=(error.equals(""))?"&nbsp;":"<B>"+error+"</B>"%>
								</TD>
							</TR>
							<TR><TD colspan="2">&nbsp;</TD></TR>
							<TR>
								<TD class="text_12_black"><B>Username</B></TD>
								<TD><INPUT name="username" type="text" value="" maxlength="50" class="input_text_medium"></TD>
							</TR>
							<TR>
								<TD class="text_12_black"><B>Password</B></TD>
								<TD><INPUT name="password" type="password" value="" maxlength="50" class="input_text_medium"></TD>
							</TR>
							<TR>
								<TD colspan="2" style="text-align:center;">
									<INPUT name="submit_form" type="submit" value="Login" class="button">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			</FORM>
		</TD>
	</TR>
	<%@ include file="/include/footer.jsp" %>
</TABLE>

</BODY>

</HTML>