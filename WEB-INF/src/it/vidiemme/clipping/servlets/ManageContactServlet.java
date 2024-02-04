package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;
import it.vidiemme.clipping.beans.ContactBean;

/**
 * Servlet di gestione contacts
 */
public class ManageContactServlet extends HttpServlet {
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
		
		ContactBean contactBean = new ContactBean();
		try {
			// Recupera tutti i dati dal form
			contactBean.setContact_id((request.getParameter("contact_id")==null)?"":request.getParameter("contact_id"));
			contactBean.setPublication_id((request.getParameter("publication_id")==null)?"":request.getParameter("publication_id"));
			contactBean.setGeneral((request.getParameter("general")==null)?"":request.getParameter("general"));
			contactBean.setFirstname((request.getParameter("firstname")==null)?"":request.getParameter("firstname"));
			contactBean.setLastname((request.getParameter("lastname")==null)?"":request.getParameter("lastname"));
			contactBean.setContacttype((request.getParameter("contacttype")==null)?"":request.getParameter("contacttype"));
			contactBean.setLastmeetingdate((request.getParameter("lastmeetingdate")==null)?"":request.getParameter("lastmeetingdate"));
			contactBean.setSpecifics((request.getParameter("specifics")==null)?"":request.getParameter("specifics"));
			contactBean.setAddress((request.getParameter("address")==null)?"":request.getParameter("address"));
			contactBean.setCity((request.getParameter("city")==null)?"":request.getParameter("city"));
			contactBean.setState((request.getParameter("state")==null)?"":request.getParameter("state"));
			contactBean.setPostalcode((request.getParameter("postalcode")==null)?"":request.getParameter("postalcode"));
			contactBean.setCountry((request.getParameter("country")==null)?"":request.getParameter("country"));
			contactBean.setWorkphone((request.getParameter("workphone")==null)?"":request.getParameter("workphone"));
			contactBean.setFaxnumber((request.getParameter("faxnumber")==null)?"":request.getParameter("faxnumber"));
			contactBean.setEmailname((request.getParameter("emailname")==null)?"":request.getParameter("emailname"));
			contactBean.setNote((request.getParameter("note")==null)?"":request.getParameter("note"));
			contactBean.setContactbyphone((request.getParameter("contactbyphone")==null)?"":request.getParameter("contactbyphone"));
			contactBean.setContactbyemail((request.getParameter("contactbyemail")==null)?"":request.getParameter("contactbyemail"));
			contactBean.setGeographic_region((request.getParameter("contactgeographicregion")==null)?"":request.getParameter("contactgeographicregion"));
			
			// Setta come attributo il contactBean valorizzato con i campi del form
			request.setAttribute("CONTACT_BEAN", contactBean);
			
			// Se si tratta del reload del form
			if(operation.equals("reload")) {
				page="/contacts/modify.jsp";
				if(contactBean.getContact_id().equals("")) {
					page="/contacts/insert.jsp";
				}
			}else if(operation.equals("insert") || operation.equals("update")){
				// Se si tratta di un inserimento o di una modifica
				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/contacts/insert.jsp";
				if(operation.equals("update")){
					page="/contacts/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(contactBean.getPublication_id().equals("")){
					request.setAttribute("ERROR", "PUBLICATION_REQUIRED");
				}else if(contactBean.getLastname().equals("")){
					request.setAttribute("ERROR", "LASTNAME_REQUIRED");
				}else if(contactBean.alreadyExists()){
					request.setAttribute("ERROR", "CONTACT_ALREADY_EXISTS");
				}else if(!Utils.isCorrectDate(contactBean.getLastmeetingdate())){
					request.setAttribute("ERROR", "FORMAT_DATE_ERROR");
				}else if(contactBean.getContactbyphone().equals("")){
					request.setAttribute("ERROR", "CONTACTBYPHONE_REQUIRED");
				}else if(contactBean.getContactbyemail().equals("")){
					request.setAttribute("ERROR", "CONTACTBYEMAIL_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = contactBean.insert();
						if(resultQuery > 0){
							page = "/contacts/resultPage.jsp";
							backPage = "/contacts/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_CONTACT");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_CONTACT");
						}
					}else if(operation.equals("update")){
						resultQuery = contactBean.update();
						if(resultQuery > 0){
							page = "/contacts/modify.jsp";
							backPage = "/contacts/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_CONTACT");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_CONTACT");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/contacts/resultPage.jsp";
				backPage = "/contacts/searchResult.jsp";
				resultQuery = contactBean.delete();
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_DELETE_CONTACT");
				}else{
					request.setAttribute("MSG", "ERROR_DELETE_CONTACT");
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