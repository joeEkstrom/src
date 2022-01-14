<%@page import="java.io.IOException, java.io.FileWriter, edu.nbcc.constants.Constants"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>

<%
String fileName = request.getParameter("fileName");
String fileContent = request.getParameter("description");

FileWriter myWriter = new FileWriter(Constants.FILE_PATH + fileName);
myWriter.write(fileContent);
myWriter.close();
response.sendRedirect("success-save.jsp");

%>