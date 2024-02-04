package it.vidiemme.clipping.servlets;

import java.io.*;
import java.util.*;
import org.apache.log4j.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Log4jInitServlet extends HttpServlet {
	private String file_pro=null;
	private final String LOG4J_PROPERTIES="log4j-init-file";

	private void loadFile(String prefix,String file){
		try{
			Properties pro=new Properties();	
			pro.load(new FileInputStream(prefix+file));
			StringTokenizer tok=new StringTokenizer(pro.get("name").toString(),",");
			String key;
			String value;
			while(tok.hasMoreTokens()){
				key=tok.nextToken().replaceAll(" ","");	
				value=pro.get(key+".File").toString();
				pro.put("log4j.appender."+key+".File",getServletContext().getRealPath("/")+value);
			}
			file_pro=prefix+file+".temporany";
			pro.store(new FileOutputStream(file_pro),"Temporani log4j.properties");
		}catch(Exception e){
			file_pro=null;
		}
	}

	public void init() {
		String prefix = getServletContext().getRealPath("/");
		String file = getInitParameter(LOG4J_PROPERTIES);
		
		loadFile(prefix,file);
		
		// if the log4j-init-file is not set, then no point in trying
		if(file_pro != null) {
			PropertyConfigurator.configure(file_pro);
		}else{
			if(file!=null){
				PropertyConfigurator.configure(prefix+file);
			}
		}
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
	}

	public void destroy(){
		try{
			new File(file_pro).delete();
			Logger logger=Logger.getRootLogger();
			logger.warn("********** end context ***********");
		}catch(Exception e){}
	}
}