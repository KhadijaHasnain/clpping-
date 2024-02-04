package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.Vector;
import java.util.Hashtable;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di gestione dei new text reports quadrimestrali
 */
public class ReportNewTextQuarterlyServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		String page = "/reports/newTextReport.jsp";
		Vector results = new Vector();
		Hashtable distinctSections = new Hashtable();
		Hashtable distinctSectionsCount = new Hashtable();
		Hashtable distinctSectionsScore = new Hashtable();
		Hashtable distinctSectionsCountValue = new Hashtable();
		Hashtable distinctSectionsScoreValue = new Hashtable();
		Hashtable yearCountTotal = new Hashtable();
		Hashtable yearScoreTotal = new Hashtable();
		Hashtable quarterCountTotal = new Hashtable();
		Hashtable quarterScoreTotal = new Hashtable();
		String id = "";
		String name = "";
		String year = "";
		String quarter = "";
		String count = "";
		String score = "";
		String yearCount = "";
		String yearScore = "";
		String quarterCount = "";
		String quarterScore = "";
		try {
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String section = (request.getParameter("section")==null)?"":request.getParameter("section");
			String trend = (request.getParameter("trend")==null)?"":request.getParameter("trend");
			String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
			String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
			String quarter_from = (request.getParameter("quarter_from")==null)?"":request.getParameter("quarter_from");
			String quarter_to = (request.getParameter("quarter_to")==null)?"":request.getParameter("quarter_to");
			String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
			String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
			String format = (request.getParameter("format")==null)?"":request.getParameter("format");
			String date_from = "";
			String date_to = "";
			if(quarter_from.equals("01")){
				month_from = "01";
			}else if(quarter_from.equals("02")){
				month_from = "04";
			}else if(quarter_from.equals("03")){
				month_from = "07";
			}else if(quarter_from.equals("04")){
				month_from = "10";
			}
			if(quarter_to.equals("01")){
				month_to = "01";
			}else if(quarter_to.equals("02")){
				month_to = "04";
			}else if(quarter_to.equals("03")){
				month_to = "07";
			}else if(quarter_to.equals("04")){
				month_to = "10";
			}
			try {
				date_from = Utils.getMonthDescription(Integer.parseInt(month_from)) + "/01/" + year_from;
				date_to = Utils.getMonthDescription(Integer.parseInt(month_to)) + "/01/" + year_to;
			} catch (Exception e) {}
			
			if(area_id.equals("")){
				request.setAttribute("ERROR", "AREA_REQUIRED");
			}else if(section.equals("")){
				request.setAttribute("ERROR", "SECTION_REQUIRED");
			}else if(quarter_to.equals("") || year_to.equals("") || quarter_from.equals("") || year_from.equals("")){
				request.setAttribute("ERROR", "DATE_RANGE_REQUIRED");
			}else if(Utils.compareDate(date_from, date_to)==-1){
				request.setAttribute("ERROR", "DATE_RANGE_ERROR");
			}else if(format.equals("")){
				request.setAttribute("ERROR", "FORMAT_REQUIRED");
			} else {
				results = DbUtils.getSelectNewTextReport(area_id, country_id, section, "quarterly", month_from, month_to, year_from, year_to);

				for (int i = 0; i < results.size(); i++) {
					yearCount = "0";
					yearScore = "0";
					quarterCount = "0";
					quarterScore = "0";
					id = ((Hashtable)results.elementAt(i)).get("id").toString();
					name = ((Hashtable)results.elementAt(i)).get("name").toString();
					year = ((Hashtable)results.elementAt(i)).get("year").toString();
					quarter = ((Hashtable)results.elementAt(i)).get("quarter").toString();
					count = ((Hashtable)results.elementAt(i)).get("total").toString();
					score = ((Hashtable)results.elementAt(i)).get("points").toString();

					// Inserisce l'id della section se non � presente nell'Hashtable
					if(!distinctSections.containsKey(id)) {
						distinctSections.put(id, name);
					}
					// Inserisce una Hashtable vuota per l'id section se non � presente
					if(!distinctSectionsCount.containsKey(id)) {
						distinctSectionsCount.put(id, new Hashtable());
					}
					// Inserisce una Hashtable vuota per l'id section se non � presente
					if(!distinctSectionsScore.containsKey(id)) {
						distinctSectionsScore.put(id, new Hashtable());
					}

					// Inserisce nella Hashtable corretta il valore di quel mese
					((Hashtable)distinctSectionsCount.get(id)).put(year + "_" + quarter, count);
					((Hashtable)distinctSectionsScore.get(id)).put(year + "_" + quarter, score);
					
					// Aggiunge al totale annuale del COUNT il valore appena letto dal DB
					if(yearCountTotal.get(id + "_" + year) != null) {
						yearCount = yearCountTotal.get(id + "_" + year).toString();
					}
					try {
						yearCount = (Integer.parseInt(yearCount) + Integer.parseInt(count)) + "";
					} catch (Exception e) {}
					yearCountTotal.put(id + "_" + year, yearCount);

					// Aggiunge al totale annuale dello SCORE il valore appena letto dal DB
					if(yearScoreTotal.get(id + "_" + year) != null) {
						yearScore = yearScoreTotal.get(id + "_" + year).toString();
					}
					try {
						yearScore = (Integer.parseInt(yearScore) + Integer.parseInt(score)) + "";
					} catch (Exception e) {}
					yearScoreTotal.put(id + "_" + year, yearScore);

					// Aggiunge al totale quadrimestrale del COUNT il valore appena letto dal DB
					if(quarterCountTotal.get(year + "_" + quarter) != null) {
						quarterCount = quarterCountTotal.get(year + "_" + quarter).toString();
					}
					try {
						quarterCount = (Integer.parseInt(quarterCount) + Integer.parseInt(count)) + "";
					} catch (Exception e) {}
					quarterCountTotal.put(year + "_" + quarter, quarterCount);

					// Aggiunge al totale quadrimestrale dello SCORE il valore appena letto dal DB
					if(quarterScoreTotal.get(year + "_" + quarter) != null) {
						quarterScore = quarterScoreTotal.get(year + "_" + quarter).toString();
					}
					try {
						quarterScore = (Integer.parseInt(quarterScore) + Integer.parseInt(score)) + "";
					} catch (Exception e) {}
					quarterScoreTotal.put(year + "_" + quarter, quarterScore);

					
				}
				request.setAttribute("distinctSections", distinctSections);
				request.setAttribute("distinctSectionsScore", distinctSectionsScore);
				request.setAttribute("distinctSectionsCount", distinctSectionsCount);
				request.setAttribute("yearCountTotal", yearCountTotal);
				request.setAttribute("yearScoreTotal", yearScoreTotal);
				request.setAttribute("quarterCountTotal", quarterCountTotal);
				request.setAttribute("quarterScoreTotal", quarterScoreTotal);
				if(format.equals("web")) {
					page = "/reports/newTextReportQuarterlyResult.jsp";
				} else {
					page = "/reports/newTextReportQuarterlyXLS.jsp";
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
