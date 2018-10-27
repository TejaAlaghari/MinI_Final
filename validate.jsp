<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> User Validation </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	
	
	<script type= "text/javascript">
		
		function form_submission(redirectURL, clg)
		{
			var form = document.getElementById("login");
			form.action = redirectURL;

			var inpfld = document.createElement("INPUT");
			inpfld.type = "hidden";
			inpfld.name = "clg";
			inpfld.value = clg;
			form.appendChild(inpfld);

			form.submit();
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
                    <li class="active"><a data-scroll href="login.jsp">Retry</a></li>
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


		<form id= 'login' action= '' method= 'post'>
		</form>
	
	<%
		String uname = request.getParameter("uname");
		String pswd  = request.getParameter("pswd");

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		int loggedin = 0;
		String redirectURL = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT * FROM logins WHERE user_name = '" + uname + "'");
		while(rs.next())
		{	
			loggedin = Integer.parseInt(rs.getString("special"));
				
			switch(loggedin)
			{
				case 1: redirectURL = "player.jsp"; break;
				case 2: redirectURL = "clg_head.jsp"; break;
				case 3: redirectURL = "admin.jsp"; break;
			}
			
			break;
		}

		if(loggedin > 0)
		{
			session.setAttribute("userName", uname);

			out.println("<script type= 'text/javascript'> "
				+ "form_submission('" + redirectURL + "', '" + rs.getString("college") + "');"
				+ " </script>");
			
			// response.sendRedirect(redirectURL + "?clg=" + rs.getString("college").toString());
		}

	%>

				<br>
		

</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>

</html>