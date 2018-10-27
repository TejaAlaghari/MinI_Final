<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Registration </title>
	<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
	
	
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData md = null;
		PreparedStatement prepStmt = null;
		int i = 0, count = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","root","root");

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT COUNT(*) FROM categories");

		if(rs.next())
			count = Integer.parseInt(rs.getString(1));
	%>

	<script type = "text/javascript">

		var count = Number("<%= count %>");
		var games = new Array();

		for(var ind = 0; ind <= count + 1; ind++)
			games[ind] = new Array();

	</script>

	<%
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT sport, category FROM categories ORDER BY sport, category");

		out.println("<script type = 'text/javascript'>");

		out.println("games[" + i + "][0] = 'None'");
		out.println("games[" + i + "][1] = 'None'");
		out.println("games[" + i + "][2] = '1'");

		i++;

		while(rs.next())
		{
			out.println("games[" + i + "][0] = '" + rs.getString(1) + "'");
			out.println("games[" + i + "][1] = '" + rs.getString(2) + "'");
			out.println("games[" + i + "][2] = '1'");

			i++;
		}

		/*stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT name FROM sports where subs = 0 ORDER BY name");

		while(rs.next())
		{
			out.println("games[" + i + "][0] = '" + rs.getString(1) + "'");
			out.println("games[" + i + "][1] = 'None'");
			out.println("games[" + i + "][2] = '1'");

			i++;
		}*/

		out.println("</script>");

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
                    <li class="active"><a data-scroll href="#reg">Register</a></li>
                    <li><a  href="login.jsp">Login</a></li>   
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


	

	<script type = "text/javascript">

		var no = 1;

		var here = document.getElementById("here");

		function create_select(game, ind)
		{
			var select;
			var option;
			var dummy;
			var element_tr, element_td;

			select = document.createElement("SELECT");
			element_td = document.createElement("TD");

		    select.setAttribute("id", game);
		    select.setAttribute("name", game);

		    if(ind == 0)
		    {
		    	select.setAttribute("onchange", "change_gam(this)");

		    	element_tr = document.createElement("TR");
		    	element_tr.setAttribute("id", "tr" + no);

		    	document.getElementById("here").appendChild(element_tr);

		    	element_td.setAttribute("id", "td" + no + "_" + 1);
		    }
		    else
		    {
		    	select.setAttribute("onchange", "change_cat(this)");

		    	element_td.setAttribute("id", "td" + no + "_" + 2);
		    }

		    element_td.setAttribute("align", "center");

		    select.setAttribute("onfocus", "$(this).data('prev', this.value);");

		    select.setAttribute("class", "mySelect");

		    document.getElementById("tr" + no).appendChild(element_td);

		    element_td.appendChild(select);


		    // Adding Default Option 
		    option = document.createElement("option");
					    
			option.setAttribute("value", "None");
			var name = document.createTextNode("None");
					    
			option.appendChild(name);

			document.getElementById(game).appendChild(option);

			game.selectedIndex = 0;

		    if(ind == 1)
		    	return;

		    for(var i = 1; i <= count; i++) 
		    {
		    	if(games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][ind]);
				    name = document.createTextNode(games[i][ind]);
					    
				    option.appendChild(name);

				    document.getElementById(game).appendChild(option);
			    }
			}
		}

		function sortSelect(selElem) 
		{
		    var tmpAry = new Array();
		    var selected = selElem.value;
		    
		    for (var i = 0; i < selElem.options.length; i++) 
		    {
		        tmpAry[i] = new Array();
		        tmpAry[i][0] = selElem.options[i].text;
		        tmpAry[i][1] = selElem.options[i].value;
		    }
		    
		    tmpAry.sort();
		    
		    while (selElem.options.length > 0) {
		        selElem.options[0] = null;
		    }

		    for (var i = 0; i < tmpAry.length; i++) 
		    {
		        var op = new Option(tmpAry[i][0], tmpAry[i][1]);
		        selElem.options[i] = op;
		    }

		    selElem.value = selected;
		    
		    return;
		}

		function show_unique(ele)
		{
			var Target = document.forms[0][ele];
			var option = "";

			for(var i = 0; i < Target.options.length; i++)
			{
				option = Target.options[i].value;

				for(var j = i + 1; j < Target.options.length; j++)
				{
					if(Target.options[j].value === option)
						Target.remove(j--);
				}
			}
		}

		function update()
		{
			var searchPar = document.getElementById("here").children;
			var searchEles, ele;
			var gseleted = "";
			var cseleted = "";
			var option, name;

			var ind;

			for(var i = 0; i < searchPar.length; i++) 
			{

				ele = document.getElementById("gam" + searchPar[i].id.substring(2));

				if(ele != null)
				{
					ind = 0;
					gseleted = ele.value;

					var j = 0;
					while(++j < ele.options.length)
					{
						if(j == ele.selectedIndex)
							continue;

						ele.remove(j);
					}

					for(j = 1; j <= count; j++) 
		    		{
		    			if(games[j][2] === "1")
						{
						    option = document.createElement("option");
							    
						    option.setAttribute("value", games[j][ind]);
						    name = document.createTextNode(games[j][ind]);
							    
						    option.appendChild(name);

						    ele.appendChild(option);
			    		}
					}

					show_unique(ele.id);

					//searchEles[i].value = gseleted;
				}
				else
					continue;

				if(gseleted === "None")
					continue;

				ele = document.getElementById("cat" + searchPar[i].id.substring(2));

				//alert("i: " + i);

				if(ele != null)
				{
					ind = 1;
					cseleted = ele.value;

					var j = 0;
					while(++j < ele.options.length)
					{
						if(j == ele.selectedIndex)
							continue;

						ele.remove(j);
					}

					for(j = 1; j <= count; j++) 
		    		{
		    			if(games[j][0] === gseleted && games[j][2] === "1")
						{
						    option = document.createElement("option");
							    
						    option.setAttribute("value", games[j][ind]);
						    name = document.createTextNode(games[j][ind]);
							    
						    option.appendChild(name);

						    ele.appendChild(option);
			    		}
					}

					show_unique(ele.id);

					//searchEles[i].value = cseleted;
				}
			}
		}

		function change_gam(ele) 
		{
			var Target = document.getElementById("cat" + ele.id.substring(3));

			var index = 1;
			var last_changed = -1;

			var tvalue = Target.value;

			var pre_gam = $(ele).data("prev");

			// Adding New Options 
			while(Target.options.length != 1)
				Target.remove(index);

			for(var i = 1; i <= count; i++) 
		    {
		    	if(games[i][0] === ele.value && games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][1]);
				    var name = document.createTextNode(games[i][1]);
					    
				    option.appendChild(name);

				    Target.appendChild(option);
				}
			}

			while(index <= count)
			{
				if(games[index][0] === pre_gam && games[index][1] === tvalue)
					games[index][2] = "1";

				if(games[index][0] === ele.value && games[index][1] === Target.value)
					games[index][2] = "0";

				index++;
			}

			update();

		}

		function change_cat(ele)
		{
			var Target = document.getElementById("gam" + ele.id.substring(3));
			
			var option;

			var index = 1;

			var pre_gam = $(Target).data("prev");
			var pre_cat = $(ele).data("prev");

			while(index <= count)
			{
				if(games[index][0] === Target.value && games[index][1] === ele.value)
				{
					//alert("Blocked: " + games[index][0] + ", " + games[index][1]);
					games[index][2] = "0";
				}

				if(games[index][0] === pre_gam && games[index][1] === pre_cat)
					games[index][2] = "1";

				index++;
			}

			update();

		}

		function create_button(name, no)
		{
			var button;
			var txtNode;
			var element_td;

			var fnctn = "_game(this)";
			var id;

			if(name === "x")
				id = "purge";
			else
				id = "add";

			fnctn = id + fnctn;

			button = document.createElement("BUTTON");
				
			txtNode = document.createTextNode(name);
			button.appendChild(txtNode);
				
			button.setAttribute("type", "button");

			button.setAttribute("id", id + no);

			button.setAttribute("name", id + no);

			button.setAttribute("onclick", fnctn);


			element_td = document.createElement("TD");
			if(name === "x")
				element_td.setAttribute("id", "td" + no + "_" + 3);
			else
				element_td.setAttribute("id", "td" + no + "_" + 4);

			element_td.setAttribute("align", "center");
			document.getElementById("tr" + no).appendChild(element_td);
			element_td.appendChild(button);

		}

		function add_game(add)
		{
			var here = document.getElementById("here");
			var searchEles = document.getElementById("here").children;

			var button;
			var i, id;

			for(i = 0; i < searchEles.length; i++)
			{
				id = searchEles[i].id.substring(2);

				if(id === add.id.substring(3))
					break;
			}

			searchEles[i].removeChild(document.getElementById("td" + id + "_" + 4));
			//add.parentNode.removeChild(add);


			if(searchEles[i].children.length == 2)
				create_button("x", parseInt(id));

			create_select("gam" + no, 0);
			create_select("cat" + no, 1);

			show_unique("gam" + no);
			show_unique("cat" + no);

			create_button("x", no);

			create_button("+", no);

			no++;

		}

		function purge_game(purge)
		{
			var here = document.getElementById("here");
			var searchEles = document.getElementById("here").children;

			var id = purge.id.substring(5);
			var ele_g, ele_c, i = 0;

			ele_g = document.getElementById("gam" + id);
			ele_c = document.getElementById("cat" + id);

			while(++i <= count)
				if(games[i][0] === ele_g.value && games[i][1] === ele_c.value)
					games[i][2] = "1";


			for(i = 0; i < searchEles.length; i++)
			{
				if(searchEles[i].id.substring(2) === id)
					break;
			}

			if(searchEles[i].children.length == 4)
				create_button("+", parseInt(searchEles[i - 1].id.substring(2)));

			here.removeChild(searchEles[i]);

			update();

			searchEles = document.getElementById("here").children;

			if(searchEles.length == 2) 
				searchEles[1].removeChild(document.getElementById("td" + searchEles[1].id.substring(2) + "_" + 3));



		}

		function fill_extra(selElem)
		{
			if(selElem.options[selElem.selectedIndex].value === "Other")
				document.getElementById("extra").style.display = "block";
			else 
				document.getElementById("extra").style.display = "none";
		}

	</script>
		
<br>
<br>
		
		<section id="reg" class="section form">
		<div class="container">
               
			   <header>
				<h1 ><span>Registration form</span></h1>
            </header>   
    		<form action= "add_members.jsp" method= "post">
    			<p class="contact"><label >FirstName</label></p> 
    			<input name="fname" placeholder="First name" required="" tabindex="1" type="text"> 
    			 <p class="contact"><label >LastName</label></p> 
    			<input  name="lname" placeholder="last name" required="" tabindex="1" type="text"> 
    			 
    			<p class="contact"><label>Email</label></p> 
    			<input name="email" placeholder="example@domain.com" required="" type="email"> 
				
				<p class="contact"><label >Mobile phone</label></p> 
				<input name="phno" placeholder="phone number" required="" type="text"> <br>
		
                
                <p class="contact"><label >DateOfBirth</label></p> 
				<input type= "date" name="bday" min="1996-01-01"><br>
				
				<fieldset>
				<label>Enter your college</label>
				
				<select class="select-style" name= "clg" placeholder="collegename" required="" onChange= "return fill_extra(this)">
				
				<%
					stmt = con.createStatement();
					rs = stmt.executeQuery("SELECT DISTINCT college FROM logins where college NOT IN('None')");

					while(rs.next()) 
						out.println("<option value= '" + rs.getString("college") + "'> " + rs.getString("college"));
					out.println("<option> Other </option><br>");
				%>
				
				</select>
				<div id= "extra" style= "display: none;">
					<br>
					<label> Required * </label>
						&nbsp;
					<input type= "text" name = "clg_new" novalidate value= "">
				</div>
				<br>
				<br>

				
                </fieldset>
				
				<p class="contact"><label for="username">create a username</label></p> 
				<input name="uname" placeholder="username" type="text"> 
    			 
				 
				
				<p class="contact">
				<table cellspacing= "5" cellpadding= "5" id= "here" align= "left"></p>
						<tbody>
							<tr>
							<td><label>Game <td><label>Catogories
							 
								<script type="text/javascript">

									create_select("gam" + no, 0);
									create_select("cat" + no, 1);

									show_unique("gam1");
									show_unique("cat1");

									create_button("+", no);

									no++;

							</script>							
						</tr>
					</tbody>
				</table><br><br><br><br><br><br>				

			
  <input class="buttom" name="submit" id="submit" tabindex="5" value="Sign me up!" type="submit" > 	 
   </form> 
</div>      


	</section>
	</body>
				<script src="bower_components/jquery/dist/jquery.min.js"></script>

				<script src="assets/js/main.js"></script>
</html>