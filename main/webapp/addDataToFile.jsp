<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Content to File</title>  
</head>
<body>

	<h1>Add Data to File</h1>  
	<form action="updateFile.jsp" method="PUT">  
	<table>  
		<tr>
			<td>File Name:</td>
			<td><input type="text" name="fileName"/></td>
		</tr>  
		<tr>
			<td>Contents of the File:</td>
			<td>
				<textarea rows = "5" cols = "60" name = "description" placeholder="Enter content here.."></textarea>
         	</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="Add Content"/></td>
		</tr>
	</table>
	</form>

</body>
</html>