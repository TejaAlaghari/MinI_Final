<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

<html>

<head>

	<title> Forgot Password </title>
	
	
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	<style>
			input[type=submit] {
			background-color: #4CAF50;
			border: none;
			color: white;
			padding: 16px 32px;
			text-decoration: none;
			margin: 4px 2px;
			cursor: pointer;
			}</style>	
	 
	

</head>
<%
		int sent = 0;
		sent = Integer.parseInt(request.getParameter("sent"));
%>
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
                    <li><a  href="login.jsp">Login</a></li> 
					<li><a  href="#forget">Forget</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>					
                </ul>
            </div>
        </div><!-- /.container -->
    </nav>
	 <header id="site-header" class="site-header valign-center"> 
        
            <div class="intro">
                      
			<h1>   Sports Management</h1>
            
           </div>
    </header>
<br>
<br>

	<section id="forget" class="section form"> 


	<div class="container">
	<div class="col-sm-9 col-md-9 col-lg-10 content equal-height">
	<div class="content-area-right">
		
					
	<%
	
		if(sent == 0)
			out.println("<form action= 'sendEmail.jsp' method= 'post'>"
			+ "<p class='contact'><label >Email Address</label><input type= 'email' placeholder='Enter your valid emailid' name= 'email'/></p>"
			+ "<br> <br> <p class='contact'><input type= 'submit' value= 'Send Password' class='btn btn-primary' role='button'/></p>"
			+ "</form>"
			+ ")"
			);
		else
			out.println("P");
	%>

</center>

</body>

</html>