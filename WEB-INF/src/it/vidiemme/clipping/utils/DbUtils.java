package it.vidiemme.clipping.utils;

import java.util.*;
import java.text.SimpleDateFormat;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.beans.UserBean;

public class DbUtils {
	/**
	 * Metodo che ritorna la descrizione dell'area relativa all'id passatogli come parametro
	 *
	 * @param String id_area Stringa contenente l'id dell'area di cui vuole ottenere la descrizione
	 * @return String area Stringa contenente la descrizione dell'area richiesta
	 */
	public static String getAreaDescription(String id_area){
		String area = "";
		Query q = null;
		Vector areaDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING, id_area);
			q = new Query("SELECT_AREA_DESCRIPTION");
			areaDetails = q.execQuery(param);
			if(areaDetails.size() > 0){
				area = (((Hashtable)areaDetails.firstElement()).get("area").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return area;
	}
	
	/**
	 * Metodo che ritorna la descrizione del medium relativa all'id passatogli come parametro
	 *
	 * @param String id_medium Stringa contenente l'id del medium di cui vuole ottenere la descrizione
	 * @return String medium Stringa contenente la descrizione del medium richiesta
	 */
	public static String getMediumDescription(String id_medium){
		String medium = "";
		Query q = null;
		Vector mediumDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_STRING, id_medium);
			q = new Query("SELECT_MEDIUM_DESCRIPTION");
			mediumDetails = q.execQuery(param);
			if(mediumDetails.size() > 0){
				medium = (((Hashtable)mediumDetails.firstElement()).get("medium").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return medium;
	}
	
	/**
	 * Metodo che ritorna la descrizione del fieldstory relativa all'id passatogli come parametro
	 *
	 * @param String fieldstory_id Stringa contenente l'id del fieldstory di cui vuole ottenere la descrizione
	 * @return String fieldstory Stringa contenente la descrizione del fieldstory richiesta
	 */
	public static String getFieldstoryDescription(String fieldstory_id){
		String fieldstory = "";
		Query q = null;
		Vector fieldstoryDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, fieldstory_id);
			q = new Query("SELECT_FIELDSTORY_DESCRIPTION");
			fieldstoryDetails = q.execQuery(param);
			if(fieldstoryDetails.size() > 0){
				fieldstory = (((Hashtable)fieldstoryDetails.firstElement()).get("fieldstory").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return fieldstory;
	}
	
	/**
	 * Metodo che ritorna la descrizione della length relativa all'id passatogli come parametro
	 *
	 * @param String id_length Stringa contenente l'id della length di cui vuole ottenere la descrizione
	 * @return String length Stringa contenente la descrizione della length richiesta
	 */
	public static String getLengthDescription(String id_length){
		String length = "";
		Query q = null;
		Vector lengthDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_length);
			q = new Query("SELECT_LENGTH_DESCRIPTION");
			lengthDetails = q.execQuery(param);
			if(lengthDetails.size() > 0){
				length = (((Hashtable)lengthDetails.firstElement()).get("length").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return length;
	}
	
	/**
	 * Metodo che ritorna la descrizione del tone relativa all'id passatogli come parametro
	 *
	 * @param String id_tone Stringa contenente l'id del tone di cui vuole ottenere la descrizione
	 * @return String tone Stringa contenente la descrizione del tone richiesta
	 */
	public static String getToneDescription(String id_tone){
		String tone = "";
		Query q = null;
		Vector toneDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_tone);
			q = new Query("SELECT_TONE_DESCRIPTION");
			toneDetails = q.execQuery(param);
			if(toneDetails.size() > 0){
				tone = (((Hashtable)toneDetails.firstElement()).get("tone").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return tone;
	}
	
	/**
	 * Metodo che ritorna la descrizione del graphic relativa all'id passatogli come parametro
	 *
	 * @param String id_graphic Stringa contenente l'id del graphic di cui vuole ottenere la descrizione
	 * @return String graphic Stringa contenente la descrizione del graphic richiesta
	 */
	public static String getGraphicDescription(String id_graphic){
		String graphic = "";
		Query q = null;
		Vector graphicDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_graphic);
			q = new Query("SELECT_GRAPHIC_DESCRIPTION");
			graphicDetails = q.execQuery(param);
			if(graphicDetails.size() > 0){
				graphic = (((Hashtable)graphicDetails.firstElement()).get("graphic").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return graphic;
	}
	
	/**
	 * Metodo che ritorna la descrizione della cover relativa all'id passatogli come parametro
	 *
	 * @param String id_cover Stringa contenente l'id della cover di cui vuole ottenere la descrizione
	 * @return String cover Stringa contenente la descrizione della cover richiesta
	 */
	public static String getCoverDescription(String id_cover){
		String cover = "";
		Query q = null;
		Vector coverDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_cover);
			q = new Query("SELECT_COVER_DESCRIPTION");
			coverDetails = q.execQuery(param);
			if(coverDetails.size() > 0){
				cover = (((Hashtable)coverDetails.firstElement()).get("cover").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return cover;
	}
	
	/**
	 * Metodo che ritorna la descrizione dell'eventtype relativa all'id passatogli come parametro
	 *
	 * @param String id_type Stringa contenente l'id dell'eventty di cui vuole ottenere la descrizione
	 * @return String type Stringa contenente la descrizione dell'eventype richiesta
	 */
	public static String getTypeDescription(String id_type){
		String type = "";
		Query q = null;
		Vector typeDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_type);
			q = new Query("SELECT_TYPE_DESCRIPTION");
			typeDetails = q.execQuery(param);
			if(typeDetails.size() > 0){
				type = (((Hashtable)typeDetails.firstElement()).get("description").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return type;
	}
	
	/**
	 * Metodo che ritorna la descrizione del role relativa all'id passatogli come parametro
	 *
	 * @param String id_role Stringa contenente l'id del role di cui vuole ottenere la descrizione
	 * @return String role Stringa contenente la descrizione del role richiesta
	 */
	public static String getRoleDescription(String id_role){
		String role = "";
		Query q = null;
		Vector roleDetails = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT, id_role);
			q = new Query("SELECT_ROLE_DESCRIPTION");
			roleDetails = q.execQuery(param);
			if(roleDetails.size() > 0){
				role = (((Hashtable)roleDetails.firstElement()).get("role").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return role;
	}
	/**
	 * Metodo che ritorna la descrizione dell'audience relativa all'id passatogli come parametro
	 *
	 * @param String id_audience Stringa contenente l'id dell'audience di cui vuole ottenere la descrizione
	 * @return String audience Stringa contenente la descrizione dell'audience richiesta
	 */
	public static String getAudienceDescription(String id_audience){
		String audience = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector audienceDescription = new Vector();
		try {
			param.put("1_"+Constants.C_INT, id_audience);
			q = new Query("SELECT_AUDIENCE_DESCRIPTION"); 
			audienceDescription = q.execQuery(param);
			if(audienceDescription.size() > 0){
				audience = (((Hashtable)audienceDescription.firstElement()).get("audience").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return audience;
	}

	/**
	 * Metodo che ritorna la descrizione del country relativa all'id passatogli come parametro
	 *
	 * @param String id_country Stringa contenente l'id del country di cui vuole ottenere la descrizione
	 * @return String country Stringa contenente la descrizione del country richiesta
	 */
	public static String getCountryDescription(String id_country){
		String country = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector countryDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_country);
			q = new Query("SELECT_COUNTRY_DESCRIPTION");
			countryDescription = q.execQuery(param);
			if(countryDescription.size() > 0){
				country = (((Hashtable)countryDescription.firstElement()).get("country").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return country;
	}
	
	/**
	 * Metodo che ritorna la descrizione della publication relativa all'id passatogli come parametro
	 *
	 * @param String id_publication Stringa contenente l'id della publication di cui vuole ottenere la descrizione
	 * @return String publication Stringa contenente il nome della publication richiesta
	 */
	public static String getPublicationDescription(String id_publication){
		String publication = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector publicationDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_publication);
			q = new Query("SELECT_PUBLICATION_DESCRIPTION");
			publicationDescription = q.execQuery(param);
			if(publicationDescription.size() > 0){
				publication = (((Hashtable)publicationDescription.firstElement()).get("name").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return publication;
	}

	/**
	 * Metodo che ritorna la descrizione della division relativa all'id passatogli come parametro
	 *
	 * @param String id_division Stringa contenente l'id della division di cui vuole ottenere la descrizione
	 * @return String division Stringa contenente il nome della division richiesta
	 */
	public static String getDivisionDescription(String id_division){
		String division = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector divisionDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_division);
			q = new Query("SELECT_DIVISION_DESCRIPTION");
			divisionDescription = q.execQuery(param);
			if(divisionDescription.size() > 0){
				division = (((Hashtable)divisionDescription.firstElement()).get("name").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return division;
	}
	
	/**
	 * Metodo che ritorna la descrizione dell'event relativa all'id passatogli come parametro
	 *
	 * @param String id_event Stringa contenente l'id dell'event di cui vuole ottenere la descrizione
	 * @return String event Stringa contenente l'eventtitle richiesto
	 */
	public static String getEventDescription(String id_event){
		String event = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector eventDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_event);
			q = new Query("SELECT_EVENT_DESCRIPTION");
			eventDescription = q.execQuery(param);
			if(eventDescription.size() > 0){
				event = (((Hashtable)eventDescription.firstElement()).get("eventtitle").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return event;
	}
	
	/**
	 * Metodo che ritorna la descrizione del product relativa all'id passatogli come parametro
	 *
	 * @param String id_product Stringa contenente l'id del product di cui vuole ottenere la descrizione
	 * @return String product Stringa contenente il purtnumberorname del product richiesto
	 */
	public static String getProductDescription(String id_product){
		String product = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector productDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_product);
			q = new Query("SELECT_PRODUCT_DESCRIPTION");
			productDescription = q.execQuery(param);
			if(productDescription.size() > 0){
				product = (((Hashtable)productDescription.firstElement()).get("partnumberorname").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return product;
	}

	/**
	 * Metodo che ritorna la descrizione della section relativa all'id passatogli come parametro
	 *
	 * @param String id_section Stringa contenente l'id della section di cui vuole ottenere la descrizione
	 * @return String section Stringa contenente la descrizione richiesta
	 */
	public static String getSectionDescription(String id_section){
		String section = "";
		Query q = null;
		Hashtable param = new Hashtable();
		Vector sectionDescription = new Vector();
		try {
			param.put("1_"+Constants.C_STRING, id_section);
			q = new Query("SELECT_SECTION_DESCRIPTION");
			sectionDescription = q.execQuery(param);
			if(sectionDescription.size() > 0){
				section = (((Hashtable)sectionDescription.firstElement()).get("name").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return section;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti gli audiences presenti nel DB
	 *
	 * @return Vector audiences Vettore contenente i valori della tabella audience
	 */
	public static Vector getAudiences(){
		Vector audiences = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_AUDIENCES"); 
			audiences = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return audiences;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le aree presenti nel DB
	 *
	 * @param Vector userAreas Vettore contenente tutte le aree associate allo user loggato
	 * @return Vector areas Vettore contenente i valori della tabella area
	 */
	public static Vector getAreas(Vector userAreas){
		Vector areas = new Vector();
		Query q = null;
		String condition = "";
		String areasStr = "";
		try {
			if(userAreas.size() > 0) {
				for (int i = 0; i < userAreas.size(); i++) {
					areasStr += userAreas.elementAt(i);
					if(i < (userAreas.size()-1))
						areasStr += ",";
				}
				condition = " AND areaid IN ("+areasStr+")";
			}
			q = new Query("SELECT_AREAS");
			q.replaceQueryConditions(condition);
			areas = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return areas;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente: tutti i countries (id, valore) presenti nell'area passata come 
	 * parametro nel caso l'utente sia un manager oppure tutti i countries (id, valore) associati a se stesso nel caso sia un 
	 * end user 
	 *
	 * @param String areaid Stringa contenente l'id dell'area di cui si vogliono conoscere i countries
	 * @param Vector userCountries Vettore contenente gli id dei countries associati ad uno user
	 * @param String userid Stringa contenente l'id dello user
	 * @return Vector countries Vettore contenente i dati selezionati dalla tabella country
	 */
	public static Vector getCountries(String areaid, Vector userCountries, String userId){
		Vector countries = new Vector();
		Query q = null;
		String countriesId = "";
		Hashtable param = new Hashtable();

		try {
			param.put("1_"+Constants.C_STRING, userId);
			// Se l'utente loggato ha dei countries associati (se si tratta di un end user)
			if(userCountries.size() > 0){
				for (int i = 0; i < userCountries.size(); i++) {
					if(i < (userCountries.size() - 1)){
						countriesId += userCountries.elementAt(i).toString() + ",";
					}else{
						countriesId += userCountries.elementAt(i).toString();
					}
				}
				q = new Query("SELECT_COUNTRIES_BY_COUNTRIES");
				q.replaceQueryConditions(countriesId);
				countries = q.execQuery(param);
			}else{
				param.put("2_"+Constants.C_STRING, areaid);
				q = new Query("SELECT_COUNTRIES_BY_AREA");
				countries = q.execQuery(param);
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return countries;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i countries presenti nel DB che corrispondono
	 * all'area passatagli come parametro
	 *
	 * @return Vector countriesList Vettore contenente i valori della tabella country ralativi all'area passatagli come parametro
	 */
	public static Vector getCountriesIdList(String area_id){
		Vector countries = new Vector();
		Vector countriesList = new Vector();
		Hashtable param = new Hashtable();
		Query q = null;
		try {
			param.put("1_"+Constants.C_STRING, area_id);
			q = new Query("SELECT_COUNTRIES_FOR_ADMIN_SEARCH");
			countries = q.execQuery(param);
			for (int i = 0; i < countries.size(); i++) {
				countriesList.add(((Hashtable)countries.elementAt(i)).get("countryid").toString());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return countriesList;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente: tutti i countries (id, valore) presenti nell'area passata come 
	 * parametro nel caso l'utente sia un manager oppure tutti i countries (id, valore) associati a se stesso nel caso sia un 
	 * end user 
	 *
	 * @param String[] area_id Array di stringhe che contenente la lista di id delle aree di cui si vogliono conoscere i countries
	 * @return Vector countries Vettore contenente i dati selezionati dalla tabella country
	 */
	public static Vector getCountriesByAreas(String[] area_id){
		Vector countries = new Vector();
		Query q = null;
		String areaList = "";
		String condition = "";
		try {
			if(area_id.length > 0 && !area_id[0].equals("")) {
				for (int i = 0; i < area_id.length; i++) {
					areaList += (i < (area_id.length-1))?area_id[i]+",":area_id[i];
				}
				condition += " AND country.areaid IN ("+areaList+")";
				q = new Query("SELECT_COUNTRIES_BY_AREA_LIST");
				q.replaceQueryConditions(condition);
				countries = q.execQuery();
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return countries;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i countries presenti nel DB che corrispondono 
	 * all'area passatagli come parametro 
	 *
	 * @return Vector countries Vettore contenente i valori della tabella country ralativi all'area passatagli come parametro 
	 */
	public static Vector getCountriesForAdminSearch(String area_id){
		Vector countries = new Vector();
		Hashtable param = new Hashtable();
		Query q = null;
		try {
			param.put("1_"+Constants.C_STRING, area_id);
			q = new Query("SELECT_COUNTRIES_FOR_ADMIN_SEARCH");
			countries = q.execQuery(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return countries;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte gli eventtypes presenti nel DB
	 *
	 * @return Vector types Vettore contenente i valori della tabella eventtypes
	 */
	public static Vector getTypes(){
		Vector types = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_TYPES"); 
			types = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return types;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i roles presenti nel DB
	 *
	 * @return Vector roles Vettore contenente i valori della tabella roles
	 */
	public static Vector getRoles(){
		Vector roles = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_ROLES"); 
			roles = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return roles;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le publications presenti nel DB che corrispondono
	 * all'area ed eventualmente al country passati come parametri
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @return Vector publications Vettore contenente i valori della tabella publications corrispondenti ai criteri selezionati
	 */
	public static Vector getPublications(String area_id, String country_id, String audience_id){
		Vector publications = new Vector();
		String condition = "";
		Query q = null;
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				condition += " AND audienceid = '"+audience_id+"'";
			q = new Query("SELECT_PUBLICATIONS");
			q.replaceQueryConditions(condition);
			//Constants.log.debug("QUERY PUBLICATIONS---> "+q.getQuery());
			publications = q.execQuery();

		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return publications;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le publications attive (non archiviate) 
	 * presenti nel DB che corrispondono all'area ed eventualmente al country passati come parametri
	 * 
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @return Vector publications Vettore contenente i valori della tabella publications corrispondenti ai criteri selezionati
	 */
	public static Vector getPublicationsNotArchived(String area_id, String country_id){
		Vector publications = new Vector();
		String condition = "";
		Query q = null;
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			q = new Query("SELECT_PUBLICATIONS_NOT_ARCHIVED");
			q.replaceQueryConditions(condition);
			publications = q.execQuery();
			
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return publications;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le publications presenti nel DB che corrispondono
	 * all'area ed eventualmente al country passati come parametri
	 *
	 * @param String[] area_id Array di stringhe che identifica la lista di id delle aree associata alla publication
	 * @param String[] country_id Array di stringhe che identifica la lista di id delle countries associata alla publication
	 * @return Vector publications Vettore contenente i valori della tabella publications corrispondenti ai criteri selezionati
	 */
	public static Vector getPublicationsByAreas(String[] area_id, String[] country_id, String audience_id){
		Vector publications = new Vector();
		String condition = "";
		String areaList = "";
		String countryList = "";
		Query q = null;
		try {
			if(area_id.length > 0 && !area_id[0].equals("")) {
				for (int i = 0; i < area_id.length; i++) {
					areaList += (i < (area_id.length-1))?area_id[i]+",":area_id[i];
				}
				condition += " AND areaid IN ("+areaList+")";
			}

			if(country_id.length > 0 && !country_id[0].equals("")) {
				for (int i = 0; i < country_id.length; i++) {
					countryList += (i < (country_id.length-1))?country_id[i]+",":country_id[i];
				}
				condition += " AND countryid IN ("+countryList+")";
			}

			if(!audience_id.equals(""))
				condition += " AND audienceid = '"+audience_id+"'";
			q = new Query("SELECT_PUBLICATIONS");
			q.replaceQueryConditions(condition);
			publications = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return publications;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti gli events presenti nel DB che corrispondono 
	 * all'area passata come parametro
	 * 
	 * @param String area_id Stringa che identifica l'id dell'area associata all'event
	 * @return Vector events Vettore contenente i valori della tabella events corrispondenti ai criteri selezionati
	 */
	public static Vector getEvents(String area_id){
		Vector events = new Vector();
		String condition = "";
		Query q = null;
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			q = new Query("SELECT_EVENTS");
			q.replaceQueryConditions(condition);
			events = q.execQuery();
			
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return events;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i level of press presenti nel DB
	 *
	 * @return Vector levels Vettore contenente i valori della tabella levels
	 */
	public static Vector getLevels(){
		Vector levels = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_LEVELS"); 
			levels = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return levels;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le sizes presenti nel DB
	 *
	 * @return Vector sizes Vettore contenente i valori della tabella sizes
	 */
	public static Vector getSizes(){
		Vector sizes = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_SIZES"); 
			sizes = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return sizes;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le frequencies presenti nel DB
	 *
	 * @return Vector frequencies Vettore contenente i valori della tabella frequencies
	 */
	public static Vector getFrequencies(){
		Vector frequencies = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_FREQUENCIES"); 
			frequencies = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return frequencies;
	}

	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i medium presenti nel DB
	 *
	 * @return Vector mediums Vettore contenente i valori della tabella medium 
	 */
	public static Vector getMediums(){
		Vector mediums = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_MEDIUM"); 
			mediums = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return mediums;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutti i fieldstories presenti nel DB
	 *
	 * @return Vector fieldstories Vettore contenente i valori della tabella fieldstories 
	 */
	public static Vector getFieldStories(){
		Vector fieldStories = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_FIELDSTORIES"); 
			fieldStories = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return fieldStories;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le lengths presenti nel DB
	 *
	 * @return Vector lengths Vettore contenente i valori della tabella lengths
	 */
	public static Vector getLengths(){
		Vector lengths = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_LENGTHS"); 
			lengths = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return lengths;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le tones presenti nel DB
	 *
	 * @return Vector tones Vettore contenente i valori della tabella tones
	 */
	public static Vector getTones(){
		Vector tones = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_TONES"); 
			tones = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return tones;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le graphics presenti nel DB
	 *
	 * @return Vector graphics Vettore contenente i valori della tabella graphics
	 */
	public static Vector getGraphics(){
		Vector graphics = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_GRAPHICS"); 
			graphics = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return graphics;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le covers presenti nel DB
	 *
	 * @return Vector covers Vettore contenente i valori della tabella covers
	 */
	public static Vector getCovers(){
		Vector covers = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_COVERS"); 
			covers = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return covers;
	}
	
	/**
	 * Metodo che ritorna un vettore di Hashtable contenente tutte le sections presenti nel DB
	 *
	 * @return Vector sections Vettore contenente i valori della tabella sections
	 */
	public static Vector getSections(){
		Vector sections = new Vector();
		Query q = null;
		try {
			q = new Query("SELECT_SECTIONS"); 
			sections = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return sections;
	}

	
	/**
	 * Metodo che ritorna un vettore contenente tutti i clippings che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String[] area_id Array di stringhe che identifica la lista di id delle aree selezionate nel form di ricerca
	 * @param String[] country_id Array di stringhe che identifica la lista di id dei countries selezionati nel form di ricerca
	 * @param String publication_id Stringa che identifica l'id della publication associata al clipping
	 * @param String title Stringa che identifica il title del clipping
	 * @param String fieldstory_id Stringa che identifica il fieldstory_id del clipping
	 * @param String datepublished_from Stringa che identifica la datepublished_from del clipping
	 * @param String datepublished_to Stringa che identifica la datepublished_to del clipping
	 * @param String lengthofarticle_id Stringa che identifica la lengthofarticle_id del clipping
	 * @param String tone_id Stringa che identifica il tone_id del clipping
	 * @param String graphic_id Stringa che identifica il graphic_id del clipping
	 * @param String cover_id Stringa che identifica il cover_id del clipping
	 * @param String score Stringa che identifica lo score del clipping
	 * @param String ordering Stringa che identifica l'ordinamento dei clippings
	 * @return Vector clippings Vettore che contiene la lista dei clippings trovati
	 */
	public static Vector getSearchClippings(String[] area_id, String[] country_id, String publication_id, String audience_id, String title, String fieldstory_id, String datepublished_from, String datepublished_to, String lengthofarticle_id, String tone_id, String graphic_id, String cover_id, String score, String ordering){
            Query q = null;
            Vector clippings = new Vector();
			String areaList = "";
			String countryList = "";
            String condition = "";
            try {
                if(!publication_id.equals(""))
                    condition += " AND clippings.publicationid = "+publication_id;
                if(!audience_id.equals(""))
                    condition += " AND publications.audienceid = "+audience_id;
                if(!title.equals(""))
                    condition += " AND title LIKE '%"+title+"%'";
                if(!fieldstory_id.equals(""))
                    condition += " AND clippings.fieldstoryid = "+fieldstory_id;
                if(!datepublished_from.equals("") && Utils.isCorrectDate(datepublished_from))
                    condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(datepublished_from)+"', \"%Y%m%d\")";
                if(!datepublished_to.equals("") && Utils.isCorrectDate(datepublished_to))
                    condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(datepublished_to)+"', \"%Y%m%d\")";
                if(!lengthofarticle_id.equals(""))
                    condition += " AND clippings.lengthid = "+lengthofarticle_id;
                if(!tone_id.equals(""))
                    condition += " AND clippings.toneid = "+tone_id;
                if(!graphic_id.equals(""))
                    condition += " AND clippings.graphicid = "+graphic_id;
                if(!cover_id.equals(""))
                    condition += " AND clippings.coverid = "+cover_id;
                if(!score.equals(""))
                    condition += " AND score = "+score;
				if(area_id.length > 0 && !area_id[0].equals("")) {
					condition += " AND (";
					for (int i = 0; i < area_id.length; i++) {
						String countryCond = "";
						String countryListId = "";
						Vector countriesByArea = getCountriesIdList(area_id[i]);
						if(country_id.length > 0) {
							for (int j = 0; j < country_id.length; j++) {
								if(countriesByArea.contains(country_id[j])) {
									countryListId += country_id[j]+",";
								}
							}
						}
						if(!countryListId.equals("")) {
							countryListId = countryListId.substring(0,(countryListId.length()-1));
							countryCond = " AND publications.countryid IN ("+countryListId+")";
						}
						if(i < (area_id.length-1)) {
							condition += " (publications.areaid = "+area_id[i]+" "+countryCond+") OR";
						} else {
							condition += " (publications.areaid = "+area_id[i]+" "+countryCond+"))";
						}
					}
				}
                condition += " ORDER BY area ASC, country ASC";
                if(!ordering.equals("")) {
					condition += ", " + ordering;
				}
                //q = new Query("SELECT_CLIPPINGS_SEARCHED");
				q = new Query("SELECT_CLIPPINGS");
                q.replaceQueryConditions(condition);
                clippings = q.execQuery();
            } catch (Exception e) {
                Constants.log.error(e.fillInStackTrace());
            }
            return clippings;
	}

	/**
	 * Metodo che ritorna un vettore contenente tutti i clippings che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String[] area_id Array di stringhe che identifica la lista di id delle aree selezionate nel form di ricerca
	 * @param String[] country_id Array di stringhe che identifica la lista di id dei countries selezionati nel form di ricerca
	 * @param String publication_id Stringa che identifica l'id della publication associata al clipping
	 * @param String title Stringa che identifica il title del clipping
	 * @param String fieldstory_id Stringa che identifica il fieldstory_id del clipping
	 * @param String datepublished_from Stringa che identifica la datepublished_from del clipping
	 * @param String datepublished_to Stringa che identifica la datepublished_to del clipping
	 * @param String lengthofarticle_id Stringa che identifica la lengthofarticle_id del clipping
	 * @param String tone_id Stringa che identifica il tone_id del clipping
	 * @param String graphic_id Stringa che identifica il graphic_id del clipping
	 * @param String cover_id Stringa che identifica il cover_id del clipping
	 * @param String score Stringa che identifica lo score del clipping
	 * @param String ordering Stringa che identifica l'ordinamento dei clippings
	 * @return Vector clippings Vettore che contiene la lista dei clippings trovati
	 */
	public static Vector getSearchClippingsXLS(String[] area_id, String[] country_id, String publication_id, String audience_id, String title, String fieldstory_id, String datepublished_from, String datepublished_to, String lengthofarticle_id, String tone_id, String graphic_id, String cover_id, String score, String ordering){
            Query q = null;
            Vector clippings = new Vector();
			String areaList = "";
			String countryList = "";
            String condition = "";
            try {
                if(!publication_id.equals(""))
                    condition += " AND clippings.publicationid = "+publication_id;
                if(!audience_id.equals(""))
                    condition += " AND publications.audienceid = "+audience_id;
                if(!title.equals(""))
                    condition += " AND title LIKE '%"+title+"%'";
                if(!fieldstory_id.equals(""))
                    condition += " AND clippings.fieldstoryid = "+fieldstory_id;
                if(!datepublished_from.equals("") && Utils.isCorrectDate(datepublished_from))
                    condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(datepublished_from)+"', \"%Y%m%d\")";
                if(!datepublished_to.equals("") && Utils.isCorrectDate(datepublished_to))
                    condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(datepublished_to)+"', \"%Y%m%d\")";
                if(!lengthofarticle_id.equals(""))
                    condition += " AND clippings.lengthid = "+lengthofarticle_id;
                if(!tone_id.equals(""))
                    condition += " AND clippings.toneid = "+tone_id;
                if(!graphic_id.equals(""))
                    condition += " AND clippings.graphicid = "+graphic_id;
                if(!cover_id.equals(""))
                    condition += " AND clippings.coverid = "+cover_id;
                if(!score.equals(""))
                    condition += " AND score = "+score;
				if(area_id.length > 0 && !area_id[0].equals("")) {
					condition += " AND (";
					for (int i = 0; i < area_id.length; i++) {
						String countryCond = "";
						String countryListId = "";
						Vector countriesByArea = getCountriesIdList(area_id[i]);
						if(country_id.length > 0) {
							for (int j = 0; j < country_id.length; j++) {
								if(countriesByArea.contains(country_id[j])) {
									countryListId += country_id[j]+",";
								}
							}
						}
						if(!countryListId.equals("")) {
							countryListId = countryListId.substring(0,(countryListId.length()-1));
							countryCond = " AND publications.countryid IN ("+countryListId+")";
						}
						if(i < (area_id.length-1)) {
							condition += " (publications.areaid = "+area_id[i]+" "+countryCond+") OR";
						} else {
							condition += " (publications.areaid = "+area_id[i]+" "+countryCond+"))";
						}
					}
				}
                condition += " ORDER BY area ASC, country ASC";
                if(!ordering.equals("")) {
					condition += ", " + ordering;
				}
                //q = new Query("SELECT_CLIPPINGS_SEARCHED");
				q = new Query("SELECT_CLIPPINGS_XLS");
                q.replaceQueryConditions(condition);
                clippings = q.execQuery();
            } catch (Exception e) {
                Constants.log.error(e.fillInStackTrace());
            }
            return clippings;
	}

	/**
	 * Metodo che ritorna un vettore contenente tutte le publications che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che identifica l'area della publication
	 * @param String name Stringa che identifica il nome della publication
	 * @param String last_rated_from_search Stringa che identifica il last_rated di inizio della publication
	 * @param String last_rated_to_search Stringa che identifica il last_rated di fine della publication
	 * @param String audience Stringa che identifica l'audince  della publication
	 * @param String level Stringa che identifica il level della publication
	 * @param String size Stringa che identifica il size della publication
	 * @param String frequency Stringa che identifica la frequency della publication
	 * @param String medium Stringa che identifica il medium della publication
	 * @param String country Stringa che identifica il country della publication
	 * @param String archive Stringa che identifica l'archive della publication
	 * @param UserBean user UserBean che identifica l'utente loggato
	 * @return Vector publications Vettore che contiene la lista delle publications trovate
	 */
	public static Vector getSearchPublications(String area, String name, String last_rated_from_search, String last_rated_to_search, String audience, String level, String size, String frequency, String medium, String country, String archive, UserBean user){
		Query q = null;
		Vector publications = new Vector();
		String roleId = user.getId_role();
		Vector areas = user.getAreas();
		String areasStr = "";
		String condition = "";
		try {
			if(!name.equals(""))
				condition += " AND name LIKE '%"+Utils.formatStringForDB(name)+"%'";
			if(!last_rated_from_search.equals("") && Utils.isCorrectDate(last_rated_from_search))
				condition += " AND date_format(last_rated, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(last_rated_from_search)+"', \"%Y%m%d\")";
			if(!last_rated_to_search.equals("") && Utils.isCorrectDate(last_rated_to_search))
				condition += " AND date_format(last_rated, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(last_rated_to_search)+"', \"%Y%m%d\")";
			if(!audience.equals(""))
				condition += " AND audienceid = '"+audience+"'";
			if(!level.equals(""))
				condition += " AND levelid = '"+level+"'";
			if(!size.equals(""))
				condition += " AND sizeid = '"+size+"'";
			if(!frequency.equals(""))
				condition += " AND frequencyid = '"+frequency+"'";
			if(!medium.equals(""))
				condition += " AND mediumid = '"+medium+"'";
			if(!area.equals("")){
				condition += " AND areaid = '"+area+"'";
			}else if(!roleId.equals(Constants.idRoleAdmin)){
				for (int i = 0; i < areas.size(); i++) {
					areasStr += areas.elementAt(i);
					if(i < (areas.size()-1)){
						areasStr += ",";
					}
				}
				condition += " AND areaid IN ("+areasStr+")";
			}
			if(!country.equals("")){
				condition += " AND countryid = '"+country+"'";
			}else if(roleId.equals(Constants.idRoleEndUser)){
				Vector endUserCountries = user.getCountries();
				String countriesList = "";
				for (int i = 0; i < endUserCountries.size(); i++) {
					countriesList += endUserCountries.elementAt(i);
					if(i < (endUserCountries.size() - 1)) 
						countriesList += ",";
				}
				condition += " AND countryid IN ("+countriesList+")";
			}
			if(!archive.equals(""))
				condition += " AND status = '"+archive+"'";

			q = new Query("SELECT_PUBLICATIONS_SEARCHED");
			q.replaceQueryConditions(condition);
			publications = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return publications;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutti gli events che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che identifica l'area dell'event
	 * @param String title Stringa che identifica il titolo dell'event
	 * @param String type Stringa che identifica il tipo di event
	 * @param String prref Stringa che identifica il prref dell'event
	 * @param String productorsubject Stringa che identifica il productorsubject dell'event
	 * @param String eventdate_from Stringa che identifica la eventdate_from dell'event
	 * @param String eventdate_to Stringa che identifica la eventdate_to dell'event
	 * @param String eventdateexpiry_from Stringa che identifica la eventdateexpiry_from dell'event
	 * @param String eventdateexpiry_to Stringa che identifica la eventdateexpiry_to dell'event
	 * @param String archive Stringa che identifica l'archive dell'event
	 * @return Vector events Vettore che contiene la lista degli events trovati
	 */
	public static Vector getSearchEvents(String area, String title, String type, String prref, String productorsubject, String eventdate_from, String eventdate_to, UserBean user){
		Query q = null;
		Vector events = new Vector();
		String roleId = user.getId_role();
		Vector areas = user.getAreas();
		String areasStr = "";
		String condition = "";
		try {
			if(!area.equals("")){
				condition += " AND areaid = '"+area+"'";
			}else if(!roleId.equals(Constants.idRoleAdmin)){
				for (int i = 0; i < areas.size(); i++) {
					areasStr += areas.elementAt(i);
					if(i < (areas.size()-1)){
						areasStr += ",";
					}
				}
				condition += " AND areaid IN ("+areasStr+")";
			}
			if(!type.equals(""))
				condition += " AND eventtypeid = '"+type+"'";
			if(!title.equals(""))
				condition += " AND eventtitle LIKE '%"+title+"%'";
			if(!eventdate_from.equals("") && Utils.isCorrectDate(eventdate_from))
				condition += " AND date_format(eventdate, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(eventdate_from)+"', \"%Y%m%d\")";
			if(!eventdate_to.equals("") && Utils.isCorrectDate(eventdate_to))
				condition += " AND date_format(eventdate, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(eventdate_to)+"', \"%Y%m%d\")";
			if(!prref.equals(""))
				condition += " AND prref LIKE '%"+prref+"%'";
			if(!productorsubject.equals(""))
				condition += " AND productorsubject LIKE '%"+productorsubject+"%'";

			q = new Query("SELECT_EVENTS_SEARCHED");
			q.replaceQueryConditions(condition);
			events = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return events;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutti i countries che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che identifica l'area del country
	 * @param String country Stringa che identifica il nome del country
	 * @return Vector countries Vettore che contiene la lista dei countries trovati
	 */
	public static Vector getSearchCountries(String area, String country){
		Vector countries = new Vector();
		Query q = null;
		String condition = "";
		try {
			if(!area.equals(""))
				condition += " AND areaid = '"+area+"'";
			if(!country.equals(""))
				condition += " AND country LIKE '%"+Utils.formatStringForDB(country)+"%'";

			q = new Query("SELECT_COUNTRIES_SEARCHED");
			q.replaceQueryConditions(condition);
			countries = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return countries;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutti gli users che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che contiene l'id dell'area di cui un admin vuole conoscere gli users 
	 * @param String role Stringa che contiene l'id del ruolo di cui un admin vuole conoscere gli users 
	 * @param UserBean user Bean dello user loggato
	 * @return Vector users Vettore che contiene la lista degli utenti trovati
	 */
	public static Vector getSearchUsers(String area, String role, UserBean user){
		Vector users = new Vector();
		Query q = null;
		String condition = "";
		String areasStr = "";
		Vector areas = user.getAreas();
		try {
			if(user.getId_role().equals(Constants.idRoleManager)){
				for (int i = 0; i < areas.size(); i++) {
					areasStr += areas.elementAt(i);
					if(i < (areas.size()-1))
						areasStr += ",";
				}
				q = new Query("SELECT_END_USERS_SEARCHED");
				condition += " AND areaid IN ("+areasStr+") AND roleid = '"+Constants.idRoleEndUser+"'";
				q.replaceQueryConditions(condition);
			}else{
				String finalQuery = "";
				String queryAdmin = "SELECT distinct users.userid, 1 AS role_order FROM users WHERE roleid="+Constants.idRoleAdmin;
				String queryManager = "SELECT distinct users.userid, 2 AS role_order FROM users, user_area WHERE roleid="+Constants.idRoleManager+" AND users.userid=user_area.userid";
				String queryEndUser = "SELECT distinct users.userid, 3 AS role_order FROM users, user_country"+
					       " WHERE roleid="+Constants.idRoleEndUser+" AND users.userid = user_country.userid";
				String conditionManager = " AND areaid = " + area;
				String conditionEndUser = " AND countryid IN ( SELECT countryid FROM country WHERE areaid="+area+")";
				
				if(role.equals("")){
					if(area.equals("")){
						finalQuery = queryAdmin + " UNION " + queryManager + " UNION " + queryEndUser;
					} else {
						finalQuery = queryManager + " " + conditionManager + " UNION " + queryEndUser + " " + conditionEndUser;
					}
				} else {
					if(role.equals(Constants.idRoleAdmin)){
						finalQuery = queryAdmin;
					}else if(role.equals(Constants.idRoleManager)){
						finalQuery = queryManager;
						if(!area.equals("")){
							finalQuery += "" + conditionManager;
						}
					}else if(role.equals(Constants.idRoleEndUser)){
						finalQuery = queryEndUser;
						if(!area.equals("")){
							finalQuery += "" + conditionEndUser;
						}
					}
				}
				finalQuery += " ORDER BY role_order";
				q = new Query(finalQuery, "");
			}
			users = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return users;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutti i products che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che identifica l'area del product
	 * @param String partnumberorname Stringa che identifica il part number o il name del product
	 * @param String archive Stringa che identifica l'archive del product
	 * @param UserBean user UserBean che identifica l'utente loggato
	 * @return Vector products Vettore che identifica la lista dei products trovati
	 */
	public static Vector getSearchProducts(String area, String partnumberorname, String archive, UserBean user){
		Vector products = new Vector();
		Query q = null;
		String condition = "";
		String roleId = user.getId_role();
		Vector areas = user.getAreas();
		String areasStr = "";
		try {
			if(!area.equals("")){
				condition += " AND areaid = '"+area+"'";
			}else if(!roleId.equals(Constants.idRoleAdmin)){
				for (int i = 0; i < areas.size(); i++) {
					areasStr += areas.elementAt(i);
					if(i < (areas.size()-1)){
						areasStr += ",";
					}
				}
				condition += " AND areaid IN ("+areasStr+")";
			}
			if(!partnumberorname.equals(""))
				condition += " AND partnumberorname LIKE '%"+Utils.formatStringForDB(partnumberorname)+"%'";
			if(!archive.equals(""))
				condition += " AND status = '"+archive+"'";

			q = new Query("SELECT_PRODUCTS_SEARCHED");
			q.replaceQueryConditions(condition);
			products = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return products;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutte le divisions che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String area Stringa che identifica l'area della division
	 * @param String name Stringa che identifica il name della division
	 * @param String archive Stringa che identifica l'archive della division
	 * @param UserBean user UserBean che identifica l'utente loggato
	 * @return Vector divisions Vettore che identifica la lista delle division trovate
	 */
	public static Vector getSearchDivisions(String area, String name, String archive, UserBean user){
		Vector divisions = new Vector();
		Query q = null;
		String condition = "";
		String roleId = user.getId_role();
		Vector areas = user.getAreas();
		String areasStr = "";
		try {
			if(!area.equals("")){
				condition += " AND areaid = '"+area+"'";
			}else if(!roleId.equals(Constants.idRoleAdmin)){
				for (int i = 0; i < areas.size(); i++) {
					areasStr += areas.elementAt(i);
					if(i < (areas.size()-1)){
						areasStr += ",";
					}
				}
				condition += " AND areaid IN ("+areasStr+")";
			}
			if(!name.equals(""))
				condition += " AND name LIKE '%"+Utils.formatStringForDB(name)+"%'";
			if(!archive.equals(""))
				condition += " AND status = '"+archive+"'";

			q = new Query("SELECT_DIVISIONS_SEARCHED");
			q.replaceQueryConditions(condition);
			divisions = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return divisions;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente tutti i contacts che corrispondono
	 * ai criteri selezionati
	 *
	 * @param String publication_id Stringa che identifica l'id della publication associata al contact
	 * @param String firstname Stringa che identifica il firstname del contact
	 * @param String lastname Stringa che identifica il lastname del contact
	 * @param String city Stringa che identifica il city del contact
	 * @param String country Stringa che identifica il country del contact
	 * @return Vector contacts Vettore che contiene la lista dei contacts trovati
	 */
	public static Vector getSearchContacts(String publication_id, String firstname, String lastname, String city, String country){
		Query q = null;
		Vector contacts = new Vector();
		String areasStr = "";
		String condition = "";
		try {
			if(!publication_id.equals(""))
				condition += " AND publicationid = '"+publication_id+"'";
			if(!firstname.equals(""))
				condition += " AND firstname LIKE '%"+firstname+"%'";
			if(!lastname.equals(""))
				condition += " AND lastname LIKE '%"+lastname+"%'";
			if(!city.equals(""))
				condition += " AND city LIKE '%"+city+"%'";
			if(!country.equals(""))
				condition += " AND country LIKE '%"+country+"%'";
			
			q = new Query("SELECT_CONTACTS_SEARCHED");
			q.replaceQueryConditions(condition);
			contacts = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return contacts;
	}

	/**
	 * Metodo che ritorna un vettore contenente il report degli important titles clippings corrispondente 
	 * ai criteri selezionati
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String score_min Stringa che identifica lo score_min del clipping
	 * @param String score_max Stringa che identifica lo score_max del clipping
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getImportantTitlesReport(String area_id, String country_id, String score_min, String score_max, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!score_min.equals(""))
				condition += " AND score >= '"+score_min+"'";
			if(!score_max.equals(""))
				condition += " AND score <= '"+score_max+"'";
			if(!date_from.equals("") && Utils.isCorrectDate(date_from))
				condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
			if(!date_to.equals("") && Utils.isCorrectDate(date_to))
				condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";

			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings in base all'audience delle publication ad essi associate 
	 * e al tipo di report: current_month, last_month, from_to
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String type Stringa che identifica il type del report
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectAudienceReport(String area_id, String country_id, String audience_id, String type, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				condition += " AND audienceid = '"+audience_id+"'";
			if(!type.equals("")){
				if(type.equals("current_month")){
					condition += " AND MONTH(datepublished) = MONTH(NOW()) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("last_month")){
					condition += " AND MONTH(datepublished) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("from_to")){
					if(!date_from.equals("") && Utils.isCorrectDate(date_from))
						condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
					if(!date_to.equals("") && Utils.isCorrectDate(date_to))
						condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";
				} 
			}
			
			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings in base agli events ad essi associati  
	 * e al tipo di report: current_month, last_month, from_to
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String event_id Stringa che identifica l'id dell'event associato al clipping
	 * @param String type Stringa che identifica il type del report
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectEventReport(String area_id, String country_id, String event_id, String type, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!event_id.equals(""))
				condition += " AND eventid = '"+event_id+"'";
			else
				condition += " AND eventid != ''";
			if(!type.equals("")){
				if(type.equals("current_month")){
					condition += " AND MONTH(datepublished) = MONTH(NOW()) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("last_month")){
					condition += " AND MONTH(datepublished) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("from_to")){
					if(!date_from.equals("") && Utils.isCorrectDate(date_from))
						condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
					if(!date_to.equals("") && Utils.isCorrectDate(date_to))
						condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";
				} 
			}
			
			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings in base alle publications ad essi associate 
	 * e al tipo di report: current_month, last_month, from_to
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String publication_id Stringa che identifica l'id della publication associata al clipping
	 * @param String type Stringa che identifica il type del report
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectPublicationReport(String area_id, String country_id, String publication_id, String type, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!publication_id.equals(""))
				condition += " AND clippings.publicationid = '"+publication_id+"'";
			if(!type.equals("")){
				if(type.equals("current_month")){
					condition += " AND MONTH(datepublished) = MONTH(NOW()) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("last_month")){
					condition += " AND MONTH(datepublished) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("from_to")){
					if(!date_from.equals("") && Utils.isCorrectDate(date_from))
						condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
					if(!date_to.equals("") && Utils.isCorrectDate(date_to))
						condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";
				} 
			}
			
			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings in base al medium delle publications ad essi associate 
	 * e al tipo di report: current_month, last_month, from_to
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String medium_id Stringa che identifica l'id del medium della publication
	 * @param String type Stringa che identifica il type del report
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectMediumReport(String area_id, String country_id, String medium_id, String type, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!medium_id.equals(""))
				condition += " AND mediumid = '"+medium_id+"'";
			if(!type.equals("")){
				if(type.equals("current_month")){
					condition += " AND MONTH(datepublished) = MONTH(NOW()) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("last_month")){
					condition += " AND MONTH(datepublished) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("from_to")){
					if(!date_from.equals("") && Utils.isCorrectDate(date_from))
						condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
					if(!date_to.equals("") && Utils.isCorrectDate(date_to))
						condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";
				} 
			}
			
			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings in base al loro score e al tipo di report: 
	 * current_month, last_month, from_to
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String score Stringa che identifica lo score del clipping
	 * @param String type Stringa che identifica il type del report
	 * @param String date_from Stringa che identifica la datepublished_from del clipping
	 * @param String date_to Stringa che identifica la datepublished_to del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectScoreReport(String area_id, String country_id, String type, String date_from, String date_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!type.equals("")){
				if(type.equals("current_month")){
					condition += " AND MONTH(datepublished) = MONTH(NOW()) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("last_month")){
					condition += " AND MONTH(datepublished) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND YEAR(datepublished) = YEAR(NOW())";
				}else if(type.equals("from_to")){
					if(!date_from.equals("") && Utils.isCorrectDate(date_from))
						condition += " AND date_format(datepublished, \"%Y%m%d\") >= date_format('"+Utils.formatDateForDB(date_from)+"', \"%Y%m%d\")";
					if(!date_to.equals("") && Utils.isCorrectDate(date_to))
						condition += " AND date_format(datepublished, \"%Y%m%d\") <= date_format('"+Utils.formatDateForDB(date_to)+"', \"%Y%m%d\")";
				} 
			}
			
			q = new Query("SELECT_REPORT");
			q.replaceQueryConditions(condition);
			clippings = q.execQuery();
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente il report dei clippings corrispondente ai criteri selezionati
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String section Stringa che identifica il parametro in base al quale si vuole ottenere il report
	 * @param String trend Stringa che identifica il trend del report: monthly, quarterly, yearly
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @param String year_to Stringa che identifica l'year_to della datepublished del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectNewTextReport(String area_id, String country_id, String section, String trend, String month_from, String month_to, String year_from, String year_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!section.equals("")){
				if(section.equals("publication")){
					if(!trend.equals("")){
						if(trend.equals("monthly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id";
						}else if(trend.equals("quarterly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, quarter ORDER BY id";
						}else if(trend.equals("yearly")){
							condition += " AND year(datepublished) >= '"+year_from+"' AND year(datepublished) <= '"+year_to+"' GROUP BY id, year ORDER BY id";
						} 
					}
					q = new Query("SELECT_PUBLICATION");
					q.replaceQueryConditions(condition);
					clippings = q.execQuery();
				}else if(section.equals("type_of_media")){
					if(!trend.equals("")){
						if(trend.equals("monthly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id";
						}else if(trend.equals("quarterly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, quarter ORDER BY id";
						}else if(trend.equals("yearly")){
							condition += " AND year(datepublished) >= '"+year_from+"' AND year(datepublished) <= '"+year_to+"' GROUP BY id, year ORDER BY id";
						} 
					}
					q = new Query("SELECT_MEDIA");
					q.replaceQueryConditions(condition);
					clippings = q.execQuery();
				}else if(section.equals("press_release")){
					if(!trend.equals("")){
						if(trend.equals("monthly")){
							condition += " AND extract(year_month from eventdate) >= '"+year_from+month_from+"' AND extract(year_month from eventdate) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id";
						}else if(trend.equals("quarterly")){
							condition += " AND extract(year_month from eventdate) >= '"+year_from+month_from+"' AND extract(year_month from eventdate) <= '"+year_to+month_to+"' GROUP BY id, year, quarter ORDER BY id";
						}else if(trend.equals("yearly")){
							condition += " AND year(eventdate) >= '"+year_from+"' AND year(eventdate) <= '"+year_to+"' GROUP BY id, year ORDER BY id";
						} 
					}
					q = new Query("SELECT_RELEASE");
					q.replaceQueryConditions(condition);
					clippings = q.execQuery();
				}else if(section.equals("rank_of_media")){
					if(!trend.equals("")){
						if(trend.equals("monthly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id";
						}else if(trend.equals("quarterly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, quarter ORDER BY id";
						}else if(trend.equals("yearly")){
							condition += " AND year(datepublished) >= '"+year_from+"' AND year(datepublished) <= '"+year_to+"' GROUP BY id, year ORDER BY id";
						} 
					}
					q = new Query("SELECT_LEVELOFPRESS");
					q.replaceQueryConditions(condition);
					clippings = q.execQuery();
				}else if(section.equals("type_of_story")){
					if(!trend.equals("")){
						if(trend.equals("monthly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id";
						}else if(trend.equals("quarterly")){
							condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, quarter ORDER BY id";
						}else if(trend.equals("yearly")){
							condition += " AND year(datepublished) >= '"+year_from+"' AND year(datepublished) <= '"+year_to+"' GROUP BY id, year ORDER BY id";
						} 
					}
					q = new Query("SELECT_FIELDSTORY");
					q.replaceQueryConditions(condition);
					clippings = q.execQuery();
				}
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente i valori selezionati per generare il report grafico dei clippings inseriti 
	 * mensilmente nel DB l'anno selezionato in base all'audience delle publications ad essi associate e al parametro in base 
	 * al quale lo si vuole generare
	 *
	 * @param String type Stringa che identifica il tipo di parametro in base al quale si vuole generare il report
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getYearSelectedGraphicReport(String type, String area_id, String country_id, String audience_id, String month_from, String month_to, String year_from, String year_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				condition += " AND publications.audienceid = '"+audience_id+"'";
			if(!type.equals("")){
				condition += " AND extract(year_month from datepublished) >= '"+year_from+month_from+"' AND extract(year_month from datepublished) <= '"+year_to+month_to+"' GROUP BY id, year, month ORDER BY id, year, month";
				if(type.equals("1")){
					q = new Query("SELECT_NUMBER_OF_CLIPPINGS");
				}else if(type.equals("2")){
					q = new Query("SELECT_NUMBER_OF_POINTS");
				}
				q.replaceQueryConditions(condition);
				clippings = q.execQuery();
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}
	
	/**
	 * Metodo che ritorna un vettore contenente i valori selezionati per generare il report grafico relativo al confronto 
	 * anno selezionato - anno precedente dei clippings inseriti mensilmente nel DB in base all'audience delle publications 
	 * ad essi associate e al parametro in base al quale lo si vuole generare
	 *
	 * @param String type Stringa che identifica il tipo di parametro in base al quale si vuole generare il report
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @return Vector clippings Vettore che contiene il risultato del report
	 */
	public static Vector getSelectedPreviousGraphicReport(String type, String area_id, String country_id, String audience_id, String month_from, String month_to, String year_from, String year_to){
		Query q = null;
		Vector clippings = new Vector();
		String condition = "";
		String previousYearFrom = String.valueOf(Integer.parseInt(year_from)-1);
		String previousYearTo = String.valueOf(Integer.parseInt(year_to)-1);
		try {
			if(!area_id.equals(""))
				condition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				condition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				condition += " AND publications.audienceid = '"+audience_id+"'";
			if(!type.equals("")){
				condition += " AND extract(year_month from datepublished) >= '"+previousYearFrom+month_from+"' AND extract(year_month from datepublished) <= '"+previousYearTo+month_to+"' GROUP BY id, year, month ORDER BY id, year, month";
				if(type.equals("1")){
					q = new Query("SELECT_NUMBER_OF_CLIPPINGS");
				}else if(type.equals("2")){
					q = new Query("SELECT_NUMBER_OF_POINTS");
				}
				q.replaceQueryConditions(condition);
				clippings = q.execQuery();
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return clippings;
	}

	/**
	 * Metodo che ritorna un vettore contenente i valori selezionati per generare il report grafico relativo al trend annuale
	 * dei clipping inseriti in un periodo di al massimo un anno di una determinata area ed eventualmente di un determinato 
	 * country e audience
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_to Stringa che identifica l'year_to della datepublished del clipping
	 * @return Hashatble valuesHash Hashtable che contiene un array di double per i valori e un array di stringhe per i mesi
	 */
	public static Hashtable getAnnualTrendGraphicReport(String area_id, String country_id, String audience_id, String month_from, String year_from, String month_to, String year_to){
		Query q = null;
		Vector score = new Vector();
		Vector scorePrevious = new Vector();
		String condition = "";
		String globalCondition = "";
		int i = 0;
		int length = 0;
		double value_to_return = 0;
		double value_up = 0;
		double value_down = 1;
		double[] values = null;
		String[] months = new String[0];
		Hashtable valuesHash = new Hashtable();
		SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.DBdateFormat);
		SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
		GregorianCalendar gcDateFrom = null;
		GregorianCalendar gcDateTo = null;
		GregorianCalendar gcDateTemp = null;
		try {
			// Calcola la condizione Globale da applicare a tutte le query
			if(!area_id.equals(""))
				globalCondition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				globalCondition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				globalCondition += " AND audienceid = '"+audience_id+"'";

			gcDateFrom = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			gcDateTo = new GregorianCalendar(Integer.parseInt(year_to), Integer.parseInt(month_to)-1, 01);
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			
			// Calcola la lunghezza dei due array
			while(!gcDateTemp.after(gcDateTo)) {
				length++;
				gcDateTemp.add(Calendar.MONTH, 1);
			}
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			values = new double[length];
			months = new String[length];

			values[i] = 0;
			months[i] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));

			while(!gcDateTemp.after(gcDateTo)) {
					condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 11 month) AND datepublished < date_add('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 1 month)";
				q = new Query("SELECT_TREND");
				q.replaceQueryConditions(condition);
				score = q.execQuery();
				try {
					value_up = Double.parseDouble(((Hashtable)score.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_up = 0;
				}

				q = new Query("SELECT_TREND");
				condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 23 month) AND datepublished < date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 11 month)";
				q.replaceQueryConditions(condition);
				scorePrevious = q.execQuery();
				try {
					value_down = Double.parseDouble(((Hashtable)scorePrevious.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_down = 1;
				}

				// Calcola il valore per il mese
				value_to_return = (value_up - value_down) / value_down;
				if(value_to_return == -1)
					value_to_return = 0;
				else
					value_to_return *= 100;

				// Incrementa di un mese la data su cui si basa il ciclo
				gcDateTemp.add(Calendar.MONTH, 1);
				if((i+1) < length){
					// Aggiunge agli array i valori dei mese
					values[i+1] = value_to_return;
					months[i+1] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));
				}
				i++;
			}
			valuesHash.put("VALUES", values);
			valuesHash.put("MONTHS", months);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return valuesHash;
	}

	/**
	 * Metodo che ritorna un vettore contenente i valori selezionati per generare il report grafico relativo al trend 
	 * semestrale dei clipping inseriti in un periodo di al massimo un anno di una determinata area ed eventualmente 
	 * di un determinato country e audience
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_to Stringa che identifica l'year_to della datepublished del clipping
	 * @return Hashatble valuesHash Hashtable che contiene un array di double per i valori e un array di stringhe per i mesi
	 */
	public static Hashtable getSemiannualTrendGraphicReport(String area_id, String country_id, String audience_id, String month_from, String year_from, String month_to, String year_to){
		Query q = null;
		Vector score = new Vector();
		Vector scorePrevious = new Vector();
		String condition = "";
		String globalCondition = "";
		int i = 0;
		int length = 0;
		double value_to_return = 0;
		double value_up = 0;
		double value_down = 1;
		double[] values = null;
		String[] months = new String[0];
		Hashtable valuesHash = new Hashtable();
		SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.DBdateFormat);
		SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
		GregorianCalendar gcDateFrom = null;
		GregorianCalendar gcDateTo = null;
		GregorianCalendar gcDateTemp = null;
		try {
			// Calcola la condizione Globale da applicare a tutte le query
			if(!area_id.equals(""))
				globalCondition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				globalCondition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				globalCondition += " AND audienceid = '"+audience_id+"'";

			gcDateFrom = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			gcDateTo = new GregorianCalendar(Integer.parseInt(year_to), Integer.parseInt(month_to)-1, 01);
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			
			// Calcola la lunghezza dei due array
			while(!gcDateTemp.after(gcDateTo)) {
				length++;
				gcDateTemp.add(Calendar.MONTH, 1);
			}
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			values = new double[length];
			months = new String[length];

			values[i] = 0;
			months[i] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));

			while(!gcDateTemp.after(gcDateTo)) {
				condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 5 month) AND datepublished < date_add('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 1 month)";
				q = new Query("SELECT_TREND");
				q.replaceQueryConditions(condition);
				score = q.execQuery();
				try {
					value_up = Double.parseDouble(((Hashtable)score.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_up = 0;
				}

				q = new Query("SELECT_TREND");
				condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 11 month) AND datepublished < date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 5 month)";
				q.replaceQueryConditions(condition);
				scorePrevious = q.execQuery();
				try {
					value_down = Double.parseDouble(((Hashtable)scorePrevious.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_down = 1;
				}

				// Calcola il valore per il mese
				value_to_return = (value_up - value_down) / value_down; 
				if(value_to_return == -1)
					value_to_return = 0;
				else
					value_to_return *= 100;

				// Incrementa di un mese la data su cui si basa il ciclo
				gcDateTemp.add(Calendar.MONTH, 1);
				if((i+1) < length){
					// Aggiunge agli array i valori dei mese
					values[i+1] = value_to_return;
					months[i+1] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));
				}
				i++;
			}
			valuesHash.put("VALUES", values);
			valuesHash.put("MONTHS", months);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return valuesHash;
	}

	/**
	 * Metodo che ritorna un vettore contenente i valori selezionati per generare il report grafico relativo al trend 
	 * trimestrale dei clipping inseriti in un periodo di al massimo un anno di una determinata area ed eventualmente 
	 * di un determinato country e audience
	 *
	 * @param String area_id Stringa che identifica l'id dell'area associata alla publication
	 * @param String country_id Stringa che identifica l'id del country associato alla publication
	 * @param String audience_id Stringa che identifica l'id dell'audience della publication
	 * @param String month_from Stringa che identifica il month_from della datepublished del clipping
	 * @param String year_from Stringa che identifica l'year_from della datepublished del clipping
	 * @param String month_to Stringa che identifica il month_to della datepublished del clipping
	 * @param String year_to Stringa che identifica l'year_to della datepublished del clipping
	 * @return Hashatble valuesHash Hashtable che contiene un array di double per i valori e un array di stringhe per i mesi
	 */
	public static Hashtable getQuarterlyTrendGraphicReport(String area_id, String country_id, String audience_id, String month_from, String year_from, String month_to, String year_to){
		Query q = null;
		Vector score = new Vector();
		Vector scorePrevious = new Vector();
		String condition = "";
		String globalCondition = "";
		int i = 0;
		int length = 0;
		double value_to_return = 0;
		double value_up = 0;
		double value_down = 1;
		double[] values = null;
		String[] months = new String[0];
		Hashtable valuesHash = new Hashtable();
		SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.DBdateFormat);
		SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
		GregorianCalendar gcDateFrom = null;
		GregorianCalendar gcDateTo = null;
		GregorianCalendar gcDateTemp = null;
		try {
			// Calcola la condizione Globale da applicare a tutte le query
			if(!area_id.equals(""))
				globalCondition += " AND areaid = '"+area_id+"'";
			if(!country_id.equals(""))
				globalCondition += " AND countryid = '"+country_id+"'";
			if(!audience_id.equals(""))
				globalCondition += " AND audienceid = '"+audience_id+"'";

			gcDateFrom = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			gcDateTo = new GregorianCalendar(Integer.parseInt(year_to), Integer.parseInt(month_to)-1, 01);
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			
			// Calcola la lunghezza dei due array
			while(!gcDateTemp.after(gcDateTo)) {
				length++;
				gcDateTemp.add(Calendar.MONTH, 1);
			}
			gcDateTemp = new GregorianCalendar(Integer.parseInt(year_from), Integer.parseInt(month_from)-1, 01);
			values = new double[length];
			months = new String[length];

			values[i] = 0;
			months[i] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));

			while(!gcDateTemp.after(gcDateTo)) {
				condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 2 month) AND datepublished < date_add('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 1 month)";
				q = new Query("SELECT_TREND");
				q.replaceQueryConditions(condition);
				score = q.execQuery();
				try {
					value_up = Double.parseDouble(((Hashtable)score.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_up = 0;
				}

				q = new Query("SELECT_TREND");
				condition = globalCondition + " AND datepublished >= date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 5 month) AND datepublished < date_sub('"+dateFormat.format(gcDateTemp.getTime())+"', INTERVAL 2 month)";
				q.replaceQueryConditions(condition);
				scorePrevious = q.execQuery();
				try {
					value_down = Double.parseDouble(((Hashtable)scorePrevious.firstElement()).get("total").toString());
				} catch (Exception e) {
					value_down = 1;
				}

				// Calcola il valore per il mese
				value_to_return = (value_up - value_down) / value_down; 
				if(value_to_return == -1)
					value_to_return = 0;
				else
					value_to_return *= 100;

				// Incrementa di un mese la data su cui si basa il ciclo
				gcDateTemp.add(Calendar.MONTH, 1);
				if((i+1) < length){
					// Aggiunge agli array i valori dei mese
					values[i+1] = value_to_return;
					months[i+1] = Utils.getMonthDescription(Integer.parseInt(monthFormat.format(gcDateTemp.getTime())));
				}
				i++;
			}
			valuesHash.put("VALUES", values);
			valuesHash.put("MONTHS", months);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return valuesHash;
	}
}