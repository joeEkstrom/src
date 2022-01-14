<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.io.File, edu.nbcc.constants.Constants"%> 
<%
	String fileName = request.getParameter("files");

	File myObj = new File(Constants.FILE_PATH + fileName); 
    if (myObj.delete()) { 
    	response.sendRedirect("success-delete.jsp");
    } else {
    	throw new ServletException("File Not Found");
    }
%>
