<!DOCTYPE html>
<html>
  <head>
    <title> Student Dashboard </title>
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
                    <li class="active"><a data-scroll href="player_games.jsp">Mygames</a></li>
                    <li><a  href="player_games_status.jsp">Status</a></li>  
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


  </body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>

</html>



