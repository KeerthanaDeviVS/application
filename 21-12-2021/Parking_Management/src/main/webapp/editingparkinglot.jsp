<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>EDIT PARKING LOT</title>
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
  overflow: hidden;
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
</style>
</head>
<body>
<%
if(session.getAttribute("user_name")==null)
{
  response.sendRedirect("AdminLogin.jsp");
}%>
<div class="box">
Select Your Option<br><br>

<select  id="AddDelete" name="AddDelete">
<option value="ADD_EXTRA_SLOTS">ADD EXTRA SLOTS</option>
<option value="DELETE_SLOTS">DELETE SLOTS</option>
</select>
<br><br>

<!-- 
<input type="radio" name="Add_/_Delete" value="ADD_EXTRA_SLOTS">
<label for="Add_/_Delete"> ADD EXTRA SLOTS</label><br><br>
<input type="radio" name="Add_/_Delete" value="DELETE_SLOTS">
<label for="Add_/_Delete"> DELETE SLOTS</label><br><br>
-->

Enter Floor Number:<input type="number" id="fn" name="floor_number"><br><br>
Enter Total_Slots to be added / deleted:<input type="number" id="as" name="available_slots"><br><br>
<!--  Click:<input type="submit" value="EDIT"><br><br>
Click:<button type="button" id="btn">EDIT</button><br><br>-->
Click:<button onclick="edit()">EDIT</button><br><br>
<a href="AdminOperations.jsp">
<input type="button" value="BACK"></a><br>
</div> 
</body>


<script>
function edit()
{
	var func="edit";
	var add_or_delete=$("#AddDelete").val();
	var floor=$("#fn").val();
	var slots=$("#as").val();

	$.post("FloorOperations",{
		AddDelete:add_or_delete,
		floor_number:floor,
		available_slots:slots,
		param:func
		
	},function(data,status){
		
		if(data=="success")
			{
			alert("FLOOR EDITED SUCCESSFULLY");
			}
		else if(data=="slotnot")
			{
			alert("SLOT NOT AVAILABLE");
			}
		else 
			{
			alert("FLOOR NOT AVAILABLE");
			}
	});


	console.log(add_or_delete);
	console.log(floor);
	console.log(slots);



	
	}
</script>

</html>