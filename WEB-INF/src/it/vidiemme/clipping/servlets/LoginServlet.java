package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import it.vidiemme.clipping.beans.UserBean;
import it.vidiemme.clipping.database.*;
import it.vidiemme.clipping.utils.*;

/**
 * Servlet di Login: controlla che username e password siano settate e che l'utente sia presente nel database
 * se presente crea un'istanza del bean utente e la mette in sessione
 */
public class LoginServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
                LdapConnection ldap = null;
                boolean access = false;
		String page = "/login.jsp";
		String username = (request.getParameter("username") == null)?"":request.getParameter("username");
		String password = (request.getParameter("password") == null)?"":request.getParameter("password");
		try {
			if(username.equals("")){
				request.setAttribute("ERROR", "USERNAME_REQUIRED");
			}else if(password.equals("")){
				request.setAttribute("ERROR", "PASSWORD_REQUIRED");
			}else{
                                ldap = new LdapConnection(username,password);
                                access = ldap.isConnected;
                                //access = true;
				Hashtable param = new Hashtable();
				param.put("1_"+Constants.C_STRING,username);
				Query q = new Query("LOGIN");
				Vector result = q.execQuery(param);
				String userId = "";
				String roleId = "";
				if(access && result.size() > 0){
					page="/index.jsp";
					userId = ((Hashtable)result.firstElement()).get("userid").toString();
					roleId = ((Hashtable)result.firstElement()).get("roleid").toString();
					UserBean user = new UserBean(userId, roleId, username);
					session.setAttribute("user", user);
				}else{
					request.setAttribute("ERROR", "INVALID_ACCOUNT");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			Constants.log.error(e.fillInStackTrace());
			request.setAttribute("ERROR", "GENERIC_ERROR");
		}
		request.getRequestDispatcher(page).forward(request, response);
	}

	/**
	 * Metodo che gestisce le chiamate in POST alla servlet
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}