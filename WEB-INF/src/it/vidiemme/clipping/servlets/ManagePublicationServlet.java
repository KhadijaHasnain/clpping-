package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;
import it.vidiemme.clipping.beans.PublicationBean;
import it.vidiemme.clipping.beans.UserBean;

/**
 * Servlet di gestione delle publications
 */
public class ManagePublicationServlet extends HttpServlet {
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
		String visualmode = (request.getParameter("visualmode")==null)?"":request.getParameter("visualmode");
		// Recupera lo userBean dell'utente loggato dalla sessione
		HttpSession session = request.getSession();
		UserBean userBean = (UserBean)session.getAttribute("user");
		PublicationBean publicationBean = new PublicationBean();
		try {
			publicationBean.setPublication_id((request.getParameter("publication_id")==null)?"":request.getParameter("publication_id"));

			// Se si tratta di un inserimento o di una modifica
			if(operation.equals("insert") || operation.equals("update")){
				// Recupera tutti i dati dal form
				publicationBean.setArea_id((request.getParameter("area_id")==null)?"":request.getParameter("area_id"));
				publicationBean.setName((request.getParameter("name")==null)?"":request.getParameter("name"));
				publicationBean.setLast_rated((request.getParameter("last_rated")==null)?"":request.getParameter("last_rated"));
				publicationBean.setAudience_id((request.getParameter("audience_id")==null)?"":request.getParameter("audience_id"));
				publicationBean.setLevel_id((request.getParameter("level_id")==null)?"":request.getParameter("level_id"));
				publicationBean.setSize_id((request.getParameter("size_id")==null)?"":request.getParameter("size_id"));
				publicationBean.setFrequency_id((request.getParameter("frequency_id")==null)?"":request.getParameter("frequency_id"));
				publicationBean.setMedium_id((request.getParameter("medium_id")==null)?"":request.getParameter("medium_id"));
				publicationBean.setDescription((request.getParameter("description")==null)?"":request.getParameter("description"));
				publicationBean.setCountry_id((request.getParameter("country_id")==null)?"":request.getParameter("country_id"));
				publicationBean.setStatus((request.getParameter("status")==null)?"":request.getParameter("status"));

				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/publications/insert.jsp";
				if(operation.equals("insert") && visualmode.equals("popup")){
					page="/publications/insertPopup.jsp";
				}
				if(operation.equals("update")){
					page="/publications/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(publicationBean.getArea_id().equals("")){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(publicationBean.getName().equals("")){
					request.setAttribute("ERROR", "NAME_REQUIRED");
				}else if(publicationBean.getLast_rated().equals("")){
					request.setAttribute("ERROR", "DATE_REQUIRED");
				}else if(!Utils.isCorrectDate(publicationBean.getLast_rated())){
					request.setAttribute("ERROR", "FORMAT_DATE_ERROR");
				}else if(publicationBean.alreadyExists()){
					request.setAttribute("ERROR", "PUBLICATION_ALREADY_EXISTS");
				}else if(publicationBean.getAudience_id().equals("")){
					request.setAttribute("ERROR", "AUDIENCE_REQUIRED");
				}else if(publicationBean.getLevel_id().equals("")){
					request.setAttribute("ERROR", "LEVEL_REQUIRED");
				}else if(publicationBean.getSize_id().equals("")){
					request.setAttribute("ERROR", "SIZE_REQUIRED");
				}else if(publicationBean.getFrequency_id().equals("")){
					request.setAttribute("ERROR", "FREQUENCY_REQUIRED");
				}else if(publicationBean.getMedium_id().equals("")){
					request.setAttribute("ERROR", "MEDIUM_REQUIRED");
				}else if(userBean.getId_role().equals(Constants.idRoleEndUser) && publicationBean.getCountry_id().equals("")){
					request.setAttribute("ERROR", "COUNTRY_REQUIRED");
				}else if(publicationBean.getStatus().equals("")){
					request.setAttribute("ERROR", "STATUS_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert") && !visualmode.equals("popup")){
						resultQuery = publicationBean.insert();
						if(resultQuery > 0){
							page = "/publications/resultPage.jsp";
							backPage = "/publications/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_PUBLICATION");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_PUBLICATION");
						}
					}else if(operation.equals("insert") && visualmode.equals("popup")){
						resultQuery = publicationBean.insert();
						if(resultQuery > 0){
							page = "/publications/resultPagePopup.jsp";
							request.setAttribute("PUBLICATION_ID", publicationBean.getPublication_id());
							request.setAttribute("COUNTRY_ID", publicationBean.getCountry_id());
							request.setAttribute("MSG", "SUCCESS_INSERT_PUBLICATION");
						}else{
							page = "/publications/insertPopup.jsp";
							request.setAttribute("ERROR", "ERROR_INSERT_PUBLICATION");
						}
					}else if(operation.equals("update")){
						resultQuery = publicationBean.update();
						if(resultQuery > 0){
							page = "/publications/modify.jsp";
							backPage = "/publications/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_PUBLICATION");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_PUBLICATION");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/publications/resultPage.jsp";
				backPage = "/publications/searchResult.jsp";
				if(publicationBean.hasAssociatedClippings()){
					request.setAttribute("MSG", "ERROR_CLIPPINGS_DELETE_PUBLICATION");
				}else if(publicationBean.hasAssociatedContacts()){
					request.setAttribute("MSG", "ERROR_CONTACTS_DELETE_PUBLICATION");
				}else{
					resultQuery = publicationBean.delete();
					if(resultQuery > 0){
						request.setAttribute("MSG", "SUCCESS_DELETE_PUBLICATION");
					}else{
						request.setAttribute("MSG", "ERROR_DELETE_PUBLICATION");
					}
				}
			}else if(operation.equals("archive")){
				page = "/publications/resultPage.jsp";
				backPage = "/publications/searchResult.jsp";
				String[] publicationsId = (request.getParameterValues("publications_id")==null)?new String[0]:request.getParameterValues("publications_id");
				resultQuery = publicationBean.archive(publicationsId);
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_ARCHIVE_PUBLICATION");
				}else{
					request.setAttribute("MSG", "ERROR_ARCHIVE_PUBLICATION");
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