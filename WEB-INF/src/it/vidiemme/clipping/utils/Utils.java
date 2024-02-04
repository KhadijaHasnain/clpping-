package it.vidiemme.clipping.utils;

import java.util.*;
import java.text.*;

public class Utils {
	/**
	 * Converte la data nel formato corretto per l visualizzazione
	 *
	 * @param String date stringa da formattare
	 * @return String date Stringa che rappresenta la data formattata
	 */
	public static String formatDateForView(String date){
		Date dateSimple = null;
		Format formatter = null;
		try {
			if(!date.equals("")){
				dateSimple = new SimpleDateFormat(Constants.DBdateFormat).parse(date);
				formatter = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH);
				date = formatter.format(dateSimple);
			}
		}catch(ParseException e) {
			Constants.log.error(e.toString());
		}
		
		return date;
	}

	/**
	 * Converte la data nel formato corretto per l'inserimento nel DB
	 *
	 * @param String date stringa da controllare
	 * @return String date Stringa che rappresenta la data formattata
	 */
	public static String formatDateForDB(String date) {
		Date dateSimple = null;
		Format formatter = null;
		try {
			if(!date.equals("")){
				dateSimple = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH).parse(date);
				formatter = new SimpleDateFormat(Constants.DBdateFormat);
				date = formatter.format(dateSimple);
			}
		}catch(ParseException e) {
			Constants.log.error(e.toString());
		}
		return date;
	}
	
	/*public static void main (String[] args){
		String date = "2006";
		String previousYearFrom = String.valueOf(Integer.parseInt(date)-1);
		//boolean correct = isCorrectDate(date);
		System.out.println("today---->"+previousYearFrom);
	}*/
	
	/**
	 *	Metodo che ritorna true o false a seconda che il formato della data passata come parametro sia corretto  
	 *	MMM/dd/yy
	 *
	 *	@param String date
	 *	@return boolean isCorrectDate
	 */
	public static boolean isCorrectDate(String date) {
		boolean isCorrectDate = true;
		try {
			Date dateSimple = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH).parse(date);
			Format formatter = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH);
			if (!date.equals(formatter.format(dateSimple)))
				isCorrectDate = false;
		}catch(ParseException e) {
			isCorrectDate = false;
		}
		return isCorrectDate;
	}
	
	/**
	 *	Metodo che confronta due date, ritorna:
	 *	
	 *	0 se la date_from e la date_to sono uguali;
	 *	1 se la date_from e' minore della date_to;
	 *	-1 se la date_from e' maggiore della date_to;
	 *
	 *	@param String date_from Data di inizio
	 *	@param String date_to Data di fine
	 *	@return int dateDifference Variabile intera che identifica il risultato del confronto tra date
	 */
	public static int compareDate(String date_from, String date_to) {
		int dateDifference = 0;
		try {
			Date dateFrom = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH).parse(date_from);
			Date dateTo = new SimpleDateFormat(Constants.VIEWdateFormat, Locale.ENGLISH).parse(date_to);
			dateDifference = dateTo.compareTo(dateFrom);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return dateDifference;
	}

	/**
	 * Metodo che data una stringa in ingresso la normalizza per il DB
	 *
	 * @param String str Stringa da normalizzare
	 * @return String date Stringa normalizzata
	 */
	public static String formatStringForDB(String str) {
		try {
			str = str.replaceAll("'", "''");
		}catch(Exception e) {
			Constants.log.error(e.toString());
		}
		return str;
	}

	/**
	 * Metodo che data una stringa in ingresso la normalizza per la visualizzazione
	 *
	 * @param String str Stringa da normalizzare
	 * @return String date Stringa normalizzata
	 */
	public static String formatStringForView(String str) {
		try {
			str = str.replaceAll("\"", "&quot;");
		}catch(Exception e) {
			Constants.log.error(e.toString());
		}
		return str;
	}

	/**
	 * Metodo che dato in ingresso l'intero che identifica il mese ne ritorna la descrizione
	 *
	 * @param int month Intero che identifica il mese
	 * @return String monthStr Stringa ceh identifica la descrizione del mese
	 */
	public static String getMonthDescription(int month) {
		String monthStr = "";
		switch(month) {
			case 1:monthStr = "Jan";break;
			case 2:monthStr = "Feb";break;
			case 3:monthStr = "Mar";break;
			case 4:monthStr = "Apr";break;
			case 5:monthStr = "May";break;
			case 6:monthStr = "Jun";break;
			case 7:monthStr = "Jul";break;
			case 8:monthStr = "Aug";break;
			case 9:monthStr = "Sep";break;
			case 10:monthStr = "Oct";break;
			case 11:monthStr = "Nov";break;
			case 12:monthStr = "Dec";break;
		}
		return monthStr;
	}

	/**
	 * Metodo che dato in ingresso un double lo arrotonda
	 *
	 * @param String doubleIn Stringa che contiene il double da arrotondare
	 * @return String doubleOut Stringa che contiene il double arrotondato
	 */
	public static String round(String doubleIn){
		String doubleOut = doubleIn;
		double doubleValue = 0.00d;

		try {
			if(!doubleIn.equals("")){
				doubleValue = Double.parseDouble(doubleIn);
				DecimalFormatSymbols difs = new DecimalFormatSymbols(Locale.ITALY);
				DecimalFormat dif = new DecimalFormat("#,###,##0.00", difs);
				doubleOut = dif.format(doubleValue);
			}
		}catch (Exception ex) {
			Constants.log.error(ex.toString());
		}

		return doubleOut;
	}

	/**
	 * Metodo che dato in ingresso un double lo arrotonda
	 *
	 * @param String doubleIn Stringa che contiene il double da arrotondare
	 * @return String doubleOut Stringa che contiene il double arrotondato
	 */
	public static String roundForDB(String doubleIn){
		String doubleOut = doubleIn;
		double doubleValue = 0.00d;

		try {
			if(!doubleIn.equals("")){
				doubleValue = Double.parseDouble(doubleIn);
				DecimalFormatSymbols difs = new DecimalFormatSymbols(Locale.ENGLISH);
				DecimalFormat dif = new DecimalFormat("0.00", difs);
				doubleOut = dif.format(doubleValue);
			}
		}catch (Exception ex) {
			Constants.log.error(ex.toString());
		}

		return doubleOut;
	}

	/**
	 * Metodo che dato in ingresso un double lo arrotonda e lo renderizza in formato americano
	 *
	 * @param String doubleIn Stringa che contiene il double da arrotondare
	 * @return String doubleOut Stringa che contiene il double arrotondato
	 */
	public static String roundUS(String doubleIn){
		String doubleOut = doubleIn;
		double doubleValue = 0.00d;

		try {
			if(!doubleIn.equals("")){
				doubleValue = Double.parseDouble(doubleIn);
				DecimalFormatSymbols difs = new DecimalFormatSymbols(Locale.US);
				DecimalFormat dif = new DecimalFormat("#,###,##0.00", difs);
				doubleOut = dif.format(doubleValue);
			}
		}catch (Exception ex) {
			Constants.log.error(ex.toString());
		}

		return doubleOut;
	}
}