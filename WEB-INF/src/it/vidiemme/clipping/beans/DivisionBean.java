package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.Constants;


public class DivisionBean {
	private String division_id = "";
	private String area_id = "";
	private String name = "";
	private String description = "";
	private String status = "";

	/**
	 * Costruttore di default della classe
	 */
	public DivisionBean() {
	}
	
	/**
	 * Costruttore che riceve in ingresso l'id della division 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String division_id Stringa che identifica l'id della division
	 */
	public DivisionBean(String division_id) {
		this.setDivision_id(division_id);
		Query q = null;
		Vector divisions = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getDivision_id());
			q = new Query("SELECT_DIVISION_DETAILS");
			divisions = q.execQuery(param);

			if(divisions.size() > 0){
				this.setArea_id(((Hashtable)divisions.firstElement()).get("areaid").toString());
				this.setName(((Hashtable)divisions.firstElement()).get("name").toString());
				this.setDescription(((Hashtable)divisions.firstElement()).get("description").toString());
				this.setStatus(((Hashtable)divisions.firstElement()).get("status").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}
	
	/**
	 * Metodo che esegue l'inserimento nel DB della division
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getArea_id());
			param.put("2_"+Constants.C_STRING,this.getName());
			param.put("3_"+Constants.C_STRING,this.getDescription());
			param.put("4_"+Constants.C_INT,this.getStatus());

			q = new Query("INSERT_DIVISION");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}
	
	/**
	 * Metodo che esegue l'aggiornamento della division nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getArea_id());
			param.put("2_"+Constants.C_STRING,getName());
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getStatus());
			param.put("5_"+Constants.C_INT,getDivision_id());

			q = new Query("UPDATE_DIVISION");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione della division dal DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getDivision_id());
			q = new Query("DELETE_DIVISION");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'archiviazione delle divisions nel DB
	 * settando lo stato ad Archived
	 *
	 * @param String[] divisionsToArchive Array di stringhe che contiene tutte le divisions da settare come archived
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int archive(String[] divisionsToArchive){
		int result = 0;
		Query q = null;
		String divisionsList = "";
		Hashtable param = new Hashtable();
		try {
			if(divisionsToArchive.length > 0){
				for (int i = 0; i < divisionsToArchive.length; i++) {
					if(i < (divisionsToArchive.length - 1)){
						divisionsList += divisionsToArchive[i] + ",";
					}else{
						divisionsList += divisionsToArchive[i];
					}
				}
				param.put("1_"+Constants.C_INT,Constants.archivedId+"");
				q = new Query("UPDATE_DIVISION_STATUS");
				q.replaceQueryConditions(divisionsList);
				result = q.execUpdate(param);
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se la division in esame ha dei clipping associati
	 *
	 * @return boolean hasAssociatedClippings Variabile booleana che indica se la division ha clippings associati
	 */
	public boolean hasAssociatedClippings(){
		boolean hasAssociatedClippings = false;
		Query q = null;
		Vector associatedClippings = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getDivision_id());
			q = new Query("SELECT_DIVISION_CLIPPINGS");
			associatedClippings = q.execQuery(param);
			if(associatedClippings.size() > 0)
				hasAssociatedClippings = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedClippings;
	}

	/**
	 * Metodo che controlla se la division in esame e' già presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se la division e' gia' presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsDivision = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getArea_id());
			param.put("2_"+Constants.C_STRING,this.getName());
			if(this.getDivision_id().equals("")){
				param.put("3_"+Constants.C_STRING,"");
			}else{
				param.put("3_"+Constants.C_INT,this.getDivision_id());
			}
			q = new Query("SELECT_DIVISION_EXISTS");
			alreadyExistsDivision = q.execQuery(param);
			if(alreadyExistsDivision.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	public String getDivision_id() {
		return division_id;
	}

	public void setDivision_id(String division_id) {
		this.division_id = division_id;
	}

	public String getArea_id() {
		return area_id;
	}

	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}