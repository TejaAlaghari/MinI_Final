<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>

	<title> Remove College </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	<link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
	
	<%
		if(session.getAttribute("userName") == null) {

	%>
	<script type="text/javascript">window.location.href = 'index.html';</script>
	<%
	}
	%>
	
	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		String[] selectedClgs = request.getParameterValues("clgs");
		String query;
	%>

	<script type= "text/javascript">
		
		var clg = new Array();

	<%
		if(selectedClgs != null)
		{
			for(int i = 0; i < selectedClgs.length; i++)
			{
				query = "DELETE FROM logins WHERE college = '" + selectedClgs[i] + "'";

				stmt = con.createStatement();
				stmt.executeUpdate(query);

				query = "ALTER TABLE finalized DROP COLUMN " + selectedClgs[i];

				stmt = con.createStatement();
				stmt.executeUpdate(query);

				out.println("alert('College " + selectedClgs[i] + " Deleted !!');");
			}
		}

		query = "SELECT DISTINCT college FROM logins WHERE college <> 'null'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);

		int i = 0;
		while(rs.next())
			out.println("clg[" + i++ + "] = '" + rs.getString(1) + "'");
	%>

	function add_chkbxs()
	{
		var chkbx, label;

		for(var i = 0; i < Number(<%= i %>); i++)
		{
			label = document.createElement("LABEL");

			chkbx = document.createElement("INPUT");
			chkbx.type = "checkbox";
			chkbx.name = "clgs";
			chkbx.value = clg[i];

			label.appendChild(chkbx);
			label.appendChild(document.createTextNode(clg[i]));


			document.forms[0].appendChild(document.createElement("BR"));
			document.forms[0].appendChild(label);
		}
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
                    <li class="active"><a data-scroll href="admin.jsp">Add New Sport</a></li>
                    <li><a  href="add_clg.jsp">Add New College</a></li> 
					<li><a  href="#rm_clg">Remove College</a></li> 
					<li><a  href="charts.jsp"> Visualize</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>	
					<li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div><!-- /.container -->
    </nav>
	 <header id="site-header" class="site-header valign-center"> 
        
            <div class="intro">
                      
			<h1>   Sports Management
            
           </div>
    </header>	
	
		
		<section id="rm_clg" class="section form"> 

		<div class="container" >
               
			   <header>
				<h3 ><span>Remove Collage</span></h3>
            </header>   
		<form action= "#" method = "post">

			<script type= "text/javascript">
			
				add_chkbxs();
			</script>

		<br> <br>
 <input class="buttom" name="submit" id="submit" tabindex="5" value="submit" type="submit" align="center"> 	 
 
			
		<!-- <input class="button" type= "submit" name= "submit" value= "submit">-->
		</form>
	
			
</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>

</html>
		