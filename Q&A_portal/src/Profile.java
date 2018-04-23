

import java.io.IOException;
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

/**
 * Servlet implementation class Profile
 */
@WebServlet("/Profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		String Rname=request.getParameter("rname");
		String RPass=request.getParameter("rpwd");
		String Rmail=request.getParameter("remail");
		String Rstate=request.getParameter("rstate");
		String Rcountry=request.getParameter("rcountry");
		String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/Ibm";
		String usn="root";
		String pwd="root";
	
		try {
			Class.forName(driver);
			Connection con;
			con = DriverManager.getConnection(url, usn, pwd);
			PreparedStatement pstmt=con.prepareStatement("insert into user(uname,password,email,state,country)values(?,?,?,?,?)");
			pstmt.setString(1, Rname);
			pstmt.setString(2, RPass);
			pstmt.setString(3, Rmail);
			pstmt.setString(4, Rstate);
			pstmt.setString(5, Rcountry);
			if(Rname.isEmpty() || RPass.isEmpty() || Rmail.isEmpty() || Rstate.isEmpty() || Rcountry.isEmpty())
			{
			
				RequestDispatcher rd=request.getRequestDispatcher("Register.html");
				rd.include(request, response);
				pw.print("<h3 style='text-align:center;color:red;' >Please don't leave any field empty!!</h3>");
			}
			else
			{	
				pstmt.execute();
				
				RequestDispatcher rd=request.getRequestDispatcher("Login.html");
				rd.include(request, response);
				pw.print("<h3 style='text-align:center;color:green;' >Successfully Registerd!!</h3>");
				
				
			}
			pstmt.close();
			con.close();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
