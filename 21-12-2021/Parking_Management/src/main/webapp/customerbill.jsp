<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <% Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
<head>
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
</style>
<meta charset="ISO-8859-1">
<title>CUSTOMER BILL</title>
</head>
<body>

<%
String parking_no=(String)request.getParameter("slot_code");
System.out.println(parking_no);
String url="jdbc:mysql://localhost:3306/parkingsystem";
String user_name="root";
String pass="Magicalkd@11";
Connection con=DriverManager.getConnection(url, user_name, pass);
PreparedStatement st=con.prepareStatement("select * from customerhistory where  slot_code = ?");
st.setString(1,parking_no);
ResultSet rs=st.executeQuery();
%>

<%while(rs.next()){ %> 
<h2 style="font-size:100;text-align:center">THANK YOU FOR VISITING US!!!</h2>
<h1 style="font-size:100;text-align:center">YOUR BILL</h1>
<div class = "box">

PARKING NUMBER   : <%=rs.getInt(1) %><br>
FLOOR NUMBER     :<%=rs.getInt(2) %><br>
SLOT CODE        :<%=rs.getString(3) %><br>
VEHICLE NUMBER   :<%=rs.getString(4) %><br>
CONTACT NUMBER   :<%=rs.getString(5) %><br>
ENTRY DATE       :<%=rs.getString(6) %><br>
ENTRY TIME       :<%=rs.getString(7) %><br>
EXIT TIME        :<%=rs.getString(8) %><br>
EXIT DATE        :<%=rs.getString(9) %><br>
CHARGE           :<%=rs.getInt(10) %><br>

</div>
<% } %>
<a href="welcomepage.html">
<input type="button" value="GO TO HOME PAGE"></a><br>
</body>
</html>


















