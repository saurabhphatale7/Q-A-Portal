

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		String Uname=request.getParameter("uname");
		String Upass=request.getParameter("upwd");
		//System.out.println(Uname);
		//System.out.println(Upass);
		String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/Ibm";
		String usn="root";
		String pwd="root";
		RequestDispatcher rd;
		try
		{
			Class.forName(driver);
			Connection con;
			con = DriverManager.getConnection(url, usn, pwd);
			PreparedStatement pstmt=con.prepareStatement("select *from user where uname=?" );
			pstmt.setString(1,Uname);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next())
			{
				
				int id=rs.getInt(1);
				//System.out.println(id);
				String pwd1 = rs.getString(3);
						if(Upass.equals(pwd1))
						{
							HttpSession hs=request.getSession();
							hs.setAttribute("id",id);
							rd=request.getRequestDispatcher("Welcome.html");
							rd.forward(request, response);
						}
						else
						{
							rd=request.getRequestDispatcher("Login.html");
							rd.include(request, response);
							pw.print("<h3 style='text-align:center;color:red;' >Invalid Password!!</h3>");
						}
						
				}
				else
				{
					
					//pw.print("Invalid Username or Password!!");
					rd=request.getRequestDispatcher("Login.html");
					rd.include(request, response);
					pw.print("<h3 style='text-align:center;color:red;' >Invalid Username !!</h3>");
				}
					
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
