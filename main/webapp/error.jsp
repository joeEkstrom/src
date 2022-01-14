<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
</head>
<body>

	<p>Sorry, an error occurred!</p>
	<p><font color="red">Error: <%=exception.getMessage() %></font></p>
	<jsp:include page="index.jsp"></jsp:include> 

</body>
</html>