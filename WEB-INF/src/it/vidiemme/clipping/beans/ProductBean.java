package it.vidiemme.clipping.beans;

import java.util.Hashtable;
import java.util.Vector;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.Constants;

/**
 * Bean che rappresenta il product
 */
public class ProductBean {
	private String product_id = "";
	private String area_id = "";
	private String partnumberorname = "";
	private String description = "";
	private String status = "";

	/**
	 * Costruttore di default della classe
	 */
	public ProductBean() {
	}

	/**
	 * Costruttore che riceve in ingresso l'id del product 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String product_id Stringa che identifica l'id del product
	 */
	public ProductBean(String product_id) {
		this.setProduct_id(product_id);
		Query q = null;
		Vector products = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getProduct_id());
			q = new Query("SELECT_PRODUCT_DETAILS");
			products = q.execQuery(param);

			if(products.size() > 0){
				this.setArea_id(((Hashtable)products.firstElement()).get("areaid").toString());
				this.setDescription(((Hashtable)products.firstElement()).get("description").toString());
				this.setPartnumberorname(((Hashtable)products.firstElement()).get("partnumberorname").toString());
				this.setStatus(((Hashtable)products.firstElement()).get("status").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB del product
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getArea_id());
			param.put("2_"+Constants.C_STRING,getPartnumberorname());
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getStatus());

			q = new Query("INSERT_PRODUCT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'aggiornamento del product nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getArea_id());
			param.put("2_"+Constants.C_STRING,getPartnumberorname());
			param.put("3_"+Constants.C_STRING,getDescription());
			param.put("4_"+Constants.C_INT,getStatus());
			param.put("5_"+Constants.C_INT,getProduct_id());

			q = new Query("UPDATE_PRODUCT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione del product nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getProduct_id());
			q = new Query("DELETE_PRODUCT");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue l'archiviazione dei products nel DB
	 * settando lo stato ad Archived
	 *
	 * @param String[] productsToArchive Array di stringhe che contiene tutti i products da settare come archived
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int archive(String[] productsToArchive){
		int result = 0;
		Query q = null;
		String productsList = "";
		Hashtable param = new Hashtable();
		try {
			if(productsToArchive.length > 0){
				for (int i = 0; i < productsToArchive.length; i++) {
					if(i < (productsToArchive.length - 1)){
						productsList += productsToArchive[i] + ",";
					}else{
						productsList += productsToArchive[i];
					}
				}
				param.put("1_"+Constants.C_INT,Constants.archivedId+"");
				q = new Query("UPDATE_PRODUCT_STATUS");
				q.replaceQueryConditions(productsList);
				result = q.execUpdate(param);
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che controlla se il product in esame e' gia' presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se il product e' gia' presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsProduct = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING,this.getPartnumberorname());
			param.put("2_"+Constants.C_INT,this.getArea_id());
			if(this.getProduct_id().equals("")){
				param.put("3_"+Constants.C_STRING,"");
			}else{
				param.put("3_"+Constants.C_INT,this.getProduct_id());
			}
			q = new Query("SELECT_PRODUCT_EXISTS");
			alreadyExistsProduct = q.execQuery(param);
			if(alreadyExistsProduct.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	/**
	 * Metodo che controlla se il product in esame ha dei clipping associati
	 *
	 * @return boolean hasAssociatedClippings Variabile booleana che indica se il product ha clippings associati
	 */
	public boolean hasAssociatedClippings(){
		boolean hasAssociatedClippings = false;
		Query q = null;
		Vector associatedClippings = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,getProduct_id());
			q = new Query("SELECT_PRODUCT_CLIPPINGS");
			associatedClippings = q.execQuery(param);
			if(associatedClippings.size() > 0)
				hasAssociatedClippings = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return hasAssociatedClippings;
	}

	/**
	 * Metodo che ritorna il product_id
	 *
	 * @return String product_id Stringa che identifica l'id del prodotto
	 */
	public String getProduct_id() {
		return product_id;
	}

	/**
	 * Metodo che setta il product_id
	 *
	 * @param String product_id Stringa che identifica l'id del prodotto
	 */
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
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
	 * Metodo che ritorna il part number or name
	 *
	 * @return String partnumberorname Stringa che identifica il part number or name
	 */
	public String getPartnumberorname() {
		return partnumberorname;
	}

	/**
	 * Metodo che ritorna il part number or name
	 *
	 * @param String partnumberorname Stringa che identifica il part number or name
	 */
	public void setPartnumberorname(String partnumberorname) {
		this.partnumberorname = partnumberorname;
	}

	/**
	 * Metodo che setta la description del prodotto
	 *
	 * @return String description Stringa che identifica la description del prodotto
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Metodo che setta la description del prodotto
	 *
	 * @param String description Stringa che identifica la description del prodotto
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Metodo che ritorna lo stato del prodotto
	 *
	 * @return String status Stringa che identifica lo status del prodotto
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Metodo che setta lo stato del prodotto
	 *
	 * @param String status Stringa che identifica lo status del prodotto
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}