<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <% Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>EXIT</title>
<style>
* {
   box-sizing: border-box;
   margin: 0;
}
body
{
background-image: url("customer.jpg");
height: 500px; 
 background-position: center;
  background-size: cover;
}
.box {
  padding: 70px;
  width: 50%;
  position:absolute;
  top:15%;
  left:25%;
  background-color:rgb(255,255,255,0.7);
}
div {text-align: center;}
</style>
</head>
<body>
<div class="box">

Enter Your Slot Code : <input type="text" id="slot_no" name="slot_no"><br><br>
Click:<button onclick="exit()">EXIT VEHICLE</button><br><br> 
<!-- Click:<input type="submit" value="EXIT VEHICLE"><br><br>-->
<a href="welcomepage.html">
<input type="button" value="GO TO HOME PAGE"></a><br>
</div>
</body>

<script>
function exit()
{
	var action="exit";
	var slot_code=$("#slot_no").val();
	var parking_no=0;
	$.post("vehicleoperations",{
		func:action,
		slotno:slot_code 
	},function(data,success)
	{
		console.log(data);
		if(data=="failure")
			{
			alert("INVALID SLOT CODE.USE VALID ID");
			}
		else
			{
			 window.location.assign("customerbill.jsp?slot_code="+data);
			}
		
	})
	
	console.log(1);
	}

</script>
</html>