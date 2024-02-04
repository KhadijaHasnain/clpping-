package it.vidiemme.clipping.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di gestione degli important tiltles reports 
 */
public class ReportImportantTitlesServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		String page = "/reports/importantTitles.jsp";
		Vector results = new Vector();
		try {
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String minScore = (request.getParameter("score_min")==null)?"":request.getParameter("score_min");
			String maxScore = (request.getParameter("score_max")==null)?"":request.getParameter("score_max");
			String date_from = (request.getParameter("date_from")==null)?"":request.getParameter("date_from");
			String date_to = (request.getParameter("date_to")==null)?"":request.getParameter("date_to");
			String format = (request.getParameter("format")==null)?"":request.getParameter("format");
			
			if(area_id.equals("")){
				request.setAttribute("ERROR", "AREA_REQUIRED");
			}else if(minScore.equals("") && maxScore.equals("")){
				request.setAttribute("ERROR", "SCORE_REQUIRED");
			}else if(date_from.equals("") && date_to.equals("")){
				request.setAttribute("ERROR", "DATE_RANGE_REQUIRED");
			}else if(!date_from.equals("") && !Utils.isCorrectDate(date_from)){
				request.setAttribute("ERROR", "FORMAT_FROM_DATE_ERROR");
			}else if(!date_to.equals("") && !Utils.isCorrectDate(date_to)){
				request.setAttribute("ERROR", "FORMAT_TO_DATE_ERROR");
			}else if(!date_from.equals("") && !date_to.equals("") && Utils.compareDate(date_from, date_to)==-1){
				request.setAttribute("ERROR", "DATE_RANGE_ERROR");
			} else if(format.equals("")) {
				request.setAttribute("ERROR", "FORMAT_REQUIRED");
			} else {
				results = DbUtils.getImportantTitlesReport(area_id, country_id, minScore, maxScore, date_from, date_to);
				request.setAttribute("results", results);
				if(format.equals("web")) {
					page = "/reports/importantTitlesResult.jsp";
				} else {
					page = "/reports/importantTitlesXLS.jsp";
				}
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
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