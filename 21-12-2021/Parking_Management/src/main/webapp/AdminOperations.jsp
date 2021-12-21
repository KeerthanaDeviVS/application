<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<head><br><br>
<title>ADMIN OPERATIONS</title>
</head>
<style>
* {
   box-sizing: border-box;
   margin: 15px;
}
body
{
background-image: url("adminop.jpg");
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
div {text-align: center;}
</style>

<body>
<%

    if(session.getAttribute("user_name")==null)
    {
	  response.sendRedirect("AdminLogin.jsp");
    }


%>
<h1 style="text-align:center;font-size:100x"> ADMIN OPERATIONS </h1>
<div>
<a href="AddingFLoors.jsp">
<input type="button" class="button" value="ADD FLOORS"></a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="editingparkinglot.jsp">
<input type="button" class="button" value="EDIT PARKING SYSTEM"></a><br><br>
<a href="showtotalslots.jsp">
<input type="button" class="button" value="SHOW PARKING SYSTEM"></a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="viewcustomerhis.jsp">
<input type="button" class="button" value="CUSTOMER HISTORY"></a><br><br>
<a href="totalamt.jsp">
<input type="submit" class="button" value="TOTAL COLLECTION"></a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="welcomepage.html">
<input type="button" class="button" value="GO TO HOME PAGE"></a><br>
</div>
</body>
</html>