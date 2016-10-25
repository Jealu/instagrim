<%-- 
    Document   : editPic
    Created on : 2016-10-22, 3:24:23
    Author     : Agrail
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.models.PicModel" %>
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
            border: solid black;
            font-size: 45px;
            font-style: italic;
            margin:10px;
            border-width: 6px 1px 1px 6px;
            height:90px;
            padding-left: 50px;
            padding-top: 20px;
        }
        body{
            background-image: url(forest.jpg);
            margin:3px;
            padding:2px;
        }
        form{
            position: absolute;
            border: black;
            right:60px;
            top:150px;
            width : 35em;
            height:25em;
            float:right;
            background: 0;
            opacity: 0.8;
            border-radius:10px 20px 10px 0px;
            border:1px solid black;
            padding: 7px;
            box-shadow: 12px 12px 8px -9px #555;
        }
        h1{
            font:"Serif";
            font-size:44px;
            font-style:italic;
            font-weight: bold;
        }
        h2{
            font:"Fantasy";
            font-size: 45px;
            color:#50572e;
            font-style: italic;
            font-weight: 300;
            position: absolute;
            bottom:-80px;
            right:260px;
            padding: 50px;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:#50572e;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            bottom:-110px;
            right: 120px;
        }
        a{
            font:"times";
            font-size: 33px;
            color:black;
            text-decoration:none;
            font-weight: 500;
            line-height: 60px;
        }
        input{
            float:left;
            width:13em;
            color:#555;
            font-size: 20px;
            outline:none;
            border-radius:10px 0 10px 0;
            margin:2px;
        }
        input[type=submit]{
            float:right;
            width:auto;
            margin:0 2px 3px 0;
            padding:0px 8px 3px;
            font-size: 1em;
            font-weight: 800;
            color:#fff;
            border:none;
            background-color: #ba560d;
            box-shadow:1px 1px 2px #888;
        }
        input[type=submit]:hover{
            font-size: 1.5em;
        }
        label{
            font-family: "Source Sans Pro", helvetica, sans-serif;
            font-weight:200;
            float:left;
            width:8em;
            font-size: 20px;
            margin: .5em;
            padding: .1em;
            color:#555
        }
        p{
            font:"times";
            font-size: 25px;
            font-style: italic;
            text-decoration: underline;
        }
        a:hover{
            font:"times";
            font-size: 35px;
            font-style: italic;
            text-decoration: underline;
        }
        div{
            width:auto;
            border:1px solid black;
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
        <%String message = (String)session.getAttribute("message");%>
        <header><%=message%></header>>
        <img src="/Instagrim/Large/<%=(java.util.UUID)session.getAttribute("currentPic")%>">
        <ul>
            <form action="Comment" method = "post">
        <%
            java.util.LinkedList<String> comments = (java.util.LinkedList<String>)session.getAttribute("comments");
            if (comments == null) {
        %>
        <p>No Comments Found</p>
        <%
        } else {
            Iterator<String> iterator;
            iterator = comments.iterator();
            while (iterator.hasNext()) {
                String com = (String) iterator.next();
        %>
        
            <p><%=com%></p>
        <%
            }
            }
        %>
            <li><input type = "text" name = "comment"></li>
            <li><input type = "submit" value = "save"></li>
            </form>
        </ul>
        <aside>
                <a href="/Instagrim/loggedIn.jsp">Home Page</a>
        </aside>
        <h2>We all seek for </h2>
        <h3>........A free life </h3>
    </body>
</html>
