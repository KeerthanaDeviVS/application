<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADMIN LOGIN</title>
<style>
* {
   box-sizing: border-box;
   margin: 0;
}
body
{
background-image: url("loginpage.jpg");
height: 500px; 
 background-position: center;
  background-size: cover;
}
.box {
  padding: 70px;
  width: 50%;
  position:absolute;
  top:25%;
  left:25%;
  background-color:rgb(255,255,255,0.7);
}
div {text-align: center;}
</style>
</head>
<body>
<div class="box">  
<form action="login" method="post">

Enter Username:<input type="text" name="user_name" placeholder="Name"><br><br>
Enter Password:<input type="password" name="passwd" placeholder="Password"><br><br>
Click:<input type="submit" value="LOGIN"><br><br>
<a href="welcomepage.html">
<input type="button" class="button" value="GO TO HOME PAGE"></a><br>
</form>

</div>
</body>
</html>