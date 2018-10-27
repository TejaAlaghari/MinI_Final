<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> Process </title>
	
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
		String gname = request.getParameter("gname");
		String cname = request.getParameter("cname");

		out.println(gname + ": " + cname); 
	%> 

	<%
		String uname = session.getAttribute("userName").toString();

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null, rs2 = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");
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
                        <img src="assets/images/logoo.jpg" alt="Logo" width="20%">
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
                   <li class="active"><a data-scroll href="#team">TeamFormation</a></li>
                   <!-- <li><a  href="player_games_status.jsp">Status</a></li> -->  
					<li><a  href="logout.jsp">Logout</a></li> 
					<li><a data-scroll href="player.jsp">Dashboard</a></li>		
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
	<section id="team" class="section form">
		<div class="container">
               
			   <header>
				<h1 ><span>Information about Sports/Events</span></h1>
            </header>  
	<br>
	<br>
	
               
		<hr>

		<%
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT team, payment FROM player WHERE user_name = '" + uname + "' AND game = '" + gname + "' AND category = '" + cname + "'");
			if(rs.next() && rs.getInt("payment") == 1)
			{
				out.println("<br> <p> Your team is successfully registered </p> <br> ");

				out.println("<form action= 'team.jsp' method= 'post'>");
				out.println("<input type= 'hidden' name= 'tname' value= '" + rs.getString("team") + "'>");
				out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
				out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

				out.println("<input type= 'submit' name= 'submit' value= 'Visit Team'>");
				out.println("</form>");	

				out.println("<br>");
			}
			else
			{
				stmt = con.createStatement();
				rs2 = stmt.executeQuery("SELECT players, price FROM categories WHERE sport = '" + gname + "' AND category = '" + cname + "'");
				if(rs2.next())
				{
					if(rs2.getInt("players") == 1)
					{
						out.println("<form action= 'payments.jsp' method= 'post'>");
						
						out.println("<input type= 'hidden' name= 'price' value= '" + rs2.getInt("price") + "'>");
						out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
						out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

						// out.println("<input type= 'hidden' name= 'tname' value= 'none'>");
						session.setAttribute("paying_team", "none");
						
						out.println("<input type= 'submit' name= 'submit' value= 'Pay'>");
						out.println("</form>");

						out.println("<br>");
					}
					else
					{
						if(rs.getString("team").equals("none"))
						{
							out.println("<form action= 'team.jsp' method= 'post'>");
							out.println("<input type= 'radio' name= 'configure' value= 'create'> Create </input> &nbsp; &nbsp;");
							out.println("<input type= 'radio' name= 'configure' value= 'join'> Join </input> <br>");

							out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
							out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

							out.println("<input type= 'text' name= 'tname'> <br> <br>");

							out.println("<input type= 'submit' name= 'submit' value= 'Submit Request'>");
						}
						else
						{
							out.println("<form action= 'team.jsp' method= 'post'>");
							out.println("<input type= 'hidden' name= 'tname' value= '" + rs.getString("team") + "'>");
							out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
							out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

							out.println("<input type= 'submit' name= 'submit' value= 'Visit Team'>");
							out.println("</form>");

							out.println("<br>");	
						}
					}
				}
			}
		%>
	</div>
	</section>
</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>
</html>