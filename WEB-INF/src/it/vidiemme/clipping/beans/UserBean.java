package it.vidiemme.clipping.beans;

import java.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;
import it.vidiemme.clipping.utils.*;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.database.ConnectionDB;

public class UserBean {
	private String id_user = "";
	private String username = "";
	private String password = "";
	private String id_role = "";
	private Vector areas = new Vector();
	private Vector countries = new Vector();

	/**
	 * Costruttore di default della classe
	 */
	public UserBean(){
	}

	/**
	 * Costruttore della classe che dati in ingresso idUser, idRole e userName in base al ruolo di un utente esegue una query di
	 * selezione per verificare a quali aree o paesi e' legato 
	 * 
	 * @param String idUser Stringa che identifica l'id dell'utente
	 * @param String idRole Stringa che identifica il ruolo dell'utente
	 * @param String UserName Stringa che identifica lo username dell'utente
	 */
	public UserBean(String idUser, String idRole, String userName){
		this.setId_user(idUser);
		this.setId_role(idRole);
		this.setUsername(userName);
		Hashtable param = new Hashtable();
		Vector result = new Vector();
		Query q = null;
		Vector countries = new Vector();
		Vector areas = new Vector();

		try {
			param.put("1_"+Constants.C_STRING,idUser);

			if(idRole.equals(Constants.idRoleEndUser)){
				q = new Query("SELECT_USER_COUNTRIES");
				result = q.execQuery(param);
				for (int i = 0; i < result.size(); i++) {
					countries.add(((Hashtable)result.elementAt(i)).get("countryid").toString());
				}
				if(result.size() > 0){
					areas.add(((Hashtable)result.firstElement()).get("areaid").toString());
				}
			}else if(idRole.equals(Constants.idRoleManager)){
				q = new Query("SELECT_USER_AREA");
				result = q.execQuery(param);
				for (int i = 0; i < result.size(); i++) {
					areas.add(((Hashtable)result.elementAt(i)).get("areaid").toString());
				}
			}
			this.setCountries(countries);
			this.setAreas(areas);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Costruttore della classe che dato in ingresso idUser seleziona le info relative allo user con quell'id, se lo trova ed e'
	 * un enduser seleziona area e countries a lui associati, se e' un manager seleziona le aree a lui associate
	 *
	 * @param String idUser Stringa che identifica l'id dell'utente
	 */
	public UserBean(String idUser){
		this.setId_user(idUser);
		Hashtable param = new Hashtable();
		Vector result = new Vector();
		Query q = null;
		Vector countries = new Vector();
		Vector areas = new Vector();

		try {
			param.put("1_"+Constants.C_STRING,this.getId_user());
			q = new Query("SELECT_USER");
			result = q.execQuery(param);
			if(result.size() > 0) {
				this.setId_role(((Hashtable)result.firstElement()).get("roleid").toString());
				this.setUsername(((Hashtable)result.firstElement()).get("user_name").toString());
			}
			if(this.getId_role().equals(Constants.idRoleEndUser)){
				q = new Query("SELECT_USER_COUNTRIES");
				result = q.execQuery(param);
				for (int i = 0; i < result.size(); i++) {
					countries.add(((Hashtable)result.elementAt(i)).get("countryid").toString());
				}
				if(result.size() > 0){
					areas.add(((Hashtable)result.firstElement()).get("areaid").toString());
				}
			}else if(this.getId_role().equals(Constants.idRoleManager)){
				q = new Query("SELECT_USER_AREA");
				result = q.execQuery(param);
				for (int i = 0; i < result.size(); i++) {
					areas.add(((Hashtable)result.elementAt(i)).get("areaid").toString());
				}
			}
			this.setCountries(countries);
			this.setAreas(areas);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}
	
	/**
	 * Metodo che esegue l'inserimento nel DB dello user
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		Connection conn = null;
		try {
			conn = ConnectionDB.getConnection();
			conn.setAutoCommit(false);
			param.put("1_"+Constants.C_INT,this.getId_role());
			param.put("2_"+Constants.C_STRING,this.getUsername());
			q = new Query("INSERT_USER");
			result = q.execUpdate(conn, param);
			
			if(result > 0) {
				this.setId_user(q.getLastInsertId());

				// Se Manager inserisce l'area
				if(this.getId_role().equals(Constants.idRoleManager)){
					for (int i = 0; (i < this.getAreas().size() && result > 0); i++){
						String area_id = areas.elementAt(i).toString();
						param = new Hashtable();
						param.put("1_"+Constants.C_INT,this.getId_user());
						param.put("2_"+Constants.C_INT,area_id);
						q = new Query("INSERT_USER_AREA");
						result = q.execUpdate(conn, param);
					}
				// Se end user inserisce tutti i country	
				}else if(this.getId_role().equals(Constants.idRoleEndUser)){
					for (int i = 0; (i < this.getCountries().size() && result > 0); i++){
						String country_id = countries.elementAt(i).toString();
						param = new Hashtable();
						param.put("1_"+Constants.C_INT,this.getId_user());
						param.put("2_"+Constants.C_INT,country_id);
						q = new Query("INSERT_USER_COUNTRY");
						result = q.execUpdate(conn, param);
					}
				}
			}
			if(result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		} finally {
			ConnectionDB.releaseConnection(conn);
		}
		return result;
	}
	
	/**
	 * Metodo che esegue l'aggiornamento dello user nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		Connection conn = null;
		try {
			conn = ConnectionDB.getConnection();
			conn.setAutoCommit(false);

			param.put("1_"+Constants.C_INT,this.getId_user());

			if(this.getId_role().equals(Constants.idRoleManager)) {
				// Cancella tutte le aree associate all'utente
				q = new Query("DELETE_USER_AREA");
				result = q.execUpdate(conn, param);
				// Re-inserisce le aree selezionate
				for (int i = 0; (i < this.getAreas().size() && result > 0); i++) {
					String area_id = this.getAreas().elementAt(i).toString();
					param.put("2_"+Constants.C_INT,area_id);
					q = new Query("INSERT_USER_AREA");
					result = q.execUpdate(conn, param);
				}
			} else if(this.getId_role().equals(Constants.idRoleEndUser)) {
				// Cancella tutti i country associati all'utente
				q = new Query("DELETE_USER_COUNTRY");
				result = q.execUpdate(conn, param);
				// Re-inserisce i country selezionati
				for (int i = 0; (i < this.getCountries().size() && result > 0); i++) {
					String country_id = this.getCountries().elementAt(i).toString();
					param.put("2_"+Constants.C_INT,country_id);
					q = new Query("INSERT_USER_COUNTRY");
					result = q.execUpdate(conn, param);
				}
			}

			if (result >= 0) {
				param = new Hashtable();
				param.put("1_"+Constants.C_INT,this.getId_role());
				param.put("2_"+Constants.C_STRING,this.getUsername());
				param.put("3_"+Constants.C_INT,this.getId_user());
				q = new Query("UPDATE_USER");
				result = q.execUpdate(conn, param);
			}
			
			if (result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
		
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		} finally {
			ConnectionDB.releaseConnection(conn);
		}
		return result;
	}
	
	/**
	 * Metodo che esegue la cancellazione dello user dal DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		Connection conn = null;
		try {
			conn = ConnectionDB.getConnection();
			conn.setAutoCommit(false);
			param.put("1_"+Constants.C_INT,this.getId_user());

			q = new Query("DELETE_USER_COUNTRY");
			result = q.execUpdate(conn, param);

			if (result >= 0) {
				q = new Query("DELETE_USER_AREA");
				result = q.execUpdate(conn, param);
			}

			if (result >= 0) {
				q = new Query("DELETE_USER");
				result = q.execUpdate(conn, param);
			}

			if (result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		} finally {
			ConnectionDB.releaseConnection(conn);
		}
		return result;
	}
	
	
	/**
	 * Metodo che controlla se l'utente esiste nel DB locale
	 *
	 * @param String username Stringa che rappresenta lo username cercato nel DB
	 * @return boolean userAleradyExists Variabile valorizzata a TRUE se l'utente esiste già nel DB locale
	 */
	public boolean userAlreadyExists(){
		boolean userAlreadyExists = false;
		Vector result = new Vector();
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,this.getUsername());
			if(this.getId_user().equals("")) {
				param.put("2_"+Constants.C_STRING,"");
			} else {
				param.put("2_"+Constants.C_INT,this.getId_user());
			}

			q = new Query("SELECT_USER_BY_USERNAME");
			result = q.execQuery(param);
			if(result.size() > 0)
				userAlreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return userAlreadyExists;
	}

	/**
	 * Metodo che controlla se l'utente esiste in LDAP
	 *
	 * @return boolean userLDAPexist Variabile valorizzata a TRUE se l'utente esiste in LDAP
	 */
	public boolean userLDAPexist(){
		boolean userLDAPexist = false;
		SelectUserLdap ldapUser = new SelectUserLdap(this.getUsername());
		try {
			if(ldapUser.user.length()>0){
				userLDAPexist = true;
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return userLDAPexist;
	}

	/**
	 * Metodo che ritorna l'id dello user
	 *
	 * @return String id_user Stringa che identifica l'id dello user
	 */
	public String getId_user() {
		return id_user;
	}

	/**
	 * Metodo che setta l'id dello user
	 *
	 * @param String id_user Stringa che identifica l'id dello user
	 */
	public void setId_user(String id_user) {
		this.id_user = id_user;
	}

	/**
	 * Metodo che ritorna la username dello user
	 *
	 * @return String username Stringa che identifica la username dello user
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Metodo che setta la username dello user
	 *
	 * @param String username Stringa che identifica la username dello user
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	
	/**
	 * Metodo che ritorna la password dello user
	 *
	 * @return String password Stringa che identifica la password dello user
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * Metodo che setta la password dello user
	 *
	 * @param String password Stringa che identifica la password dello user
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * Metodo che ritorna l'id_role dello user
	 *
	 * @return String id_role Stringa che identifica l'id del ruolo dello user
	 */
	public String getId_role() {
		return id_role;
	}

	/**
	 * Metodo che setta l'id_role dello user
	 *
	 * @param String id_role Stringa che identifica l'id del ruolo dello user
	 */
	public void setId_role(String id_role) {
		this.id_role = id_role;
	}

	/**
	 * Metodo che ritorna il vettore delle aree dello user
	 *
	 * @return Vector aree Vettore delle aree dello user
	 */
	public Vector getAreas() {
		return areas;
	}

	/**
	 * Metodo che setta il vettore delle aree dello user
	 *
	 * @param Vector aree Vettore delle aree dello user
	 */
	public void setAreas(Vector areas) {
		this.areas = areas;
	}

	/**
	 * Metodo che ritorna le countries dello user
	 *
	 * @return Vector countries Vettore che contiene tutte le countries associate all'utente
	 */
	public Vector getCountries() {
		return countries;
	}

	/**
	 * Metodo che setta le countries dello user
	 *
	 * @return Vector countries Vettore che contiene tutte le countries associate all'utente
	 */
	public void setCountries(Vector countries) {
		this.countries = countries;
	}
}
