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
 * Servlet di creazione grafici composti da linee
 */
public class LineChartServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		double[] values = null;
		LineDataSerie data = null;
		
		OutputStream out = response.getOutputStream();

		String strTitolo = session.getAttribute("Title").toString();
		String strYlabel = session.getAttribute("xLabel").toString();
		String strXlabel = session.getAttribute("yLabel").toString();
		String[] labelXAxis = (String[])session.getAttribute("labelXAxis");
		ArrayList<String> audienceList = (ArrayList)session.getAttribute("legendList");
		Hashtable<String, double[]> chartHash = (Hashtable)session.getAttribute("chartHash");
		double max_value = Double.parseDouble(session.getAttribute("max_value").toString());
		
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
                //YAxis.scaleTickInterval = YAxis.scale.max/12;
		YAxis.scaleTickInterval = YAxis.scale.max/15;
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
		
		// scorre audienceList per generare le dataserie
		for(int i=0; i<audienceList.size(); i++){
			String audience = audienceList.get(i).toString();
			values = chartHash.get(audience);
			data = new LineDataSerie(values, new LineStyle(1.5f,colors[i%colors.length],LineStyle.LINE_NORMAL));
			data.drawPoint = true;
			data.pointColor = colors[i%colors.length];
			//data.valueFont = new Font("Arial",Font.BOLD,15);
			data.valueColor = colors[i%colors.length]; 
			chart.addSerie(data);
		}

		// legenda
		Legend legend = new Legend();
		legend.background = new FillStyle(Color.WHITE);
		for(int i=0; i<audienceList.size(); i++){
			legend.addItem(audienceList.get(i).toString(), new LineStyle(0.5f,colors[i%colors.length],LineStyle.LINE_NORMAL));
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
