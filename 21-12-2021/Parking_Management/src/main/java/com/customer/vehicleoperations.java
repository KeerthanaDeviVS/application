package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Random;
import com.jdbcconnection.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/vehicleoperations")
public class vehicleoperations extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String slotcode;int floor_no,available_slots1,booked_slots1;
	int charge=0,available_slots2,booked_slots2;
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			Connection con = connectiondatabase.getConnection();
			PrintWriter out = resp.getWriter();
			SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm:ss");
		    LocalDate entry_date = LocalDate.now();
		    LocalTime entry_time = LocalTime.now();
		    LocalDate exit_date = LocalDate.now();
		    LocalTime exit_time = LocalTime.now();
			String action=req.getParameter("func");
			if(action.equals("park"))
			{
			String vehicle_type=req.getParameter("vehicle");
			String vehicle_num=req.getParameter("vehicle_no");
			String contact_num=req.getParameter("telphone");
//			String query4="update floors set status_of_slot = ? ,vehicle_num = ? where slot_code =? ";
//			String query5="insert into customerhistory values(?,?,?,?,?,?,?,?,?,?)";
//			String query2="update parkinglot set available_slots=?, booked_slots = ? where floor_number=?";
			Random random = new Random();
//			String query1="select floor_number,booked_slots,available_slots from parkinglot where available_slots>'0' and vehicle_type=?";
			PreparedStatement st1=con.prepareStatement("select floor_number,booked_slots,available_slots from parkinglot where available_slots>'0' and vehicle_type=?");
			st1.setString(1, vehicle_type);
			ResultSet rs1=st1.executeQuery();
			if(!(rs1.next()))
			{
				resp.getWriter().write("failure");
//				out.println("<meta http-equiv='refresh' content='3;URL=parking.jsp'>");
//				out.println("<p style='color:red;'>SLOT NOT AVAILABLE</p>");
			}
			else
			{
			floor_no=rs1.getInt(1);
			booked_slots1=rs1.getInt(2); 
			available_slots1=rs1.getInt(3);}
			PreparedStatement st2=con.prepareStatement("update parkinglot set available_slots=?, booked_slots = ? where floor_number=?");
			st2.setInt(1,available_slots1-1);
			st2.setInt(2, booked_slots1+1);
		    st2.setInt(3, floor_no);
		    st2.executeUpdate(); 
			String query3="select slot_code from floors where floor_number=? and status_of_slot= 'EMPTY' ORDER BY length(slot_code), slot_code limit 1";
			PreparedStatement st3=con.prepareStatement(query3);
			st3.setInt(1, floor_no);
			ResultSet rs=st3.executeQuery();
			rs.next();
			slotcode=rs.getString(1);
			PreparedStatement st4=con.prepareStatement("update floors set status_of_slot = ? ,vehicle_num = ? where slot_code =? ");
			st4.setString(1,"FULL");
			st4.setString(2, vehicle_num);
			st4.setString(3, slotcode);
			int cnt=st4.executeUpdate();
			PreparedStatement st5=con.prepareStatement("insert into customerhistory values(?,?,?,?,?,?,?,?,?,?)");
			int random_number=random.nextInt(10000);
			st5.setInt(1, random_number);
			st5.setInt(2, floor_no);
			st5.setString(3, slotcode);
			st5.setString(4, vehicle_num);
			st5.setString(5,contact_num);
			st5.setString(6,formatter1.format(entry_date));
			st5.setString(7, formatter2.format(entry_time));
			st5.setString(8, null);
			st5.setString(9,null);
			st5.setInt(10,0);
			st5.executeUpdate();
			st2.close();
			st3.close();
			st4.close();
			st5.close();
			if(cnt==1)
			{
				resp.getWriter().write(slotcode);

			}
			st1.close();
			}
			else if(action.equals("exit"))
			{
				String slot_no=req.getParameter("slotno");
//				String query1="select Parking_No,entry_time,floor_number from customerhistory where charge='0' and slot_code = ?";
//				String query2 ="update customerhistory set exit_time= ? ,charge=? ,exit_date = ? where charge='0' and slot_code = ?";
				PreparedStatement st1=con.prepareStatement("select Parking_No,entry_time,floor_number from customerhistory where charge='0' and slot_code = ?");
				st1.setString(1, slot_no);
				ResultSet rs=st1.executeQuery();
				if(!(rs.next()))
				{
					resp.getWriter().write("failure");
//					out.println("<meta http-equiv='refresh' content='3;URL=exit.jsp'>");
//					out.println("<p style='color:red;'>INVALID SLOT CODE.USE VALID ID</p>");
				}
				else {
					
					int parking_no=rs.getInt(1);
				String entry__time=rs.getString(2);
				int floor_number=rs.getInt(3);
				Date enter_time=format.parse(entry__time);
				Date exittime=format.parse(formatter2.format(exit_time));
				long time_diff=exittime.getTime()-enter_time.getTime();
				long time_diff_Mins = (time_diff / (60 * 1000))% 60;
				int mins=(int)time_diff_Mins;
				if(slot_no.contains("B"))
				charge=50+mins*10;
				else
					charge=100+mins*10;
				PreparedStatement st2=con.prepareStatement("update customerhistory set exit_time= ? ,charge=? ,exit_date = ? where charge='0' and slot_code = ?");
				st2.setString(1,formatter2.format(exit_time));
				st2.setInt(2, charge);
				st2.setString(3, formatter1.format(exit_date));
				st2.setString(4, slot_no);
				st2.executeUpdate();
				String query3="select available_slots,booked_slots from parkinglot where floor_number="+floor_number;
				Statement st3=con.createStatement();
				ResultSet rs1=st3.executeQuery(query3);
				rs1.next();
				available_slots2=rs1.getInt(1);
				booked_slots2=rs1.getInt(2);
//				String query4="update parkinglot set available_slots=?, booked_slots = ? where floor_number=?";
				PreparedStatement st4=con.prepareStatement("update parkinglot set available_slots=?, booked_slots = ? where floor_number=?");
				st4.setInt(1, available_slots2+1);
				st4.setInt(2, booked_slots2-1);
				st4.setInt(3, floor_number);
				st4.executeUpdate();
//				String query5="update floors set status_of_slot='EMPTY',vehicle_num='NIL' where slot_code=?";
				PreparedStatement st5=con.prepareStatement("update floors set status_of_slot='EMPTY',vehicle_num='NIL' where slot_code=?");
				st5.setString(1, slot_no);
		        st5.executeUpdate();
		        resp.getWriter().write(slot_no);
		        System.out.println(slot_no);
				st2.close();
				st3.close();
				st3.close();
				st4.close();
				st5.close();
				}
				st1.close();
			}
		} catch (SQLException | ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	

}
