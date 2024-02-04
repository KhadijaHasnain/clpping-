<TABLE width="97%" border="0" cellpadding="1" cellspacing="3" align="center">
	<TR>
		<TD colspan="3" class="text_12_black">The search found <B><%=resultVector.size()%></B> results in <B><%=numbpages%></B> pages</TD>
	</TR>
	<TR>
		<TD width="20%" class="text_12_black" style="text-align:left;vertical-align:middle;">
			<%if(int_group>1){%>
				<A href="javascript: changeGroup(document.search_form, <%=int_group-1%>,<%=(int_group-1)*totpaginepergruppo%>)">&laquo; Prev Block</A>
			<%}%>
		</TD>
		<TD width="60%" class="text_12_black" style="text-align:center;vertical-align:middle;">
			<%for (int i = startpagina; i < numbpages && i < endpagina && numbpages > 1; i++) {%>
				<%if((i+1)!=intpagina){%>
					<A href="javascript: changePage(document.search_form, <%=(i+1)%>)"><%=(i+1)%></A>
				<%}else{%>
					<B><%=(i+1)%></B>
				<%}%>
			<%}%>
		</TD>
		<TD width="20%" class="text_12_black" style="text-align:right;vertical-align:middle;">
			<%if(n_group_pag>1 && int_group<n_group_pag){%>
				<A href="javascript: changeGroup(document.search_form, <%=int_group+1%>,<%=(int_group*totpaginepergruppo) + 1%>)">Next Block &raquo;</A>
			<%}%>
		</TD>
	</TR>
</TABLE>