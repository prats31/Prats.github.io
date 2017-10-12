<%-- 
    Document   : iframe
    Created on : May 22, 2016, 11:29:04 AM
    Author     : Harish
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
                   tr:nth-of-type(odd) { 
                background: #7fb3d5; 
            }
            th { 
                background:  #1b4f72; 
                color: #f5eef8; 
                font-weight: bold; 
            }
            td, th { 
                padding: 4px; 
                border: 1px solid #ccc; 
                text-align: center; 
            }
            
             html{
 background: rgba(255, 255, 255, 1);
        }
     
        </style>
    </head>
    <body>
        <h2 align="center">Expiry List of Customers</h2>
        <table border="1" width="100%">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Expiry Date</th>
                    <th>Zone</th>
                    <th>Area</th>
                    <th>Building Name</th>
                    <th>Plan Name</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
         
        
        <%
            Connection con = ConClass.CClass.getConnection();
            Statement stmt = con.createStatement();
                 int loginid  = (Integer) session.getAttribute("loginID");
         
ResultSet rs = stmt.executeQuery("select concat(pc.first_name ,' ', pc.last_name), reverse(substring(reverse(up.username),length(pa.zone)+1)),"
        + " up.expirydat, pa.zone,pa.are, pa.buildingname , pp.planid, pp.name, pp.amount "
        + "from userplaninfo up , addressinfo pa , customerinfo pc, planinfo pp where "
        + "subdate(up.expirydat,interval 1 day) = current_date() and pc.username = up.username and "
        + " pc.addressid = pa.addressid and up.planid = pp.planid and pc.loginid="+loginid+"");
while(rs.next()){
%>
       <tr>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getDate(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td><%=rs.getString(6)%></td>
                    <td><%=rs.getString(8)%></td>
                    <td><%=rs.getInt(9)%></td>
                </tr>



<%
}
        %> 

            </tbody>
        </table>
   
    </body>
</html>
