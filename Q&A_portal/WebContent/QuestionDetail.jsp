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
<a href="Logout" style="margin-left: 9in;font-size: large;color:blue;">Logout</a>
<table>
<tr><td><img src="q&a.png" style="width:80px;height:70px;"></td><td></td><td></td><td></td><td></td><td></td>
<td><h1 style="text-align: left;" >Q&A Portal</h1><p>Problem shared is a problem solved!!</p></td></tr>
</table>
<%
PrintWriter pw=response.getWriter();
String Uname=request.getParameter("uname");

String driver="com.mysql.jdbc.Driver";
String url="jdbc:mysql://localhost:3306/Ibm";
String usn="root";
String pwd="root";
HttpSession hs;
hs=request.getSession(false);


try {
	int qno=Integer.parseInt(request.getParameter("qno"));
	Class.forName(driver);
	Connection con;
	con = DriverManager.getConnection(url, usn, pwd);
	Statement stmt=con.createStatement();
	ResultSet ra=stmt.executeQuery("select *from answer where qno='"+qno+"';");
	if(ra.next()==true)
	{
		PreparedStatement pstmt=con.prepareStatement("Update question set status='Answerd';");
		pstmt.execute();
	}		
	
	ResultSet rs=stmt.executeQuery("select *from question,user where question.qno='"+qno+"'and question.uno=user.uno;");
	rs.last();
	%>
	<form action="PostAnswer.jsp">
	<table border=""  >
<tr>
<td style='width:auto;'><%=rs.getString(8) %> 
<br><%=rs.getString(11) %>,
<%=rs.getString(12) %></td>
<td width="60%"><b><u>Question:</u></b><br>
<%=rs.getString(2) %>
<br><%=rs.getString(4) %> -  
 <font color="green"><%=rs.getString(6) %></font>
<br><br><b><u>Question_Details:
</b></u><br>
<%=rs.getString(3) %>
<br><br><input style="margin-right:auto; " type="submit" name="req" value=" PostAnswer ">
<input type="hidden" name="qid" value="<%=rs.getString(1)%>">
</td>
</tr>
</table>


</form>
	<% 
	Statement stmt1=con.createStatement();
	ResultSet rs1=stmt1.executeQuery("select *from user,answer where answer.qno='"+qno+"'and answer.uno=user.uno;");
	%>
	<br><b><u>Answers:</u></b>
	<%
	while(rs1.next())
	{
	%>
				
				<br><table border=""  >
			<tr>
			<td style="width: 15%"><%=rs1.getString(2) %> 
			<br><%=rs1.getString(5) %>
			<br><%=rs1.getString(6) %>
			</td>
			<td><b><u>Posted Answer:</u></b><br>
			<%=rs1.getString(8) %>
			<br><%=rs1.getString(9) %> -  
			<%if(rs1.getString(12).equals("Helpful"))
			{
				%><font color="blue"><%= rs1.getString(12)%></font>
			<%}
			else
			{
				%><font color="red"><%= rs1.getString(12)%></font>
			<%}
				%>
			
			<br><form action="Helpful.jsp">
			<input style="margin-right:auto; " type="submit" name="req" value=" Mark as Helpful ">
			<input type="hidden" name="aid" value=<%=rs1.getString(7) %>>
			</form>
			</td>
				</tr>
			</table>
	<% 
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


%>
</body>
</html>