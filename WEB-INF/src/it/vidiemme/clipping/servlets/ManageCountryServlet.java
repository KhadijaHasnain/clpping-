package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.beans.CountryBean;

/**
 * Servlet di gestione dei countries
 */
public class ManageCountryServlet extends HttpServlet {
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
		int resultQuery = 0;
		// Recupera il valore dell'operazione da eseguire
		String operation = (request.getParameter("operation")==null)?"":request.getParameter("operation");
		
		CountryBean countryBean = new CountryBean();
		try {
			countryBean.setCountry_id((request.getParameter("country_id")==null)?"":request.getParameter("country_id"));
			// Se si tratta di un inserimento o di una modifica
			if(operation.equals("insert") || operation.equals("update")){
				// Recupera tutti i dati dal form
				countryBean.setArea_id((request.getParameter("area_id")==null)?"":request.getParameter("area_id"));
				countryBean.setCountry((request.getParameter("country")==null)?"":request.getParameter("country"));
				countryBean.setDescription((request.getParameter("description")==null)?"":request.getParameter("description"));

				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/countries/insert.jsp";
				if(operation.equals("update")){
					// Setta come attributo il country Bean valorizzato con i campi del form
					request.setAttribute("COUNTRY_BEAN", countryBean);
					page="/countries/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(countryBean.getArea_id().equals("")){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(countryBean.getCountry().equals("")){
					request.setAttribute("ERROR", "COUNTRY_REQUIRED");
				}else if(countryBean.alreadyExists()){
					request.setAttribute("ERROR", "COUNTRY_ALREADY_EXISTS");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = countryBean.insert();
						if(resultQuery > 0){
							page = "/countries/resultPage.jsp";
							backPage = "/countries/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_COUNTRY");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_COUNTRY");
						}
					}else if(operation.equals("update")){
						resultQuery = countryBean.update();
						if(resultQuery > 0){
							page = "/countries/modify.jsp";
							backPage = "/countries/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_COUNTRY");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_COUNTRY");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/countries/resultPage.jsp";
				backPage = "/countries/searchResult.jsp";
				if(countryBean.hasAssociatedUsers()){
					request.setAttribute("MSG", "ERROR_USERS_DELETE_COUNTRY");
				}else if(countryBean.hasAssociatedPublications()){
					request.setAttribute("MSG", "ERROR_PUBLICATIONS_DELETE_COUNTRY");
				}else{
					resultQuery = countryBean.delete();
					if(resultQuery > 0){
						request.setAttribute("MSG", "SUCCESS_DELETE_COUNTRY");
					}else{
						request.setAttribute("MSG", "ERROR_DELETE_COUNTRY");
					}
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