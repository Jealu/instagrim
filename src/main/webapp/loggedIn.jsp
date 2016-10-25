<%-- 
    Document   : loggedIn
    Created on : 2016-10-22, 18:11:53
    Author     : Agrail
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.models.*" %>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts" %>
<%@ page import="com.datastax.driver.core.Cluster" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
    </head>
    <style type="text/css">
        *{
            margin : 0;
            padding : 0px;
        }
        header{
            width:1460px;
            height:90px;
            font-size: 40px;
            padding-left: 50px;
            padding-top: 20px;
            color:white;
            position: relative;
        }
        body{
            background-image: url(forest.jpg);
            background-repeat: no-repeat;
            background-size:cover;
        }
        form{
            position: relative;
            left:60px;
            top:40px;
            width : 8em;
            height:11em;
            float:left;
            background: #45f345;
            opacity: 0.8;
            border-radius:10px 20px 10px 0px;
            border:0;
            padding: 7px;
            box-shadow: 0 12px 8px -9px #555;
        }
        label{
            font-family: "Source Sans Pro", helvetica, sans-serif;
            font-weight:200;
            float:left;
            width:8em;
            font-size: 21px;
            margin: .5em;
            padding: .1em;
            color:#555
        }
        input{
            float:right;
            width:13em;
            color:#555;
            font-size: 20px;
            outline:none;
            margin: .5em;
            padding: .1em;
            border-radius:10px 0 10px 0;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:white;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            bottom:60px;
            right: 40px;
        }
        .m{
            font:"times";
            font-size: 25px;
            color:black;
            margin: 0;
        }
        a{
            font:"times";
            font-size: 23px;
            color:whitesmoke;
            text-decoration:none;
            font-weight: 100;
            line-height: 60px;
            margin:20px;
        }
        a:hover{
            font:"times";
            font-size: 35px;
            font-style: italic;
            text-decoration: underline;
        }
        aside{
            height: auto;
            margin: 10px;
            padding : 10px;
            position :absolute;
            right : 30px;
            top : 10px;
        }
    </style>
    <body>
        <header>Other users in the communist</header>
        <h3>Some of us live  .......A green life</h3>
        <aside>
            <ul>
                <%String username = (String)session.getAttribute("username");%>
                <li><a href="/Instagrim/Images/<%=username%>">Your Images</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href = "/Instagrim">log off</a></li>
            </ul>
        </aside>
        <article>
        <%
            java.util.LinkedList<String> others = (java.util.LinkedList<String>)session.getAttribute("others");
            if (others == null) {
            %>
            <p>No Otherusers Found</p>
            <%
            } else {
                Iterator<String> iterator;
                iterator = others.iterator();
                while (iterator.hasNext()) {
                    String user = (String) iterator.next();
                    if( user.compareTo((String)session.getAttribute("username"))!=0){
                        User u = new User();
                        Cluster cluster = CassandraHosts.getCluster();
                        u.setCluster(cluster);
                        java.util.UUID picid =u.getUserPic(user);
            %>
            <form>
                <a href="/Instagrim/Image/<%=picid%>" ><img src="/Instagrim/Small/<%=picid%>" alt="no user pic"></a>
                <a class = "m" href ="/Instagrim/Profile/<%=user%>"><%=user%></a>
            </form>
            <%
                }
                }
                }
            %>
        </article>
    </body>
</html>
