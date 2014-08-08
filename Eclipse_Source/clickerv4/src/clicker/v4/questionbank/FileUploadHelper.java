package clicker.v4.questionbank;

import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.apache.tomcat.util.http.fileupload.FileItem;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
//import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This Class gets the Servlet Context and the path of Uploaded XLS File. Servlet implementation class FileUploadHelper
 */
//@WebServlet("/fileuploader")
public class FileUploadHelper extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadHelper() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	private File file;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("In servlet");
		FileItemFactory factory=new DiskFileItemFactory();
		ServletFileUpload upload=new ServletFileUpload(factory);
		boolean fileFlag=ServletFileUpload.isMultipartContent(request);
		List<FileItem> items=null;
		System.out.println("File Flag:"+fileFlag);
		
		if(fileFlag){
			try{
				items=upload.parseRequest(request);
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
			for(FileItem item:items){
				if(!item.isFormField()&&!item.getName().equals("")){
					String fileName = new File(item.getName()).getName();
					System.out.println("The File Name :"+item.getName());
					item.getName();
					ServletContext context = getServletContext();
					String pathurl = context.getRealPath("/uploads");
					file=new File(pathurl + "/" + fileName);
					
					System.out.println("FilePath: " + file.getPath());
					//System.out.println("File: " + new File(item.getName()).getAbsolutePath());
					try {
						item.write(file);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println("File Uploaded.");
				}
			}
		}
		
		//XLSimport xls=new XLSimport();
			//String status=xls.readQuestionXLSFile(file);
			
			//response.sendRedirect("jsp/QuestionBank/questionbank.jsp?fileuploadstatus=" + status);
			//return;
	}

}
