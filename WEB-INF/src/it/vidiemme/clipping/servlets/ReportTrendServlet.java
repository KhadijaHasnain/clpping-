package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di controllo dati form e creazione strutture dati per la tipologia di report grafico TREND
 */
public class ReportTrendServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		String page = "/reports/graphicReport.jsp";
		String date_from = "";
		String date_to = "";
		HttpSession session = request.getSession();
		SimpleDateFormat format = null;
		GregorianCalendar gc_from = null;
		GregorianCalendar gc_to = null;
		GregorianCalendar gc_temp = null;
		int length = 0;
		Hashtable valuesHash = new Hashtable();
		Hashtable valuesHashGlobal = new Hashtable();
		
		try {
			String type = (request.getParameter("type")==null)?"":request.getParameter("type");
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
			String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
			String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
			String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
			String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
			String image_title = (request.getParameter("image_title")==null)?"ST Report (Value * 100)":request.getParameter("image_title");
			String label_x = (request.getParameter("label_x")==null)?"Label X":request.getParameter("label_x");
			String label_y = (request.getParameter("label_y")==null)?"Label Y":request.getParameter("label_y");
			String[] trendoptions = (request.getParameterValues("trendoption")==null)?new String[0]:request.getParameterValues("trendoption");
			
			try {
				if(!year_from.equals(""))
					date_from = "/01/" + year_from;
				if(!year_to.equals(""))
					date_to = "/01/" + year_to;
				if(!month_from.equals(""))
					date_from = Utils.getMonthDescription(Integer.parseInt(month_from)) + date_from;
				if(!month_to.equals(""))
					date_to = Utils.getMonthDescription(Integer.parseInt(month_to)) + date_to;
			} catch (Exception e) {}
			
			if(area_id.equals("")){
				request.setAttribute("ERROR", "AREA_REQUIRED");
			}else if(month_from.equals("") && year_from.equals("") && month_to.equals("") && year_to.equals("")){
				request.setAttribute("ERROR", "DATE_RANGE_REQUIRED");
			}else if(!date_from.equals("") && !Utils.isCorrectDate(date_from)){
				request.setAttribute("ERROR", "FORMAT_FROM_DATE_ERROR");
			}else if(!date_to.equals("") && !Utils.isCorrectDate(date_to)){
				request.setAttribute("ERROR", "FORMAT_TO_DATE_ERROR");
			}else if(!date_from.equals("") && !date_to.equals("") && Utils.compareDate(date_from, date_to)==-1){
				request.setAttribute("ERROR", "DATE_RANGE_ERROR");
			// Se year_to > year_from+1 --> ERRORE 
			}else if(!date_from.equals("") && !date_to.equals("") && Integer.parseInt(year_to) > Integer.parseInt(year_from)+1){
				request.setAttribute("ERROR", "YEAR_RANGE_ERROR");
			// Se year_to == year_from+1 && month_from <= month_to --> ERRORE
			}else if(!date_from.equals("") && !date_to.equals("") && Integer.parseInt(year_to) == Integer.parseInt(year_from)+1 && Integer.parseInt(month_from) <= Integer.parseInt(month_to)){
				request.setAttribute("ERROR", "YEAR_RANGE_ERROR");
			}else if(trendoptions.length == 0){
				request.setAttribute("ERROR", "TREND_REQUIRED");
			}else{
				if(date_from.equals("") && !date_to.equals("")){
					// Se month_to = dicembre: year_from uguale, month_from gennaio
					if(Integer.parseInt(month_to) == 12){
						month_from = "01";
						year_from = year_to;
					}else{
						// year_from diminuisce di 1 e month_from aumenta di 1
						month_from = (Integer.parseInt(month_to)+1) + "";
						if((Integer.parseInt(month_to)+1) < 10)
							month_from = "0" + month_from;
						year_from = (Integer.parseInt(year_to)-1) + "";
					}
				}else if(!date_from.equals("") && date_to.equals("")){
					// Se month_from = gennaio: year_to uguale, month_to dicembre
					if(Integer.parseInt(month_from) == 1){
						month_to = "12";
						year_to = year_from;
					}else{
						// year_to aumenta di 1 e month_to diminuisce di 1
						month_to = (Integer.parseInt(month_from)-1) + "";
						if((Integer.parseInt(month_from)-1) < 10)
							month_to = "0" + month_to;
						year_to = (Integer.parseInt(year_from)+1) + "";
					}
				}
				if(containsTrendOption(trendoptions, "ANNUAL")){
					valuesHash = DbUtils.getAnnualTrendGraphicReport(area_id, country_id, audience_id, month_from, year_from, month_to, year_to);
					valuesHashGlobal.put("MONTHS", valuesHash.get("MONTHS"));
					valuesHashGlobal.put("ANNUAL", valuesHash.get("VALUES"));
				}
				if(containsTrendOption(trendoptions, "SEMIANNUAL")){
					valuesHash = DbUtils.getSemiannualTrendGraphicReport(area_id, country_id, audience_id, month_from, year_from, month_to, year_to);
					valuesHashGlobal.put("MONTHS", valuesHash.get("MONTHS"));
					valuesHashGlobal.put("SEMIANNUAL", valuesHash.get("VALUES"));
				}
				if(containsTrendOption(trendoptions, "QUARTERLY")){
					valuesHash = DbUtils.getQuarterlyTrendGraphicReport(area_id, country_id, audience_id, month_from, year_from, month_to, year_to);
					valuesHashGlobal.put("MONTHS", valuesHash.get("MONTHS"));
					valuesHashGlobal.put("QUARTERLY", valuesHash.get("VALUES"));
				}

				page = "/reports/graphicTrendReportResult.jsp";
				// mette in sessione tutte le variabili e le strutture dati per la creazione del grafico
				session.setAttribute("Title", image_title);
				session.setAttribute("xLabel",label_x);
				session.setAttribute("yLabel",label_y);
				session.setAttribute("legend", trendoptions);
				session.setAttribute("values", valuesHashGlobal);
			}
		} catch (Exception e) {
			Constants.log.error(e);
			e.printStackTrace();
		}
		request.getRequestDispatcher(page).forward(request, response);
	}

	private boolean containsTrendOption(String[] trendoptions, String trendoption){
		boolean containsTrendOption = false;
		for (int q = 0; q < trendoptions.length; q++) {
			if(trendoptions[q].equals(trendoption)){
				containsTrendOption = true;
				break;
			}
		}
		return containsTrendOption;
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
	
	/**
	 * Metodo che gestisce le chiamate in GET alla servlet
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
