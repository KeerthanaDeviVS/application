package com.flooroperations;

import java.io.IOException;
import com.jdbcconnection.*;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/FloorOperations")
public class FloorOperations extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out=resp.getWriter();
		try {
			Connection con = connectiondatabase.getConnection();
//			Class.forName("com.mysql.jdbc.Driver");
//			Connection con=DriverManager.getConnection(vehicleoperations.url, vehicleoperations.User_name, vehicleoperations.Password);
			String param_function=req.getParameter("param");
			if(param_function.equals("add"))
			{
				String vehicle_type=req.getParameter("vehicle");
				int floor_num=Integer.parseInt(req.getParameter("floor_number"));
				int available_slots=Integer.parseInt(req.getParameter("available_slots"));
//				String query1="insert into parkinglot values(?,?,?,?)";
//				String query2="insert into floors values(?,?,?,?)";
				PreparedStatement st1=con.prepareStatement("insert into parkinglot values(?,?,?,?)");
				st1.setString(1,vehicle_type);
				st1.setInt(2, floor_num);
				st1.setInt(3, available_slots);
				st1.setInt(4, 0);
				int count=st1.executeUpdate();
				PreparedStatement st2=con.prepareStatement("insert into floors values(?,?,?,?)");
				for(int indx=1;indx<=available_slots;indx++)
				{
					st2.setInt(1, floor_num);
					if(vehicle_type.equals("Bike")) {
						st2.setString(2, String.format("%dB%d", floor_num,indx));}
						else 
						{
							st2.setString(2, String.format("%dC%d", floor_num,indx));
						}
					st2.setString(3, "EMPTY");
					st2.setString(4, "NIL");
					st2.executeUpdate();
				}
				st1.close();
				st2.close();
				resp.setContentType("text/plain"); 
		        resp.setCharacterEncoding("UTF-8");
				if(count==1)
				{
					resp.getWriter().write("success");
				}
			}
			else if(param_function.equals("edit"))
			{
				String add_or_delete=req.getParameter("AddDelete");
				int floor_num=Integer.parseInt(req.getParameter("floor_number"));
				int available_slots=Integer.parseInt(req.getParameter("available_slots")); 
				int duplicate_cnt=available_slots; String bike_or_car = null;
				String query1="select vehicle_type,available_slots,booked_slots from parkinglot where floor_number="+floor_num;
				String query2="update parkinglot set available_slots = ? where floor_number = ? " ;
				String query3=null;int cnt=0;
					if(add_or_delete.equals("ADD_EXTRA_SLOTS"))
					{
						query3="insert into floors values(?,?,?,?)";
					}
					else
					{
						query3="delete from floors where floor_number = ? order by slot_code desc limit 1";
					}
					Statement st1=con.createStatement();
					ResultSet rs=st1.executeQuery(query1);
					resp.setContentType("text/plain"); 
			        resp.setCharacterEncoding("UTF-8");
					if(!rs.next())
					{
						  cnt=1;
						resp.getWriter().write("failure");
//					  out.println("<meta http-equiv='refresh' content='3;URL=editingparkinglot.jsp'>");
//						 out.println("<p style='color:red;'>FLOOR NOT AVAILABLE!</p>");
					}
					else {
					int val=0,booked_count=0;
					val=rs.getInt(2);
					bike_or_car=rs.getString(1);
					booked_count=rs.getInt(3);
					int old_val=val;
					PreparedStatement st2=con.prepareStatement(query2);
					if(add_or_delete.equals("ADD_EXTRA_SLOTS")) {
					val+=available_slots;
					st2.setInt(1, val);
					st2.setInt(2, floor_num);
					st2.executeUpdate();
					}
					else if(add_or_delete.equals("DELETE_SLOTS") && val>=available_slots)
					{
						val-=available_slots;
						st2.setInt(1, val);
						st2.setInt(2, floor_num);
				       st2.executeUpdate();
					}
					else
					{  
						  cnt=1;
						resp.getWriter().write("slotnot");
//						 out.println("<meta http-equiv='refresh' content='3;URL=editingparkinglot.jsp'>");
//						 out.println("<p style='color:red;'>SLOTS NOT AVAILABLE!</p>");
						 
					}
					PreparedStatement st3=con.prepareStatement(query3);
					if(add_or_delete.equals("ADD_EXTRA_SLOTS"))
					{
					for(int indx=old_val+booked_count;indx<val+booked_count;indx++)
					{
						st3.setInt(1, floor_num);
						if(bike_or_car.equals("Bike")) {
						st3.setString(2, String.format("%dB%d", floor_num,indx));}
						else {
							st3.setString(2, String.format("%dC%d",floor_num,indx));
						}
						st3.setString(3, "EMPTY");
						st3.setString(4, "NIL");
						st3.executeUpdate();
					}
					}
					else if(add_or_delete.equals("DELETE_SLOTS") && old_val>=available_slots) {
						int count=1;
						while(count<=duplicate_cnt) {
						st3.setInt(1,floor_num);
						st3.executeUpdate();count++;}
						}
						
					if(cnt==0)
					{resp.getWriter().write("success");
//						out.println("<meta http-equiv='refresh' content='3;URL=AdminOperationsList.jsp'>");
//						   out.println("<p style='color:green;'>SLOTS EDITED SUCCESSFULLY!</p>");
					}
					   st2.close();
						st3.close();
			
					}
					st1.close();
					
			}
			else if(param_function.equals("viewhistory"))
			{
				String date=req.getParameter("dateday");
				String query="select * from customerhistory where exit_date = ?";
				PreparedStatement st1=con.prepareStatement(query);
			    st1.setString(1, date);
			    ResultSet rs=st1.executeQuery();
			    if(!(rs.next()))
				{
					resp.getWriter().write("failure");
				}
			    else {
					resp.getWriter().write(date);
				
			    }
			    st1.close();
			}
			else if(param_function.equals("totalamt")) {
				String date=req.getParameter("dateday"); 
				int total_amount=0;
				PreparedStatement st1=con.prepareStatement("select charge from customerhistory where exit_date = ?");
			    st1.setString(1, date);
			    ResultSet rs=st1.executeQuery();
			    if(!(rs.next()))
			    {
					resp.getWriter().print("failure");
				}
			    else {
				do
				{
				total_amount+=rs.getInt(1);
				
				}while(rs.next());
				resp.getWriter().print(total_amount);
			    }
			    
			}
			
	}
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	

}
