package it.vidiemme.clipping.database;

import java.sql.*;
import java.util.*;
import it.vidiemme.clipping.utils.*;

/** 
 * Classe che si occupa di effettuare query sul database
 */
public class Query {
	String query = "";
	private String lastInsertId = "";
	Connection conn;

	/**
	 * Costruttore della classe con definizione della query da effettuare
	 *
	 * @param String queryName Nome della query SQL da effettuare
	 */
	public Query(String queryName){
		this.query = Constants.queries.getParameter(queryName);
	}

	/**
	 * Metodo che dato in ingesso la query da eseguire e la stringa da sostituire come #CONDITION#
	 * setta la variabile query della classe
	 *
	 * @param String query Stringa che identifica la query SQL da effettuare
	 * @param String replacement Stringa che identifica la stringa sostitutiva
	 */
	public Query(String query, String replacement){
		this.query = query;
		replaceQueryConditions(replacement);
	}

	/** 
	 * Esegue query di interrogazione (select).
	 * 
	 * @return Vector Vettore contenente Hashtable costituite da entry del tipo NOME CAMPO --> VALORE e rappresentano i risultati della query
	 */
	public Vector execQuery(){
		Hashtable param = new Hashtable();
		return execQuery(param);
	}

	/**
	 * Metodo che data una stringa esegue il replace delle condizioni dinamiche 
	 * all'interno della query
	 *
	 * @param String replacement Stringa che identifica la stringa sostitutiva
	 */
	public void replaceQueryConditions(String replacement){
		this.setQuery(this.getQuery().replaceAll("#CONDITION#", replacement));
	}

	/** 
	 * Esegue query di interrogazione (select).
	 * 
	 * @param Hashtable Contiene i parametri della query
	 * @return Vector Vettore contenente Hashtable costituite da entry del tipo NOME CAMPO --> VALORE e rappresentano i risultati della query
	 */
	public Vector execQuery(Hashtable param){
		Hashtable row = new Hashtable();
		Vector result = new Vector();
		PreparedStatement pstmt = null;
		try{
			conn = ConnectionDB.getConnection();
			pstmt = conn.prepareStatement(getQuery());
			pstmt = prepareStat(pstmt,param);
			ResultSet rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int numberOfColumns = rsmd.getColumnCount();
			int i;
			while(rs.next()){
				i = 1;
				row = new Hashtable();
				while (i <= numberOfColumns){
					String column_name = rs.getMetaData().getColumnName(i);
					Object value = rs.getString(i);
					if(value == null) 
						value = "";
					row.put(column_name.toLowerCase(),value);   
					i++;
				}
				result.addElement(row);
			}
		}catch(SQLException e){
			Constants.log.error("IMPOSSIBILE ESEGUIRE LA QUERY "+getQuery()+" "+e.toString());
		}finally{
			try {
				pstmt.close();
				ConnectionDB.releaseConnection(conn);
			}catch (Exception ex) {
			}
		}
		return result;
	}

	/** 
	 * Metodo che esegue inserimenti, aggiornamenti e cancellazioni
	 *
	 * @param Hashtable Contiene i parametri della query
	 * @return result risultato della query eseguita
	 * @throws SQLException		
	 */
	public int execUpdate(Hashtable param){
		
		int result = 0;
		PreparedStatement pstmt = null;
		try{
			conn=ConnectionDB.getConnection();
			pstmt = conn.prepareStatement(getQuery());
			pstmt = prepareStat(pstmt,param);
			result = pstmt.executeUpdate();
			ResultSet lastInsertIdRs = pstmt.getGeneratedKeys();
			while(lastInsertIdRs.next()) {
				lastInsertId = lastInsertIdRs.getString(1);
			}
		}catch (SQLException ex) {
			Constants.log.error("IMPOSSIBILE ESEGUIRE LA QUERY "+getQuery()+" "+ex.toString());
			result=-1;
		}finally{
			try {
				pstmt.close();
				ConnectionDB.releaseConnection(conn);
			}catch (Exception ex) {
			}
		}
		return result;
	}

	/** 
	 * Metodo che esegue inserimenti, aggiornamenti e cancellazioni che potrebbero coinvolgere più tabelle quindi l'esecuzione di
	 * più query contemporaneamente, uso una nuova connessione per fare in modo che l'esito negativo di una delle query blocchi 
	 * il tutto evitando il commit di transazioni in parte errate  
	 *  
	 * @param Hashtable Contiene i parametri della query
	 * @param Connection conn
	 * @return result risultato della query eseguita
	 * @throws SQLException		
	 **/
	public int execUpdate(Connection conn, Hashtable param){
		
		int result = 0;
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(getQuery());
			pstmt = prepareStat(pstmt,param);
			result = pstmt.executeUpdate();
			ResultSet lastInsertIdRs = pstmt.getGeneratedKeys();
			while(lastInsertIdRs.next()) {
				lastInsertId = lastInsertIdRs.getString(1);
			}
		}catch (SQLException ex) {
			Constants.log.error("IMPOSSIBILE ESEGUIRE LA QUERY "+getQuery()+" "+ex.toString());
			result = -1;
		}finally{
			try {
				pstmt.close();
			}catch (Exception ex) {
			}
		}

		return result;
	}

	
	/** 
	 * Setta la query da eseguire (SQL).
	 * 
	 * @param query Query SQL da eseguire
	 */
	public void setQuery (String query){
		this.query = query;
	}	

	/** 
	 * Ritorna la query SQL da eseguire.
	 * 
	 * @return String Query SQL da eseguire.
	 */
	public String getQuery (){
		return query;
	}	

	/**
	 * Setta i parametri per la query SQL da eseguire.
	 *
	 * @return String Query SQL da eseguire.
	 */
	private PreparedStatement prepareStat(PreparedStatement pstmt, Hashtable param) throws SQLException {
		String valore = "";
		String tipo = "";
		int posizione;
		try {
			Enumeration enumeration = param.keys();
			while (enumeration.hasMoreElements()){
				String key = (String) enumeration.nextElement();
				posizione = Integer.parseInt(key.substring(0,key.indexOf("_")));
				tipo = key.substring(key.indexOf("_")+1);
				valore = (String)param.get(key);

				if (tipo.equalsIgnoreCase(Constants.C_INT)){
					pstmt.setInt(posizione,Integer.parseInt(valore));
				}else if (tipo.equalsIgnoreCase(Constants.C_STRING)){
					pstmt.setString(posizione,valore);
				}else if (tipo.equalsIgnoreCase(Constants.C_DATE)){
					pstmt.setDate(posizione,java.sql.Date.valueOf(valore));
				}else if (tipo.equalsIgnoreCase(Constants.C_NULL)){
					pstmt.setString(posizione,null);
				}else if (tipo.equalsIgnoreCase(Constants.C_DOUBLE)){
					pstmt.setDouble(posizione,Double.parseDouble(valore));
				}
			}
		}catch (Exception ex) {
			Constants.log.error(ex.toString());
		}
		return pstmt;
	}

	/** 
	 * Ritorna l'ultimo id autoincrement generato
	 * 
	 * @return String lastInsertId Ultimo id autoincrement generato
	 */
	public String getLastInsertId() {
		return lastInsertId;
	}

	/** 
	 * Setta il valore dell'ultimo id autoincrement generato
	 * 
	 * @param String lastInsertId Ultimo id autoincrement generato
	 */
	public void setLastInsertId(String lastInsertId) {
		this.lastInsertId = lastInsertId;
	}
}