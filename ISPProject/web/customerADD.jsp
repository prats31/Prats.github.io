
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
            width:1000px;
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
    </style>
    <script>
        $(document).ready(function () {
            var enddate;
            var plan_id;
            var am, dur;
            $('#plan_id').change(function () {
                plan_id = $('#plan_id').val();
                $.ajax({
                    type: 'POST',
                    data: {"plan_name": plan_id},
                    dataType: 'json',
                    url: "PlanAutoField",
                    success: function (data) {
                        var d = new Date();
                        dur = data.dur;
                        am = data.am;
                        d.setDate(d.getDate() + dur);
                        enddate = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
                        $('#Amount').val(am);
                        $('#Duration').val(dur);
                        $('#endDate').val(enddate);
                    }
                });
            });

            $("form").submit(function () {
                var fname = $('#Fname').val();
                var lname = $('#Lname').val();
                var no = $('#contact').val();
                var email = $('#email').val();
                var flat = $('#flat').val();
                var build = $('#build').val();
                var zone = $('#zone').val();
                var area = $('#area').val();
                var user = $('#user').val();
                var todayDate = $('#todayDate').val();
                var addre = $('#address').val();
                //   var planid = $('#plan_id').val();

                //            alert(fname + " " + lname + " " + no + " " + email + " " + flat + " " + build + " " + zone + " " + area + " " + user + " " + todayDate
                //                  + " " + addre + " " + plan_id);

                $.ajax({
                    //dataType: 'json',
                    type: 'POST',
                    url: "AddCustomer",
                    async: false,
                    data: {
                        "fname": fname, "lname": lname, "no": no, "email": email,
                        "flat": flat, "build": build, "zone": zone, "area": area,
                        "user": user, "today": todayDate, "addre": addre, "planid": plan_id, "enddate": enddate

                    },
                    success: function (data) {
                        //           alert(data);  
                        $('form')[0].reset();

                        document.getElementById("response").innerHTML = data;

                    }


                });
                return  false;

            });

        });
    </script>

    <body>    
        <%
            java.text.DateFormat df = new java.text.SimpleDateFormat("y-MM-dd");

            Calendar cal = Calendar.getInstance();

            cal.add(Calendar.DATE, 0);
            String todayDate = df.format(cal.getTime());

        %>    

        <!--header of page -->
        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> home </strong></a>
            </span>
        </div>
        <!--header End -->

        <!--container start-->
        <div id="container">
            <div id="container_body">
                <div>
                    <h2 class="form_title">customer registration</h2>
                </div>
                <hr>
                <table width="100%">
                    <form name="myForm">
                        <tr>
                            <td width="45%">
                                <h3 class="class_info">Personal Information</h3>
                                <div id="Personal info">
                                    <input type="text"class="inputs , FnameLname " id="Fname" name="FnameLname" placeholder="First Name" width=200px; required="" /> 
                                    <input type="text"class="inputs , FnameLname" id="Lname" name="FnameLname" placeholder="Last Name" required=""/>
                                    <br>
                                    <br>

                                    <input type="text" class="inputs" required="" id="contact" placeholder="Contact No." /> 

                                    <br><br> 
                                    <input type="email"class="inputs , email " required="" id="email" name="email" placeholder="e-mail" /> 
                                    <br>
                                    <br>
                                    <input type="text"class="inputs" id="flat" required="" placeholder="Flat No." /> 

                                    <input type="text"class="inputs , email" required="" id="build"  placeholder="Building Name" /> 
                                    <br><br>
                                    <input type="text"class="inputs" id="zone" required="" placeholder="zone" />
                                    <input type="text"class="inputs ,email " required="" id="area" name="email" placeholder="Area" />

                                    <br><br>
                                    Address<br>

                                    <textarea id="address" class="t1" rows ="4" cols="40" ></textarea>
                            </td>   
                            <td width="1%"><hr style="height:400px;width:1px;margin-bottom:-8px;padding:0px; color: #141823 "  /></td>   
                            <td width="45%" valign ="top">

                                <h3 class="class_info">Plan Information</h3>

                                <%                                    Connection con = ConClass.CClass.getConnection();
                                    Statement statement = con.createStatement();
                                         int loginid  = (Integer) session.getAttribute("loginID");
         
                                    ResultSet rs = statement.executeQuery("select * from planinfo where loginid=" + loginid + "");
                                %>
                                <!-- Displaying the values in the combo box -->
                                <div>     <select id="plan_id"   class="inputs" >
                                        <%
                                            while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getInt("planid")%>"><%=rs.getString("name")%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <input type="text" class="inputs" id="user" placeholder="Username" /> 

                                </div>


                                <br><br><table><tr><td>
                                            <label class="class_info">Start date:</label><br>
                                            <input type="text"class="inputs"  value="<%=todayDate%>"  placeholder="Renew Date(yyyy-mm-dd)"  disabled=""/> 
                                            <input type="hidden" id ="todayDate" value="<%=todayDate%>"/></td><td>
                                            <label class="class_info">End date:</label><br>
                                            <input type="text" id="endDate"  class="inputs"placeholder="Expiry Date(yyyy-mm-dd)" disabled=""/> 
                                        </td> </tr><tr><td>
                                            <label class="class_info">Duration:</label><br>
                                            <input type="text" id="Duration"  class="inputs" placeholder="Duration" disabled=""/> 
                                        </td><td>
                                            <label class="class_info">Amount:</label><br>
                                            <input type="text"  id="Amount"class="inputs" placeholder="Amount" disabled=""/> 
                                        </td></tr></table>
                                <br>
                                <br>
                                <br>
                                <h3 class="class_info">Registration Date:</h3>
                                &nbsp;&nbsp;&nbsp;<lable class="class_info"><%=todayDate%></lable>
                        <br><br>
                        <br>
                        <p align="center">
                            <input type="reset" class="myButton" value="Clear" /> &nbsp;&nbsp;&nbsp; <input class="myButton" id="but" type="submit" value="Submit" /> 
                            <br>
                            <br><br>
                            <label id="response"></label>

                        </p>  </td>   
                        </tr>
                    </form>
                </table>
            </div>
        </div>
    </body>
</html>
