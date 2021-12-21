<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <% Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CUSTOMER HISTORY</title>
<style>
body
{
background-image: url("adminop.jpg");
height: 500px; 
 background-position: center;
  background-size: cover;
}
.center {
  margin-left: auto;
  margin-right: auto;
}
table {
  width: 75%;
  
}
th, td {
  text-align: left;
  padding: 16px;
}
</style>

</head>
<body>
<%

if(session.getAttribute("user_name")==null)
{
  response.sendRedirect("AdminLogin.jsp");
}
String entry_date=(String)request.getParameter("date");
System.out.println(entry_date);
String url="jdbc:mysql://localhost:3306/parkingsystem";
String user_name="root";
String pass="Magicalkd@11";
Connection con=DriverManager.getConnection(url, user_name, pass);
PreparedStatement st=con.prepareStatement("select * from customerhistory where entry_date = ?");
st.setString(1,entry_date);
ResultSet rs=st.executeQuery();
%>

<table class="center" border="1">
<tr>
<th style="background-color:rgb(255,255,255,0.5)">PARKING NUMBER</th>
<TH style="background-color:rgb(255,255,255,0.5)">FLOOR NUMBER </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> SLOT CODE </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> VEHICLE NUMBER </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> CONTACT NUMBER </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> ENTRY DATE </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> ENTRY TIME</TH>
<TH style="background-color:rgb(255,255,255,0.5)"> EXIT TIME </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> EXIT DATE </TH>
<TH style="background-color:rgb(255,255,255,0.5)"> CHARGE </TH>
</tr>
<%while(rs.next()){ %>
<tr> 
<td><%=rs.getInt(1) %></td>
<td><%=rs.getInt(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><%=rs.getString(7) %></td>
<td><%=rs.getString(8) %></td>
<td><%=rs.getString(9) %></td>
<td><%=rs.getInt(10) %></td>
</tr>
<% } %>
</table><br><br>
<a href="AdminOperations.jsp">
<input type="button" value="BACK"></a><br>
</body>
</html>