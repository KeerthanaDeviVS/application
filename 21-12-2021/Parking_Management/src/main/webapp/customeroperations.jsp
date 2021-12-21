<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CUSTOMER OPERATIONS</title>
<style>
* {
   box-sizing: border-box;
   margin: 0;
   padding:15px;
}
body
{
background-image: url("customer.jpg");
height: 500px; 
 background-position: center;
  background-size: cover;
}
.button {
  background-color:#ffe4e1;
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  font-size: 16px;
  margin: 4px 2px;
}
.box {
  padding: 70px;
  width: 50%;
  position:absolute;
  top:15%;
  left:25%;
  background-color:rgb(0,0,0,0.5);
}
div {text-align: center;}
</style>

</head>
<body>
<div class="box">
<p style="font-size:100;color:white">CHARGES: BIKE    : Rs.50<br><br>
         CAR     : Rs.100<br><br>
         PER MIN : Rs.10<br><br></p>
<form action="parking.jsp" method="post">
<input type="submit" value="PARK"><br><br>
</form>
<form action="exit.jsp"> 
<input type="submit" value="VEHICLE EXIT"><br><br> 
</form>
<a href="welcomepage.html">
<input type="button" value="GO TO HOME PAGE"></a><br>
</div>
</body>
</html>