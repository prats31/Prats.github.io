
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
        <script src="ScriptFiles/JQuery.js" type="text/javascript"></script>
    </head>

    <style>
        html{
            background-color: #4A96AD;
        }
        #container{
            width:500px;
            /*height: 600px;
            background-color:#fff;*/

            margin:auto;
            margin-top:40px;
            background: rgba(255, 255, 255, 0.6); 
            margin-bottom:10px;
            box-shadow:0 0 3px #999;
            border: solid 1px #cbc9c9;
            -webkit-border-radius: 8px/7px; 
            -moz-border-radius: 8px/7px; 
            -o-border-radius:8px/7px;

        }
        #container_body{
            padding:22px;
        }
        #Flat {
            width:60px
        }
        .FnameLname {
            width:145px
        }

        .email {
            width:230px
        }


        .inputs,select {
            height: 30px;
            border: 3px solid #EBE6E2;
            border-radius: 5px;
            -webkit-transition: all 0.3s ease-out;
            -moz-transition: all 0.3s ease-out;
            -ms-transition: all 0.3s ease-out;
            -o-transition: all 0.3s ease-out;
            transition: all 0.3s ease-out;
        }
        .t1{
            border: 3px solid #EBE6E2;
            border-radius: 5px;
            -webkit-transition: all 0.3s ease-out;
            -moz-transition: all 0.3s ease-out;
            -ms-transition: all 0.3s ease-out;
            -o-transition: all 0.3s ease-out;
            transition: all 0.3s ease-out;

        }


        #zone{
            width: 90px;
        }


        .inputs:focus {
            border-color: #BBB;
            outline: none;
        }

        .myButton {
            -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
            -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
            box-shadow:inset 0px 1px 0px 0px #ffffff;
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
            background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
            background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
            background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
            background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
            background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);
            background-color:#ffffff;
            -moz-border-radius:6px;
            -webkit-border-radius:6px;
            border-radius:6px;
            border:1px solid #dcdcdc;
            display:inline-block;
            cursor:pointer;
            color:#666666;
            font-family:Arial;
            font-size:15px;
            font-weight:bold;
            padding:6px 24px;
            text-decoration:none;
            text-shadow:0px 1px 0px #ffffff;
        }
        .myButton:hover {
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
            background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
            background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
            background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
            background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
            background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);
            background-color:#f6f6f6;
        }
        .myButton:active {
            position:relative;
            top:1px;
        }

        select{
            width: 200px;
        }
         #headline1 { 
             background-image: url(images/newsletter_headline1.gif);
             background-repeat: no-repeat; 
             background-position: left top;
             padding-top:68px; 
             margin-bottom:50px;
         }
    </style>
    
    <body>  
        <!--header of page -->
        <div class="codrops-top">

            
            <span class="right">
                <a href="HomePage.jsp"><strong> home page </strong></a>
            </span>
        </div>
        <!--header End -->

        <!--container start-->
       
        <div id="container">
            <div id="container_body">
                <div>
                    <h2 class="form_title">REPORTS</h2>
                </div>
                <hr>
              
                <form name="myForm" action="report.jsp">
                        <tr>
                            <td width="45%">
                                <h3 class="class_info">Type Of Report</h3>
                                <div id="Personal info">
                                    <p align="center">
                                    <input type="radio" name="grp1" value="mon" checked="checked" /> MONTHLY &nbsp;
                                  <input type="radio" name="grp1" value="pad" /> PAID &nbsp;
                                   <input type="radio" name="grp1" value="due" /> DUE &nbsp;
                                    </p>
                                    
                                    
                                    <p  align="left">
                                <h3 class="class_info">Select Month</h3>
                                </p>
                                <p align="center">
                            <%  Connection con = ConClass.CClass.getConnection();
                        Statement statement = con.createStatement();
                            int loginid  = (Integer) session.getAttribute("loginID");
         
                        ResultSet rs = statement.executeQuery("select  distinct(concat((monthname(expirydat)),'-',year(expirydat)))  from userplaninfo where loginid="+ loginid+";");
                                                  
                            %>
                                    <select  name="time">
                      <%
                      while(rs.next()){
%>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                                    
                                <%
                                }%>
                                </select>
                                </p>
                                    <BR>
                                    <p align="right">
                                        <input type="submit" class="myButton"  value="SUBMIT" name="BTN1"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                    </p>
                                    
                    </form>
               </div>
        </div>
    </body>
</html>
