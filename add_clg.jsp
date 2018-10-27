<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    
	<link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="assets/css/main.css">
	
	<title> Adding College </title>
	<%
		if(session.getAttribute("userName") == null) {

	%>
	<script type="text/javascript">window.location.href = 'index.html';</script>
	<%
	}
	%>
	<script type= "text/javascript">
			
	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		String uname = request.getParameter("uname");
		String clg = request.getParameter("clg");

		if(uname != null)
		{
			String query;
		
			query = "INSERT INTO logins VALUES ( "
				+ "'" + uname + "', "
				+ "'" + clg + "', " 
				+ "2"
				+ ")";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			query = "CREATE TABLE IF NOT EXISTS finalized( "
				+ "sport_key varchar(20) NOT NULL REFERENCES categories.sport_key)";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			query = "ALTER TABLE finalized ADD COLUMN "
				+ "`" + clg + "` "
				+ "int(2) NOT NULL DEFAULT 0";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			out.println("alert('College " + clg + " Added !!');");
		}
		
	%>

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
                    <li class="active"><a data-scroll href="admin.jsp">Add New Sport</a></li>
                    <li><a  href="#add_clg">Add New College</a></li> 
					<li><a  href="rm_clg.jsp">Remove College</a></li> 
					<li><a  href="charts.jsp"> Visualize</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>		
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


<br>
<br>
	
	<section id="add_clg" class="section form"> 

		<div class="container">
               
			   <header>
				<h1 ><span>Add Collage</span></h1>
            </header>   
	

		<form action= "#" method= "post">
			<p class="contact"><label >UserName</label></p> 
    			<input  name="uname" placeholder="enter UserName" required="" tabindex="1" type="text">
			
							
			<p class="contact"><label >College</label></p> 
    			<input  name="clg" placeholder="enter Collage name to be added" required="" tabindex="1" type="text">
				
			<br>
			
		 <input class="buttom" name="submit" id="submit" tabindex="5" value="Add" type="submit"> 	 
 
			
		</form>
</div>
</section>
		

</body>
<!-- script -->
								<script src="bower_components/jquery/dist/jquery.min.js"></script>
								<script src="assets/js/main.js"></script>
</html>
			