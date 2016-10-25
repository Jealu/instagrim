/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

@WebServlet(urlPatterns = {
    "/Publish",
    "/Publish/*"
})
@MultipartConfig

/**
 *
 * @author Agrail
 */
public class publish extends HttpServlet {

    
    private Cluster cluster;
    
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet publish</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet publish at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
        DisplayImage(Convertors.DISPLAY_IMAGE,args[2], request, response);
        RequestDispatcher rd = request.getRequestDispatcher("/publish.jsp");
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
        HttpSession Session=request.getSession();
        java.util.UUID picid = (java.util.UUID)Session.getAttribute("uploadPic");
        String message = request.getParameter("message");
        String i = request.getParameter("radio");
        Session session = cluster.connect("instagrim");
        ByteBuffer bImage = null;
        String type = null;
        int length = 0;
        
        Convertors convertor = new Convertors();
        ResultSet rs = null;
        PreparedStatement ps = null;
        if (i.compareTo("111")==1){
            ps = session.prepare("select processed from Pics where picid =?");
            BoundStatement boundStatement = new BoundStatement(ps);
            rs = session.execute(boundStatement.bind(picid));
            for (Row row : rs){
                PreparedStatement p = session.prepare("UPDATE Pics SET image = ? WHERE picid = ?");
                BoundStatement bound = new BoundStatement(p);
                bImage = row.getBytes("processed");
                session.execute(bound.bind(bImage,picid));
            }
        }
            Session.setAttribute("uploadPic",null);
        PreparedStatement p = session.prepare("UPDATE pics SET message = ? WHERE picid = ?");
        BoundStatement bound = new BoundStatement(p);
        session.execute(bound.bind(message,picid));
        RequestDispatcher rd = request.getRequestDispatcher("/UsersPics.jsp");
        rd.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */



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
}
