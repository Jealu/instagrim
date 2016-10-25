<%-- 
    Document   : profile
    Created on : 2016-10-19, 21:39:29
    Author     : Agrail
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.models.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complete your profile!</title>
    </head>
    <style type="text/css">
        *{
            margin : 0;
            padding : 0px;
        }
        body{
            background-image: url(dim.jpg);
            background-repeat: no-repeat;
            background-size:cover;
        }
        form{
            position: absolute;
            left:60px;
            top:240px;
            width : 30em;
            height:23em;
            float:left;
            background: #fff;
            opacity: 0.4;
            border-radius:10px 20px 10px 60px;
            box-shadow: 0 12px 8px -9px #555;
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
        footer{
            position:absolute;
            bottom :2px;
        }
        li{
            overflow: hidden;
            padding:.25em 0;
        }
        h2{
            font:"Fantasy";
            font-size: 45px;
            color:#595b46;
            font-style: italic;
            font-weight: 300;
            position: absolute;
            bottom:160px;
            right:60px;
            padding: 50px;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:#595b46;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            bottom:100px;
            right: 40px;
        }
        a{
            font:"times";
            font-size: 23px;
            color:black;
            text-decoration:none;
            font-weight: 100;
            line-height: 60px;
        }
        h1{
            position: absolute;
            left:60px;
            font-size: 30px;
            font-style: italic;
        }
        a:hover{
            font:"times";
            font-size: 35px;
            font-style: italic;
            text-decoration: underline;
        }
        div{
            height: auto;
            margin: 10px;
            padding : 10px;
            position :absolute;
            left : 80px;
            top : 40px;
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
        <% 
            java.util.LinkedList<String> userProfile=(java.util.LinkedList<String>)session.getAttribute("profile");
            java.util.UUID picid = (java.util.UUID)session.getAttribute("picid");
        %>
        <h1>your user image</h1>
        <div>
            
            <a href="/Instagrim/Image/<%=picid%>" ><img src="/Instagrim/Small/<%=picid%>"></a>
        </div>
        
        <form method="POST"  action="Register">
            <ul>
                <li><label for="username">User Image</label> <input type="file" name="upfile"></li>
                <li><label for="first_name">first name</label> <input type="text" value= <%=userProfile.get(0)%> name="first_name"></li>
                <li><label for="last_name">last name</label> <input type="text" value= <%=userProfile.get(1)%> name="last_name"></li>
                <li><label for="email">contact email</label> <input type="text" value= <%=userProfile.get(3)%> name="email"></li>
                <li><label for="interest">interest</label> <input type="text" value= <%=userProfile.get(2)%> name="interest"></li>
                <li><label for="address">address</label> <input type="text" value= <%=userProfile.get(4)%> name="address"></li>
            </ul>
            <input type="submit" value="Save"> 
        </form>
        <aside>
                <a href="/Instagrim/loggedIn.jsp">Home Page</a>
        </aside>
        <h2>Enjoy the silence</h2>
        <h3>......A quiet life</h3>
    </body>
</html>
