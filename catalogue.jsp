<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<html>

<head>
	<title> Games Catalogue </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
	
	<%
		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		ResultSet rs = null, rs2 = null;
		int res = 0;

		String query;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");
	%>

	<script type= "text/javascript">

		$(document).ready(function() {
		    $.fn.get_catq = function(game_btn) { 

		        var div = document.getElementById("cat_div");
				var table = document.getElementById("cat_table");
				var ele;
				var iter = 1;
				var output = "";

				if(table == null) {
					table = document.createElement("TABLE");
					table.id = "cat_table";
					table.border = true;
					table.class ="contact";
					table.style="width:500px";
					ele = document.createElement("TR");
					ele.innerHTML += "\
						 <th> Category</th> \
						<th> Players </th> \
						<th> Rounds </th> \
						<th> Days </th> \
						<th> Price </th> \
						<th> Location </th> \
					";

					table.appendChild(ele);

					ele = document.createElement("TBODY");
					ele.id = "cat_tbody";
					table.appendChild(ele);

					div.appendChild(table);
				}
				else 
					document.getElementById("cat_tbody").innerHTML = "";


				/*
				$.ajax({
					type:    "POST",
					url:     "get_categories.jsp",
					cache: false, 
					async: false, 
					data:    "game=" + game_btn.value,
					success: function(data){
						alert(data);
					}
				}); 
				*/

				$.post('get_categories.jsp', {  cache: false, aync: false, game:  game_btn.value}, function(data){
			    	if(data) {
			        	document.getElementById("cat_tbody").innerHTML = data // response from your server
			    	}
				});
			}

		    $(".call-btn").click(function(){
		        $.fn.get_catq(this);
		    });

		});

	</script>

</head>

<body data-spy="scroll" data-target="#site-nav">
    <nav id="site-nav" class="navbar navbar-fixed-top navbar-custom">
        <div class="container">
		 <div class="row">
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
                   <li class="active">
				   <li><a data-scroll href="login.jsp">Login</a></li>
					<li> <a href= "#cat"> Catalogue </a></li>	
					</ul>
            </div>
        </div><!-- /.container -->
		</div>
    </nav>
	 <header id="site-header" class="site-header valign-center"> 
        
            <div class="intro">
                      
			<h1>   Sports Management
            
           </div>
    </header>	
	<section id="cat" class="section form"> 

		<div class="container">
               
			   <header>
				<h1 ><span>Catalogue</span></h1>
            </header>   
		<%
			query = "SELECT DISTINCT theme FROM sports";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				out.println("<h3><p class='contact'> " + rs.getString("theme") + "</p> </h3>");

				query = "SELECT name FROM sports WHERE theme = '" + rs.getString("theme") + "'";
				stmt = con.createStatement();
				rs2 = stmt.executeQuery(query);
				
				while(rs2.next()) {
					out.println("<ul>");
					out.println("<li> <p class='contact'><button type= 'button' class= 'call-btn' value= '" + rs2.getString("name") + "'> " + rs2.getString("name") + " </button> </p> </li>");
					out.println("</ul>");
				}

				out.println("<br />");
			}
		%>

		<p class="contact"><div id= "cat_div"> </div></p>
		<p class="contact"><div id= "response"> </div></p>

	</center>
</body>

</html>