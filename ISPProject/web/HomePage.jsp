<%-- 
    Document   : HomePage
    Created on : May 5, 2016, 2:14:18 PM
    Author     : Harish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
  <script type = "text/javascript" >
            function preventBack() {
                window.history.forward();
            }
            setTimeout("preventBack()", 10);
            window.onunload = function () {
                null
            };
            function changeHashOnLoad() {
                window.location.href += '#';
                setTimeout('changeHashAgain()', '50');
            }
            function changeHashAgain() {
                window.location.href += '1';
            }

            var storedHash = window.location.hash;
            window.setInterval(function () {
                if (window.location.hash != storedHash) {
                    window.location.hash = storedHash;
                }
            }, 50);
            window.onload = changeHashOnLoad;
        </script>

    </head>
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }
              html{
            background-color: #4A96AD;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background: rgba(255, 255, 255, 0.5); 
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        }

        .dropdown-content a {
            color: black;
            padding: 8px 12px;
            text-decoration: none;
            display: block;

        }

        .dropdown-content a:hover {background-color: #f1f1f1}

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: #3e8e41;
            }
        
        .logo {
    float: right;
   padding-top: 20px;
  
   
}

    </style>

    <body>

        <div class="codrops-top">

            <div class="dropdown">
                <a><strong> customer </strong></a>
                <div class="dropdown-content">
                    <a href="customerADD.jsp"><strong>new customer</strong></a>
                    <a href="selectCustomer.jsp"><strong>update customer</strong></a>
                    <a href="ListOfCust.jsp"><strong>List of Customer</strong></a>
                    <a href="selectForDetails.jsp"><strong>Details</strong></a>                  
                </div>
            </div>


            <div class="dropdown">
                <a>  <strong> plan </strong></a>
                <div class="dropdown-content">
                    <a href="AddPlan.jsp"><strong>New plan</strong></a>
                    <a href="PlanUpdate.jsp"><strong>update plan</strong></a>
                    <a href="ListOfPlan.jsp"><strong>List of plan</strong></a>
                    
                </div>
            </div>

            <div class="dropdown">
                <a><strong>delete</strong></a>
                <div class="dropdown-content">
                    <a href="selectForDelete.jsp"><strong>customer</strong></a>
                </div>
            </div>
            <a href="newjsp.jsp"><strong> payment </strong></a>



            <a href="SelectReport.jsp"><strong>Reports</strong></a>
            <a href="mailServlet"><strong>Mail</strong></a>
            <span class="right">
                <a href="Login.jsp"><strong> Logout </strong></a>
            </span>
        </div>
    </div>
 <br><br><br>
           <br> 
           <br>  
           <div align="right">
                <iframe src="iframe.jsp" height="300px" width="100%" bg>
                
            </iframe>
                </div>

<div class="logo" >
     <img height="120px" src="Images/hp logo final blue.jpg" alt=""/>
 </div>


</body>
</html>
