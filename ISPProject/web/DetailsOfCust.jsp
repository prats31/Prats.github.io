<%@page import="java.sql.*"%>

<%-- 
    Document   : DetailsOfCust
    Created on : Jun 6, 2016, 9:49:22 AM
    Author     : Harish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
        <style>
            html{
                background-color: #4A96AD;
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
                
            }

        </style>
    </head>
    <body>
        <!--header of page -->
        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> back </strong></a>
            </span>
        </div>
        <!--header End -->

                        <%
                            String name="",address="",area="",zone="";
                            Date reg_date=null;
                            String username = request.getParameter("user");
                            Connection con = ConClass.CClass.getConnection();
                            Statement statement = con.createStatement();
                            int loginid = (Integer) session.getAttribute("loginID");
                            ResultSet rs = statement.executeQuery("select concat(pc.first_name,' ',pc.last_name), pc.registrationdate,"
                                    + "pa.addressline1 , pa.zone, pa.are from addressinfo pa, customerinfo pc"
                                    + " where pa.addressid = pc.addressid and pc.username='"+ username +"' and pc.loginid="+loginid+" ");
while(rs.next()){
    name=rs.getString(1);
    reg_date = rs.getDate(2);
    address = rs.getString(3);
    zone = rs.getString(4);
    area = rs.getString(5);
    
}
                        %>

                        <div id="container">
                            <div id="container_body">
                                <div class="class_info">  Name: <%=name%>
                                    <br>
                                    <br>
                                    Registration Date: <%=reg_date %>
                                <br>
                                    <br>
                                Address: <%=address %>
                                <br>
                                    <br>
                                    Area: <%=area %>
                                    <br>
                                    <br>
                                    Zone: <%=zone %>
                                
                                </div>
                             
                           


                        <%                            rs = statement.executeQuery("select pp.name , pp.amount, pp.duration, up.renewdat , up.expirydat,up.due,up.paid "
                                    + " from userplaninfo up , planinfo pp where up.planid = pp.planid and username='" + username + "' and up.loginid=" + loginid + "");

                        %>
                        <table border="1"  width="100%" style="text-align:  center" >
                            <thead>
                                <tr>
                                    <th>Plan Name</th>
                                    <th>Amount</th>
                                    <th>Duration</th>
                                    <th>RenewDate</th>
                                    <th>ExpiryDate</th>
                                    <th>Due</th>
                                    <th>Paid</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                          while (rs.next()) {
                                %>
                                <tr>
                                    <td><%=rs.getString(1)%></td>
                                    <td><%=rs.getInt(2)%></td>
                                    <td><%=rs.getInt(3)%></td>
                                          <%

                    java.text.DateFormat df = new java.text.SimpleDateFormat("MMM dd, yyyy");
                    java.util.Date renew = rs.getDate(4);
                    java.util.Date expire = rs.getDate(5);

                    String renewd = df.format(renew);
                    String expired = df.format(expire);
                %> 
          
                                    <td><%=renewd%></td>
                                    <td><%=expired%></td>
                                    <td><%=rs.getInt(6)%></td>
                                    <td><%=rs.getInt(7)%></td>
                                </tr>
                                <% }
                                %>
                            </tbody>
                        </table>


 </div></div>
                            


    </body>
</html>
