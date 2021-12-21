<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>CUSTOMER HISTORY</title>
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
  top:25%;
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
}%>
<div class="box">
Enter Date:<input type="text" name="dateday" id="dateday" placeholder="DD-MM-YYYY"><br><br>
<!-- Click:<input type="submit" value="GET HISTORY"><br><br> -->
Click:<button onclick="history()">GET HISTORY</button><br><br>
<a href="AdminOperations.jsp">
<input type="button" value="BACK"></a><br>
</div>
</body>
<script>
function history()
{
    var func="viewhistory";
    var date=$("#dateday").val();
    
    $.post("FloorOperations",{
    	dateday:date,
    	param:func
    },function(data,status)
    {
    	if(data=="failure")
    		{
    		     alert("NO CUSTOMER HISTORY ON :"+date);
    		}
    	else
    		{
    		
    		  window.location.assign("customerhistory.jsp?date="+data);
    		}
    });
    console.log(date);
}
</script>
</html>