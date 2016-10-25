<%-- 
    Document   : publish
    Created on : 2016-10-24, 0:01:18
    Author     : Agrail
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        body{
            margin:3px;
            padding:2px;
        }
        form{
            position: relative;
            border: black;
            left:60px;
            top:40px;
            width : 26em;
            height:20em;
            float:left;
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
        <header>
            <dix>
                <a href="upload.jsp">Click here to select a picture</a>
            </dix>
        </header>
        <img src="/Instagrim/Middle/<%=session.getAttribute("uploadPic")%>" alt="no picture yet">
        <img src="/Instagrim/Decolored/<%=session.getAttribute("uploadPic")%>" alt="no picture yet">
        <h2>Ready to make a change!.....An exciting life</h2>
        <form method = "post" action = "publish">
            <p>you can also choose a decolored version</p>
            <label for="radio">original picture</label><input type = "radio" name = "radio" value = "111" checked><br>
            <label for="radio">decolored picture</label><input type = "radio" name = "radio" value = "222"><br>
            <label for="message">Want to leave a message?</label><input type="text" name="message">
            <input type = "submit" value = "publish">
        </form>
        <aside>
                <a href="/Instagrim/loggedIn.jsp">Home Page</a>
        </aside>
    </body>
</html>
