<!DOCTYPE HTML>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>

    <title> Visualization </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	
    <%
        if(session.getAttribute("userName") == null)
            out.println("<script type= 'text/javascript'> window.location.href = 'index.html'; </script>");

        String type = request.getParameter("chartType");
        String game = request.getParameter("game");

        // out.println("<script type= 'text/javascript'> alert('" + type + " " + game + "'); </script>");

        Connection con = null;  
        Statement stmt = null;
        PreparedStatement prepStmt = null;
        ResultSet rs = null;

        String query = "", output = "", title = "", total = "";
        double tot = 100.00;

        if(type == null)
            title += "Statistic Visualization";
        else if(game == null)
        {
            title += "Stats of all Games";

            query = "SELECT game as main_key, COUNT(*) as value FROM player GROUP BY game ORDER BY game ASC";

            total = "SELECT COUNT(*) as total FROM player";

        }
        else
        {
            title += "Stats of categories in " + game;

            query = "SELECT category as main_key, count(*) as value FROM player WHERE game= '" + game + "' group by category ORDER BY category ASC";

            total = "SELECT COUNT(*) as total FROM player WHERE game = '" + game + "'";
        }

        Class.forName("com.mysql.jdbc.Driver"); 
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

        if(type != null)
        {
            stmt = con.createStatement();
            rs = stmt.executeQuery(total);

            if(rs.next())
                tot = (double) rs.getInt("total");

            stmt = con.createStatement();
            rs = stmt.executeQuery(query);

            String temp = "";
            if(rs.next())
            {
                temp = String.format("%.2g%n", (rs.getInt("value") / tot) * 100.00).trim();
                output += "{y: " + temp + ", label: '" + rs.getString("main_key") + "'}";
            }

            while(rs.next())
            {
                temp = String.format("%.2g%n", (rs.getInt("value") / tot) * 100.00).trim();
                output += ", {y: " + temp + ", label: '" + rs.getString("main_key") + "'}";
            }
        }
    %>

    <script type= "text/javascript">
        var ele_focus = null;

        function gen_chart(ele) {

            var click_fn = null;
            if("<%= game %>" === "null")
                click_fn = seg_click;

            var chart = new CanvasJS.Chart(ele, {
                animationEnabled: true,
                title: {
                    text: "<%= title %>"
                },
                data: [{
                    type: "<%= type %>",
                    startAngle: 240,
                    click: click_fn, 
                    yValueFormatString: "##0.00\"%\"",
                    indexLabel: "{label} {y}",
                    dataPoints: [ <%= output %>
                        
                        /*
                        {y: 79.45, label: "Google"},
                        {y: 7.31, label: "Bing"},
                        {y: 7.06, label: "Baidu"},
                        {y: 4.91, label: "Yahoo"},
                        {y: 1.26, label: "Others"}
                        */
                    ]
                }]
            });

            chart.render();
        }

        function seg_click(evt) {
            var ifr = document.getElementById("sub");
            ifr.width = "100%";
            ifr.height = "350px";

            toggle();
            var game = document.createElement("input");
            game.name = "game";
            game.type = "hidden";
            game.value = evt.dataPoint.label;
            document.getElementById("games").appendChild(game);

            var myForm = document.getElementById("myForm");
            myForm.chartType.value = "<%= type %>";
            myForm.target = "sub";
            if(ele_focus == null) {
                ele_focus = evt.dataPoint.label;
                myForm.submit();
            }
            else
                ele_focus = null;

        }

        function toggle() {
            var ele = document.getElementById("games");
            ele.parentNode.removeChild(ele);

            ele = document.createElement("div");
            ele.id = "games";

            document.forms[0].appendChild(ele);
        }

        function final_fn() {
            var myForm = document.getElementById("myForm");
            document.forms[0].target = "_self";
            toggle();
        }

    </script>
</head>
<body data-spy="scroll" data-target="#site-nav">
    <nav id="site-nav" class="navbar navbar-fixed-top navbar-custom">
        <div class="container">
            <div class="navbar-header">

                <!-- logo -->
                <div class="site-branding">
                    <a class="logo" href="index.html">
                        
                        <!-- logo image  -->
                        <img src="assets\images\logoo.jpg" alt="Logo" width="20%">
                               Sports Management
                    </a>
                </div>

                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-items" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                </button>

            </div><!-- /.navbar-header -->

            <div class="collapse navbar-collapse" id="navbar-items">
                <ul class="nav navbar-nav navbar-right">

                    <!-- navigation menu -->
                    <li class="active"><a  href="#add_sport">Add New Sport</a></li>
                    <li><a  href="add_clg.jsp">Add New College</a></li> 
					<li><a  href="rm_clg.jsp">Remove College</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>	
					<li><a  href="#chart"> Visualize</a></li> 
					<li><a  href="logout.jsp">Logout</a></li> 			
                </ul>
            </div>
        </div><!-- /.container -->
    </nav>
	 <header id="site-header" class="site-header valign-center"> 
        
            <div class="intro">
                      
			<h1>   Sports Management
            
           </div>
    </header>	
	


    <%
        if(game == null) {
    %> 
	<section id="chart" class="section form"> 

		<div class="container">
               
			   <header>
				<h1 ><span>Visualization</span></h1>
            </header>   

            <form  id= "myForm" method= "post" onSubmit= "return final_fn()">

                <select  class="select-style" name= "chartType">
                    <p class="contact"><option value= "column"> Bar </option></p>
                    <p class="contact"><option value= "pie"> Pie </option></p>
                    <p class="contact"><option value= "doughnut"> Doughnut </option></p>
                </select>

                &nbsp; &nbsp; &nbsp;
                <input class="buttom" type= "submit" name= "form-submit" value= "GO">

                <div id= "games"> </div>
            </form>

        </center>
    <%
        }
    %>
   
    <br /> 
    <br />
    <div id= "chartContainer"></div>
    <p class="contact"><iframe src= "" name= "sub" id= "sub" width= "0%" height= "0px" scrolling = "no" frameborder= "0"></iframe></p>
    
    <%
        if(game == null) {
    %>
            <br />
            <br />
            <p align= "center"> <a href= "admin.jsp"> </a> </p>
    <%
        }
    %>

    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

    <%
        if(type != null) {
    %>
            <script type= "text/javascript"> 
                var div_ele = document.getElementById("chartContainer");

                div_ele.setAttribute("style", "height: 300px; width: 70%; margin-left: 200px;");

                gen_chart("chartContainer"); 
            </script>
    <%
        }
    %>
	</div>
	</section>
</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>
				<script src="assets/js/main.js"></script>
</html>