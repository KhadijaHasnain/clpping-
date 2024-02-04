package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.Constants;
import it.vidiemme.clipping.utils.Utils;

/**
 * Bean che rappresenta l'event
 */
public class EventBean {
	private String event_id = "";
	private String area_id = "";
	private String eventtitle = "";
	private String eventtype_id = "";
	private String eventdate = "";
	private String prref = "";
	private String productorsubject = "";

	/**
	 * Costruttore di default della classe
	 */
	public EventBean() {
	}
	
	/**
	 * Costruttore che riceve in ingresso l'id della publication 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String publication_id Stringa che identifica l'id della publication
	 */
	public EventBean(String event_id) {
		this.setEvent_id(event_id);
		Query q = null;
		Vector events = new Vector();
		Hashtable param = new Hashtable();
		try {
			if(!this.getEvent_id().equals("")){
				param.put("1_"+Constants.C_INT,this.getEvent_id());
				q = new Query("SELECT_EVENT_DETAILS");
				events = q.execQuery(param);

				if(events.size() > 0){
					this.setArea_id(((Hashtable)events.firstElement()).get("areaid").toString());
					this.setEventtitle(((Hashtable)events.firstElement()).get("eventtitle").toString());
					this.setEventtype_id(((Hashtable)events.firstElement()).get("eventtypeid").toString());
					this.setEventdate(Utils.formatDateForView(((Hashtable)events.firstElement()).get("eventdate").toString()));
					this.setPrref(((Hashtable)events.firstElement()).get("prref").toString());
					this.setProductorsubject(((Hashtable)events.firstElement()).get("productorsubject").toString());
				}
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB dell'event
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getArea_id());
			param.put("2_"+Constants.C_INT,this.getEventtype_id());
			param.put("3_"+Constants.C_STRING,this.getEventtitle());
			param.put("4_"+Constants.C_STRING,Utils.formatDateForDB(this.getEventdate()));
			param.put("5_"+Constants.C_STRING,this.getPrref());
			param.put("6_"+Constants.C_STRING,this.getProductorsubject());
			
			q = new Query("INSERT_EVENT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'aggiornamento dell'event nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getArea_id());
			param.put("2_"+Constants.C_INT,this.getEventtype_id());
			param.put("3_"+Constants.C_STRING,this.getEventtitle());
			param.put("4_"+Constants.C_STRING,Utils.formatDateForDB(this.getEventdate()));
			param.put("5_"+Constants.C_STRING,this.getPrref());
			param.put("6_"+Constants.C_STRING,this.getProductorsubject());
			param.put("7_"+Constants.C_INT,this.getEvent_id());

			q = new Query("UPDATE_EVENT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione dell'event dal DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getEvent_id());
			q = new Query("DELETE_EVENT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se l'event in esame ha dei clipping associati
	 * 
	 * @return boolean hasAssociatedClippings Variabile booleana che indica se l'event ha clippings associati
	 */
	public boolean hasAssociatedClippings(){
		boolean hasAssociatedClippings = false;
		Query q = null;
		Vector associatedClippings = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getEvent_id());
			q = new Query("SELECT_EVENT_CLIPPINGS");
			associatedClippings = q.execQuery(param);
			if(associatedClippings.size() > 0)
				hasAssociatedClippings = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedClippings;
	}

	/**
	 * Metodo che controlla se l'event in esame e' già presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se l'event e' già presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsEvent = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getArea_id());
			param.put("2_"+Constants.C_INT,this.getEventtype_id());
			param.put("3_"+Constants.C_STRING,this.getEventtitle());
			param.put("4_"+Constants.C_STRING,Utils.formatDateForDB(this.getEventdate()));
			if(this.getEvent_id().equals("")){
				param.put("5_"+Constants.C_STRING,"");
			}else{
				param.put("5_"+Constants.C_INT,this.getEvent_id());
			}
			q = new Query("SELECT_EVENT_EXISTS");
			alreadyExistsEvent = q.execQuery(param);
			if(alreadyExistsEvent.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	/**
	 * Metodo che ritorna l'id dell'event
	 * 
	 * @return String event_id Stringa che identifica l'id dell'event
	 */
	public String getEvent_id() {
		return event_id;
	}
	
	/**
	 * Metodo che setta l'event_id dell'event
	 * 
	 * @param String event_id Stringa che identifica l'event_id dell'event
	 */
	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
	
	/**
	 * Metodo che ritorna l'area_id dell'event
	 * 
	 * @return String area_id Stringa che identifica l'area_id dell'event
	 */
	public String getArea_id() {
		return area_id;
	}
	
	/**
	 * Metodo che setta l'area_id dell'event
	 * 
	 * @param String area_id Stringa che identifica l'area_id dell'event
	 */
	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}
	
	/**
	 * Metodo che ritorna il titolo dell'event
	 * 
	 * @return String eventtitle Stringa che identifica il titolo dell'event
	 */
	public String getEventtitle() {
		return eventtitle;
	}
	
	/**
	 * Metodo che setta l'eventtitle dell'event
	 * 
	 * @param String eventtitle Stringa che identifica l'eventtitle dell'event
	 */
	public void setEventtitle(String eventtitle) {
		this.eventtitle = eventtitle;
	}
	
	/**
	 * Metodo che ritorna l'eventtype_id dell'event
	 * 
	 * @return String eventtype_id Stringa che identifica l'eventtype_id dell'event
	 */
	public String getEventtype_id() {
		return eventtype_id;
	}
	
	/**
	 * Metodo che setta l'eventtype_id dell'event
	 * 
	 * @param String eventtype_id Stringa che identifica l'eventtype_id dell'event
	 */
	public void setEventtype_id(String eventtype_id) {
		this.eventtype_id = eventtype_id;
	}
	
	/**
	 * Metodo che ritorna l'eventdate dell'event
	 * 
	 * @return String eventdate Stringa che identifica l'eventdate dell'event
	 */
	public String getEventdate() {
		return eventdate;
	}
	
	/**
	 * Metodo che setta l'eventdate dell'event
	 * 
	 * @param String eventdate Stringa che identifica l'eventdate dell'event
	 */
	public void setEventdate(String eventdate) {
		this.eventdate = eventdate;
	}
	
	/**
	 * Metodo che ritorna il prref dell'event
	 * 
	 * @return String prref Stringa che identifica il prref dell'event
	 */
	public String getPrref() {
		return prref;
	}
	
	/**
	 * Metodo che setta il prref dell'event
	 * 
	 * @param String prref Stringa che identifica il prref dell'event
	 */
	public void setPrref(String prref) {
		this.prref = prref;
	}
	
	/**
	 * Metodo che ritorna il productorsubject dell'event
	 * 
	 * @return String productorsubject Stringa che identifica il productorsubject dell'event
	 */
	public String getProductorsubject() {
		return productorsubject;
	}
	
	/**
	 * Metodo che setta il productorsubject dell'event
	 * 
	 * @param String productorsubject Stringa che identifica il productorsubject dell'event
	 */
	public void setProductorsubject(String productorsubject) {
		this.productorsubject = productorsubject;
	}
}