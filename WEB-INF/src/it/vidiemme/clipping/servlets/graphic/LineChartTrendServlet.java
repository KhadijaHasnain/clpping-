package it.vidiemme.clipping.servlets.graphic;

import java.io.*;
import java.util.*;
import java.awt.*;
import java.awt.image.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.imageio.ImageIO;
import com.java4less.rchart.*;

/**
 * Servlet di creazione grafici composti da linee per il report TREND
 */
public class LineChartTrendServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		LineDataSerie data = null;
		
		OutputStream out = response.getOutputStream();

		String strTitolo = session.getAttribute("Title").toString();
		String strYlabel = session.getAttribute("xLabel").toString();
		String strXlabel = session.getAttribute("yLabel").toString();
		String[] trends = (String[])session.getAttribute("legend");
		Hashtable valuesHashGlobal = (Hashtable)session.getAttribute("values");
		
		double[] values = new double[0];
		String[] labelXAxis = new String[0];
		double max_value = 0;
		if(valuesHashGlobal.get("MONTHS")!=null){
			labelXAxis = (String[])valuesHashGlobal.get("MONTHS");
		}

		for (int j = 0; j < trends.length; j++) {
			values = (double[])valuesHashGlobal.get(trends[j]);
			for (int i = 0; i < values.length; i++) {
				if(values[i] > max_value){
					max_value = values[i];
				}
			}
		}
		
                // creazione array dei colori
		Color[] colors = new Color[]{
			Color.RED,
			Color.BLUE,
			Color.GREEN,
			Color.GRAY,
			Color.YELLOW,
			Color.BLACK,
			Color.ORANGE,
			Color.PINK,
			Color.CYAN,
			Color.MAGENTA
		};
		
		// create title
		com.java4less.rchart.Title title = new Title(strTitolo);
		title.font = new Font("Arial",Font.BOLD,25);
		
		// create axis
		com.java4less.rchart.Axis  XAxis = new Axis(Axis.HORIZONTAL,new Scale());
		com.java4less.rchart.Axis  YAxis = new Axis(Axis.VERTICAL,new Scale());
		
		YAxis.tickAtBase = true; // draw also first tick
		XAxis.tickAtBase = true;
		
		YAxis.scale.min = 0;
		YAxis.scale.max = max_value;
		XAxis.scale.min = 0;
		XAxis.scale.max = labelXAxis.length;
		
		XAxis.IntegerScale = true;
		YAxis.IntegerScale = true;
		XAxis.scaleTickInterval = 1;
                if(YAxis.scale.max > 20){
                    YAxis.scaleTickInterval = YAxis.scale.max/15;
                }else{
                    YAxis.scaleTickInterval = YAxis.scale.max/2;
                }
		// Griglia orizzontale
                XAxis.gridStyle = new LineStyle(0.2f,java.awt.Color.LIGHT_GRAY, LineStyle.LINE_NORMAL);
                // Griglia verticale
                YAxis.gridStyle = new LineStyle(0.2f,java.awt.Color.LIGHT_GRAY, LineStyle.LINE_NORMAL);
                
		// plotter
		com.java4less.rchart.LinePlotter plot = new LinePlotter();

		// create chart
		com.java4less.rchart.Chart chart = new Chart(title,plot,XAxis,YAxis);
		chart.leftMargin = 0.15;
		chart.topMargin = 0.05;
		chart.bottomMargin = 0.1;
		chart.rightMargin = 0;
		// font delle labels sulle tacche
		chart.XAxis.DescFont = new Font("Arial",Font.ITALIC,15); 
		chart.YAxis.DescFont = new Font("Arial",Font.ITALIC,15);
		chart.setSize(800,800);
		
		// prende l'array di double per il trend selezionato dall'utente e ne genera la dataserie
		for (int i = 0; i < trends.length; i++) {
			data = new LineDataSerie((double[])valuesHashGlobal.get(trends[i]), new LineStyle(1.5f,colors[i%colors.length],LineStyle.LINE_NORMAL));
			data.drawPoint = true;
			data.pointColor = colors[i%colors.length];
			//data.valueFont = new Font("Arial",Font.BOLD,15);
			data.valueColor = colors[i%colors.length]; 
			chart.addSerie(data);
		}

		// legenda
		Legend legend = new Legend();
		legend.background = new FillStyle(Color.WHITE);
		for (int i = 0; i < trends.length; i++) {
			legend.addItem(trends[i], new LineStyle(0.5f,colors[i%colors.length],LineStyle.LINE_NORMAL));
		}
		legend.border = new LineStyle(0.2f, Color.BLACK, LineStyle.LINE_NORMAL);
		legend.font = new Font("Arial",Font.ITALIC,15);
		chart.legend = legend;
		chart.layout = chart.LAYOUT_LEGEND_BOTTOM;

		// labels che affiancano gli assi
		VAxisLabel YLabel = new VAxisLabel(strXlabel,java.awt.Color.black,new Font("Arial",Font.BOLD,15));
		HAxisLabel XLabel = new HAxisLabel(strYlabel,java.awt.Color.black,new Font("Arial",Font.BOLD,15));
		chart.YLabel = YLabel;
		chart.XLabel = XLabel;

		// labels dei mesi sull'asse x (01=Jan, 02=Feb, ...)
		XAxis.tickLabels = labelXAxis;

		// background di chart e plotter
		chart.back = new FillStyle(new java.awt.Color(1f,1f,1f));
		plot.back = new FillStyle(new java.awt.Color(1.0f,1.0f,0.75f));
                //chart.back = new FillStyle(Color.WHITE);
                //plot.back = new FillStyle(Color.WHITE);

		// create image
		BufferedImage image = new BufferedImage(800,800,BufferedImage.TYPE_INT_RGB);
		Graphics imgGraphics = image.createGraphics();

		// paint chart on image
		chart.paint(imgGraphics);
		ImageIO.write(image, "bmp", out);
		out.close();
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
	
	/**
	 * Metodo che gestisce le chiamate in GET alla servlet
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
