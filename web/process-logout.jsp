<%-- 
    Document   : process-logout
    Created on : Aug 8, 2023, 8:26:03 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("teacher_id") != null){
        session.invalidate();
        response.sendRedirect("teacher-login.jsp");
    }
    else if(session.getAttribute("student_id") != null){
        session.invalidate();
        response.sendRedirect("student-login.jsp");
    }
    else{
        response.sendRedirect("student-login.jsp");
    }
%>