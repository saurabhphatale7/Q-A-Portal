<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table>
<tr><td><img src="q&a.png" style="width:80px;height:70px;"></td><td></td><td></td><td></td><td></td><td></td>
<td><h1 style="text-align: left;" >Q&A Portal</h1><p>Problem shared is a problem solved!!</p></td></tr>
</table>
<form action="Answer.jsp">
<br><textarea name="answer" rows="7" cols="100" placeholder="Provide Your Answer Here"></textarea><br>
<br><input style="margin-left: 4in;"  type="Submit" name="req" value="Submit Answer">
<br><br>

<%
int Qid=Integer.parseInt(request.getParameter("qid"));
%>
<input type="hidden" name="qid" value="<%=Qid%>">
</form>
</body>
</html>