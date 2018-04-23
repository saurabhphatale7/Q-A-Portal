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
<body>

<%
PrintWriter pw=response.getWriter();
String Qname=request.getParameter("question");
String Qdetails=request.getParameter("questiondetail");
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
		if(Qname.isEmpty() || Qdetails.isEmpty())
		{
			
			rd=request.getRequestDispatcher("Welcome.html");
			rd.include(request, response);
			pw.print("<h3 style='text-align:center;color:red;' >Enter Proper Details!!</h3>");
		}
		else
		{
			hs=request.getSession(false);
			uid= (int) hs.getAttribute("id");	
			con = DriverManager.getConnection(url, usn, pwd);
			PreparedStatement pstmt=con.prepareStatement("insert into question(qname,qdetails,time,uno,status) values(?,?,now(),?,?);");
			pstmt.setString(1, Qname);
			pstmt.setString(2, Qdetails);
			pstmt.setInt(3, uid);
			pstmt.setString(4, "UnAnswerd");
			pstmt.execute();
			rd=request.getRequestDispatcher("Welcome.html");
			rd.include(request, response);
			pw.print("<h3 style='text-align:center;color:green;' >Question stored succesfully!!</h3>");
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