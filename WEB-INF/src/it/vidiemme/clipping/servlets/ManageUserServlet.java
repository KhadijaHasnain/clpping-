package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;

import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.beans.UserBean;

/**
 * Servlet di gestione users
 */
public class ManageUserServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		String page = "";
		String backPage = "";
		String[] countries = null;
		String[] areas = null;
		Vector countriesVector = new Vector();
		Vector areasVector = new Vector();
		int resultQuery = 0;
		// Recupera il valore dell'operazione da eseguire
		String operation = (request.getParameter("operation")==null)?"":request.getParameter("operation");
		
		UserBean userBean = new UserBean();
		try {
			// Recupera tutti i dati dal form
			userBean.setId_user((request.getParameter("user_id")==null)?"":request.getParameter("user_id"));
			userBean.setId_role((request.getParameter("id_role")==null)?"":request.getParameter("id_role"));
			userBean.setUsername((request.getParameter("username")==null)?"":request.getParameter("username"));
			if(userBean.getId_role().equals(Constants.idRoleEndUser )) {
				countries = (request.getParameterValues("country")==null)? new String[0]:request.getParameterValues("country");
				for (int i = 0; i < countries.length; i++) {
					countriesVector.add(countries[i]);
				}
				userBean.setCountries(countriesVector);
			}
			if(!userBean.getId_role().equals(Constants.idRoleAdmin)) {
				areas = (request.getParameterValues("area")==null)? new String[0]:request.getParameterValues("area");
				for (int i = 0; i < areas.length; i++) {
					areasVector.add(areas[i]);
				}
				userBean.setAreas(areasVector);
			}

			// Setta come attributo lo userBean valorizzato con i campi del form
			request.setAttribute("USER_BEAN", userBean);

			// Se si tratta del reload del form
			if(operation.equals("reload")) {
				page="/users/modify.jsp";
				if(userBean.getId_user().equals("")) {
					page="/users/insert.jsp";
				}
			}else if(operation.equals("insert") || operation.equals("update")){
				// Se si tratta di un inserimento o di una modifica
				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/users/insert.jsp";
				if(operation.equals("update")){
					page="/users/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(userBean.getId_role().equals("")){
					request.setAttribute("ERROR", "ROLE_REQUIRED");
				}else if(userBean.getUsername().equals("")){
					request.setAttribute("ERROR", "USERNAME_USER_REQUIRED");
				}else if(!userBean.userLDAPexist()){
					request.setAttribute("ERROR", "LDAP_ERROR");
				}else if(userBean.userAlreadyExists()){
					request.setAttribute("ERROR", "USERNAME_ALREADY_EXISTS");
				}else if(!userBean.getId_role().equals(Constants.idRoleAdmin) && userBean.getAreas().size() == 0){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(userBean.getId_role().equals(Constants.idRoleEndUser) && userBean.getCountries().size() == 0){
					request.setAttribute("ERROR", "AT_LEAST_ONE_COUNTRY_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = userBean.insert();
						if(resultQuery > 0){
							page = "/users/resultPage.jsp";
							backPage = "/users/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_USER");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_USER");
						}
					}else if(operation.equals("update")){
						resultQuery = userBean.update();
						if(resultQuery > 0){
							page = "/users/modify.jsp";
							backPage = "/users/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_USER");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_USER");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/users/resultPage.jsp";
				backPage = "/users/searchResult.jsp";
				resultQuery = userBean.delete();
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_DELETE_USER");
				}else{
					request.setAttribute("MSG", "ERROR_DELETE_USER");
				}
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		request.setAttribute("BACK_PAGE", backPage);
		request.getRequestDispatcher(page).forward(request, response);
	}

	/**
	 * Metodo che gestisce le chiamate in POST alla servlet
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
