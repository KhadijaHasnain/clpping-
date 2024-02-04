package it.vidiemme.clipping.utils;

import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;

/**
 *
 */
public class SelectUserLdap {
	Hashtable props = null;
	DirContext context = null;
	String server = null;
	int port;
	public String user = "";

	public SelectUserLdap(String uid) {
		this.server = Constants.LDAP_HOST;
		this.port = Integer.parseInt(Constants.LDAP_PORT);
		SearchResult result = null;
		Attribute a = null;
		try{
			connect();
		}catch(NamingException ex){
			ex.printStackTrace();
		}

		String filter = "(&(uid="+ uid +"))";
		String[] returnAttrib = {"uid"};
		int scope = SearchControls.SUBTREE_SCOPE;

		NamingEnumeration namingEnum = search(Constants.LDAP_SEARCHBASE, filter, returnAttrib, scope);
		int i = 1;
		try{
			if(namingEnum != null){
				while (namingEnum.hasMoreElements()){
				result = (SearchResult)namingEnum.nextElement();
				NamingEnumeration attributes = result.getAttributes().getAll();
				while(attributes.hasMore()){
					a = (Attribute)attributes.next();
					user = a.toString();
				}
				i++;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public void connect() throws NamingException {
		try{
			props = new Hashtable();
			props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			props.put(Context.PROVIDER_URL,  "ldap://"+this.server + ":" + this.port);
			context = new InitialDirContext(props);
		}catch (NamingException e){
			e.printStackTrace();
			props=null;
			throw e;
		}
	}

	public NamingEnumeration search(String name, String filter, String[] returnAttribs, int type) {
		NamingEnumeration result = null;
		SearchControls ctrl = new SearchControls();
		ctrl.setSearchScope(type);
		ctrl.setReturningAttributes(returnAttribs);
		if(context != null){
			try{
				result = context.search(name, filter, ctrl);
			}catch(NamingException e){
				e.printStackTrace();
			}
		}
		return result;
	}
}