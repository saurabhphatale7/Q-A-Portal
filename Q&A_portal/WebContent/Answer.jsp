<%@page import=" java.io.IOException" %>
<%@page import=" java.io.PrintWriter" %>
<%@page import=" java.sql.DriverManager" %>
<%@page import=" java.sql.PreparedStatement" %>
<%@page import=" java.sql.ResultSet" %>
<%@page import=" java.sql.SQLException" %>
<%@page import=" java.sql.Statement" %>
<%@page import=" javax.servlet.ServletException" %>
<%@page import=" javax.servlet.annotation.WebServlet" %>
<%@page import=" javax.servlet.http.HttpServlet" %>
<%@page import=" javax.servlet.http.HttpServletRequest" %>
<%@page import=" javax.servlet.http.HttpServletResponse" %>
<%@page import=" java.sql.Connection" %>
<%@page import=" javax.servlet.http.HttpSession" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
PrintWriter pw=response.getWriter();
String Aname=request.getParameter("answer");
//String Adetails=request.getParameter("questiondetail");
int Qid=Integer.parseInt(request.getParameter("qid"));
//String Uname=request.getParameter("uname");
String driver="com.mysql.jdbc.Driver";
String url="jdbc:mysql://localhost:3306/Ibm";
String usn="root";
String pwd="root";
RequestDispatcher rd;
HttpSession hs;
int uid ;

try {
		Class.forName(driver);
		Connection con;
		if(Aname.isEmpty())
		{
			
			rd=request.getRequestDispatcher("PostAnswer.jsp");
			rd.include(request, response);
			pw.print("<h3 style='text-align:center;color:red;' >Enter Proper Details!!</h3>");
		}
		else
		{
			hs=request.getSession(false);
			uid= (int) hs.getAttribute("id");	
			con = DriverManager.getConnection(url, usn, pwd);
			PreparedStatement pstmt=con.prepareStatement("insert into answer(aname,time,uno,qno,status) values(?,now(),?,?,?);");
			pstmt.setString(1, Aname);
			pstmt.setInt(2, uid);
			pstmt.setInt(3, Qid);
			pstmt.setString(4, "Yet not helpful");
			pstmt.execute();
			rd=request.getRequestDispatcher("Welcome.html");
			rd.include(request, response);
			pw.print("<h3 style='text-align:center;color:green;' >Answer stored succesfully!!</h3>");
		}	
		
	}
	catch (SQLException e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
		pw.print("exception");
	} catch (ClassNotFoundException e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
		pw.print("exception");
	}




%>
</body>
</html>