package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.utils.Bytes;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.HashMap;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.imgscalr.Scalr;
import static org.imgscalr.Scalr.*;
import org.imgscalr.Scalr.Method;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

/**
 * Servlet implementation class Image
 */
@WebServlet(urlPatterns = {
    "/Image",
    "/Image/*",
    "/Thumb/*",
    "/Filtered/*",
    "/Decolored/*",
    "/Large/*",
    "/Middle/*",
    "/Small/*",
    "/Images",
    "/Images/*"
})
@MultipartConfig

public class Image extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Cluster cluster;
    private HashMap CommandsMap = new HashMap();
    
    

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Image() {
        super();
        // TODO Auto-generated constructor stub
        CommandsMap.put("Image", 1);
        CommandsMap.put("Images", 2);
        CommandsMap.put("Thumb", 3);
        CommandsMap.put("Decolored", 5);
        CommandsMap.put("Small", 6);
        CommandsMap.put("Middle", 7);
        CommandsMap.put("Large", 8);
    }

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String args[] = Convertors.SplitRequestPath(request);
        int command;
        try {
            command = (Integer) CommandsMap.get(args[1]);
        } catch (Exception et) {
            error("Bad Operator", response);
            return;
        }
        switch (command) {
            case 1:
                DisplayImage(Convertors.DISPLAY_IMAGE,args[2], request, response);
                break;
            case 2:
                DisplayImageList(args[2], request, response);
                break;
            case 3:
                DisplayImage(Convertors.DISPLAY_THUMB,args[2], request, response);
                break;
            case 5:
                DisplayImage(Convertors.DISPLAY_DECOLORED,args[2], request, response);
                break;
            case 6:
                DisplayResized(Convertors.DISPLAY_IMAGE, 1, args[2], request,response);
                break;
            case 7:
                DisplayResized(Convertors.DISPLAY_IMAGE, 2, args[2], request,response);
                break;
            case 8:
                DisplayResized(Convertors.DISPLAY_IMAGE, 3, args[2], request,response);
                break;
            default:
                error("Bad Operator", response);
        }
    }

    private void DisplayResized(int Type, int size, String image, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        BufferedImage BI = ImageIO.read(new File("/var/tmp/instagrim/" + image));
        BufferedImage processed = BI;
        if(size==1){processed = resize(BI,Method.SPEED,Scalr.Mode.FIT_EXACT,100,100);}
        if(size==2){processed = resize(BI,Method.SPEED,Scalr.Mode.FIT_EXACT,250,300);}
        if(size==3){processed = resize(BI,Method.SPEED,Scalr.Mode.FIT_EXACT,500,600);}
        ImageIO.write(processed,"JPEG",response.getOutputStream());
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.UUID picid = java.util.UUID.fromString(image);
        String message = tm.getMessage(picid);
        HttpSession Session=request.getSession();
        Session.setAttribute("message", message);
        Session.setAttribute("currentPic", picid);
        Pic p = tm.getPic(Type,picid);
        response.setContentType(p.getType());
        response.setContentLength(p.getLength());
        /*ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(processed, p.getType(), baos);
        baos.flush();
        byte[] imageInByte = baos.toByteArray();
        baos.close();
        OutputStream out = response.getOutputStream();
        InputStream is = new ByteArrayInputStream(imageInByte);
        BufferedInputStream input = new BufferedInputStream(is);
        byte[] buffer = new byte[8192];
        for (int length = 0; (length = input.read(buffer)) > 0;) {
            out.write(buffer, 0, length);
        }
        out.close();*/
    }
    
    private void DisplayImageList(String User, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(User);
        RequestDispatcher rd = request.getRequestDispatcher("/UsersPics.jsp");
        request.setAttribute("Pics", lsPics);
        rd.forward(request, response);
    }
    

    private void DisplayImage(int type,String Image, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.UUID picid = java.util.UUID.fromString(Image);
        Pic p = tm.getPic(type,picid);
        String message = tm.getMessage(picid);
        HttpSession session=request.getSession();
        session.setAttribute("message", message);
        session.setAttribute("currentPic", picid);
        OutputStream out = response.getOutputStream();
        response.setContentType(p.getType());
        response.setContentLength(p.getLength());
        //out.write(Image);
        InputStream is = new ByteArrayInputStream(p.getBytes());
        BufferedInputStream input = new BufferedInputStream(is);
        byte[] buffer = new byte[8192];
        for (int length = 0; (length = input.read(buffer)) > 0;) {
            out.write(buffer, 0, length);
        }
        out.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        for (Part part : request.getParts()) {
            System.out.println("Part Name " + part.getName());
            String type = part.getContentType();
            String filename = part.getSubmittedFileName();
            InputStream is = request.getPart(part.getName()).getInputStream();
            int i = is.available();
            HttpSession session=request.getSession();
            LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
            String username="majed";
            String message=request.getParameter("message");
            if (lg.getlogedin()){
                username=lg.getUsername();
            }
            if (i > 0) {
                byte[] b = new byte[i + 1];
                is.read(b);
                System.out.println("Length : " + b.length);
                PicModel tm = new PicModel();
                tm.setCluster(cluster);
                java.util.UUID picid = tm.insertPic(b, type, filename, username, message);
                session.setAttribute("uploadPic", picid);
                java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(username);
                session.setAttribute("Pics", lsPics);
                is.close();
            }
           
            RequestDispatcher rd = request.getRequestDispatcher("/publish.jsp");
            rd.forward(request, response);
        }

    }

    private void error(String mess, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = null;
        out = new PrintWriter(response.getOutputStream());
        out.println("<h1>You have a na error in your input</h1>");
        out.println("<h2>" + mess + "</h2>");
        out.close();
        return;
    }
}