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
 * Servlet di creazione grafici a barre verticali
 */
public class VerticalBarChartServlet extends HttpServlet {
	/**
	 * Metodo che gestisce le richieste
	 *
	 * @param request servlet request
	 * @param response servlet response
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		double[] values = null;
		BarDataSerie data = null;
		
		OutputStream out = response.getOutputStream();

		String strTitolo = session.getAttribute("Title").toString();
		String strYlabel = session.getAttribute("xLabel").toString();
		String strXlabel = session.getAttribute("yLabel").toString();
		String[] labelXAxis = (String[])session.getAttribute("labelXAxis");
		ArrayList<String> audienceList = (ArrayList)session.getAttribute("legendList");
		ArrayList<String> monthList = (ArrayList)session.getAttribute("monthList");
		Hashtable<String, double[]> chartHash = (Hashtable)session.getAttribute("chartHash");
		double max_value = Double.parseDouble(session.getAttribute("max_value").toString());
		double ampMonthAxis = 0.0;
		int max_month = labelXAxis.length;
		
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
		
		YAxis.scale.min = 0;
		YAxis.scale.max = max_value;
		XAxis.scale.min = 0;
		//XAxis.scale.max = labelXAxis.length;
		
		switch(max_month) {
			case 1:ampMonthAxis = 2;break;
			case 2:ampMonthAxis = 2.5;break;
			case 3:ampMonthAxis = 3.5;break;
			case 4:ampMonthAxis= 4.5;break;
			case 5:ampMonthAxis = 5.5;break;
			case 6:ampMonthAxis = 6.5;break;
			case 7:ampMonthAxis = 7.5;break;
			case 8:ampMonthAxis = 8.5;break;
			case 9:ampMonthAxis = 9.5;break;
			case 10:ampMonthAxis = 10.5;break;
			case 11:ampMonthAxis = 11.5;break;
			case 12:ampMonthAxis = 12.5;break;
		}
		
		XAxis.scale.max = ampMonthAxis;

		XAxis.IntegerScale = true;
		YAxis.IntegerScale = true;
		XAxis.scaleTickInterval = 1;
                //YAxis.scaleTickInterval = YAxis.scale.max/8;
		YAxis.scaleTickInterval = YAxis.scale.max/15;
                // Griglia orizzontale
                XAxis.gridStyle = new LineStyle(0.2f,java.awt.Color.LIGHT_GRAY, LineStyle.LINE_NORMAL);
                // Griglia verticale
                YAxis.gridStyle = new LineStyle(0.2f,java.awt.Color.LIGHT_GRAY, LineStyle.LINE_NORMAL);
		
		// plotter
		com.java4less.rchart.BarPlotter plot = new BarPlotter();
		plot.verticalBars = true;
		//plot.interBarSpace = 2;
		//plot.barWidth = 15;
		//plot.InterGroupSpace = 1;

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
			data = new BarDataSerie(values, new FillStyle(colors[i%colors.length]));
			//data.valueFont = new Font("Arial",Font.BOLD,15);
                        data.border = new LineStyle(0.2f,java.awt.Color.BLACK,LineStyle.LINE_NORMAL);
			chart.addSerie(data);
		}
		
		// legenda
		Legend legend = new Legend();
		legend.background = new FillStyle(Color.WHITE);
		for(int i=0; i<audienceList.size(); i++){
			legend.addItem(audienceList.get(i).toString(), new FillStyle(colors[i%colors.length]));
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
