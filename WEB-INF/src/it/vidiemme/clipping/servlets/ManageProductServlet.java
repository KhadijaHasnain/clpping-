package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.beans.ProductBean;

/**
 * Servlet di gestione dei prodotti
 */
public class ManageProductServlet extends HttpServlet {
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
		ProductBean productBean = new ProductBean();
		try {
			productBean.setProduct_id((request.getParameter("product_id")==null)?"":request.getParameter("product_id"));

			// Se si tratta di un inserimento o di una modifica
			if(operation.equals("insert") || operation.equals("update")){
				// Recupera tutti i dati dal form
				productBean.setArea_id((request.getParameter("area_id")==null)?"":request.getParameter("area_id"));
				productBean.setPartnumberorname((request.getParameter("partnumberorname")==null)?"":request.getParameter("partnumberorname"));
				productBean.setDescription((request.getParameter("description")==null)?"":request.getParameter("description"));
				productBean.setStatus((request.getParameter("status")==null)?"":request.getParameter("status"));

				// Setta come attributo il productBean valorizzato con i campi del form
				request.setAttribute("PRODUCT_BEAN", productBean);

				// Setta la pagina di destinazione in base all'operazione da eseguire
				page="/products/insert.jsp";
				if(operation.equals("update")){
					page="/products/modify.jsp";
				}

				// Effettua il controllo sui dati
				if(productBean.getArea_id().equals("")){
					request.setAttribute("ERROR", "AREA_REQUIRED");
				}else if(productBean.getPartnumberorname().equals("")){
					request.setAttribute("ERROR", "PARTNUMBERORNAME_REQUIRED");
				}else if(productBean.alreadyExists()){
					request.setAttribute("ERROR", "PRODUCT_ALREADY_EXISTS");
				}else if(productBean.getStatus().equals("")){
					request.setAttribute("ERROR", "STATUS_REQUIRED");
				}else{
					// Esegue l'inserimento\modifica
					if(operation.equals("insert")){
						resultQuery = productBean.insert();
						if(resultQuery > 0){
							page = "/products/resultPage.jsp";
							backPage = "/products/insert.jsp";
							request.setAttribute("MSG", "SUCCESS_INSERT_PRODUCT");
						}else{
							request.setAttribute("ERROR", "ERROR_INSERT_PRODUCT");
						}
					}else if(operation.equals("update")){
						resultQuery = productBean.update();
						if(resultQuery > 0){
							page = "/products/modify.jsp";
							backPage = "/products/modify.jsp";
							request.setAttribute("ERROR", "SUCCESS_MODIFY_PRODUCT");
						}else{
							request.setAttribute("ERROR", "ERROR_MODIFY_PRODUCT");
						}
					}
				}
			}else if(operation.equals("delete")){
				page = "/products/resultPage.jsp";
				backPage = "/products/searchResult.jsp";
				if(productBean.hasAssociatedClippings()){
					request.setAttribute("MSG", "ERROR_CLIPPINGS_DELETE_PRODUCT");
				}else{
					resultQuery = productBean.delete();
					if(resultQuery > 0){
						request.setAttribute("MSG", "SUCCESS_DELETE_PRODUCT");
					}else{
						request.setAttribute("MSG", "ERROR_DELETE_PRODUCT");
					}
				}
			}else if(operation.equals("archive")){
				page = "/products/resultPage.jsp";
				backPage = "/products/searchResult.jsp";
				String[] productsId = (request.getParameterValues("products_id")==null)?new String[0]:request.getParameterValues("products_id");
				resultQuery = productBean.archive(productsId);
				if(resultQuery > 0){
					request.setAttribute("MSG", "SUCCESS_ARCHIVE_PRODUCT");
				}else{
					request.setAttribute("MSG", "ERROR_ARCHIVE_PRODUCT");
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