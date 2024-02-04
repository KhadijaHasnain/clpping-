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