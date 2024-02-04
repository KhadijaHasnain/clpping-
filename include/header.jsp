<%@page contentType="text/html" import="it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>


<%
UserBean userHeader = (session.getAttribute("user") == null)? new UserBean():(UserBean)session.getAttribute("user");

String role_desc = "";
if(userHeader.getId_role().equals(Constants.idRoleAdmin)){
	role_desc = "admin";
}else if(userHeader.getId_role().equals(Constants.idRoleManager)){
	role_desc = "manager";
}else{
	role_desc = "end_user";
}
%>


<TR>
	<TD><IMG src="<%=request.getContextPath()%>/images/logo.gif" alt="STMicroelettronics" width="85" height="100"><IMG src="<%=request.getContextPath()%>/images/header.jpg" alt="STMicroelettronics" width="855" height="100"></TD>
</TR> 
<TR>
	<TD class="menu_table">
		<TABLE border="0" cellspacing="0" cellpadding="0">
			<TR>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/publications/insert.jsp">Publications</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/clippings/insert.jsp">Clippings</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/events/insert.jsp">Events</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/reports/index.jsp">Reports</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(userHeader.getId_role().equals(Constants.idRoleAdmin) || userHeader.getId_role().equals(Constants.idRoleManager)){%>
					<A href="<%=request.getContextPath()%>/users/search.jsp">User</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(userHeader.getId_role().equals(Constants.idRoleAdmin)){%>
					<A href="<%=request.getContextPath()%>/countries/search.jsp">Country</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%--<%if(!user.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/products/search.jsp">Products</A>
					<%}%>--%>
				</TD>
				<td width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%--<%if(!user.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/divisions/search.jsp">Divisions</A>
					<%}%>--%>
				</TD>
				<!--<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%--<%if(!user.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/contacts/search.jsp">Contacts</A>
					<%}%>--%>
				</TD>-->
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/helps/help_<%=role_desc%>.pdf">Full Help</A>
					<%}%>
				</TD>
				<TD width="1" id="td_spacer"></TD>
				<TD class="menu">
					<%if(!userHeader.getId_role().equals("")){%>
					<A href="<%=request.getContextPath()%>/logout.do">Logout</A>
					<%}%>
				</TD>
			</TR>
		</TABLE>
	</TD>
</TR>
<TR>
	<TD height="15"></TD>
</TR>
<TR>
	<TD><IMG src="<%=request.getContextPath()%>/images/centrale_sopra.gif" alt="STMicroelettronics" width="940" height="5"></TD>
</TR>