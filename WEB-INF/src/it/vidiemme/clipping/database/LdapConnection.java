package it.vidiemme.clipping.database;

import java.util.*;
import javax.naming.*;
import javax.naming.directory.*;
import it.vidiemme.clipping.utils.Constants;

/**
 * LdapConnection: Classe che effettua la connessione a Ldap
 */
public class LdapConnection {
	// id dell'utente
	private String strLdapUser = null;
	// password dell'utente
	private String strLdapPassword = null; 
	// esito della tentata connessione
	public boolean isConnected = false; 
	// per connessione anonima e ricerca LdapUid, viene settata al termine della ricerca
	private String result = null;
	// viene settata dalla classe che richiama il metodo di connessione anonima 
	private String strUid = null; 

	/**
	 * Costruttore
	 */ 
	public LdapConnection (String username,String password) 
	{	
		setLdapUser(username);
		setLdapPassword(password);
		connect();	
	}
    
	/**
	 * Setta il valore dell' id dell'utente.
	 * @parameter strLdapUser id dell'utente da settare 
	 */
	public void setLdapUser(String strLdapUser) {
		this.strLdapUser = strLdapUser;
	}
    
	/**
	 * Setta il valore dell' id dell'utente.
	 * @parameter strLdapUser id dell'utente da settare 
	 */
	public void setLdapPassword(String strLdapPassword) {
		this.strLdapPassword = strLdapPassword;
	} 
    
	/**
	 * Metodo per creare una connessione con Ldap Server
	 *
	 * @param connectionType tipo di connessione da realizzare
	 * @return boolean che rappresenta l'esito dell'operazione di connessione; se TRUE, la connessione e' avvenuta
	 */
	public boolean connect() {
		// nome del package del LDAP service provider; specifica quale classe usare per il JNDI provider           
		String initContextFactory = "com.sun.jndi.ldap.LdapCtxFactory";     
		String strLdapHost = Constants.LDAP_HOST;
		String strLdapPort = Constants.LDAP_PORT;
		String strLdapUrl = strLdapHost + ":" + strLdapPort;
		String strLdapBase = Constants.LDAP_SEARCHBASE; 

		String FILTER = "uid="+this.strLdapUser;
		boolean logged = false;
		String dn = null;

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env.put(Context.PROVIDER_URL, "ldap://"+strLdapHost+":"+strLdapPort);

		/********* get dn and auth with pwd ********/
		try{
			DirContext ctx = new InitialDirContext(env);
			SearchControls constraint = new SearchControls();
			constraint.setSearchScope(SearchControls.SUBTREE_SCOPE);

			NamingEnumeration result = ctx.search(strLdapBase,FILTER,constraint);
			while((result!=null) && (result.hasMore())){
				SearchResult sr = (SearchResult) result.next();	
				dn = sr.getName() + "," + strLdapBase;
				break;
			}
			if(dn != null){
				env.put(Context.SECURITY_AUTHENTICATION, "simple");
				env.put(Context.SECURITY_PRINCIPAL, dn);
				env.put(Context.SECURITY_CREDENTIALS, this.strLdapPassword);
				DirContext ctx2 = null;
				ctx2 = new  InitialDirContext(env);
				logged = true;
			}
		}catch(Exception e){
			logged = false;
		}
		/*********************************/
		this.isConnected=logged;
		return isConnected;
	}

	/**
	 * Restituisce la stringa "result"; se non e' nulla, significa che la ricerca su Ldap Server ha avuto un buon esito
	 *
	 * @return result, che rappresenta l'esito della ricerca di un particolare uid su Ldap
	 */
	public String getResult() {        
		return this.result;
	}

	/**
	 * Setta la stringa strUid, che rappresenta l'uid di cui si vuole cercare una corrispondenza su Ldap
	 *
	 * @return result, che rappresenta l'esito della ricerca di un particolare uid su Ldap
	 */
	public void setStrUid(String newStrUid) {
		this.strUid = newStrUid;
	}
}