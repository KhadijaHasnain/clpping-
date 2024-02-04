package it.vidiemme.clipping.database;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import it.vidiemme.clipping.utils.*;

/**
 * ConnectionDB: questa classe restituisce un oggetto di tipo Connection (metodo getConnection()) 
 * per effettuare connessioni al database. Al primo accesso viene creato un oggetto di tipo 
 * DataSource che serve a selezionare il database su cui lavorare. Per le connessioni 
 * al db, viene utilizzato il pool di connessioni di TOMCAT (parametri di configurazione nel 
 * server.xml di tomcat).  
 */
public class ConnectionDB{
	// Oggetto che identifica il database su cui lavora l'applicazione
	private static DataSource database = null;

	/**
	 * Costruttore di default
	 */
	public 	ConnectionDB(){}

	/**
	 * Questa parte di codice viene richiamata la prima volta che si richiama questa
	 * classe. Crea l'oggetto database di tipo DataSource che identifica il database
	 * da utilizzare
	 *
	 * @param dbName Nome del database
	 * @throws NamingException
	 */
	public void loadParam(String dbName) {
		try{
			Context env = (Context) new InitialContext().lookup("java:comp/env");
			database = (DataSource) env.lookup("jdbc/"+dbName);
		}catch (NamingException e) {
			Constants.log.error(e.toString()+" - IMPOSSIBILE CARICARE IL DATASOURCE");
		}catch(Exception ex){
			Constants.log.error(ex.toString()+" - IMPOSSIBILE CARICARE IL DATASOURCE");
		}
	}

	/**
	 * Metodo richiamato dalle altre classi per prendere una connessione per effettuare
	 * operazioni sul db.
	 *
	 * @return conn Connessione
	 * @throws SQLException
	 **/
	public static Connection getConnection() {
		// connessione da restituire
		Connection conn=null;
		try {
			//connessione
			conn = database.getConnection();
		}catch(SQLException e) {
			Constants.log.error(e.toString()+" - IMPOSSIBILE CREARE LA CONNESSIONE");
			Constants.log.error(e.toString());
		}
		//restituisce la connessione
		return conn;
	}

	/**
	 * Una volta effettuata l'operazione sul db con la connessione precedentemente presa,
	 * questo metodo rilascia la connessione utilizzata.
	 *
	 * @param conn Connessione utilizzata per l'operazione sul db
	 * @throws SQLException,Exception eccezione
	 */
	public static void releaseConnection(Connection conn){
		try{
			//chiudo la connessione
			conn.close();
		}catch (SQLException ex){
			Constants.log.error(ex.toString()+" - IMPOSSIBILE RILASCIARE LA CONNESSIONE!");
		}catch(Exception e){
			Constants.log.error(e.toString()+" - IMPOSSIBILE RILASCIARE LA CONNESSIONE!");
		}
	}
}