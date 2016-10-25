<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <style type="text/css">
        *{
            margin : 0;
            padding : 0px;
        }
        body{
            background-image: url(butterfly.jpg);
            background-repeat: no-repeat;
            background-size:cover;
        }
        form{
            position: relative;
            right:60px;
            top:40px;
            width : 30em;
            height:8em;
            float:right;
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
            color:#dbc8a7;
            font-style: italic;
            font-weight: 300;
            position: absolute;
            bottom:230px;
            left:60px;
            padding: 50px;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:#dbc8a7;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            bottom:360px;
            left: 40px;
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
        <h2>......A beautiful life</h2>
        </header>
       
        <article>
            <h3>Always wish for</h3>
            
            <form method="POST"  action="Login">
                <ul>
                    <li><label for="username">User Name</label> <input type="text" name="username"></li>
                    <li><label for="password">Password</label> <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
