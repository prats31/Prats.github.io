<%-- 
    Document   : ListOfCust
    Created on : Jun 4, 2016, 10:45:07 AM
    Author     : Harish

--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="ScriptFiles/JQuery.js" type="text/javascript"></script>
        <script src="ScriptFiles/jquery.tablesorter.min.js" type="text/javascript"></script>
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>

        <script>
            $(document).ready(function ()
            {
                $("#myTable").tablesorter();
            }
            );
 $(document).ready(function()
			{
				$('#search').keyup(function()
				{
					searchTable($(this).val());
				});
			});
			function searchTable(inputVal)
			{
				var table = $('#myTable');
				table.find('tr').each(function(index, row)
				{
					var allCells = $(row).find('td');
					if(allCells.length > 0)
					{
						var found = false;
						allCells.each(function(index, td)
						{
							var regExp = new RegExp(inputVal, 'i');
							if(regExp.test($(td).text()))
							{
								found = true;
								return false;
							}
						});
						if(found == true)$(row).show();else $(row).hide();
					}
				});
			}

   
        </script>
        <style>
            html{
                background-color: #4A96AD;
            }
              .inputs,select {
            height: 30px;
             width: 13%;
            border: 3px solid #EBE6E2;
            border-radius: 5px;
            -webkit-transition: all 0.3s ease-out;
            -moz-transition: all 0.3s ease-out;
            -ms-transition: all 0.3s ease-out;
            -o-transition: all 0.3s ease-out;
            transition: all 0.3s ease-out;
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

        </style>
    </head>
    <body>
        <%
            ResultSet rs,rs1;
              Connection con = ConClass.CClass.getConnection();
                int loginid = (Integer) session.getAttribute("loginID");
          PreparedStatement ps = con.prepareStatement("select count(username) from customerinfo where loginid="+loginid+"");
             rs1 =ps.executeQuery();
int  count=0;
                while (rs1.next()) {
             count= rs1.getInt(1);
                } 
        %>
        
        <div class="codrops-top">
            <strong>total : <%=count%></strong>
            <span class="right">
                <a href="HomePage.jsp"><strong> home </strong></a>
            </span>
        </div>
        <br>
         <p align="right">   <input type="text" class="inputs" width="10%" id="search" value="" />
            </p>
   
        
        <table id="myTable" class="tablesorter" width="100%">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>UserName</th>
                    <th>FlatNo</th>
                    <th>BuildingName</th>
                    <th>Area</th>
                    <th>Address</th>
                    <th>Zone</th>
                    <th>PlanName</th>
                    <th>Amount</th>
                    <th>Duration</th>
                </tr>
            </thead>
            <%
                 ps = con.prepareStatement("select lower(concat(pc.first_name,' ',pc.last_name)),lower(reverse(substring(reverse(pc.username),length(pa.zone)+1))) AS Username "
                        + ",pa.flatno, lower(pa.buildingname), lower(pa.are), lower(pa.addressline1) ,lower(pa.zone) , lower(pp.name), pp.amount, pp.duration "
                        + " from  customerinfo pc , planinfo pp, addressinfo pa "
                        + " where   pp.planid = pc.planid and pc.addressid = pa.addressid and pc.loginid= " + loginid + ";");
                 rs = ps.executeQuery();

                while (rs.next()) {
            %><tr>
            
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td><%=rs.getString(6)%></td>
                    <td><%=rs.getString(7)%></td>
                    <td><%=rs.getString(8)%></td>
                    <td><%=rs.getInt(9)%></td>
                    <td><%=rs.getInt(10)%></td>
                
            </tr>
            <%
                
                }
            %>

        </table>
    </body>
</html>
