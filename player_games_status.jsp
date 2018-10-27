<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> Status </title>
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
	
	
	<%
		String uname = session.getAttribute("userName").toString();

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		String query = "";

		query += "SELECT p.game, p.category, p.team, c.players, p.payment FROM player p, categories c ";
		query += "WHERE p.user_name = '" + uname + "' ";
		query += "AND p.sport = c.sport ";
		query += "AND p.category = c.category ";

		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
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
                    <li class="active"><a data-scroll href="#player_games">Mygames</a></li>
                    <!--<li><a  href="player_games_status.jsp">Status</a></li>-->  
					<li><a  href="logout.jsp">Logout</a></li> 
					<!--<li><a data-scroll href="player.jsp">Dashboard</a></li>-->	
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
	<section id="player_games" class="section form"> 
	<div class="container">
		<p class="contact">
		<table width= "50%" cellspacing= "5" cellpadding= "5" align= "center">
			<tr>
				<th> Game </th>
				<th> Category </th>

			</tr>
		</table></p>
	</div>
	</section>
</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>
				<script src="assets/js/main.js"></script>
</html>