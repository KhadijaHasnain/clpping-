<%@page contentType="text/html" import="java.util.Hashtable,java.util.Vector,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
UserBean userWelcome = (session.getAttribute("user") == null)? new UserBean():(UserBean)session.getAttribute("user");

String roleDesc = "";
if(userWelcome.getId_role().equals(Constants.idRoleAdmin)){
	roleDesc = "admin";
}else if(userWelcome.getId_role().equals(Constants.idRoleManager)){
	roleDesc = "manager";
}else{
	roleDesc = "end_user";
}
// Stringa che identifica la sezione
String section = (request.getParameter("section_help")==null)?"":request.getParameter("section_help");

String areastr = "";
for(int i = 0; i < userWelcome.getAreas().size(); i++){
	areastr += DbUtils.getAreaDescription(userWelcome.getAreas().elementAt(i).toString());
	if(i < userWelcome.getAreas().size() - 1){
		areastr += ", ";
	}
}
%>

<TR>
	<TD class="text_12_black">
		<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
			<TR>
				<TD width="35%">
					<B>Welcome <%=DbUtils.getRoleDescription(userWelcome.getId_role())%></B> <%=userWelcome.getUsername()%>
				</TD>
				<TD>
					<%if(!userWelcome.getId_role().equals(Constants.idRoleAdmin)){%>
					<B>AREAS:</B>&nbsp;<%=areastr%>
					<%}%>
				</TD>
				<TD style="text-align:right;">
					<%if(!section.equals("")){%>
					<A href="<%=request.getContextPath()%>/helps/help_<%=section%>_<%=roleDesc%>.pdf" target="_blank"><IMG src="<%=request.getContextPath()%>/images/help.jpg" alt="Section HELP" border="0"></A>
					<%}%>
				</TD>
			</TR>
			<TR><TD colspan="3">&nbsp;</TD></TR>
		</TABLE>
	</TD>
</TR>
