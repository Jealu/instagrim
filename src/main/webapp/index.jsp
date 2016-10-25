<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <style type="text/css">
        *{
            margin : 0;
            padding : 0px;
        }
        body{
            background-image: url(sunny.jpg);
            background-repeat: no-repeat;
            background-size:cover;
        }
        header{
            width:1460px;
            height:90px;
            padding-left: 50px;
            padding-top: 20px;
            color:white;
            background:linear-gradient(#ccffff,#8ebad7);
            background-size: cover;
            position: relative;
            opacity: 0.6;
        }
        footer{
            position:absolute;
            bottom :2px;
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
            bottom:30px;
            left:130px;
            padding: 50px;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:#50572e;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            bottom:10px;
            left: 120px;
        }
        a{
            font:"times";
            font-size: 23px;
            color:black;
            text-decoration:none;
            font-weight: 100;
            line-height: 60px;
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
        <header>
            <h1>InstaGrim ! </h1>
        </header>
        <audio autoplay loop>
            <source src="Rampart.mp3">
            <source src="Rampart.ogg">
            <source src="Rampart.wav">
        </audio>
        <article>
            <h2>To be happy: <br></h2>
            <h3>.........A simple life <br></h3>
        </article>
        
        <aside>
            <ul>
                <li><a href="register.jsp">Register</a><br></li>
                <li><a href="login.jsp" target=_blank>Login</a><br><br></li>
            </ul>
        </aside>
        <footer>
            &COPY; Andy C
        </footer>
    </body>
    
</html>
