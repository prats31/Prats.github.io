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

        <link href="CSSfiles/All.css" rel="stylesheet" type="text/css"/>
    </head>
    <script src="ScriptFiles/JQuery.js" type="text/javascript"></script>
    <link href="CSSfiles/autocomplete-0.3.0.css" rel="stylesheet" type="text/css"/>

    <script src="ScriptFiles/autocomplete-0.3.0.min.js" type="text/javascript"></script>
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
            width: 180px;
        }

        .inputs:focus,.textarea:focus {
            border-color: #BBB;
            outline: none;
        }

    </style>
    <STYLE TYPE="text/css" media="all">
.ui-autocomplete { 
    position: absolute; 
    cursor: default; 
    height: 180px; 
    overflow-y: scroll; 
    overflow-x: hidden;}
</STYLE>

<script type="text/javascript">
$(document).ready(function() {
    $("input#autoText").autocomplete({
        width: 200,
        max: 5,
        delay: 100,
        minLength: 1,
        autoFocus: true,
        cacheLength: 1,
        scroll: true,
        highlight: false,
        
        source: function(request, response) {
       // alert(request);
        $.ajax({
                url: 'AutoName',
                dataType: "json",
                data: request,
                success: function( data, textStatus, jqXHR) {
       // alert(data);           
        console.log( data);
                    var items = data;
                    response(items);
                },
                error: function(jqXHR, textStatus, errorThrown){
                     console.log( textStatus);
                }
            });
        }

    });
    
    
    
    
});
   
</script>

    <body>
        <!--header of page -->


        <div class="codrops-top">

            <span class="right">
                <a href="HomePage.jsp"><strong> home </strong></a>
            </span>
        </div>
        <!--header End -->
        <br><br><br>
        <!--container start-->
        <form name="as400samplecode" action="CustomerUpdatePage.jsp" method="get">

            <div id="container">
                <div id="container_body">
                    <div>
                        <h2 class="form_title">Customer Update</h2>
                    </div>
                    <hr>
                     <h3 class="class_info">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search</h3>

                    <p align="center">
           
      
                        <input id="autoText" name="user" class="inputs" maxlength="20"  required=""/>
 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </p>
                    <br>
                    <p align="right">
                    <input type="submit" value="Submit" name="btn1" class="myButton" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
            </div>
        </form> 
    </body>
    </html>