<%-- 
    Document   : newjsp
    Created on : May 10, 2016, 2:13:38 PM
    Author     : Harish
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
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
          .input {
                width: 60px; 
                box-sizing: border-box;
                -webkit-box-sizing:border-box;
                -moz-box-sizing: border-box;
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
        }      html{
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
                padding: 4px; 
                border: 1px solid #ccc; 
                text-align: center; 
            }
            
            th{
                
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
      

        </style>
    </head>
    <%
        mainpage.selectExpRecords obj = new mainpage.selectExpRecords();
        String[] args = {};
        obj.main(args);
    %>
    <body><form action="MainPage" method="post">
            
        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> home </strong></a>
            </span>
        </div>
            <br>
            
            <input type="submit" value="Submit" class="myButton" align="right" style="position: fixed  " />
            
            <p align="right">   <input type="text" class="inputs" width="10%" id="search" value="" />
            </p>
            <br>
            <table id="myTable" class="tablesorter" width="100%">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>UserName</th>
                        <th>FlatNo</th>
                        <th>BuildingName</th>
                        <th>Area</th>
                        <th>Zone</th>
                        <th>PlanName</th>
                        <th>Amount</th>
                        <th>RenewDate</th>
                        <th>ExpiryDate</th>
                        <th>due</th>
                        <th>paid</th>
                        <th>Link</th>
                    </tr>
                </thead>
                <tr>
                    <%
                        Connection con = ConClass.CClass.getConnection();
                             int loginid  = (Integer) session.getAttribute("loginID");
         
                        PreparedStatement ps = con.prepareStatement("select pc.first_name, pc.last_name, reverse(substring(reverse(up.username),length(pa.zone)+1)), pa.flatno, pa.buildingname, pa.are ,pa.zone"
                                + ",pp.name, pp.amount, up.renewdat, up.expirydat, up.due, up.paid   "
                                + "from userplaninfo up, planinfo pp, customerinfo pc, addressinfo pa where up.username = pc.username "
                                + " and pa.addressid = pc.addressid and pp.planid = up.planid and up.loginid= "+loginid+" and up.due>0 and (select max(up1.expirydat) from userplaninfo up1 where up1.username = up.username) < current_date() ;");
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                    %>
                    
                        <td  ><%=rs.getString(1).toLowerCase() + " " + rs.getString(2).toLowerCase()%></td>
                        <td  ><%=rs.getString(3).toLowerCase()%></td>
                        <%
                            String username = rs.getString(3).toLowerCase();
                        %>
                <input type="hidden" name ="<%=username%>" value="<%=username%>">
                <td ><%=rs.getString(4)%></td>
                <td ><%=rs.getString(5).toLowerCase()%></td>
                <td ><%=rs.getString(6).toLowerCase()%></td>
                <td ><%=rs.getString(7).toLowerCase()%></td>
                <td ><%=rs.getString(8)%></td>
                <td ><%=rs.getInt(9)%></td>
                <%

                    java.text.DateFormat df = new java.text.SimpleDateFormat("MMM dd, yyyy");
                    java.util.Date renew = rs.getDate(10);
                    java.util.Date expire = rs.getDate(11);

                    String renewd = df.format(renew);
                    String expired = df.format(expire);
                %> 
                <td align="center" width="8%"><%=renewd%></td>
                <input type="hidden" name="<%=username + "new"%>" value="<%=renew%>"/>
                <td  align="center"><%=expired%></td>
                <input type="hidden" name="<%=username + "exp"%>" value="<%=expire%>"/>
                <td align="center"><%=rs.getInt(12)%></td>
                <input type="hidden" name="<%=username + "due"%>" value="<%=rs.getInt(12)%>"/>
                <td ><input class="input"  type="text" name="<%=username + "pay"%>" id="<%=rs.getString(3)%>" value="<%=rs.getInt(13)%>" /></td>
                    <%String zone = rs.getString(7);
                        String url = "";
                        if (zone.equalsIgnoreCase("airnet")) {
                            url = "<a href=\"http://110.5.73.178\" onclick=\"window.open(this.href, 'mywin',\n"
                                    + "'left=20,top=20,width=800,height=500,toolbar=1,resizable=0'); return false;\" >Link</a>";

                        } else if (zone.equalsIgnoreCase("dna")) {
                            url = "<a href=\"http://partner.samparkestates.com\" onclick=\"window.open(this.href, 'mywin',\n"
                                    + "'left=20,top=20,width=800,height=500,toolbar=1,resizable=0'); return false;\" >Link</a>";

                        } else if (zone.equalsIgnoreCase("pacenet")) {
                            url = "<a href=\"http://203.115.71.90/admin\" onclick=\"window.open(this.href, 'mywin',\n"
                                    + "'left=20,top=20,width=800,height=500,toolbar=1,resizable=0'); return false;\" >Link</a>";

                        } else if (zone.equalsIgnoreCase("snet")) {

                            url = "<a href=\"http://110.5.73.181/admin\" onclick=\"window.open(this.href, 'mywin',\n"
                                    + "'left=20,top=20,width=800,height=500,toolbar=1,resizable=0'); return false;\" >Link</a>";
                        }

                    %>        
                <td><%=url%></td>   
                </tr>
                <%
                    }
                %>
                
            </table>
        </form>
   </body>
</html>
