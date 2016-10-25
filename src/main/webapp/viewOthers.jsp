<%-- 
    Document   : viewOthers
    Created on : 2016-10-22, 18:11:33
    Author     : Agrail
--%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
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
            
            background-image: url(quiet.jpg);
            background-repeat: no-repeat;
            background-size:cover;
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
            top:30px;
            right:130px;
            padding: 50px;
        }
        h3{
            font:"arial";
            font-size: 43px;
            color:black;
            font-style: italic;
            font-weight: 200;
            position: absolute;
            top:150px;
            right: 20px;
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
        td{
            padding: 10px;
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
        <center>
        <h1>User Picture</h1>
        <h2>Love is simple</h2>
        <h3>But......difficult</h3>
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("othersPic");
            java.util.LinkedList<String> userProfile=(java.util.LinkedList<String>)request.getAttribute("othersPro");
            java.util.UUID picid = (java.util.UUID)request.getAttribute("userPic");
        %>
        <a href="/Instagrim/Image/<%=picid%>" ><img src="/Instagrim/Small/<%=picid%>" alt="no user pic"></a>
        <table border="1" width="318" height="167">
            <tr>
                <td>first name</td>
                <td><%=userProfile.get(0)%></td>
            </tr>
            <tr> 
                <td>last name</td>
                <td><%=userProfile.get(1)%></td>
            </tr>
            <tr> 
                <td>e-mail</td>
                <td><%=userProfile.get(3)%></td>
            </tr>
            <tr> 
                <td>interest</td>
                <td><%=userProfile.get(2)%></td>
            </tr>
            <tr> 
                <td>address</td>
                <td><%=userProfile.get(4)%></td>>
            </tr>
        </table>
        </center>>
        <%if (lsPics == null) {%>
        <p>No Pictures found！！</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();
        %>
        <form>
            <a href="/Instagrim/comment/<%=p.getSUUID()%>" ><img src="/Instagrim/Middle/<%=p.getSUUID()%>"></a>
        </form>
        <%
            }
            }
        %>
        <aside>
            <a href="/Instagrim/loggedIn.jsp">Home Page</a>
        </aside>
    </body>
</html>
