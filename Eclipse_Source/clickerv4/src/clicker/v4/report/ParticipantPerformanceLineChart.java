package clicker.v4.report;

import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * Servlet implementation class ParticipantPerformanceLineChart
 */
public class ParticipantPerformanceLineChart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ParticipantPerformanceLineChart() {
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
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		String sname="";
		int i=1;
		DatabaseConnection dbcon = new DatabaseConnection();   
		HttpSession session = request.getSession();
		String path = getServletContext().getRealPath("/");        
		String qtype = request.getParameter("qtype");
        try {
        	  con =dbcon.createRemoteDatabaseConnection();
        	  if(qtype.equals("nquiz")){
        		  pst = con.prepareStatement("select ParticipantName, if(per<=0 || isNull(per),0.0, per) as Percentage from (select sq.ParticipantName, sum((sq.Credit * sq.correct)-(sq.NegativeMark * (NOT sq.correct) * sq.NegativeMarking * sq.isNoResponse)) / sum(sq.Credit) * 100 as per  from (select distinct qr.TimeStamp, p.ParticipantName, qr.NegativeMarking, if(qrq.Response='Z' or qrq.Response='',0,1) as isNoResponse, qst.QuestionID, qst.Credit, qst.NegativeMark, if((count(*) = sum(o.OptionCorrectness) and count(*) in (SELECT count(*) FROM options oo where oo.QuestionID = qst.QuestionID and oo.OptionCorrectness = 1) ),1,0) as correct from quiz q, quizrecord qr, quizrecordquestion qrq, participant p, options o, question qst where q.WorkshopID=? and qr.QuizID = q.QuizID and qrq.QuizRecordID = qr.QuizRecordID and qrq.ParticipantID=p.ParticipantID and qrq.ParticipantID=? and o.OptionID = qrq.OptionID and qst.QuestionID = qrq.QuestionID group by p.ParticipantID, qst.QuestionID, qrq.QRTimeStamp) sq group by sq.TimeStamp order by sq.TimeStamp desc) as msq");
        	  }else{
        		  pst = con.prepareStatement("select sq.ParticipantName, Round(sum(sq.correct) / count(sq.correct) *100) as Percentage from (select distinct q.QuizDate, qrq.IQuizID, p.ParticipantName, qst.IQuestionID, if(qrq.Response=qst.CorrectAns,1,0) as correct from instantquiznew q, instantquizresponsenew qrq, participant p, instantquestion qst where q.WorkshopID=? and qrq.IQuizID = q.IQuizID and qrq.ParticipantID=p.ParticipantID and qrq.ParticipantID=? and qst.IQuestionID = qrq.IQuestionID group by p.ParticipantID, qst.IQuestionID, qrq.QTimeStamp) as sq group by sq.IQuizID");
        	  }              
              String wid = session.getAttribute("WorkshopID").toString();
              String instid = session.getAttribute("CoordinatorID").toString();
              String pid = request.getParameter("pid");
              pst.setString(1, wid);
              pst.setString(2, pid);
              rs = pst.executeQuery();
               
               // Define the data for the line chart
               XYSeriesCollection line_chart_dataset=new XYSeriesCollection();
               XYSeries s = new XYSeries("Performance");
               while(rs.next()){
               	s.add(i++, rs.getInt(2));                	
               	sname = rs.getString(1);
               }
               line_chart_dataset.addSeries(s);
               // Designing the chart 
               JFreeChart lineChartObject=ChartFactory.createXYLineChart(sname + " Quiz Preformance","Quizzes","Mark in Percentage", line_chart_dataset,PlotOrientation.VERTICAL,true,true,false);
               
               // set chart background transparent
               lineChartObject.setBackgroundPaint(new Color(255,255,255,0));
               XYPlot plot = (XYPlot) lineChartObject.getPlot();
               
               // set plot background transparent
               plot.setBackgroundPaint( new Color(255,255,255,0) );
               
               final XYLineAndShapeRenderer renderer = new XYLineAndShapeRenderer();
               renderer.setBaseShapesVisible(true);
               renderer.setBaseLinesVisible(true);
               plot.setRenderer(renderer);
               
               // set y axis label size
               plot.getDomainAxis().setLabelFont( plot.getDomainAxis().getLabelFont().deriveFont(new Float(16)) );
               
               // set tick label size
               plot.getDomainAxis().setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(12)));           
               
               // Range Axis font size
               NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
               rangeAxis.setLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(16)));
               rangeAxis.setTickLabelFont(plot.getDomainAxis().getLabelFont().deriveFont(new Float(14)));
               // set the upper margin for inside chart
               rangeAxis.setUpperMargin(0.1);                
               
               // Write line chart to a file               
               int width=420;
               int height=320;
               folderCreateOrDelete(path, instid);
               File lineChart=new File(path+instid+"/participantResult.png");              
               ChartUtilities.saveChartAsPNG(lineChart,lineChartObject,width,height);
				
        }
        catch (SQLException ex)
        {
           ex.printStackTrace();
        }catch (IOException e) {
			e.printStackTrace();
		 }finally{
			 if(rs!=null)
				try {rs.close();} catch (SQLException e) {
					e.printStackTrace();
				}
			 if(pst!=null)
				try {pst.close();} catch (SQLException e) {
					e.printStackTrace();
				}
			 if(con!=null)
				dbcon.closeRemoteConnection(con);
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

}
