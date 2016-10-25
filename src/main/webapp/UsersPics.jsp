<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
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
        form{
            position: relative;
            left:60px;
            top:40px;
            width : 18em;
            height:20em;
            float:left;
            background: 0;
            opacity: 0.8;
            border-radius:10px 20px 10px 0px;
            border:1px solid black;
            padding: 20px;
            margin: 10px;
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
            bottom:10px;
            right: 40px;
        }
        .m{
            font:"times";
            font-size: 25px;
            color:black;
            margin: 0;
        }
        h1{
            font:"Serif";
            font-size:44px;
            font-style:italic;
            font-weight: bold;
        }
        a{
            font:"times";
            font-size: 23px;
            color:black;
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
        <h1>Money cannot.......A lonely life </h1>
        
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) session.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <p>No Pictures found！！</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();
        %>
        <form>
            <a href="/Instagrim/comment/<%=p.getSUUID()%>" ><img src="/Instagrim/Middle/<%=p.getSUUID()%>"></a><br/>
        </form>
        <%
            }
            }
        %>
        <aside>
            <ul>
                <li><a href="/Instagrim/publish.jsp">Upload</a><br></li>
                <li><a href="/Instagrim/loggedIn.jsp">Home Page</a><br><br></li>
            </ul>
        </aside>
        
    </body>
</html>
