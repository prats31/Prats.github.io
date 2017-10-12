<%@page import="java.util.List"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Simple Login Form</title>
        <link href="CSSfiles/reset.css" rel="stylesheet" type="text/css"/>

        <script src="ScriptFiles/JQuery.js" type="text/javascript"></script>

        <link href="CSSfiles/structure.css" rel="stylesheet" type="text/css"/>

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

        <style>
            body{

  
    
        background: url("Images/front page ips.jpg") no-repeat center center fixed; 
                -webkit-background-size: cover;
                -moz-background-size: cover;
                -o-background-size: cover;
                background-size: cover;
           
            }
        </style>

    </head>


    <body>


        <form class="box login"action="login" method="post" id="loginform">
            <fieldset class="boxBody">
                <label>Login</label><br>
                <input type="text" tabindex="1" name="user" placeholder="UserName" id="1"  required="">
                <input type="password" tabindex="2" name="pass"  placeholder="Password" id="2" required="">
            </fieldset>
            <footer>
                <input type="submit" id="login" class="btnLogin" value="Login" tabindex="4">
            </footer><br>
            <%

                List<String> msgList = (List<String>) request.getAttribute("msgList");
                if (msgList != null && msgList.size() > 0) {

                    for (String msgStr : msgList) {
            %>

            <span id="text"><p align="center">
                <lable for="lable1" ><%=msgStr%></lable> <br />
                </p>
                <%
                        }
                    }
                %>
            </span>
        </form>
        <footer id="main">
        </footer>
    </body>
</html>
