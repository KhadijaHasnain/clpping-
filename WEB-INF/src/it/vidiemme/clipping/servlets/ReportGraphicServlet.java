package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di controllo dati form e creazione strutture dati dei report grafici
 */
public class ReportGraphicServlet extends HttpServlet {
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
		
		Vector results = new Vector();
		Vector resultsPrevious = new Vector();
		
		Hashtable<String,Hashtable> resultHash = new Hashtable();
		Hashtable<String, double[]> chartHash = new Hashtable();
		
		ArrayList monthList = new ArrayList();
		ArrayList audienceList = new ArrayList();
		
		SimpleDateFormat format = null;
		
		GregorianCalendar gc_from = null;
		GregorianCalendar gc_to = null;
		GregorianCalendar gc_temp = null;
		
		double max_value = 0;
		
		try {
			String type = (request.getParameter("type")==null)?"":request.getParameter("type");
			String area_id = (request.getParameter("area_id")==null)?"":request.getParameter("area_id");
			String country_id = (request.getParameter("country_id")==null)?"":request.getParameter("country_id");
			String audience_id = (request.getParameter("audience_id")==null)?"":request.getParameter("audience_id");
			String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
			String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
			String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
			String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
			String type_graph = (request.getParameter("type_graph")==null)?"":request.getParameter("type_graph");
			String image_title = (request.getParameter("image_title")==null)?"ST Report":request.getParameter("image_title");
			String label_x = (request.getParameter("label_x")==null)?"Label X":request.getParameter("label_x");
			String label_y = (request.getParameter("label_y")==null)?"Label Y":request.getParameter("label_y");
			String year_type = (request.getParameter("year_type")==null)?"":request.getParameter("year_type");
			
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
			}else if(year_type.equals("selected_previous") && audience_id.equals("")){
				request.setAttribute("ERROR", "SPECIFY_AUDIENCE");
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
				
				if(audience_id.equals("")){
					results = DbUtils.getAudiences();
					for (int i=0; i<results.size(); i++){
						String audience = ((Hashtable)results.elementAt(i)).get("audience").toString();
						resultHash.put(audience, new Hashtable());
						audienceList.add(audience);
					}
					resultHash.put("Total", new Hashtable());
					audienceList.add("Total");
				
				}else if(!audience_id.equals("") && year_type.equals("selected_previous")){
					String audience = DbUtils.getAudienceDescription(audience_id);
					resultHash.put(audience, new Hashtable());
					audienceList.add(audience);
					resultHash.put(audience+" Previous", new Hashtable());
					audienceList.add(audience+" Previous");
					
				}else{
					String audience = DbUtils.getAudienceDescription(audience_id);
					resultHash.put(audience, new Hashtable());
					audienceList.add(audience);
				}
				
				if(year_type.equals("selected")){
					results = DbUtils.getYearSelectedGraphicReport(type, area_id, country_id, audience_id, month_from, month_to, year_from, year_to);
				}else{
					results = DbUtils.getYearSelectedGraphicReport(type, area_id, country_id, audience_id, month_from, month_to, year_from, year_to);
					resultsPrevious = DbUtils.getSelectedPreviousGraphicReport(type, area_id, country_id, audience_id, month_from, month_to, year_from, year_to);
				}
					
				format = new SimpleDateFormat("MM");
				
				gc_from = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
				gc_to = new GregorianCalendar(Integer.parseInt(year_to), Integer.parseInt(month_to)-1, 01);
				gc_temp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
				
				while(!gc_temp.after(gc_to)){
					String month_temp = format.format(gc_temp.getTime());
					String monthDesc = Utils.getMonthDescription(Integer.parseInt(month_temp));
					monthList.add(monthDesc);
					Enumeration<String> audienceEnum = resultHash.keys();
					while(audienceEnum.hasMoreElements()){
						resultHash.get(audienceEnum.nextElement()).put(monthDesc, "0");
					}
					gc_temp.add(Calendar.MONTH, 1);
				}
				
				if(year_type.equals("selected")){
					for (int i = 0; i < results.size(); i++) {
						String audience = ((Hashtable)results.elementAt(i)).get("name").toString();
						String monthDB = ((Hashtable)results.elementAt(i)).get("month").toString();
						String total = ((Hashtable)results.elementAt(i)).get("total").toString();
						if(Double.parseDouble(total) > max_value){
							max_value = Double.parseDouble(total);
						}
						monthDB = Utils.getMonthDescription(Integer.parseInt(monthDB));
						resultHash.get(audience).put(monthDB, total);
						if(audience_id.equals("")){
							double oldVal = Double.parseDouble(resultHash.get("Total").get(monthDB).toString());
							double newVal = oldVal + Double.parseDouble(total);
							if(type.equals("1")){
								resultHash.get("Total").put(monthDB, Math.round(newVal) + "");
							}else{
								resultHash.get("Total").put(monthDB, newVal + "");
							}
							if(newVal > max_value){
								max_value = newVal;
							}
						}
					}					
				
				}else{
					for (int i = 0; i < results.size(); i++) {
						String audience = ((Hashtable)results.elementAt(i)).get("name").toString();
						String monthDB = ((Hashtable)results.elementAt(i)).get("month").toString();
						String total = ((Hashtable)results.elementAt(i)).get("total").toString();
						if(Double.parseDouble(total) > max_value){
							max_value = Double.parseDouble(total);
						}
						monthDB = Utils.getMonthDescription(Integer.parseInt(monthDB));
						if(type.equals("1")){
							resultHash.get(audience).put(monthDB, Math.round(Double.parseDouble(total))+"");
						}else{
							resultHash.get(audience).put(monthDB, total);
						}
					}
					for (int i = 0; i < resultsPrevious.size(); i++) {
						String audience = ((Hashtable)resultsPrevious.elementAt(i)).get("name").toString();
						String monthDB = ((Hashtable)resultsPrevious.elementAt(i)).get("month").toString();
						String total = ((Hashtable)resultsPrevious.elementAt(i)).get("total").toString();
						if(Double.parseDouble(total) > max_value){
							max_value = Double.parseDouble(total);
						}
						monthDB = Utils.getMonthDescription(Integer.parseInt(monthDB));
						if(type.equals("1")){
							resultHash.get(audience+" Previous").put(monthDB, Math.round(Double.parseDouble(total)));
						}else{
							resultHash.get(audience+" Previous").put(monthDB, total);
						}
					}
				}
				
				page = "/reports/graphicReportResult.jsp";
				
				// trasforma la lista dei mesi in array per creare le labels dei mesi
				String[] monthArray = (String[])monthList.toArray(new String[monthList.size()]);
				
				// costruisce l'hashtable chartHash che conterra' per ogni audience un array di double che rappresenta il numero di clipping per ogni mese
				for(int i=0; i<audienceList.size(); i++){
					String audience_temp = audienceList.get(i).toString();
					chartHash.put(audience_temp, new double[monthList.size()]);
					for(int j=0; j<monthList.size(); j++) {
						double val = Double.parseDouble(resultHash.get(audience_temp).get(monthList.get(j)).toString());
						if(type.equals("1")){
							chartHash.get(audience_temp)[j] = Math.round(val);
						}else {
							chartHash.get(audience_temp)[j] = val;
						}
					}
				}
				// mette in sessione tutte le variabili e le strutture dati per la creazione dei grafici
				session.setAttribute("audienceList", audienceList);
				session.setAttribute("resultHash", resultHash);
				session.setAttribute("Title", image_title);
				session.setAttribute("xLabel",label_x);
				session.setAttribute("yLabel",label_y);
				session.setAttribute("labelXAxis", monthArray);
				session.setAttribute("legendList", audienceList);
				session.setAttribute("monthList", monthList);
				session.setAttribute("chartHash", chartHash);
				session.setAttribute("max_value", max_value);
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
