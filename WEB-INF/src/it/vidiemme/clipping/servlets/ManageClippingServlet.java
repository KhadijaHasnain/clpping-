package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.beans.ClippingBean;
import it.vidiemme.clipping.utils.Utils;

/**
 * Servlet di gestione clippings
 */
public class ManageClippingServlet extends HttpServlet {
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
		
		ClippingBean clippingBean = new ClippingBean();
		try {
			// Recupera tutti i dati dal form
			clippingBean.setClipping_id((request.getParameter("clipping_id")==null)?"":request.getParameter("clipping_id"));
			clippingBean.setPublication_id((request.getParameter("publication_id")==null)?"":request.getParameter("publication_id"));
			clippingBean.setEvent_id((request.getParameter("event_id")==null)?"":request.getParameter("event_id"));
			clippingBean.setLengthofarticle_id((request.getParameter("lengthofarticle_id")==null)?"":request.getParameter("lengthofarticle_id"));
			clippingBean.setTone_id((request.getParameter("tone_id")==null)?"":request.getParameter("tone_id"));
			clippingBean.setGraphic_id((request.getParameter("graphic_id")==null)?"":request.getParameter("graphic_id"));
			clippingBean.setCover_id((request.getParameter("cover_id")==null)?"":request.getParameter("cover_id"));
			clippingBean.setFieldstory_id((request.getParameter("fieldstory_id")==null)?"":request.getParameter("fieldstory_id"));
			clippingBean.setTitle((request.getParameter("title")==null)?"":request.getParameter("title"));
			clippingBean.setDatepublished((request.getParameter("datepublished")==null)?"":request.getParameter("datepublished"));
			
			// Setta come attributo il clippingBean valorizzato con i campi del form
			request.setAttribute("CLIPPING_BEAN", clippingBean);
			
			// Se si tratta del reload del form
			if(operation.equals("reload")) {
				page="/clippings/modify.jsp";
				if(clippingBean.getClipping_id().equals("")) {
					page="/clippings/insert.jsp";
				}
			}else if(operation.equals("insert") || operation.equals("update")){
				// Se si tratta di un inserimento o di una modifica
				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/clippings/insert.jsp";
				if(operation.equals("update")){
					page="/clippings/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(clippingBean.getPublication_id().equals("")){
					request.setAttribute("ERROR", "PUBLICATION_REQUIRED");
				}else if(clippingBean.getTitle().equals("")){
					request.setAttribute("ERROR", "TITLE_REQUIRED");
				}else if(clippingBean.getDatepublished().equals("")){
					request.setAttribute("ERROR", "DATE_REQUIRED");
				}else if(!Utils.isCorrectDate(clippingBean.getDatepublished())){
					request.setAttribute("ERROR", "FORMAT_DATE_ERROR");
				}else if(clippingBean.alreadyExists()){
					request.setAttribute("ERROR", "CLIPPING_ALREADY_EXISTS");
				}else if(clippingBean.getLengthofarticle_id().equals("")){
					request.setAttribute("ERROR", "LENGTHOFARTICLE_REQUIRED");
				}else if(clippingBean.getTone_id().equals("")){
					request.setAttribute("ERROR", "TONE_REQUIRED");
				}else if(clippingBean.getGraphic_id().equals("")){
					request.setAttribute("ERROR", "GRAPHIC_REQUIRED");
				}else if(clippingBean.getCover_id().equals("")){
					request.setAttribute("ERROR", "COVER_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = clippingBean.insert();
						if(resultQuery > 0){
							page = "/clippings/insertResult.jsp";
							request.setAttribute("ERROR", "SUCCESS_INSERT_CLIPPING");
							request.setAttribute("CLIPPINGID", clippingBean.getClipping_id());
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_CLIPPING");
						}
					}else if(operation.equals("update")){
						resultQuery = clippingBean.update();
						if(resultQuery > 0){
							page = "/clippings/modify.jsp";
							backPage = "/clippings/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_CLIPPING");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_CLIPPING");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/clippings/resultPage.jsp";
				backPage = "/clippings/searchResult.jsp";
				resultQuery = clippingBean.delete();
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_DELETE_CLIPPING");
				}else{
					request.setAttribute("MSG", "ERROR_DELETE_CLIPPING");
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