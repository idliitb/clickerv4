package clicker.v4.report;

import java.awt.Color;
import java.awt.Paint;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * Servlet implementation class GenerateChartRemote
 */
public class GenerateChartRemote extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateChartRemote() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request,response);
	}
	
	/**
	 * This method is used to generate the pie chart based on chart category
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/png");            
        String chartType = request.getParameter("charttype");     
        System.out.println("Chart type" + chartType);
        HttpSession session = request.getSession(true);
        String username= session.getAttribute("CoordinatorID").toString();       
        System.out.println("Inside Generate Chart");
        int maxval=0;
        String path = getServletContext().getRealPath("/");
        System.out.println(path);        
        folderCreateOrDelete(path, username);
        try {
        	DefaultCategoryDataset barDataset = new DefaultCategoryDataset();
            if (chartType.equals("QuizResponseChart")){            	
            	RemoteReportHelper reportHelper = new RemoteReportHelper();
            	String qid = request.getParameter("qid");
            	String qts = request.getParameter("qts");
            	String wid =  session.getAttribute("WorkshopID").toString();
            	String questionIDpatten = reportHelper.getQuestionIDs(qid, wid);
            	System.out.println(questionIDpatten);
            	String questionIDs[] = questionIDpatten.split("@");
            	session.setAttribute("QuestionIDs", questionIDs);            	
            	int noofQuestions = questionIDs.length;            	
            	StringBuffer correctAns = new StringBuffer("");
            	for(int j=0;j<noofQuestions;j++){
            		System.out.println(questionIDs[j]);
            		if(!questionIDs[j].equals("")){
	            		String Responses_Answer = reportHelper.getQuestionResponse(questionIDs[j],qid,qts);
	            		String allResponses = Responses_Answer.split("@")[0];
	            		System.out.println(allResponses);	     
	            		String ans = Responses_Answer.split("@")[1];
	            		correctAns.append(ans.replace(";", "") + "@");
	            		if(!allResponses.equals("")){
	                	String responses[] = allResponses.split(";");	    
	                	DefaultCategoryDataset barDataset1 = new DefaultCategoryDataset();
	                    for(int i=0; i<responses.length;i++){
	                    	if(Integer.parseInt(responses[i].split("=")[1])>maxval)
	                    		maxval = Integer.parseInt(responses[i].split("=")[1]);	                    	
	                        barDataset1.setValue(Integer.parseInt(responses[i].split("=")[1]), "Incorrect",responses[i].split("=")[0] );                    
	                    }	            	
	                    String chartInfo[] = {"Question - " + (j+1), "Responses", "No of Responses"};
	                    responseChart(path, username, chartInfo, maxval, barDataset1,"Chart"+j, ans);
            		}
            		}
            	}
            	session.setAttribute("correctAns", correctAns);            	
            }
            else if (chartType.equals("QuizResultChart")){
            	RemoteReportHelper reportHelper = new RemoteReportHelper();
            	String cid = session.getAttribute("WorkshopID").toString();
            	String qid = request.getParameter("qid");
            	String qts = request.getParameter("qts");
            	System.out.println("ResultChart   -  " + cid + qid + qts);
            	String allResult = reportHelper.getQuizResult(cid, qid, qts);
            	System.out.println(allResult);
            	String[] percentages = allResult.split("@")[0].split(";");
                for(int i=0; i<percentages.length;i++){
                	if(Integer.parseInt(percentages[i].split("=")[1])>maxval)
                		maxval = Integer.parseInt(percentages[i].split("=")[1]);
                    barDataset.setValue(Integer.parseInt(percentages[i].split("=")[1]), "Result", percentages[i].split("=")[0]);                    
                }
                String chartInfo[] = {"Quiz Reult", "Percentage", "No. of Student"};
                chartMaker(path, username, chartInfo, maxval, barDataset, "RemoteQuizResult");
                
                DefaultCategoryDataset barDataset1 = new DefaultCategoryDataset();
                String grades[] = allResult.split("@")[1].split(";");
                for(int i=0; i<grades.length;i++){
                	barDataset1.setValue(Integer.parseInt(grades[i].split("=")[1]), "Grade", grades[i].split("=")[0]);                    
                }
                String gradeChartInfo[] = {"Quiz Grade", "Grade", "No. of Student"};
                chartMaker(path, username, gradeChartInfo, maxval, barDataset1, "RemoteQuizGrade");
                session.setAttribute("topPercentage", allResult.split("@")[2]);
            }
            else if (chartType.equals("Attendance")){
            	ReportHelper reportHelper = new ReportHelper();
            	String cid = request.getParameter("cid");
            	String date = request.getParameter("date");
            	String sn = request.getParameter("session");
            	String attendance = reportHelper.getAttendance(cid, date, sn);
            	System.out.println(attendance);
            	String status[] = attendance.split(";");
                for(int i=0; i<status.length;i++){
                	if(Integer.parseInt(status[i].split("=")[1])>maxval)
                		maxval = Integer.parseInt(status[i].split("=")[1]);
                    barDataset.setValue(Integer.parseInt(status[i].split("=")[1]),"Attendance", status[i].split("=")[0]);                    
                }
                String chartInfo[] = {"Attendance", "Status", "No of Students"};
                chartMaker(path, username, chartInfo, maxval, barDataset, "Attendance");
            }else if (chartType.equals("RemoteAttendance")){
            	RemoteReportHelper reportHelper = new RemoteReportHelper();
            	String cid = request.getParameter("cid");
            	String date = request.getParameter("date");
            	String sn = request.getParameter("session");
            	String attendance = reportHelper.getAttendance(cid, date, sn);
            	System.out.println(attendance);
            	String status[] = attendance.split(";");
                for(int i=0; i<status.length;i++){
                	if(Integer.parseInt(status[i].split("=")[1])>maxval)
                		maxval = Integer.parseInt(status[i].split("=")[1]);
                    barDataset.setValue(Integer.parseInt(status[i].split("=")[1]),"Attendance", status[i].split("=")[0]);                    
                }
                String chartInfo[] = {"Attendance", "Status", "No of Students"};
                chartMaker(path, username, chartInfo, maxval, barDataset, "RemoteAttendance");
            }
            else if (chartType.equals("instantquizchart")){
            	ReportHelper reportHelper = new ReportHelper();
            	String qid = request.getParameter("qid");
            	String instantresponse = reportHelper.getInstantResponse(qid);
            	System.out.println(instantresponse);
            	String allResponses = instantresponse.split("@")[0];
        		System.out.println(allResponses);	     
        		String ans = instantresponse.split("@")[1];
        		//StringBuffer correctAns.append(ans.replace(";", "") + "@");
        		if(!allResponses.equals("")){
            	String responses[] = allResponses.split(";");	    
            	DefaultCategoryDataset barDataset1 = new DefaultCategoryDataset();
                for(int i=0; i<responses.length;i++){
                	if(Integer.parseInt(responses[i].split("=")[1])>maxval)
                		maxval = Integer.parseInt(responses[i].split("=")[1]);	                    	
                    barDataset1.setValue(Integer.parseInt(responses[i].split("=")[1]), "Incorrect",responses[i].split("=")[0] );                    
                }            	
                String chartInfo[] = {"Instant Quiz", "Responses", "No of Responses"};
                responseChart(path, username, chartInfo, maxval, barDataset1,"InstantChart", ans);    		
        		}
            }else if (chartType.equals("InstantQuizResponseChart")){            	
            	RemoteReportHelper reportHelper = new RemoteReportHelper();
            	String qid = request.getParameter("qid");
            	//String qts = request.getParameter("qts");
            	String questionIDpatten = reportHelper.getInstantQuestionIDs(qid);
            	System.out.println(questionIDpatten);
            	String questionIDs[] = questionIDpatten.split("@");
            	session.setAttribute("QuestionIDs", questionIDs);            	
            	int noofQuestions = questionIDs.length;            	
            	for(int j=0;j<noofQuestions;j++){
            		System.out.println(questionIDs[j]);
            		if(!questionIDs[j].equals("")){
	            		String Responses_Answer = reportHelper.getInstantQuestionResponse(Integer.parseInt(qid),questionIDs[j]);
	            		String allResponses = Responses_Answer.split("@")[0];
	            		System.out.println(allResponses);	     
	            		String ans = Responses_Answer.split("@")[1];
	            		if(!allResponses.equals("")){
	                	String responses[] = allResponses.split(";");	    
	                	DefaultCategoryDataset barDataset1 = new DefaultCategoryDataset();
	                    for(int i=0; i<responses.length;i++){
	                    	if(Integer.parseInt(responses[i].split("=")[1])>maxval)
	                    		maxval = Integer.parseInt(responses[i].split("=")[1]);	                    	
	                        barDataset1.setValue(Integer.parseInt(responses[i].split("=")[1]), "Incorrect",responses[i].split("=")[0] );                    
	                    }	            	
	                    String chartInfo[] = {"Question - " + (j+1), "Responses", "No of Responses"};
	                    responseChart(path, username, chartInfo, maxval, barDataset1,"RemoteChart"+j, ans);
            		}
            		}
            	}
            }
            else if(chartType.equals("PollResponseChart")){
            	RemoteReportHelper reportHelper = new RemoteReportHelper();
            	String pid = request.getParameter("pid");
            	String pollresponse = reportHelper.getPollResponse(pid);
            	System.out.println("" + pollresponse);
            	String allResponses = pollresponse.split("@")[0];
        		System.out.println(allResponses);	     
        		String ans = pollresponse.split("@")[1];
        		if(!allResponses.equals("")){
            	String responses[] = allResponses.split(";");	    
            	DefaultCategoryDataset barDataset1 = new DefaultCategoryDataset();
                for(int i=0; i<responses.length;i++){
                	if(Integer.parseInt(responses[i].split("=")[1])>maxval)
                		maxval = Integer.parseInt(responses[i].split("=")[1]);	                    	
                    barDataset1.setValue(Integer.parseInt(responses[i].split("=")[1]), "Incorrect",responses[i].split("=")[0] );                    
                }            	
                String chartInfo[] = {"Poll", "Responses", "No of Responses"};
                responseChart(path, username, chartInfo, maxval, barDataset1,"PollChart", ans);    		
        		}
            }    
        }
        catch (Exception e)
        {
           System.out.println(e.toString());
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
		            } else {
		                f.delete();
		            }
		        }
		    }
		    System.out.println("Folder Content is deleted");
		}
	}
	
	public void chartMaker(String path, String username, String[] chartInfo, int maxval, DefaultCategoryDataset barDataset, String chartname){
		try{
			
			JFreeChart chart=null;
			chart= ChartFactory.createBarChart(chartInfo[0], chartInfo[1], chartInfo[2], barDataset, PlotOrientation.VERTICAL, false, true, false);		
			
            chart.setBackgroundPaint(Color.white);
            CategoryPlot plot = (CategoryPlot) chart.getPlot();
                        
            final CategoryItemRenderer rendererDiffColor = new DifferentColorRenderer(
                    new Paint[] {Color.red, Color.blue, Color.green,
                        Color.yellow, Color.orange, Color.cyan,
                        Color.magenta, Color.blue}
                );
            
            plot.setRenderer(rendererDiffColor);
            
            chartLayout(chart, plot, path, username, chartname, maxval);
           
		}catch(Exception e){
			e.getStackTrace();
		}
	}
	
	//Overload for quiz chart with out delete folder
	public void responseChart(String path, String username, String[] chartInfo, int maxval, DefaultCategoryDataset barDataset, String chartname, String answers){
		try{						
			GreenRedBarRenderer colorGreenRed = new GreenRedBarRenderer();

			if (!answers.contains(";")) {
				colorGreenRed.setCorrect(answers);
			} else if (answers.contains(";")){
				String answersArray [] = answers.split(";");
				for (int i = 0; i < answersArray.length; i++) {
					colorGreenRed.setCorrect(answersArray[i]);
				}
			}
			
			JFreeChart chart=null;
			chart= ChartFactory.createBarChart(chartInfo[0], chartInfo[1], chartInfo[2], barDataset, 
					PlotOrientation.VERTICAL, true, true, false);		
			
			chart.setBackgroundPaint(Color.white);
            CategoryPlot plot = (CategoryPlot) chart.getPlot();
                        
           	// Set the Legend for chart
            java.awt.Shape shape = new java.awt.geom.Rectangle2D.Double(-4.0,
            		-4.0, 8.0, 8.0);            
            org.jfree.chart.LegendItemCollection legend = plot.getLegendItems();
            
            legend.add(new org.jfree.chart.LegendItem(
						new java.text.AttributedString("Correct"), "", "", "",
						shape, java.awt.Color.GREEN));
            plot.setFixedLegendItems(legend);
            // set green color for correct answers
            plot.setRenderer(colorGreenRed); 
                
			chartLayout(chart, plot, path, username, chartname, maxval);
		}catch(Exception e){
			e.getStackTrace();
		}
	}
	
	public void chartLayout(JFreeChart chart, CategoryPlot plot, String path, String username, String chartname, int maxval){
		try{			
        
		//Object for riderer
        BarRenderer renderer = (BarRenderer) plot.getRenderer();
		
		// set plot background color
        plot.setBackgroundPaint(Color.white);
        
        // set y axis label size
        plot.getDomainAxis().setLabelFont( plot.getDomainAxis().getLabelFont().deriveFont(new Float(16)) );
        
        // set tick label (bar value label) size
        plot.getDomainAxis().setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(12)));           
                   
        // Range Axis font size
        NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
        rangeAxis.setLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(16)));
        rangeAxis.setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(14)));
        // set the upper margin for inside chart
        rangeAxis.setUpperMargin(0.1);

        // Show value on bar chart
        renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
        renderer.setBaseItemLabelsVisible(true);
        
        // set font for inner barchart label
        renderer.setBaseItemLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(15)));
        rangeAxis.setTickUnit(new NumberTickUnit( (int)maxval/5 == 0 ? 1 : (int)maxval/5 , new DecimalFormat("0")));
        File file = new File(path + username + "/"+chartname+".jpeg");
		ChartUtilities.saveChartAsJPEG(file, chart, 450, 300);
        //ChartUtilities.writeChartAsPNG(out, chart, 800, 600);
		//out.close();
		}catch(Exception e){
			e.getStackTrace();
		}
	}
	
	class GreenRedBarRenderer extends BarRenderer {
		private static final long serialVersionUID = 1L;
		private String correct;

		public GreenRedBarRenderer() {
			super();
			correct="";
		}

		public void setCorrect(String c) {
			correct = correct + c;
		}

		public Paint getItemPaint(int x, int y) {
			org.jfree.data.category.CategoryDataset dataset = this.getPlot()
					.getDataset();
			String key = (String) dataset.getColumnKey(y);
			if (correct.equalsIgnoreCase(key)) {
				return java.awt.Color.GREEN;
			} else {
				return java.awt.Color.RED;
			}
		}
	}
	
	 class DifferentColorRenderer extends BarRenderer {
	        private static final long serialVersionUID = 1L;
			/** The colors. */
	        private Paint[] colors;

	        /**
	         * Creates a new renderer.
	         *
	         * @param colors  the colors.
	         */
	        public DifferentColorRenderer(final Paint[] colors) {
	            this.colors = colors;
	        }

	        /**
	         * Returns the paint for an item.  Overrides the default behaviour inherited from
	         * AbstractSeriesRenderer.
	         *
	         * @param row  the series.
	         * @param column  the category.
	         *
	         * @return The item color.
	         */
	        public Paint getItemPaint(final int row, final int column) {
	            return this.colors[column % this.colors.length];
	        }
	    }

}
