package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;
import it.vidiemme.clipping.beans.EventBean;

/**
 * Servlet di gestione degli events
 */
public class ManageEventServlet extends HttpServlet {
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
		EventBean eventBean = new EventBean();
		try {
			eventBean.setEvent_id((request.getParameter("event_id")==null)?"":request.getParameter("event_id"));

			// Se si tratta di un inserimento o di una modifica
			if(operation.equals("insert") || operation.equals("update")){
				// Recupera tutti i dati dal form
				eventBean.setArea_id((request.getParameter("area_id")==null)?"":request.getParameter("area_id"));
				eventBean.setEventtitle((request.getParameter("eventtitle")==null)?"":request.getParameter("eventtitle"));
				eventBean.setEventtype_id((request.getParameter("eventtype_id")==null)?"":request.getParameter("eventtype_id"));
				eventBean.setEventdate((request.getParameter("eventdate")==null)?"":request.getParameter("eventdate"));
				eventBean.setPrref((request.getParameter("prref")==null)?"":request.getParameter("prref"));
				eventBean.setProductorsubject((request.getParameter("productorsubject")==null)?"":request.getParameter("productorsubject"));
				
				// Setta come attributo l'eventBean valorizzato con i campi del form
				request.setAttribute("EVENT_BEAN", eventBean);

				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/events/insert.jsp";
				if(operation.equals("update")){
					page="/events/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(eventBean.getArea_id().equals("")){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(eventBean.getEventtitle().equals("")){
					request.setAttribute("ERROR", "TITLE_REQUIRED");
				}else if(eventBean.getEventtype_id().equals("")){
					request.setAttribute("ERROR", "TYPE_REQUIRED");
				}else if(eventBean.getEventdate().equals("")){
					request.setAttribute("ERROR", "DATE_REQUIRED");
				}else if(!Utils.isCorrectDate(eventBean.getEventdate())){
					request.setAttribute("ERROR", "FORMAT_DATE_ERROR");
				}else if(eventBean.alreadyExists()){
					request.setAttribute("ERROR", "EVENT_ALREADY_EXISTS");
				}else if(eventBean.getPrref().equals("")){
					request.setAttribute("ERROR", "PRREF_REQUIRED");
				}else if(eventBean.getProductorsubject().equals("")){
					request.setAttribute("ERROR", "PRODUCTORSUBJECT_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = eventBean.insert();
						if(resultQuery > 0){
							page = "/events/resultPage.jsp";
							backPage = "/events/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_EVENT");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_EVENT");
						}
					}else if(operation.equals("update")){
						resultQuery = eventBean.update();
						if(resultQuery > 0){
							page = "/events/modify.jsp";
							backPage = "/events/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_EVENT");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_EVENT");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/events/resultPage.jsp";
				backPage = "/events/searchResult.jsp";
				if(eventBean.hasAssociatedClippings()){
					request.setAttribute("MSG", "ERROR_CLIPPINGS_DELETE_EVENT");
				}else{
					resultQuery = eventBean.delete();
					if(resultQuery > 0){
						request.setAttribute("MSG", "SUCCESS_DELETE_EVENT");
					}else{
						request.setAttribute("MSG", "ERROR_DELETE_EVENT");
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