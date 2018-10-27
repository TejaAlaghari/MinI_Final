<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> User Login </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	 
	
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
                    <li class="active"><a data-scroll href="registration.jsp">Register</a></li>
                    <li><a  href="#log">Login</a></li> 
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
			<h1 ><span>Login form</span></h1>
			</header> 
			
			<form action= "validate.jsp" method= "post">
				
			
				<p class="contact"><label for="name">UserName</label></p> 
							<input id="name" name="uname" placeholder="name" required="" tabindex="1" type="text"> 
				<p class="contact"><label for="password">Password</label></p> 
							<input id="password" name="pswd" placeholder="password" required="" tabindex="1" type="password"> 
							 <br>
				
				<input class="buttom" name="submit" id="submit" tabindex="5" value="Sign in!" type="submit"/><br>
				<a class="sign-up" href="registration.jsp">Sign Up!</a>
				<br>
   
			</div>

	  
	</section>
 	<%
	 	String msg = request.getParameter("msg");
	 	if(msg != null)
	 		out.println("<script type= 'text/javascript'>alert('" + msg + "'); </script>");
	%>
</body>
<!-- script -->
	<script src="bower_components/jquery/dist/jquery.min.js"></script>
	<script src="assets/js/main.js"></script>
</html>