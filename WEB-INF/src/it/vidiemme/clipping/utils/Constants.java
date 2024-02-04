package it.vidiemme.clipping.utils;

import org.apache.log4j.*;

/**
 * In questa classe vengono definite quelle che sono le costanti utili all'applicazione
 **/
public class Constants {
	// Oggetto del logger per loggare eventuali errori
 	public static Logger log = null;

	// Stringa che identifica il titolo delle pagine JSP
	public static String pageTitle = "STMicroelectronics - Clipping DB";

	// tipo di variabili per il prepared statement
	public static String C_INT = "INT";
	public static String C_STRING = "STRING";
	public static String C_DATE = "DATE";
	public static String C_NULL = "NULL";
	public static String C_DOUBLE = "DOUBLE";

	// Formato delle date nel DB
	public static String DBdateFormat = "yyyyMMdd";

	// Formato delle date per la visualizzazione
	public static String VIEWdateFormat = "MMM/dd/yyyy";
	
	// Stringa che identifica il formato corretto per l'inserimento delle date
	public static String STRINGdateFormat = "(Mon/dd/yyyy)";

	// Parametri per la connessione LDAP
	public final static String LDAP_HOST = "164.130.4.78";
	public final static String LDAP_PORT = "389";
	public final static String LDAP_SEARCHBASE = "ou=people, dc=st, dc=com";

	// Oggetto usato per la lettura del file di properties contenente i messaggi di errore
	public static ReadErrorLabelFile errorLabel;
	
	// Oggetto usato per la lettura del file di properties contenente le query SQL
	public static ReadQueryFile queries;

	// Variabili che identificano gli id dei vari ruoli utente
	public static String idRoleAdmin = "1";
	public static String idRoleManager = "2";
	public static String idRoleEndUser = "3";

	// Numero di risultati visualizzati nelle pagine
	public static int resultForPage = 20;
	
	// Numero di risultati per la ricerca dei clippings
	public static int resultForClippingSearch = 3000;

	// Variabili che identificano gli id degli stati Archived e Not Archived
	public static int notArchivedId = 0;
	public static int archivedId = 1;
}