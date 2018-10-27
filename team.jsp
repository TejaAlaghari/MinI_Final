<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>

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
		
		String gname = request.getParameter("gname");
		String cname = request.getParameter("cname");
		String tname = request.getParameter("tname");

		out.println("<title> " + tname + " </title>");

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		String query;
		int mem_cnt = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		String configure = request.getParameter("configure");
		if(configure != null)
		{
			query = "";
			
			query += "UPDATE player SET team = '" + tname + "' ";
			
			if(configure.equals("create"))
				query += ", admin = 1 ";
			
			query += "WHERE user_name = '" + uname + "' ";
			query += "AND game = '" + gname + "' ";
			query += "AND category = '" + cname + "'";
			
			stmt = con.createStatement();
			stmt.execute(query);
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
                    <li><a  href="#info">Team Information</a></li>   
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
	<br>
	<br>
	<br>
	<section id="info" class="section form">
		<div class="container">
               <br>
			   <br>
			   <header>
				<h1 ><span>Information about Team</span></h1>
            </header>  
	               <br>
		<center><p class="contact">
		<table align= "center" border id= "members" width= "50%"></p>
			<p class="contact"><tr> 
				<th> First Name </th> 
				<th> Last Name </th> 
				<th> Payment </th>
			</tr></p>

			<%
				query = "";

				query += "SELECT m.first_name, m.last_name, p.admin, p.payment FROM members m, player p ";
				query += "WHERE p.team = '" + tname + "' ";
				query += "AND game = '" + gname + "' ";
				query += "AND category = '" + cname + "' ";
				query += "AND p.user_name = m.user_name ";
				query += "ORDER BY p.admin DESC";

				stmt = con.createStatement();
				rs = stmt.executeQuery(query);
				
				String row;
				while(rs.next())
				{
					row = "";

					row += "<tr>";
					row += "<td align= 'center'> " + rs.getString("first_name") + "</td>";
					row += "<td align= 'center'> " + rs.getString("last_name") + "</td>";
					if(rs.getInt("payment") == 1)
						row += "<td align= 'center'> Done </td>";
					else
					{
						mem_cnt++;
						row += "<td align= 'center'> Pending </td>";
					}
					row += "</tr>";

					out.println(row);
				}
			%>
		</table>

		<%			
			query = "";
			query += "SELECT players, price FROM categories ";
			query += "WHERE sport = '" + gname + "' ";
			query += "AND category = '" + cname + "'";

			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				if(rs.getInt("players") == mem_cnt)
				{
					out.println("<form action= 'payments.jsp' method= 'post'>");
					
					out.println("<input type= 'hidden' name= 'price' value= '" + rs.getInt("price") + "'>");
					out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
					out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

					// out.println("<input type= 'hidden' name= 'tname' value= '" + tname + "'>");
					session.setAttribute("paying_team", tname);
					
					out.println("<br> <input type= 'submit' name= 'submit' value= 'Pay'>");
					out.println("</form>");

					out.println("<br>");
				}
				else if(mem_cnt == 0)
					out.println("<br> <br> <p> *Team registration is complete </p>");
				else
					out.println("<br> <br> <p> *Pay option is available after all members are registerd ! </p>");
			}
		%>

			
	</center>
</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>

</html>