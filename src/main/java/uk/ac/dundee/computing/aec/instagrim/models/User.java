/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public boolean RegisterUser(String username, String Password, String first_name,String last_name,String email){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (login,password,first_name,last_name,email) Values(?,?,?,?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username,EncodedPassword,first_name,last_name,email));
        //We are assuming this always works.  Also a transaction would be good here !
        
        return true;
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
   
    
    return false;  
    }
       public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
    
    public void setUserProfile(String username,String first_name,String last_name, String interest, String email, String address, java.util.UUID picid){
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("UPDATE userprofiles SET first_name = ?, last_name = ?, interest = ?, email = ?, addresses = ?, picid = ? WHERE login = ?");
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute(boundStatement.bind(first_name,last_name,interest,email,address,picid,username));
    }
    
    public java.util.LinkedList<String> getUserProfile(String User) {
        java.util.LinkedList<String> Profile = new java.util.LinkedList<>();
        Session sessionn = cluster.connect("instagrim");
        PreparedStatement ps = sessionn.prepare("select * from userprofiles where login =?");
        ResultSet rs;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = sessionn.execute(boundStatement.bind(User));
        if (rs.isExhausted()) {
            System.out.println("No Profile returned");
            return null;
        } else {
            for (Row row : rs){
                Profile.add(row.getString("first_name"));
                Profile.add(row.getString("last_name"));
                Profile.add(row.getString("interest"));
                Profile.add(row.getString("email"));
                Profile.add(row.getString("addresses"));
            }
        }
        return Profile;
    }
    
    public java.util.LinkedList<String> getOthers(String User) {
        java.util.LinkedList<String> others = new java.util.LinkedList<>();
        Session sessionn = cluster.connect("instagrim");
        PreparedStatement ps = sessionn.prepare("select login from userprofiles");
        ResultSet rs;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = sessionn.execute(boundStatement.bind());
        if (rs.isExhausted()) {
            System.out.println("No other users yet.");
            return null;
        } else {
            for (Row row : rs){
                if(row.getString("login")!=User){
                    others.add(row.getString("login"));
                }
            }
        }
        return others;
    }
    
    public java.util.UUID getUserPic(String User) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select picid from userprofiles where login =?");
        ResultSet rs;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(User));
        if (rs.isExhausted()) {
            System.out.println("No Profile returned");
            return null;
        } else {
            for (Row row : rs){
                java.util.UUID picid = row.getUUID("picid");
                return picid;
            }
            return null;
        }
    }
}
