<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>PARK</title>
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
<!-- <form action="park" method="post"> -->
Enter your Name:<input type="text" name="customer_name"><br><br>
Enter your Vehicle Number:<input type="text" id="vehicle_num" name="vehicle_no"><br><br>
Enter your Contact Number:<input type="tel" id="phone" name="telphone"  pattern="[0-9]{10}"  title="Ten digits code" required/><br><br>
Select Vehicle Type<br><br>
<select  id="vehicle">
<option value="Bike">Bike</option>
<option value="Car">Car</option>

</select>
<br><br>
<!--  Tick Vehicle Type<br><br>
<input type="radio" name="vehicle" value="Bike">
<label for="vehicle"> Bike</label><br><br>
<input type="radio" name="vehicle" value="Car">
<label for="vehicle"> Car</label><br><br>
Click:<input type="submit" value="PROCEED TO PARK"><br><br>--> 
Click:<button onclick="park()">PROCEED TO PARK</button><br><br>
<a href="welcomepage.html">
<input type="button" value="GO TO HOME PAGE"></a><br>
<!--  </form>-->
</div>

</body>
<script>
function park()
{
	var action="park";
	var vehicle_number=$("#vehicle_num").val();
	var phone=$("#phone").val()
	var vehic=$("#vehicle").val();
	
	$.post("vehicleoperations",{
		func:action,
		vehicle_no:vehicle_number,
		telphone:phone, 
		vehicle:vehic
	},
	function(data,status)
	{
		if(data=="failure")
			{
			alert("SORRY!!!SLOTS NOT AVAILABLE");
			}
		else 
			{
			alert(" YOUR VEHICLE PARKED ON SLOTCODE :"+data);
			}
		
	})
	console.log(vehicle_number);
	console.log(phone);
	console.log(vehic);
	}
</script>

</html>