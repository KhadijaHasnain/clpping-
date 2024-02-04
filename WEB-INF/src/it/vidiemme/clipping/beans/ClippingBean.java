package it.vidiemme.clipping.beans;

import java.util.Vector;
import java.util.Hashtable;
import it.vidiemme.clipping.database.Query;
import it.vidiemme.clipping.utils.*;

public class ClippingBean {
	private String clipping_id = "";
	private String publication_id = "";
	private String event_id = "";
	private String lengthofarticle_id = "";
	private String tone_id = "";
	private String graphic_id = "";
	private String cover_id = "";
	private String fieldstory_id = "";
	private String title = "";
	private String datepublished = "";
	private String score = "";
	private String lengthscore = "";
	
	/**
	 * Costruttore di default della classe
	 */
	public ClippingBean() {
	}
	
	/**
	 * Costruttore che riceve in ingresso l'id del clipping 
	 * e che ne valorizza tutti gli attributi
	 *
	 * @param String clipping_id Stringa che identifica l'id del clipping
	 */
	public ClippingBean(String clipping_id) {
		this.setClipping_id(clipping_id);
		Query q = null;
		Vector result = new Vector();
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getClipping_id());
			q = new Query("SELECT_CLIPPING_DETAILS");
			result = q.execQuery(param);

			if(result.size() > 0){
				this.setPublication_id(((Hashtable)result.firstElement()).get("publicationid").toString());
				this.setEvent_id(((Hashtable)result.firstElement()).get("eventid").toString());
				this.setLengthofarticle_id(((Hashtable)result.firstElement()).get("lengthid").toString());
				this.setTone_id(((Hashtable)result.firstElement()).get("toneid").toString());
				this.setGraphic_id(((Hashtable)result.firstElement()).get("graphicid").toString());
				this.setCover_id(((Hashtable)result.firstElement()).get("coverid").toString());
				this.setFieldstory_id(((Hashtable)result.firstElement()).get("fieldstoryid").toString());
				this.setTitle(((Hashtable)result.firstElement()).get("title").toString());
				this.setDatepublished(Utils.formatDateForView(((Hashtable)result.firstElement()).get("datepublished").toString()));
				this.setScore(((Hashtable)result.firstElement()).get("score").toString());
				this.setLengthscore(((Hashtable)result.firstElement()).get("lengthscore").toString());
			}
			
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
	}

	/**
	 * Metodo che esegue l'inserimento nel DB del clipping
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int insert(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			if(this.getEvent_id().equals("")){
				param.put("2_"+Constants.C_NULL,"NULL");
			}else{
				param.put("2_"+Constants.C_INT,this.getEvent_id());
			}
			param.put("3_"+Constants.C_INT,this.getLengthofarticle_id());
			param.put("4_"+Constants.C_INT,this.getTone_id());
			param.put("5_"+Constants.C_INT,this.getGraphic_id());
			if(this.getCover_id().equals("")){
				param.put("6_"+Constants.C_NULL,"NULL");
			}else{
				param.put("6_"+Constants.C_INT,this.getCover_id());
			}
			if(this.getFieldstory_id().equals("")){
				param.put("7_"+Constants.C_NULL,"NULL");
			}else{
				param.put("7_"+Constants.C_INT,this.getFieldstory_id());
			}
			param.put("8_"+Constants.C_STRING,this.getTitle());
			param.put("9_"+Constants.C_STRING,Utils.formatDateForDB(this.getDatepublished()));
			if(this.getScore().equals("")){
				param.put("10_"+Constants.C_NULL,"NULL");
			}else{
				param.put("10_"+Constants.C_DOUBLE,this.getScore());
			}
			param.put("11_"+Constants.C_INT,"1");
			
			q = new Query("INSERT_CLIPPING");
			result = q.execUpdate(param);
			if(result > 0) {
				this.setClipping_id(q.getLastInsertId());
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		} 
		return result;
	}

	/**
	 * Metodo che esegue l'aggiornamento del clipping nel DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int update(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			if(this.getEvent_id().equals("")){
				param.put("2_"+Constants.C_NULL,"NULL");
			}else{
				param.put("2_"+Constants.C_INT,this.getEvent_id());
			}
			param.put("3_"+Constants.C_INT,this.getLengthofarticle_id());
			param.put("4_"+Constants.C_INT,this.getTone_id());
			param.put("5_"+Constants.C_INT,this.getGraphic_id());
			if(this.getCover_id().equals("")){
				param.put("6_"+Constants.C_NULL,"NULL");
			}else{
				param.put("6_"+Constants.C_INT,this.getCover_id());
			}
			if(this.getFieldstory_id().equals("")){
				param.put("7_"+Constants.C_NULL,"NULL");
			}else{
				param.put("7_"+Constants.C_INT,this.getFieldstory_id());
			}
			param.put("8_"+Constants.C_STRING,this.getTitle());
			param.put("9_"+Constants.C_STRING,Utils.formatDateForDB(this.getDatepublished()));
			if(this.getScore().equals("")){
				param.put("10_"+Constants.C_NULL,"NULL");
			}else{
				param.put("10_"+Constants.C_DOUBLE,this.getScore());
			}
			if(this.getLengthscore().equals("")){
				param.put("11_"+Constants.C_NULL,"NULL");
			}else{
				param.put("11_"+Constants.C_INT,this.getLengthscore());
			}
			param.put("12_"+Constants.C_INT,this.getClipping_id());
				
			q = new Query("UPDATE_CLIPPING");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}

	/**
	 * Metodo che esegue la cancellazione del clipping dal DB
	 *
	 * @return int result Intero che rappresenta l'esito dell'operazione
	 */
	public int delete(){
		int result = 0;
		Query q = null;
		Hashtable param = new Hashtable();
		try {
			param.put("1_"+Constants.C_INT,this.getClipping_id());
			q = new Query("DELETE_CLIPPING");
			result = q.execUpdate(param);
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return result;
	}
	
	/**
	 * Metodo che controlla se il clipping in esame e' gia' presente nel DB
	 *
	 * @return boolean alreadyExists Variabile booleana che indica se il clipping e' gia' presente nel DB
	 */
	public boolean alreadyExists(){
		boolean alreadyExists = false;
		Query q = null;
		Vector alreadyExistsClipping = new Vector();
		Hashtable param = new Hashtable();
		try {	
			param.put("1_"+Constants.C_INT,this.getPublication_id());
			param.put("2_"+Constants.C_STRING,this.getTitle());
			param.put("3_"+Constants.C_STRING,Utils.formatDateForDB(this.getDatepublished()));
			if(this.getClipping_id().equals("")){
				param.put("4_"+Constants.C_STRING,"");
			}else{
				param.put("4_"+Constants.C_INT,this.getClipping_id());
			}
			q = new Query("SELECT_CLIPPING_EXISTS");
			alreadyExistsClipping = q.execQuery(param);
			if(alreadyExistsClipping.size() > 0)
				alreadyExists = true;
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return alreadyExists;
	}

	public String getClipping_id() {
		return clipping_id;
	}

	public void setClipping_id(String clipping_id) {
		this.clipping_id = clipping_id;
	}

	public String getPublication_id() {
		return publication_id;
	}

	public void setPublication_id(String publication_id) {
		this.publication_id = publication_id;
	}

	public String getLengthofarticle_id() {
		return lengthofarticle_id;
	}

	public void setLengthofarticle_id(String lengthofarticle_id) {
		this.lengthofarticle_id = lengthofarticle_id;
	}

	public String getTone_id() {
		return tone_id;
	}

	public void setTone_id(String tone_id) {
		this.tone_id = tone_id;
	}

	public String getGraphic_id() {
		return graphic_id;
	}

	public void setGraphic_id(String graphic_id) {
		this.graphic_id = graphic_id;
	}

	public String getCover_id() {
		return cover_id;
	}

	public void setCover_id(String cover_id) {
		this.cover_id = cover_id;
	}

	public String getFieldstory_id() {
		return fieldstory_id;
	}

	public void setFieldstory_id(String fieldstory_id) {
		this.fieldstory_id = fieldstory_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDatepublished() {
		return datepublished;
	}

	public void setDatepublished(String datepublished) {
		this.datepublished = datepublished;
	}

	public String getScore() {
		Query q = null;
		Hashtable param = new Hashtable();
		Vector lengthAudienceVector = new Vector();
		Vector levelSizeVector = new Vector();
		double lengthAudienceValue = 0;
		double levelValue = 0;
		double toneValue = 0.00;
		double graphicValue = 0.00;
		double levelSizeValue = 0.00;
		double score = 0.00;
		String scoreStr = "";
		try {
			if(!this.getPublication_id().equals("")) {
				PublicationBean publication = new PublicationBean(this.getPublication_id());

				// Recupera il valore del lengthAudienceValue
				param.put("1_"+Constants.C_INT,this.lengthofarticle_id);
				param.put("2_"+Constants.C_INT,publication.getAudience_id());
				q = new Query("SELECT_LENGTH_AUDIENCE_VALUE");
				lengthAudienceVector = q.execQuery(param);
				if(lengthAudienceVector.size() > 0) {
					lengthAudienceValue = Double.parseDouble(((Hashtable)lengthAudienceVector.firstElement()).get("length_audience_value").toString());
				}
				
				if(!publication.getLevel_id().equals("")) {
					// Query per recuperare il levelValue
					param = new Hashtable();
					param.put("1_"+Constants.C_INT,publication.getLevel_id());
					q = new Query("SELECT_LEVEL_VALUE");
					Vector levelVector = q.execQuery(param);
					if(levelVector.size() > 0) {
						levelValue = Double.parseDouble(((Hashtable)levelVector.firstElement()).get("level_value").toString());
					}
				}
				
				if(!this.getTone_id().equals("")) {
					// Query per recuperare il toneValue
					param = new Hashtable();
					param.put("1_"+Constants.C_INT,this.getTone_id());
					q = new Query("SELECT_TONE_VALUE");
					Vector toneVector = q.execQuery(param);
					if(toneVector.size() > 0) {
						toneValue = Double.parseDouble(((Hashtable)toneVector.firstElement()).get("tone_value").toString());
					}
				}
				
				if(!this.getGraphic_id().equals("")) {
					// Query per recuperare il graphicValue
					param = new Hashtable();
					param.put("1_"+Constants.C_INT,this.getGraphic_id());
					q = new Query("SELECT_GRAPHIC_VALUE");
					Vector graphicVector = q.execQuery(param);
					if(graphicVector.size() > 0) {
						graphicValue = Double.parseDouble(((Hashtable)graphicVector.firstElement()).get("graphic_value").toString());
					}
				}
				param = new Hashtable();
				param.put("1_"+Constants.C_INT,publication.getLevel_id());
				param.put("2_"+Constants.C_INT,publication.getSize_id());
				q = new Query("SELECT_LEVEL_SIZE_VALUE");
				levelSizeVector = q.execQuery(param);
				if(levelSizeVector.size() > 0) {
					levelSizeValue = Double.parseDouble(((Hashtable)levelSizeVector.firstElement()).get("level_size_value").toString());
				}
				score = lengthAudienceValue * levelValue * toneValue * graphicValue * levelSizeValue;
				if(this.getCover_id().equals("2")) {
					score = score * 0.5;
				}
				scoreStr = Utils.roundForDB(score+"");
			}
		} catch (Exception e) {
			Constants.log.error(e.fillInStackTrace());
		}
		return scoreStr;
	}

	public void setScore(String score) {
		this.score = score;
	}

	public String getLengthscore() {
		return lengthscore;
	}

	public void setLengthscore(String lengthscore) {
		this.lengthscore = lengthscore;
	}

	public String getEvent_id() {
		return event_id;
	}

	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
}