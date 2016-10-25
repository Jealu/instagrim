/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

@WebServlet(urlPatterns = {
    "/Profile",
    "/Profile/*"
})
@MultipartConfig

/**
 *
 * @author Agrail
 */
public class EditProfile extends HttpServlet {
    Cluster cluster=null;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String args[] = Convertors.SplitRequestPath(request);
        PicModel tm = new PicModel();
        User u = new User();
        u.setCluster(cluster);
        tm.setCluster(cluster);
        java.util.LinkedList<String> othersPro = u.getUserProfile(args[2]);
        java.util.LinkedList<Pic> othersPic = tm.getPicsForUser(args[2]);
        java.util.UUID picid = u.getUserPic(args[2]);
        RequestDispatcher rd = request.getRequestDispatcher("/viewOthers.jsp");
        request.setAttribute("othersPic", othersPic);
        request.setAttribute("userPic", picid);
        request.setAttribute("othersPro", othersPro);
        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part part = request.getPart("upfile");
        System.out.println("Part Name " + part.getName());
        String type = part.getContentType();
        String filename = part.getSubmittedFileName();
        InputStream is = request.getPart(part.getName()).getInputStream();
        int i = is.available();
        HttpSession session=request.getSession();
        LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
        String username="majed";
        if (lg.getlogedin()){
            username=lg.getUsername();
        }
        if (i > 0) {
            byte[] b = new byte[i + 1];
            is.read(b);
            System.out.println("Length : " + b.length);
            PicModel tm = new PicModel();
            tm.setCluster(cluster);
            String message = " ";
            java.util.UUID picid = tm.insertPic(b, type, filename, username,message);
            session.setAttribute("picid", picid);
            is.close();
        }
        
        
        PrintWriter out = response.getWriter();
        User u = new User();
        u.setCluster(cluster);
        String first_name = (String)request.getParameter("first_name");
        String last_name = (String)request.getParameter("last_name");
        String interest = (String)request.getParameter("interest");
        String email = (String)request.getParameter("email");
        String address = (String)request.getParameter("address");
        out.println(first_name);
        java.util.UUID picid;
        picid = (java.util.UUID)session.getAttribute("picid");
        u.setUserProfile(username,first_name,last_name,interest,email,address,picid);
        java.util.LinkedList<String> userProfile = u.getUserProfile(username);
        session.setAttribute("profile",userProfile);
        RequestDispatcher rd=request.getRequestDispatcher("profile.jsp");
	rd.forward(request,response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
