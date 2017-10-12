<%@page import="java.sql.*"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="ScriptFiles/JQuery.js" type="text/javascript"></script>
        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
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

        #t1{
            border: 3px solid #EBE6E2;
            border-radius: 5px;
            -webkit-transition: all 0.3s ease-out;
            -moz-transition: all 0.3s ease-out;
            -ms-transition: all 0.3s ease-out;
            -o-transition: all 0.3s ease-out;
            transition: all 0.3s ease-out;

        }
        .inputs {
            height: 30px;
            border: 3px solid #EBE6E2;
            border-radius: 5px;
            -webkit-transition: all 0.3s ease-out;
            -moz-transition: all 0.3s ease-out;
            -ms-transition: all 0.3s ease-out;
            -o-transition: all 0.3s ease-out;
            transition: all 0.3s ease-out;
            width: 170px;
        }

        .inputs:focus,.textarea:focus {
            border-color: #BBB;
            outline: none;
        }

    </style>
    <script>
        $(document).ready(function () {
           
        $('#plan_id').change(function () {
       var  plan_id = $('#plan_id').val();
        $.ajax({
        type: 'POST',
                data: {"plan_name":  plan_id},
                dataType: 'json',
                url: "PlanUpdateAutofield",
                success: function (data) {
                var    des=data.des;
       /// alert(des);       
        var dur = data.dur;
               var am = data.am;
               document.getElementById('am').value =am ;
                document.getElementById('t1').value = des;     
                document.getElementById('dur').value = dur;
    }
        });
        return false;
        });
      
        
        
        
        
        
        
        $("form").submit(function () {

                var name = $('#plan_id').val();
                var des = $('#t1').val();
                var am = $('#am').val();
                var dur = $('#dur').val();
                alert(name + "" + des + "" + am + "" + dur);
                $.ajax({
                    type: 'POST',
                    data: {
                        "name": name,
                        "des": des,
                        "am": am,
                        "dur": dur
                    },
                    url: "UpdatePlan",
                    success: function (data) {
                        //  alert(data);
                        document.getElementById("lable").innerHTML = data;
                        $('form')[0].reset();
                    }
                });
                return false;

            });


        });


    </script>
    <body>
        <!--header of page -->


        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> home  </strong></a>
            </span>
        </div>
        <!--header End -->
        <!--container start-->
        <form>
            <div id="container">
                <div id="container_body">
                    <div>
                        <h2 class="form_title">Update plan</h2>
                    </div>
                    <hr>
                    <h3 class="class_info">Plan Information</h3>
                    <%  Connection con = ConClass.CClass.getConnection();
                        Statement statement = con.createStatement();
                            int loginid  = (Integer) session.getAttribute("loginID");
         
                        ResultSet rs = statement.executeQuery("select * from planinfo where loginid ="+loginid+"");
                    %>
                    <!-- Displaying the values in the combo box -->
                    <div>     <select id="plan_id"   class="inputs" >
                            <%
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("name")%>"><%=rs.getString("name")%></option>
                            <%
                                }
                            %>
                        </select>


                     <!--   <input type="text"class="inputs" placeholder="Plan Name" id="name" required=""/> 

-->
                        <br><br>
                        Description
                        <br>

                        <textarea id="t1" rows="4" cols="40"></textarea>
                        <br><br>
                        <input type="text"class="inputs" placeholder="Duration"   id="dur" required=""/> 
                        <br><br> 
                        <input type="text" class="inputs"placeholder="Amount" id="am"  required=""/> 
                        <br>
                        <br>
                        <p align="right">
                            <input type="reset" class="myButton" value="Clear" />
                            <input type="submit" class="myButton" id="sub" value="Submit" />
                        </p>
                        <label id="lable"></label>

                    </div>
                </div>
        </form> 



    </body>
</html>
