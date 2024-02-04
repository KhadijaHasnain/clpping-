package it.vidiemme.clipping.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.log4j.*;
import it.vidiemme.clipping.utils.*;
import it.vidiemme.clipping.database.*;

/**
 * Questa classe gestisce il caricamento dei files di configurazione Al primo accesso,
 * vengono passati alla classe ConnectionDB i nomi dei database a cui connettersi
 **/
 public class Initial extends HttpServlet{ 	
	
	/**
	 * In questa parte di codice l'applicazione ci entra una sola volta.
	 * Vengono passati alla classe ConnectionDB i nomi dei database a 
	 * cui aprire le connessioni
	 *
	 * @param config
	 * @throws ServletException
	 **/
	public void init(ServletConfig config)throws ServletException{
 		// Configurazione della connessione al DB
		ConnectionDB conn = new ConnectionDB();

		// Recupera i nomi dei file di properties da caricare e il nome del datasource dal web.xml
		String query_properties_name = config.getInitParameter("query_file");
		String error_label_properties_name = config.getInitParameter("error_label_file");
		String dataSourceName = config.getInitParameter("clipping_ds_name");

		// Caricamento parametri per la connessione al DB
		conn.loadParam(dataSourceName);
		
		// Definizione del percorso assoluto dell'applicazione, utile per caricare i file di properties
		String realApplicationPath = config.getServletContext().getRealPath("/");

		// Definizione del log4j
		Constants.log = Logger.getRootLogger();

		// Carica i file di properties
		Constants.queries = new ReadQueryFile(realApplicationPath+query_properties_name);
		Constants.errorLabel = new ReadErrorLabelFile(realApplicationPath+error_label_properties_name);
 	}
 }