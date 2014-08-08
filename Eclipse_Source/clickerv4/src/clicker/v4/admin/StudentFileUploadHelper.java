/* Author : Gobianth M
 * Use :for uploading the student xls file
 *  
 */
package clicker.v4.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class FileUploadHelper
 */
//@WebServlet("/studentfileuploader")
public class StudentFileUploadHelper extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentFileUploadHelper() {
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
		
		//System.out.println("In file upload helper servlet");
		FileItemFactory factory=new DiskFileItemFactory();
		ServletFileUpload upload=new ServletFileUpload(factory);
		boolean fileFlag=ServletFileUpload.isMultipartContent(request);
		List<FileItem> items=null;
		//System.out.println("File Flag:"+fileFlag);
		
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
					//System.out.println("The File Name :"+item.getName());
					item.getName();
					ServletContext context = getServletContext();
					String pathurl = context.getRealPath("/uploads");
					//System.out.println("Pathurl: " + pathurl);
					file=new File(pathurl + "/" + fileName);
					
					//System.out.println("FilePath: " + file.getPath());
					//System.out.println("File: " + new File(item.getName()).getAbsolutePath());
					try {
						item.write(file);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					//System.out.println("File Uploaded.");
				}
			}
		}
	}

}
