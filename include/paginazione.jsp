<%
//pagina corrente
String pagina = request.getParameter("pagina")==null?"1":request.getParameter("pagina");
//gruppo corrente
String group = request.getParameter("group")==null?"1":request.getParameter("group");

int resultPerPage = Constants.resultForPage;
if(paging.equals("n")){
	resultPerPage = resultVector.size();
}
//calcolo numero paginenecessarie
int numbpages = resultVector.size()/resultPerPage;
int intpagina = Integer.parseInt(pagina);
int resto = resultVector.size()%resultPerPage;
if(resto!=0)
	numbpages = numbpages+1;

int startpage = 0;
int endpage = resultPerPage;

//calcolo pagina iniziale e finale
startpage = (intpagina*resultPerPage)-resultPerPage;
endpage = (intpagina*resultPerPage);

int startpagina = 0;
int endpagina = 3;
int totpaginepergruppo = 10;
//numero di gruppi che posso avere (es 1,2,3 4,5,6 ecc)
int n_group_pag = numbpages/totpaginepergruppo;
 
//il gruppo che viene postato dalla fuzione javascript viene convertito in intero (gruppo corrente)
int int_group = Integer.parseInt(group);
 
//resto (per pagine non "complete" es: 7,8)
int resto_group = numbpages%totpaginepergruppo;
 
//se resto è diverso da zero aggiungo un nuovo gruppo ()
if(resto_group!=0)
    n_group_pag = n_group_pag+1;

//pagina iniziale della lista
startpagina = (int_group*totpaginepergruppo)-totpaginepergruppo;
//pagina finale della lista
endpagina = (int_group*totpaginepergruppo);
%>

<TABLE width="90%" border="0" cellpadding="1" cellspacing="3" align="center">
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