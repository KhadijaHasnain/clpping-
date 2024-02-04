package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.Constants;

/**
 * Bean che rappresenta il country
 */
public class CountryBean {
	private String country_id = "";
	private String country = "";
	private String area_id = "";
	private String description = "";

	/**
	 * Costruttore di default della classe
	 */
	public CountryBean() {
	}

	/**
	 * Costruttore che riceve in ingresso l'id del country 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String country_id Stringa che identifica l'id del country
	 */
	public CountryBean(String country_id) {
		this.setCountry_id(country_id);
		Query q = null;
		Vector countries = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getCountry_id());
			q = new Query("SELECT_COUNTRY_DETAILS");
			countries = q.execQuery(param);

			if(countries.size() > 0){
				this.setCountry(((Hashtable)countries.firstElement()).get("country").toString());
				this.setArea_id(((Hashtable)countries.firstElement()).get("areaid").toString());
				this.setDescription(((Hashtable)countries.firstElement()).get("description").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB del country
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,getCountry());
			param.put("2_"+Constants.C_INT,getArea_id());
			param.put("3_"+Constants.C_STRING,getDescription());

			q = new Query("INSERT_COUNTRY");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'aggiornamento del country nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,getCountry());
			param.put("2_"+Constants.C_INT,getArea_id());
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getCountry_id());

			q = new Query("UPDATE_COUNTRY");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione del country nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getCountry_id());
			q = new Query("DELETE_COUNTRY");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}
	
	/**
	 * Metodo che controlla se il country in esame ha users associati
	 *
	 * @return boolean hasAssociatedUsers Variabile booleana che indica se il country ha users associati
	 */
	public boolean hasAssociatedUsers(){
		boolean hasAssociatedUsers = false;
		Query q = null;
		Vector associatedUsers = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getCountry_id());
			q = new Query("SELECT_COUNTRY_USERS");
			associatedUsers = q.execQuery(param);
			if(associatedUsers.size() > 0)
				hasAssociatedUsers = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedUsers;
	}

	/**
	 * Metodo che controlla se il country in esame ha delle publications associate
	 *
	 * @return boolean hasAssociatedPublications Variabile booleana che indica se il country ha publications associate
	 */
	public boolean hasAssociatedPublications(){
		boolean hasAssociatedPublications = false;
		Query q = null;
		Vector associatedPublications = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getCountry_id());
			q = new Query("SELECT_COUNTRY_PUBLICATIONS");
			associatedPublications = q.execQuery(param);
			if(associatedPublications.size() > 0)
				hasAssociatedPublications = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedPublications;
	}
	
	/**
	 * Metodo che controlla se il country in esame è già presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se il country è già presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsCountry = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,getCountry());
			if(getCountry_id().equals("")){
				param.put("2_"+Constants.C_STRING,"");
			}else{
				param.put("2_"+Constants.C_INT,getCountry_id());
			}
			param.put("3_"+Constants.C_INT,getArea_id());
			q = new Query("SELECT_COUNTRY_EXISTS");
			alreadyExistsCountry = q.execQuery(param);
			if(alreadyExistsCountry.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}
	
	/**
	 * Metodo che ritorna il country_id
	 *
	 * @return String country_id Stringa che identifica l'id del country
	 */
	public String getCountry_id() {
		return country_id;
	}
	
	/**
	 * Metodo che setta il country_id
	 *
	 * @param String country_id Stringa che identifica l'id del country
	 */
	public void setCountry_id(String country_id) {
		this.country_id = country_id;
	}
	
	/**
	 * Metodo che ritorna il country
	 *
	 * @return String country Stringa che identifica il nome del country
	 */
	public String getCountry() {
		return country;
	}
	
	/**
	 * Metodo che setta il country
	 *
	 * @return String country Stringa che identifica il nome del country
	 */
	public void setCountry(String country) {
		this.country = country;
	}
	
	/**
	 * Metodo che ritorna l'area_id
	 *
	 * @return String area_id Stringa che identifica l'id area
	 */
	public String getArea_id() {
		return area_id;
	}
	
	/**
	 * Metodo che setta l'area_id
	 *
	 * @param String area_id Stringa che identifica l'id area
	 */
	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}
	
	/**
	 * Metodo che ritorna la description del country
	 *
	 * @return String description Stringa che identifica la description del country
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * Metodo che setta la description del country
	 *
	 * @return String description Stringa che identifica la description del country
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
}
