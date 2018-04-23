

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
 * Servlet implementation class AllQuestion
 */
@WebServlet("/AllQuestion")
public class AllQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllQuestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/Ibm";
		String usn="root";
		String pwd="root";
		try {
			Class.forName(driver);
			Connection con;
			con = DriverManager.getConnection(url, usn, pwd);
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select *from question");
			RequestDispatcher rd=request.getRequestDispatcher("Welcome.html");
			rd.include(request, response);
			pw.print("<table  border='' >");
			while(rs.next())
					{
				pw.print("<tr><td style='width:auto;'><a href='QuestionDetail.jsp?qno="+rs.getInt(1)+"'>"+rs.getInt(1)+"</a></td>");
				pw.print(" <td style='width:auto;'>"+rs.getString(2)+"</td>");
				pw.print(" <td style='width:auto;'>"+rs.getString(4)+"</td>");
				pw.print(" <td style='width:auto;'>"+rs.getString(6)+"</td>");
				pw.print(" </tr>");
					}
			pw.print("</table>");
			stmt.close();
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
