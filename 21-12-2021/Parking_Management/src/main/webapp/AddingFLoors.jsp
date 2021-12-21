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
<title>ADD FLOORS</title>
<style>
* {
   box-sizing: border-box;
   margin: 0;
}
body
{
background-image: url("adminop.jpg");
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
.button {
  background-color:#d3d3d3;
}
div {text-align: center;}
</style>
</head>
<body>
<%
if(session.getAttribute("user_name")==null)
{
  response.sendRedirect("AdminLogin.jsp");
}
%>
<div class="box">  


Select Vehicle Type<br><br>
<select  id="vehicle">
<option value="Bike">Bike</option>
<option value="Car">Car</option>

</select>
<br><br>
Enter Floor Number:<input type="number" id="fn" name="floor_number"><br><br>
Enter Total_Slots:<input type="number" id="as" name="available_slots"><br><br>
Click:<button onclick="book()">ADD</button><br><br>
<a href="AdminOperations.jsp">
<input type="button" class="button" value="BACK"></a><br>


</div>  
</body>
<script type="text/javascript">

function book()
{
	var func="add";
var vehic=$("#vehicle").val();
var floor=$("#fn").val();
var slots=$("#as").val();

$.post("FloorOperations",{
	vehicle:vehic,
	floor_number:floor,
	available_slots:slots,
	param:func
	
},function(data,status){
	
	if(data=="success")
		{
		alert("FLOOR ADDED SUCCESSFULLY");
		}
	
	
	
});


console.log(vehic);
console.log(floor);
console.log(slots);

}










</script>
</html>
