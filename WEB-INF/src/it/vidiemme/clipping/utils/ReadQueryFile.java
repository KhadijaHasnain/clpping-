package it.vidiemme.clipping.utils;

import java.io.*;
import java.util.*;
import org.apache.log4j.*;

/**
 * Questa classe carica il file di properties contenente le query
 */
public class ReadQueryFile{
	// Oggetto per usare il log4j 
	static Logger logger = Logger.getRootLogger();

	// Percoso dove si trova il File di properties 
	static String path = "";

	// File di Properties
	static Properties properties = null;

	/**
	 * Indica se il file e' stato trovato oppure no;
	 * error = true --> file non trovato
	 * error = false --> file trovato
	 */
	static boolean error = false;

	/**
	 * Costruttore di ReadQueryFile
	 *
	 * @param String path Stringa che identifica il path del file di properties da caricare
	 */
	public ReadQueryFile(String path){
		try{
			this.path = path;
			properties = new Properties();
			properties.load(new FileInputStream(path));
		}catch (Exception ex){	
			setError(true);
			logger.error(ex.toString());
		}
	}
	
	/**
	 * Questo metodo ritorna il parametro richiesto
	 *
	 * @param String paramName Stringa che identifica il nome del parametro da leggere
	 * @return String param Stringa che identifica il valore del parametro
	 */
	public static String getParameter(String paramName){
		String param = properties.getProperty(paramName);
		return param;
	}

	/**
	 * Metodo setError
	 *
	 * @param boolean error Variabile booleana che identifica il verificarsi di un errore
	 */
	public void setError(boolean error){
		this.error = error;
	}

	/**
	 * Metodo getError
	 *
	 * @return boolean error Variabile booleana che identifica il verificarsi di un errore
	 */
	public static boolean getError(){
		return error;
	}
}