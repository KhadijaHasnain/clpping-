package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.Vector;
import java.util.Hashtable;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di gestione dei new text reports annuali
 */
public class ReportNewTextYearlyServlet extends HttpServlet {
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
		String id = "";
		String name = "";
		String year = "";
		String month = "";
		String count = "";
		String score = "";
		String yearCount = "0";
		String yearScore = "0";
		try {
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String section = (request.getParameter("section")==null)?"":request.getParameter("section");
			String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
			String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
			String format = (request.getParameter("format")==null)?"":request.getParameter("format");
			String date_from = "Jan/01/" + year_from;
			String date_to = "Jan/01/" + year_to;
			if(area_id.equals("")){
				request.setAttribute("ERROR", "AREA_REQUIRED");
			}else if(section.equals("")){
				request.setAttribute("ERROR", "SECTION_REQUIRED");
			}else if(year_from.equals("")){
				request.setAttribute("ERROR", "YEAR_FROM_REQUIRED");
			}else if(year_to.equals("")){
				request.setAttribute("ERROR", "YEAR_TO_REQUIRED");
			}else if(Utils.compareDate(date_from, date_to) == -1){
				request.setAttribute("ERROR", "DATE_RANGE_ERROR");
			}else if(format.equals("")){
				request.setAttribute("ERROR", "FORMAT_REQUIRED");
			} else {
				results = DbUtils.getSelectNewTextReport(area_id, country_id, section, "yearly", "", "", year_from, year_to);

				for (int i = 0; i < results.size(); i++) {
					yearCount = "0";
					yearScore = "0";
					id = ((Hashtable)results.elementAt(i)).get("id").toString();
					name = ((Hashtable)results.elementAt(i)).get("name").toString();
					year = ((Hashtable)results.elementAt(i)).get("year").toString();
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

					// Inserisce nella Hashtable corretta il valore di quell'anno
					((Hashtable)distinctSectionsCount.get(id)).put(year, count);
					((Hashtable)distinctSectionsScore.get(id)).put(year, score);
					
					if(yearCountTotal.get(year) != null) {
						yearCount = yearCountTotal.get(year).toString();
					}
					try {
						yearCount = (Integer.parseInt(yearCount) + Integer.parseInt(count)) + "";
					} catch (Exception e) {}
					yearCountTotal.put(year, yearCount);

					if(yearScoreTotal.get(year) != null) {
						yearScore = yearScoreTotal.get(year).toString();
					}
					try {
						yearScore = (Integer.parseInt(yearScore) + Integer.parseInt(score)) + "";
					} catch (Exception e) {}
					yearScoreTotal.put(year, yearScore);
				}
				request.setAttribute("distinctSections", distinctSections);
				request.setAttribute("distinctSectionsScore", distinctSectionsScore);
				request.setAttribute("distinctSectionsCount", distinctSectionsCount);
				request.setAttribute("yearCountTotal", yearCountTotal);
				request.setAttribute("yearScoreTotal", yearScoreTotal);
				if(format.equals("web")) {
					page = "/reports/newTextReportYearlyResult.jsp";
				} else {
					page = "/reports/newTextReportYearlyXLS.jsp";
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
