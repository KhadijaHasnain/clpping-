package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.*;

/**
 * Bean che rappresenta il contact
 */
public class ContactBean {
	private String contact_id = "";
	private String publication_id = "";
	private String general = "";
	private String firstname = "";
	private String lastname = "";
	private String specifics = "";
	private String address = "";
	private String city = "";
	private String state = "";
	private String postalcode = "";
	private String country = "";
	private String workphone = "";
	private String faxnumber = "";
	private String emailname = "";
	private String contacttype = "";
	private String lastmeetingdate = "";
	private String note = "";
	private String contactbyphone = "";
	private	String contactbyemail = "";
	private String geographic_region = "";

	/**
	 * Costruttore di default della classe
	 */
	public ContactBean() {
	}

	/**
	 * Costruttore che riceve in ingresso l'id del contact 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String contact_id Stringa che identifica l'id del contact
	 */
	public ContactBean(String contact_id) {
		this.setContact_id(contact_id);
		Query q = null;
		Vector contacts = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getContact_id());
			q = new Query("SELECT_CONTACT_DETAILS");
			contacts = q.execQuery(param);

			if(contacts.size() > 0){
				this.setPublication_id(((Hashtable)contacts.firstElement()).get("publicationid").toString());
				this.setGeneral(((Hashtable)contacts.firstElement()).get("general").toString());
				this.setFirstname(((Hashtable)contacts.firstElement()).get("firstname").toString());
				this.setLastname(((Hashtable)contacts.firstElement()).get("lastname").toString());
				this.setContacttype(((Hashtable)contacts.firstElement()).get("contacttype").toString());
				this.setLastmeetingdate(Utils.formatDateForView(((Hashtable)contacts.firstElement()).get("lastmeetingdate").toString()));
				this.setSpecifics(((Hashtable)contacts.firstElement()).get("specifics").toString());
				this.setAddress(((Hashtable)contacts.firstElement()).get("address").toString());
				this.setCity(((Hashtable)contacts.firstElement()).get("city").toString());
				this.setState(((Hashtable)contacts.firstElement()).get("state").toString());
				this.setPostalcode(((Hashtable)contacts.firstElement()).get("postalcode").toString());
				this.setCountry(((Hashtable)contacts.firstElement()).get("country").toString());
				this.setWorkphone(((Hashtable)contacts.firstElement()).get("workphone").toString());
				this.setFaxnumber(((Hashtable)contacts.firstElement()).get("faxnumber").toString());
				this.setEmailname(((Hashtable)contacts.firstElement()).get("emailname").toString());
				this.setNote(((Hashtable)contacts.firstElement()).get("note").toString());
				this.setContactbyphone(((Hashtable)contacts.firstElement()).get("contactbyphone").toString());
				this.setContactbyemail(((Hashtable)contacts.firstElement()).get("contactbyemail").toString());
				this.setGeographic_region(((Hashtable)contacts.firstElement()).get("geographic_region").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB del contact
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			param.put("2_"+Constants.C_STRING,this.getGeneral());
			param.put("3_"+Constants.C_STRING,this.getFirstname());
			param.put("4_"+Constants.C_STRING,this.getLastname());
			param.put("5_"+Constants.C_STRING,this.getSpecifics());
			param.put("6_"+Constants.C_STRING,this.getAddress());
			param.put("7_"+Constants.C_STRING,this.getCity());
			param.put("8_"+Constants.C_STRING,this.getState());
			param.put("9_"+Constants.C_STRING,this.getPostalcode());
			param.put("10_"+Constants.C_STRING,this.getCountry());
			param.put("11_"+Constants.C_STRING,this.getWorkphone());
			param.put("12_"+Constants.C_STRING,this.getFaxnumber());
			param.put("13_"+Constants.C_STRING,this.getEmailname());
			param.put("14_"+Constants.C_STRING,this.getContacttype());
			if(this.getLastmeetingdate().equals("")){
				param.put("15_"+Constants.C_NULL,"NULL");
			}else{
				param.put("15_"+Constants.C_STRING,Utils.formatDateForDB(this.getLastmeetingdate()));
			}
			param.put("16_"+Constants.C_STRING,this.getNote());
			param.put("17_"+Constants.C_INT,this.getContactbyphone());
			param.put("18_"+Constants.C_INT,this.getContactbyemail());
			param.put("19_"+Constants.C_STRING,this.getGeographic_region());

			q = new Query("INSERT_CONTACT");
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
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			param.put("2_"+Constants.C_STRING,this.getGeneral());
			param.put("3_"+Constants.C_STRING,this.getFirstname());
			param.put("4_"+Constants.C_STRING,this.getLastname());
			param.put("5_"+Constants.C_STRING,this.getSpecifics());
			param.put("6_"+Constants.C_STRING,this.getAddress());
			param.put("7_"+Constants.C_STRING,this.getCity());
			param.put("8_"+Constants.C_STRING,this.getState());
			param.put("9_"+Constants.C_STRING,this.getPostalcode());
			param.put("10_"+Constants.C_STRING,this.getCountry());
			param.put("11_"+Constants.C_STRING,this.getWorkphone());
			param.put("12_"+Constants.C_STRING,this.getFaxnumber());
			param.put("13_"+Constants.C_STRING,this.getEmailname());
			param.put("14_"+Constants.C_STRING,this.getContacttype());
			if(this.getLastmeetingdate().equals("")){
				param.put("15_"+Constants.C_NULL,"NULL");
			}else{
				param.put("15_"+Constants.C_STRING,Utils.formatDateForDB(this.getLastmeetingdate()));
			}
			param.put("16_"+Constants.C_STRING,this.getNote());
			param.put("17_"+Constants.C_INT,this.getContactbyphone());
			param.put("18_"+Constants.C_INT,this.getContactbyemail());
			param.put("19_"+Constants.C_STRING,this.getGeographic_region());
			param.put("20_"+Constants.C_INT,this.getContact_id());

			q = new Query("UPDATE_CONTACT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione del contact dal DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getContact_id());
			q = new Query("DELETE_CONTACT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se il contact in esame e' già presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se il contact e' già presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsContact = new Vector();
		Hashtable param = new Hashtable();
		try {	
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			param.put("2_"+Constants.C_STRING,this.getLastname());
			if(this.getContact_id().equals("")){
				param.put("3_"+Constants.C_STRING,"");
			}else{
				param.put("3_"+Constants.C_INT,this.getContact_id());
			}
			q = new Query("SELECT_CONTACT_EXISTS");
			alreadyExistsContact = q.execQuery(param);
			if(alreadyExistsContact.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	/**
	 * Metodo che ritorna il contact_id
	 *
	 * @return String contact_id Stringa che identifica l'id del contact
	 */
	public String getContact_id() {
		return contact_id;
	}
	
	/**
	 * Metodo che setta il contact_id
	 *
	 * @param String contact_id Stringa che identifica l'id del contact
	 */
	public void setContact_id(String contact_id) {
		this.contact_id = contact_id;
	}
	
	/**
	 * Metodo che ritorna il publication_id del contact
	 *
	 * @return String publication_id Stringa che identifica il publication_id del contact
	 */
	public String getPublication_id() {
		return publication_id;
	}
	
	/**
	 * Metodo che setta il publication_id del contact
	 *
	 * @param String publication_id Stringa che identifica il publication_id del contact
	 */
	public void setPublication_id(String publication_id) {
		this.publication_id = publication_id;
	}
	
	/**
	 * Metodo che ritorna il general del contact
	 *
	 * @return String general Stringa che identifica il general del contact
	 */
	public String getGeneral() {
		return general;
	}
	
	/**
	 * Metodo che setta il general del contact
	 *
	 * @param String general Stringa che identifica il general del contact
	 */
	public void setGeneral(String general) {
		this.general = general;
	}
	
	/**
	 * Metodo che ritorna il firstname del contact
	 *
	 * @return String firstname Stringa che identifica il firstname del contact
	 */
	public String getFirstname() {
		return firstname;
	}
	
	/**
	 * Metodo che setta il firstname del contact
	 *
	 * @param String firstname Stringa che identifica il firstname del contact
	 */
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	
	/**
	 * Metodo che ritorna il lastname del contact
	 *
	 * @return String general Stringa che identifica il general del contact
	 */
	public String getLastname() {
		return lastname;
	}
	
	/**
	 * Metodo che setta il lastname del contact
	 *
	 * @param String lastname Stringa che identifica il lastname del contact
	 */
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	/**
	 * Metodo che ritorna le specifics del contact
	 *
	 * @return String specifics Stringa che identifica le specifiche del contact
	 */
	public String getSpecifics() {
		return specifics;
	}
	
	/**
	 * Metodo che setta le specifics del contact
	 *
	 * @param String specifics Stringa che identifica le specifiche del contact
	 */
	public void setSpecifics(String specifics) {
		this.specifics = specifics;
	}
	
	/**
	 * Metodo che ritorna l'address del contact
	 *
	 * @return String address Stringa che identifica l'address del contact
	 */
	public String getAddress() {
		return address;
	}
	
	/**
	 * Metodo che setta l'address del contact
	 *
	 * @param String address Stringa che identifica l'address del contact
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * Metodo che ritorna la city del contact
	 *
	 * @return String city Stringa che identifica la city del contact
	 */
	public String getCity() {
		return city;
	}
	
	/**
	 * Metodo che setta la city del contact
	 *
	 * @param String city Stringa che identifica la city del contact
	 */
	public void setCity(String city) {
		this.city = city;
	}
	
	/**
	 * Metodo che ritorna lo state del contact
	 *
	 * @return String state Stringa che identifica lo state del contact
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * Metodo che setta lo state del contact
	 *
	 * @param String state Stringa che identifica lo state del contact
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * Metodo che ritorna il postalcode del contact
	 *
	 * @return String postalcode Stringa che identifica il postalcode del contact
	 */
	public String getPostalcode() {
		return postalcode;
	}
	
	/**
	 * Metodo che setta il postalcode del contact
	 *
	 * @param String postalcode Stringa che identifica il postalcode del contact
	 */
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	
	/**
	 * Metodo che ritorna il workphone del contact
	 *
	 * @return String workphone Stringa che identifica il workphone del contact
	 */
	public String getWorkphone() {
		return workphone;
	}
	
	/**
	 * Metodo che setta il workphone del contact
	 *
	 * @param String workphone Stringa che identifica il workphone del contact
	 */
	public void setWorkphone(String workphone) {
		this.workphone = workphone;
	}
	
	/**
	 * Metodo che ritorna il faxnumber del contact
	 *
	 * @return String faxnumber Stringa che identifica il faxnumber del contact
	 */
	public String getFaxnumber() {
		return faxnumber;
	}
	
	/**
	 * Metodo che setta il faxnumber del contact
	 *
	 * @param String faxnumber Stringa che identifica il faxnumber del contact
	 */
	public void setFaxnumber(String faxnumber) {
		this.faxnumber = faxnumber;
	}
	
	/**
	 * Metodo che ritorna l'email del contact
	 *
	 * @return String emailname Stringa che identifica l'email del contact
	 */
	public String getEmailname() {
		return emailname;
	}
	
	/**
	 * Metodo che setta l'email del contact
	 *
	 * @return String emailname Stringa che identifica l'email del contact
	 */
	public void setEmailname(String emailname) {
		this.emailname = emailname;
	}
	
	/**
	 * Metodo che ritorna il type del contact
	 *
	 * @return String contacttype Stringa che identifica il type del contact
	 */
	public String getContacttype() {
		return contacttype;
	}
	
	/**
	 * Metodo che setta il type del contact
	 *
	 * @param String contacttype Stringa che identifica il type del contact
	 */
	public void setContacttype(String contacttype) {
		this.contacttype = contacttype;
	}
	
	/**
	 * Metodo che ritorna il lastmeetingdate del contact
	 *
	 * @return String lastmeetingdate Stringa che identifica il lastmetingdate del contact
	 */
	public String getLastmeetingdate() {
		return lastmeetingdate;
	}
	
	/**
	 * Metodo che setta il lastmeetingdate del contact
	 *
	 * @param String lastmeetingdate Stringa che identifica il lastmetingdate del contact
	 */
	public void setLastmeetingdate(String lastmeetingdate) {
		this.lastmeetingdate = lastmeetingdate;
	}
	
	/**
	 * Metodo che ritorna le note del contact
	 *
	 * @return String note Stringa che identifica le note del contact
	 */
	public String getNote() {
		return note;
	}
	
	/**
	 * Metodo che setta le note del contact
	 *
	 * @param String note Stringa che identifica le note del contact
	 */
	public void setNote(String note) {
		this.note = note;
	}
	
	/**
	 * Metodo che ritorna la geographic_region del contact
	 *
	 * @return String geographic_region Stringa che identifica la geographic_region del contact
	 */
	public String getGeographic_region() {
		return geographic_region;
	}
	
	/**
	 * Metodo che setta la geographic_region del contact
	 *
	 * @param String geographic_region Stringa che identifica la geographic_region del contact
	 */
	public void setGeographic_region(String geographic_region) {
		this.geographic_region = geographic_region;
	}
	
	/**
	 * Metodo che ritorna il country del contact
	 *
	 * @return String country Stringa che identifica il country del contact
	 */
	public String getCountry() {
		return country;
	}
	
	/**
	 * Metodo che setta il country del contact
	 *
	 * @param String country Stringa che identifica il country del contact
	 */
	public void setCountry(String country) {
		this.country = country;
	}
	
	/**
	 * Metodo che ritorna il contactbyphone del contact
	 *
	 * @return String contactbyphone Stringa che identifica il contactbyphone del contact
	 */
	public String getContactbyphone() {
		return contactbyphone;
	}
	
	/**
	 * Metodo che setta il contactbyphone del contact
	 *
	 * @param String contactbyphone Stringa che identifica il contactbyphone del contact
	 */
	public void setContactbyphone(String contactbyphone) {
		this.contactbyphone = contactbyphone;
	}
	
	/**
	 * Metodo che ritorna il contactbyemail del contact
	 *
	 * @return String contactbyemail Stringa che identifica il contactbyemail del contact
	 */
	public String getContactbyemail() {
		return contactbyemail;
	}
	
	/**
	 * Metodo che setta il contactbyemail del contact
	 *
	 * @param String contactbyemail Stringa che identifica il contactbyemail del contact
	 */
	public void setContactbyemail(String contactbyemail) {
		this.contactbyemail = contactbyemail;
	}
	
}
