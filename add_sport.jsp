<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Add New Sport </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	
	<%
		if(session.getAttribute("userName") == null) {
	%>
			<script type= "text/javascript"> window.location.href = 'index.html'; </script>
	<%
		}
	%>

	<%
		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		int res = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");
	%>

	<script type="text/javascript">
		var pr_row_cnt = 0;

		function addSubs()
		{
	    	var number = document.getElementById("subs").value;

	    	if(number == 0 || number == pr_row_cnt)
	    		return;

		    var categories;

		    if(pr_row_cnt == 0)
	    	{
	    		var cat = document.getElementById("cat");

	    		categories = document.createElement("th");
	    		categories.innerHTML = "Category";

	    		cat.appendChild(categories);

	    		var ele = document.getElementById("tr0");
	    		ele.parentNode.removeChild(ele);
	    		
	    	}

		    var here = document.getElementById("here");

		    var str = "";
		    while(pr_row_cnt < number)
		    {
		    	str = "";
		    	
		    	categories = document.createElement("tr");
		    	categories.id = "tr" + ++pr_row_cnt;

		    	str += '<td> <input type= "text" style="width: 50px"; name= "Players_in_cat ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" style="width: 50px"; name= "Rounds ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" style="width: 50px"; name= "Days ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" style="width: 50px"; name= "Price ' + pr_row_cnt + '" value= "0"> </td>';

				str += '<td> <input type= "radio" name= "Location ' + pr_row_cnt + '" value= "1"> In City </input> \
						<br /> \
  						<input type= "radio" name= "Location ' + pr_row_cnt + '" value= "0"> Out Of City </input>';
				
				str += '<td> <input type= "text" style="width: 50px"; name= "Category ' + pr_row_cnt + '"> </td>';
		    	
		    	categories.innerHTML = str;
		    	here.appendChild(categories);
		    }

		    while(pr_row_cnt > number)
		    {
		    	ele = document.getElementById("tr" + pr_row_cnt);
		    	ele.parentNode.removeChild(ele);

		    	pr_row_cnt--;
		    }
		}

		function fill_extra(select_ele)
		{
			var ele;
			var extra = document.getElementById("extra");

			if(select_ele.options[select_ele.selectedIndex].value === "Other")
			{
				ele = document.createElement("LABEL");
				ele.innerHTML = "Required:*";
				extra.appendChild(ele);

				extra.innerHTML += "&nbsp;";
				
				ele = document.createElement("INPUT");
				ele.type = "text";
				ele.name = "theme_new";
				ele.value = "";
				ele.required = true;

				extra.appendChild(ele);
			}
			else 
				extra.innerHTML = "";
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
                    <li class="active"><a  href="#add_sport">Add New Sport</a></li>
                    <li><a  href="add_clg.jsp">Add New College</a></li> 
					<li><a  href="rm_clg.jsp">Remove College</a></li> 
					<li><a data-scroll href="index.html">Home</a></li>	
					<li><a  href="charts.jsp"> Visualize</a></li> 
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
	
	<section id="add_sport" class="section form"> 

		<div class="container">
               
			   <header>
				<h1 ><span>Add Collage</span></h1>
            </header>   
	
<br>
	<form action= "add_sport_trgt.jsp" method= "post">
	<center>
		<label> Theme: </label>
		<select name= "theme" class="select-style" required=""  onChange= "return fill_extra(this)">
			<%
				out.println("<p class='contact'><option value= 'Open'> Open </option></p>");
				try {
					stmt = con.createStatement();
					rs = stmt.executeQuery("SELECT DISTINCT theme FROM sports");

					while(rs.next()) {
						if(!rs.getString("theme").equals("Open"))
							out.println("<option value= '" + rs.getString("theme") + "'> " + rs.getString("theme") + " </option>");
					}
				}
				catch(Exception e) {

				}
				out.println("<option value= 'Other'> Other </option>");
			%>
		</select>
		<br>
		<br>
		
		<div id= "extra"> </div>

		<label> Sport: </label>
		<input type= "text" style="width: 250px"; name= "sport">

		<br>
		<label> Sub Categories: </label>
		<input type= "text" style="width: 250px"; id= "subs" name= "subs" value= "0"> &nbsp; &nbsp; 
		
		<button type= "button" onclick= "addSubs()"> + </button> 

		<br />
		<br />
		<table border="0" cellspacing= "5"  cellpadding= "5" id= "here" width="100%">
			<tbody >
			<tr id= "cat">
				<th> <p class="contact"><label>Players</label></p> </th>
				<th> <p class="contact"><label>Rounds </label></p></th>
				
				<th> <p class="contact"><label>Days</label></p></th>
				<th> <p class="contact"><label>Price</label></p></th>
				<th><p class="contact"><label>Location</label></p></th>
			</tr>
			<tr id= "tr0">
				<td> <input type= "text" style="width: 50px"; name= "players" value= "1"> </td>

				<td> <input type= "text" style="width: 50px"; name= "rounds" value= "1"> </td>
					
				<td> <input type= "text" style="width: 50px"; name= "days" value= "1"> </td>

				<td> <input type= "text" style="width: 50px"; name= "price" value= "0"> </td>

				<td>
					<input type= "radio" name= "location" value= "1"><label> InCity</label>
					<br>
  					<input type= "radio" name= "location" value= "0"><label>OutOfCity</label>
  					<br >
					<br>
  				</td>
			</tr>
			</tbody>
		</table>

		<br>
		<p class="contact"><label> Info(any): </label></p>&nbsp;&nbsp;
		<textarea rows= "5" cols= "32">  </textarea>

		<br>
		<input type= "submit" class="buttom" name= "submit" value= "Proceed">
	</center>
	</form>
</div>
</section>
	</body>
	
	<script src="bower_components/jquery/dist/jquery.min.js"></script>
	<script src="assets/js/main.js"></script>
</html>