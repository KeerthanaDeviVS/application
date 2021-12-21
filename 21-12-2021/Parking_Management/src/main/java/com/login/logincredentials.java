
package com.login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.log.dao.LoginDAO;

@WebServlet("/login")
public class logincredentials extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=req.getParameter("user_name");
		String password=req.getParameter("passwd");
		LoginDAO dao=new LoginDAO();
		try {
			if(dao.checkcredentials(username, password))
			{
				HttpSession session=req.getSession();
				session.setAttribute("user_name",username);
				resp.sendRedirect("AdminOperations.jsp");
			}
			else
			{
				resp.sendRedirect("AdminLogin.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}




}
