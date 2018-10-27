<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Adding Sport </title>
	<title> Adding Sport </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	 <%
		if(session.getAttribute("userName") == null) {

	%>
	<script type="text/javascript">window.location.href = 'index.html';</script>
	<%
	}
	%>
	 
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
                    <li class="active"><a data-scroll href= "add_sport.jsp" >Add another game</a></li>
                    <li><a  href="logout.jsp">Logout</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>					
                </ul>
            </div>
        </div><!-- /.container -->
    </nav>
	 <header id="site-header" class="site-header valign-center"> 
        
            <div class="intro">
                      
			<h1>   Sports Management
            
           </div>
    </header>
<br>
<br>

	<section id="log" class="section form">
			<div class="container">
			
			
			<header>
			<h1 ><span>Adding Sports</span></h1>
			</header> 

	<%

		if(session.getAttribute("userName") == null)
			out.println("<script type= 'text/javascript'> window.location.href = 'index.html'; </script>");

		String sport = request.getParameter("sport");
		int sub_cats = Integer.parseInt(request.getParameter("subs"));
		String info = request.getParameter("info");

		String theme = request.getParameter("theme_new");
		if(theme == null)
			theme = request.getParameter("theme");

		sport = Character.toString(sport.charAt(0)).toUpperCase() + sport.substring(1);
		theme = Character.toString(theme.charAt(0)).toUpperCase() + theme.substring(1);

		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		int res = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");
		con.setAutoCommit(false);

		stmt = con.createStatement();
		
		boolean failure = false;

		stmt = con.createStatement();
		stmt.executeUpdate("CREATE TABLE IF NOT EXISTS sports " + 
			"(" + 
			"name varchar(15) NOT NULL PRIMARY KEY, " + 
			"subs int(2) NOT NULL DEFAULT 0, " + 
			"info varchar(160), " + 
			"theme varchar(25) DEFAULT 'Open'" + 
			")");

		try
		{
			res = stmt.executeUpdate("INSERT INTO sports VALUES " + 
			"(" + 
			"'" + sport + "', " + 
			sub_cats + ", " + 
			"'" + info + "', " + 
			"'" + theme + "' " + 
			")");

			out.println("<br> " + sport + " is created !");

			res = 0;

			stmt = con.createStatement();
				stmt.executeUpdate("CREATE TABLE IF NOT EXISTS categories " + 
				"(" + 
				"sport varchar(15) NOT NULL, " +
				"category varchar(15) NOT NULL, " + 
				"players int(2) NOT NULL, " + 
				"rounds int(2) NOT NULL, " + 
				"days int(2) NOT NULL, " + 
				"sport_key varchar(10) NOT NULL, " + 
				"price int(6) NOT NULL, " + 
				"location int(1), " + 
				"PRIMARY KEY (sport, category), " + 
				"FOREIGN KEY(sport) REFERENCES sports(name) ON DELETE CASCADE ON UPDATE CASCADE" + 
				")");

			String category, players, price, key;
			String rounds, days, location;
	
			for(int i = 1; i <= sub_cats; i++)
			{
				category = request.getParameter("Category " + i); 
				players = request.getParameter("Players_in_cat "+ i); 
				price = request.getParameter("Price "+ i); 
				rounds = request.getParameter("Rounds "+ i);
				days = request.getParameter("Days "+ i);
				location = request.getParameter("Location "+ i);
				key = sport.substring(0, 3) + "_" + category.substring(0, 4); 

				try
				{
					res = stmt.executeUpdate("INSERT INTO categories VALUES " + 
					"(" + 
					"'" + sport + "', " + 
					"'" + category + "', " + 
					players + ", " +  
					rounds + ", " +  
					days + ", " +  
					"'" + key + "', " + 
					price + ", " + 
					location + 
					")");

					out.println("<br> Sub category " + category + " is created !");
				}
				catch(Exception e)
				{
					out.println("<br> Error: Insertion of " + category + " of " + sport + " !");
					failure = true;
				}
			}

			if(sub_cats == 0)
			{
				price = request.getParameter("price");
				players = request.getParameter("players");
				rounds = request.getParameter("rounds");
				days = request.getParameter("days");
				location = request.getParameter("location");

				try
				{
					res = stmt.executeUpdate("INSERT INTO categories VALUES " + 
					"(" + 
					"'" + sport + "', " + 
					"'None', " + 
					players + ", " + 
					rounds + ", " +  
					days + ", " +
					"'" + sport.substring(0, 3) + "_None', " + 
					price + ", " + 
					location + 
					")");

					out.println("<br> With no sub category !");
				}
				catch(Exception e)
				{
					out.println("<br> Error: Insertion of " + sport + " into categories !");
					failure = true;
				}	
			}
		}
		catch(Exception e)
		{
			out.println("<br> Error: Insertion of " + sport + " ! <br> ");
			failure = true;
		}
		
		stmt = con.createStatement();
		if(failure)
			con.rollback();
		else
			con.commit();
	%>
	
	<br> <br> 
	
</body>

</html>