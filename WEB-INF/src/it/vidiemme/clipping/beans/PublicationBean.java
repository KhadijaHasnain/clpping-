package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.utils.Utils;

/**
 * Bean che rappresenta la publication
 */
public class PublicationBean {
	private String publication_id = "";
	private String name = "";
	private String last_rated = "";
	private String description = "";
	private String status = "";
	private String audience_id = "";
	private String level_id = "";
	private String size_id = "";
	private String frequency_id = "";
	private String medium_id = "";
	private String area_id = "";
	private String country_id = "";

	/**
	 * Costruttore di default della classe
	 */
	public PublicationBean() {
	}

	/**
	 * Costruttore che riceve in ingresso l'id della publication 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String publication_id Stringa che identifica l'id della publication
	 */
	public PublicationBean(String publication_id) {
		this.setPublication_id(publication_id);
		Query q = null;
		Vector publications = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getPublication_id());
			q = new Query("SELECT_PUBLICATION_DETAILS");
			publications = q.execQuery(param);

			if(publications.size() > 0){
				this.setName(((Hashtable)publications.firstElement()).get("name").toString());
				this.setLast_rated(Utils.formatDateForView(((Hashtable)publications.firstElement()).get("last_rated").toString()));
				this.setDescription(((Hashtable)publications.firstElement()).get("description").toString());
				this.setStatus(((Hashtable)publications.firstElement()).get("status").toString());
				this.setAudience_id(((Hashtable)publications.firstElement()).get("audienceid").toString());
				this.setLevel_id(((Hashtable)publications.firstElement()).get("levelid").toString());
				this.setSize_id(((Hashtable)publications.firstElement()).get("sizeid").toString());
				this.setFrequency_id(((Hashtable)publications.firstElement()).get("frequencyid").toString());
				this.setMedium_id(((Hashtable)publications.firstElement()).get("mediumid").toString());
				this.setArea_id(((Hashtable)publications.firstElement()).get("areaid").toString());
				this.setCountry_id(((Hashtable)publications.firstElement()).get("countryid").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB della publication
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,getName());
			param.put("2_"+Constants.C_STRING,Utils.formatDateForDB(getLast_rated()));
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getStatus());
			param.put("5_"+Constants.C_INT,getAudience_id());
			param.put("6_"+Constants.C_INT,getLevel_id());
			param.put("7_"+Constants.C_INT,getSize_id());
			param.put("8_"+Constants.C_INT,getFrequency_id());
			param.put("9_"+Constants.C_INT,getMedium_id());
			param.put("10_"+Constants.C_INT,getArea_id());
			if(getCountry_id().equals("")){
				param.put("11_"+Constants.C_NULL,"NULL");
			}else{
				param.put("11_"+Constants.C_INT,getCountry_id());
			}

			q = new Query("INSERT_PUBLICATION");
			result = q.execUpdate(param);
			if(result > 0)  {
				this.setPublication_id(q.getLastInsertId());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'aggiornamento della publication nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,getName());
			param.put("2_"+Constants.C_STRING,Utils.formatDateForDB(getLast_rated()));
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getStatus());
			param.put("5_"+Constants.C_INT,getAudience_id());
			param.put("6_"+Constants.C_INT,getLevel_id());
			param.put("7_"+Constants.C_INT,getSize_id());
			param.put("8_"+Constants.C_INT,getFrequency_id());
			param.put("9_"+Constants.C_INT,getMedium_id());
			param.put("10_"+Constants.C_INT,getArea_id());
			if(getCountry_id().equals("")){
				param.put("11_"+Constants.C_NULL,"NULL");
			}else{
				param.put("11_"+Constants.C_INT,getCountry_id());
			}

			param.put("12_"+Constants.C_INT,getPublication_id());

			q = new Query("UPDATE_PUBLICATION");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione della publication nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getPublication_id());
			q = new Query("DELETE_PUBLICATION");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se la publication in esame ha dei clipping associati
	 * 
	 * @return boolean hasAssociatedClippings Variabile booleana che indica se la publication ha clippings associati
	 */
	public boolean hasAssociatedClippings(){
		boolean hasAssociatedClippings = false;
		Query q = null;
		Vector associatedClippings = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getPublication_id());
			q = new Query("SELECT_PUBLICATION_CLIPPINGS");
			associatedClippings = q.execQuery(param);
			if(associatedClippings.size() > 0)
				hasAssociatedClippings = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedClippings;
	}

	/**
	 * Metodo che controlla se la publication in esame ha dei contacts associati
	 *
	 * @return boolean hasAssociatedContacts Variabile booleana che indica se la publication ha contacts associati
	 */
	public boolean hasAssociatedContacts(){
		boolean hasAssociatedContacts = false;
		Query q = null;
		Vector associatedContacts = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getPublication_id());
			q = new Query("SELECT_PUBLICATION_CLIPPINGS");
			associatedContacts = q.execQuery(param);
			if(associatedContacts.size() > 0)
				hasAssociatedContacts = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedContacts;
	}

	/**
	 * Metodo che esegue l'archiviazione delle publication nel DB
	 * settando lo stato ad Archived
	 *
	 * @param String[] publicationsToArchive Array di stringhe che contiene tutte le publications da settare come archived
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int archive(String[] publicationsToArchive){
		int result = 0;
		Query q = null;
		String publicationsList = "";
		Hashtable param = new Hashtable();
		try {
			if(publicationsToArchive.length > 0){
				for (int i = 0; i < publicationsToArchive.length; i++) {
					if(i < (publicationsToArchive.length - 1)){
						publicationsList += publicationsToArchive[i] + ",";
					}else{
						publicationsList += publicationsToArchive[i];
					}
				}
				param.put("1_"+Constants.C_INT,Constants.archivedId+"");
				q = new Query("UPDATE_PUBLICATION_STATUS");
				q.replaceQueryConditions(publicationsList);
				result = q.execUpdate(param);
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se la publication in esame e' gia' presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se la publication e' gia' presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsPublication = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,this.getName());
			param.put("2_"+Constants.C_INT,this.getArea_id());
			param.put("3_"+Constants.C_INT,Utils.formatDateForDB(this.getLast_rated()));
			if(this.getPublication_id().equals("")){
				param.put("4_"+Constants.C_STRING,"");
			}else{
				param.put("4_"+Constants.C_INT,this.getPublication_id());
			}
			q = new Query("SELECT_PUBLICATION_EXISTS");
			alreadyExistsPublication = q.execQuery(param);
			if(alreadyExistsPublication.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	/**
	 * Metodo che ritorna l'id della publication
	 * 
	 * @return String publication_id Stringa che identifica l'id della publication
	 */
	public String getPublication_id() {
		return publication_id;
	}

	/**
	 * Metodo che setta l'id della publication
	 * 
	 * @param String publication_id Stringa che identifica l'id della publication
	 */
	public void setPublication_id(String publication_id) {
		this.publication_id = publication_id;
	}

	/**
	 * Metodo che ritorna il name della publication
	 * 
	 * @return String name Stringa che identifica il name della publication
	 */
	public String getName() {
		return name;
	}

	/**
	 * Metodo che setta il name della publication
	 *
	 * @param String name Stringa che identifica il name della publication
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Metodo che ritorna la last rated della publication
	 *
	 * @return String last_rated Stringa che identifica la last rated della publication
	 */
	public String getLast_rated() {
		return last_rated;
	}

	/**
	 * Metodo che setta la last rated della publication
	 *
	 * @return String last_rated Stringa che identifica la last rated della publication
	 */
	public void setLast_rated(String last_rated) {
		this.last_rated = last_rated;
	}

	/**
	 * Metodo che ritorna la description della publication
	 * 
	 * @return String description Stringa che identifica la description della publication
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Metodo che setta la description della publication
	 * 
	 * @param String description Stringa che identifica la description della publication
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Metodo che ritorna o status della publication
	 * 
	 * @return String status Stringa che identifica lo status della publication
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Metodo che setta lo status della publication
	 * 
	 * @param String status Stringa che identifica lo status della publication
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * Metodo che ritorna l'audience_id della publication
	 * 
	 * @return String audience_id Stringa che identifica l'audience_id della publication
	 */
	public String getAudience_id() {
		return audience_id;
	}

	/**
	 * Metodo che setta l'audience_id della publication
	 * 
	 * @param String audience_id Stringa che identifica l'audience_id della publication
	 */
	public void setAudience_id(String audience_id) {
		this.audience_id = audience_id;
	}

	/**
	 * Metodo che ritorna il level_id della publication
	 * 
	 * @return String level_id Stringa che identifica il level_id della publication
	 */
	public String getLevel_id() {
		return level_id;
	}

	/**
	 * Metodo che setta il level_id della publication
	 * 
	 * @param String level_id Stringa che identifica il level_id della publication
	 */
	public void setLevel_id(String level_id) {
		this.level_id = level_id;
	}

	/**
	 * Metodo che ritorna il size_id della publication
	 * 
	 * @return String size_id Stringa che identifica il size_id della publication
	 */
	public String getSize_id() {
		return size_id;
	}

	/**
	 * Metodo che setta il size_id della publication
	 * 
	 * @param String size_id Stringa che identifica il size_id della publication
	 */
	public void setSize_id(String size_id) {
		this.size_id = size_id;
	}

	/**
	 * Metodo che ritorna la frequency_id della publication
	 * 
	 * @return String frequency_id Stringa che identifica la frequency_id della publication
	 */
	public String getFrequency_id() {
		return frequency_id;
	}

	/**
	 * Metodo che setta la frequency_id della publication
	 * 
	 * @param String frequency_id Stringa che identifica la frequency_id della publication
	 */
	public void setFrequency_id(String frequency_id) {
		this.frequency_id = frequency_id;
	}

	/**
	 * Metodo che ritorna il medium_id della publication
	 * 
	 * @return String medium_id Stringa che identifica il medium_id della publication
	 */
	public String getMedium_id() {
		return medium_id;
	}

	/**
	 * Metodo che setta il medium_id della publication
	 * 
	 * @param String medium_id Stringa che identifica il medium_id della publication
	 */
	public void setMedium_id(String medium_id) {
		this.medium_id = medium_id;
	}

	/**
	 * Metodo che ritorna l'area_id della publication
	 * 
	 * @return String area_id Stringa che identifica l'area_id della publication
	 */
	public String getArea_id() {
		return area_id;
	}

	/**
	 * Metodo che setta l'area_id della publication
	 * 
	 * @param String area_id Stringa che identifica l'area_id della publication
	 */
	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}

	/**
	 * Metodo che ritorna il country_id della publication
	 * 
	 * @return String country_id Stringa che identifica il country_id della publication
	 */
	public String getCountry_id() {
		return country_id;
	}

	/**
	 * Metodo che setta il country_id della publication
	 * 
	 * @param String country_id Stringa che identifica il country_id della publication
	 */
	public void setCountry_id(String country_id) {
		this.country_id = country_id;
	}
}