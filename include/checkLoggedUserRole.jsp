<%
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
// Recupero dal POST il tipo di accesso
// 1 --> tutti gli utenti loggati
// 2 --> solo Admin
// 3 --> Admin o Manager
boolean errorLogin = true;
UserBean user = (session.getAttribute("user") == null)? new UserBean():(UserBean)session.getAttribute("user");

if(accessType.equals("1") && !user.getId_role().equals("")){
	errorLogin = false;
}else if(accessType.equals("2") && user.getId_role().equals(Constants.idRoleAdmin)){
	errorLogin = false;
}else if(accessType.equals("3") && user.getId_role().equals(Constants.idRoleAdmin) || user.getId_role().equals(Constants.idRoleManager)){
	errorLogin = false;
}
if(errorLogin){
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>