<%-- 
    Document   : process-delete
    Created on : Aug 11, 2023, 11:33:37 PM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>

<%
    try{
        String quiz_id = request.getParameter("quiz_id");
        Connection con = DBConnector.getConnection();
        String query = "DELETE FROM quiz WHERE quiz_id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, quiz_id);
        pstmt.executeUpdate();
        response.sendRedirect("teacher-index.jsp?error=0");
    }
    catch(Exception e){
        out.println(e.getMessage());
    }
%>