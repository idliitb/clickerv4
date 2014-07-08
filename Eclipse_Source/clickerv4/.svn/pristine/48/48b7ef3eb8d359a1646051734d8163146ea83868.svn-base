package clicker.v4.report;

import java.awt.Color;
import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 * 
 * @author rajavel
 * Servlet implementation class QuizLineChart
 */
public class QuizLineChart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizLineChart() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response){
		int i=1;
		HttpSession session = request.getSession();
		String path = getServletContext().getRealPath("/");   
		String instid =null;
		if(session.getAttribute("InstructorID")!=null){
			instid = session.getAttribute("InstructorID").toString();
		}
        if(instid==null){
        	instid = session.getAttribute("CoordinatorID").toString();
        }
        String cid="";
        if(request.getParameter("cid")!=null){
			cid = request.getParameter("cid");
		}
        String chartdata[] = request.getParameter("chartdata").split("~@~");
        System.out.println("length : " + chartdata.length);
        String nqchartdata[]=null;
        if(chartdata.length>0){
        	nqchartdata = chartdata[0].split("~!~");
        }
        String iqchartdata[]=null;
        if(chartdata.length==2){
        	iqchartdata = chartdata[1].split("~!~");
        }
        // Define the data for the line chart
        XYSeriesCollection line_chart_dataset=new XYSeriesCollection();
        XYSeries s = new XYSeries("Normal Quiz");
        if(nqchartdata!=null){
        	while(i < nqchartdata.length){
               	s.add(i, Integer.parseInt(nqchartdata[i])); 
               	i++;
        	}
        }
        line_chart_dataset.addSeries(s);
        i=1;
        XYSeriesCollection line_chart_dataset1=new XYSeriesCollection();
        XYSeries s1 = new XYSeries("Instant Quiz");
        if(iqchartdata!=null){
            while(i < iqchartdata.length ){
          	   s1.add(i, Integer.parseInt(iqchartdata[i])); 
          	   i++;
            }
        }             
        line_chart_dataset1.addSeries(s1);
        // Designing the chart 
        JFreeChart lineChartObject=ChartFactory.createXYLineChart("","","", line_chart_dataset,PlotOrientation.VERTICAL,true,true,false);
        // set chart background transparent
        lineChartObject.setBackgroundPaint(new Color(255,255,255,0));
        XYPlot plot = (XYPlot) lineChartObject.getPlot();
        plot.setDataset(1,line_chart_dataset1);              
        // set plot background transparent
        plot.setBackgroundPaint( new Color(255,255,255,0) );
        XYLineAndShapeRenderer renderer0 = new XYLineAndShapeRenderer(); 
        XYLineAndShapeRenderer renderer1 = new XYLineAndShapeRenderer(); 
        renderer0.setBaseShapesVisible(true);
        renderer0.setBaseLinesVisible(true);
        renderer1.setBaseShapesVisible(true);
        renderer1.setBaseLinesVisible(true);
        plot.setRenderer(0, renderer0); 
        plot.setRenderer(1, renderer1);              
               
        plot.getRendererForDataset(plot.getDataset(0)).setSeriesPaint(0, Color.red); 
        plot.getRendererForDataset(plot.getDataset(1)).setSeriesPaint(0, Color.blue);
               
        // set y axis label size
        plot.getDomainAxis().setLabelFont( plot.getDomainAxis().getLabelFont().deriveFont(new Float(12)) );
               
        // set tick label size
        plot.getDomainAxis().setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(12)));           
               
        // Range Axis font size
        NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
        rangeAxis.setLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(10)));
        rangeAxis.setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(10)));
        // set the upper margin for inside chart
        rangeAxis.setUpperMargin(0.1);                
        // Write line chart to a file               
        int width=450;
        int height=150;
        folderCreateOrDelete(path, instid);
        File lineChart=new File(path+instid+"/"+cid+"qpchart.png");              
        try {
			ChartUtilities.saveChartAsPNG(lineChart,lineChartObject,width,height);
		} catch (IOException e) {
			e.printStackTrace();
		}			
    }
	
	public void folderCreateOrDelete(String path, String username){
		boolean iscreated = (new File(path + username)).mkdir();
		if (iscreated) {
			System.out.println("Directory: " + path + username + " created");
		}else {	
			File folder = new File (path+username);
			File[] files = folder.listFiles();
		    if(files!=null) { //some JVMs return null for empty dirs
		        for(File f: files) {
		            if(f.isDirectory()) {
		               continue;
		            } else if(f.getName().equals("qpchart.png")){
		                f.delete();
		                System.out.println("Old image is deleted");
		            }
		        }
		    }
		}
	}

}
