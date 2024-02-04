package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di gestione dei text reports
 */
public class ReportTextServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		String page = "/reports/textReport.jsp";
		Vector results = new Vector();
		try {
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String section_id = (request.getParameter("section_id")==null)?"":request.getParameter("section_id");
			String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
			String publication_id = (request.getParameter("publication_id")==null)?"":request.getParameter("publication_id");
			String event_id = (request.getParameter("event_id")==null)?"":request.getParameter("event_id");
			String medium_id = (request.getParameter("medium_id")==null)?"":request.getParameter("medium_id");
			String time = (request.getParameter("time")==null)?"":request.getParameter("time");
			String date_from = (request.getParameter("date_from")==null)?"":request.getParameter("date_from");
			String date_to = (request.getParameter("date_to")==null)?"":request.getParameter("date_to");
			String format = (request.getParameter("format")==null)?"":request.getParameter("format");
			
			if(area_id.equals("")){
				request.setAttribute("ERROR", "AREA_REQUIRED");
			}else if(section_id.equals("")){
				request.setAttribute("ERROR", "SECTION_REQUIRED");
			}else if(time.equals("")){
				request.setAttribute("ERROR", "TIME_REQUIRED");
			}else if(time.equals("from_to") && date_from.equals("") && date_to.equals("")){
				request.setAttribute("ERROR", "DATE_RANGE_REQUIRED");
			}else if(!date_from.equals("") && !Utils.isCorrectDate(date_from)){
				request.setAttribute("ERROR", "FORMAT_FROM_DATE_ERROR");
			}else if(!date_to.equals("") && !Utils.isCorrectDate(date_to)){
				request.setAttribute("ERROR", "FORMAT_TO_DATE_ERROR");
			}else if(!date_from.equals("") && !date_to.equals("") && Utils.compareDate(date_from, date_to)==-1){
				request.setAttribute("ERROR", "DATE_RANGE_ERROR");
			} else if(format.equals("")) {
				request.setAttribute("ERROR", "FORMAT_REQUIRED");
			}else{
				if(section_id.equals("7")){
					results = DbUtils.getSelectScoreReport(area_id, country_id, time, date_from, date_to);
				}else if(section_id.equals("1")){
					results = DbUtils.getSelectAudienceReport(area_id, country_id, audience_id, time, date_from, date_to);
				}else if(section_id.equals("3")){
					results = DbUtils.getSelectEventReport(area_id, country_id, event_id, time, date_from, date_to);
				}else if(section_id.equals("5")){
					results = DbUtils.getSelectPublicationReport(area_id, country_id, publication_id, time, date_from, date_to);
				}else if(section_id.equals("6")){
					results = DbUtils.getSelectMediumReport(area_id, country_id, medium_id, time, date_from, date_to);
				}
				request.setAttribute("results", results);
				if(format.equals("web")) {
					page = "/reports/textReportResult.jsp";
				} else {
					page = "/reports/textReportXLS.jsp";
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