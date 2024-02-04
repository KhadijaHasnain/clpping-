package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.beans.DivisionBean;

/**
 * Servlet di gestione delle divisions
 */
public class ManageDivisionServlet extends HttpServlet {
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
		DivisionBean divisionBean = new DivisionBean();
		try {
			divisionBean.setDivision_id((request.getParameter("division_id")==null)?"":request.getParameter("division_id"));

			// Se si tratta di un inserimento o di una modifica
			if(operation.equals("insert") || operation.equals("update")){
				// Recupera tutti i dati dal form
				divisionBean.setArea_id((request.getParameter("area_id")==null)?"":request.getParameter("area_id"));
				divisionBean.setName((request.getParameter("name")==null)?"":request.getParameter("name"));
				divisionBean.setDescription((request.getParameter("description")==null)?"":request.getParameter("description"));
				divisionBean.setStatus((request.getParameter("status")==null)?"":request.getParameter("status"));

				// Setta come attributo il divisionBean valorizzato con i campi del form
				request.setAttribute("DIVISION_BEAN", divisionBean);

				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/divisions/insert.jsp";
				if(operation.equals("update")){
					page="/divisions/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(divisionBean.getArea_id().equals("")){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(divisionBean.getName().equals("")){
					request.setAttribute("ERROR", "NAME_REQUIRED");
				}else if(divisionBean.alreadyExists()){
					request.setAttribute("ERROR", "DIVISION_ALREADY_EXISTS");
				}else if(divisionBean.getStatus().equals("")){
					request.setAttribute("ERROR", "STATUS_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = divisionBean.insert();
						if(resultQuery > 0){
							page = "/divisions/resultPage.jsp";
							backPage = "/divisions/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_DIVISION");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_DIVISION");
						}
					}else if(operation.equals("update")){
						resultQuery = divisionBean.update();
						if(resultQuery > 0){
							page = "/divisions/modify.jsp";
							backPage = "/divisions/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_DIVISION");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_DIVISION");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/divisions/resultPage.jsp";
				backPage = "/divisions/searchResult.jsp";
				if(divisionBean.hasAssociatedClippings()){
					request.setAttribute("MSG", "ERROR_CLIPPINGS_DELETE_DIVISION");
				}else{
					resultQuery = divisionBean.delete();
					if(resultQuery > 0){
						request.setAttribute("MSG", "SUCCESS_DELETE_DIVISION");
					}else{
						request.setAttribute("MSG", "ERROR_DELETE_DIVISION");
					}
				}
			}else if(operation.equals("archive")){
				page = "/divisions/resultPage.jsp";
				backPage = "/divisions/searchResult.jsp";
				String[] divisionsId = (request.getParameterValues("divisions_id")==null)?new String[0]:request.getParameterValues("divisions_id");
				resultQuery = divisionBean.archive(divisionsId);
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_ARCHIVE_DIVISION");
				}else{
					request.setAttribute("MSG", "ERROR_ARCHIVE_DIVISION");
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