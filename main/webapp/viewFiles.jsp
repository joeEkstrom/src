<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File, edu.nbcc.constants.Constants, java.util.*"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Contents of File</title>
</head>
<body>
	<h1>File Content</h1>
	<form action="deleteFile.jsp" method="DELETE">  
	<table>  
		<%
		List<String> pathnames;
        File f = new File(Constants.FILE_PATH);
        pathnames = Arrays.asList(f.list());
        request.setAttribute("pathnames", pathnames);
		%>
		<tr>
			<td>
				<select name="files" id="files">
			    <option value="">--Select File Name--</option>
			    <c:if test="${!empty pathnames}">
			        <c:forEach items="${pathnames}" var="pathname" varStatus="loop">
			            <option value="${pathname}">${pathname}</option>
			        </c:forEach>
			    </c:if>
			</select>
			</td>
		</tr>
		
		<tr>
			<td colspan="2"><input type="submit" value="Delete File"/></td>
		</tr>
	</table>
	</form>
</body>
</html>