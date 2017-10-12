<%-- 
    Document   : ListOfPlan
    Created on : Jun 6, 2016, 8:10:30 AM
    Author     : Harish
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plan List</title>
        <link rel="shortcut icon" href="Images/ips logo.jpg" />
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
        <style>
               html{
            background-color: #4A96AD;
        }
            tr:nth-of-type(odd) { 
                background: #7fb3d5; 
            }
            th { 
                background:  #1b4f72; 
                color: #f5eef8; 
                font-weight: bold; 
            }
            td, th { 
                padding: 3px; 
                border: 1px solid #ccc; 
                text-align: center; 
            }
 #container{
            width:80%;
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
        </style>
    </head>
    <body>
  <!--header of page -->


        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> back  </strong></a>
            </span>
        </div>
        <!--header End -->
         <div id="container">
       
         <div id="container_body">
       

          <div>
                    <h2 class="form_title">List of plans</h2>
                </div>
             <hr >          
        <table align="center" border="1" width="100%">
            <thead>
                <tr>
                    <th>Sr. No.</th>
                    <th>Plan Name</th>
                    <th>Description</th>
                    <th>Duration</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                 <%
            ResultSet rs;
              Connection con = ConClass.CClass.getConnection();
                int loginid = (Integer) session.getAttribute("loginID");
          PreparedStatement ps = con.prepareStatement("select * from planinfo where loginid="+loginid+"");
             rs =ps.executeQuery();
            int a=0;
             while(rs.next()){
                a++; %>
                <tr>
                    <td><%=a%></td>
                    <td><%=rs.getString(3).toLowerCase() %></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getInt(5)%></td>
                    <td><%=rs.getInt(6)%></td>
                </tr>
                <%}
                %>
            </tbody>
        </table>
         </div>
         </div>
    </body>
</html>
