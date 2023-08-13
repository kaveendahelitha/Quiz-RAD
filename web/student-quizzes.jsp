<%-- 
    Document   : student-quizzes
    Created on : Aug 12, 2023, 12:45:01 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList" %>

<%
    String student_id = String.valueOf(session.getAttribute("student_id"));
    Connection con = DBConnector.getConnection();
    String query = "SELECT DISTINCT subject.subject_id, subject.subject_category, subject.subject_level FROM subject, quiz WHERE quiz.subject_id = subject.subject_id";
    PreparedStatement pstmt = con.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Subjects</title>
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="./css/style-main.css">
    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
            <div class="container-fluid nav">
                <a class="navbar-brand" href="index.jsp">WeQuiz</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse " id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                        <a class="nav-link" href="student-quizzes.jsp">Quizzes</a>
                        <a class="nav-link" href="student-educators.jsp">Educators</a> 
                        <a class="nav-link" href="student-settings.jsp">Settings</a>        
                        <%
                            if (session.getAttribute("teacher_id") != null) {
                        %>
                        <p class="h5 ms-auto"><a class="nav-link" href="teacher-index.jsp">Teacher - Home</a></p>
                        <%
                            }
                        %>
                    </div>

                    <div class="d-flex ms-auto order-5">
                        <%
                            if (session.getAttribute("teacher_id") == null && session.getAttribute("student_id") == null) {
                        %>
                        <button type="button" class="btn btn-primary me-3" onclick="location.href = 'student-login.jsp'">Login</button>
                        <button type="button" class="btn btn-primary me-3" onclick="location.href = 'teacher-login.jsp'">For Educators</button>
                        <%
                        } else {
                        %>
                        <button type="button" class="btn btn-primary me-3" onclick="location.href = 'process-logout.jsp'">Logout</button>
                        <%
                            }
                        %>                                           
                    </div>
                </div>
            </div>
        </nav>


        <main>
            <div class="container-md">             
                <div>
                    <%
                        while(rs.next()){
                        %>
                            <div class="row mt-5">
                                <div class="col">
                                    <h4 class="display-6"><% out.println(rs.getString("subject_level") + " - " + rs.getString("subject_category")); %></h4>
                                </div>
                                <%
                                    String query2 = "SELECT * FROM quiz WHERE subject_id = ?";
                                    PreparedStatement pstmt2 = con.prepareStatement(query2);
                                    pstmt2.setString(1, rs.getString("subject_id"));
                                    ResultSet rs2 = pstmt2.executeQuery();
                                    while(rs2.next()){
                                        %>
                                        <div class="row mt-5">
                                            <div class="col">
                                                <div class="container mb-3">
                                                    <div class="cards">
                                                        <div class="row">
                                                            <div class="col text-center">
                                                                <h5 class="h5 mt-2"><%= rs2.getString("quiz_title") %></h5>
                                                            </div>
                                                            <div class="col text-center">
                                                                <p class="mt-2">
                                                                    <% 
                                                                        if(rs2.getBoolean("is_public")){
                                                                            out.println("Public");
                                                                        }  
                                                                        else{
                                                                            out.println("Private");
                                                                        }
                                                                    %>                        
                                                                </p>
                                                            </div>
                                                            <div class="col text-center">
                                                                <%
                                                                    ArrayList <String> attempts = new ArrayList();
                                                                    String query3 = "SELECT DISTINCT student_id FROM student_answer WHERE quiz_id=?";
                                                                    PreparedStatement pstmt3 = con.prepareStatement(query3);
                                                                    pstmt3.setString(1, rs2.getString("quiz_id"));
                                                                    ResultSet rs3 = pstmt3.executeQuery();
                                                                    while(rs3.next()){
                                                                        attempts.add(rs3.getString("student_id"));
                                                                    }
                                                                    
                                                                    if(!attempts.contains(student_id)){
                                                                        %>
                                                                        <button class="btn btn-primary mt-2" disabled="">View Last Attempt</button>
                                                                        <%
                                                                    }
                                                                    else{
                                                                        %>
                                                                        <button class="btn btn-primary mt-2" onclick="location.href = 'student-view-quiz.jsp?quiz_id=<%= rs2.getString("quiz_id") %>'">View Last Attempt</button>
                                                                        <%
                                                                    }
                                                                %>                                                          
                                                                <button class="btn btn-primary mt-2">Leaderboard</button>
                                                                <button class="btn btn-primary mt-2" onclick="location.href = 'student-quiz.jsp?quiz_id=<%= rs2.getString("quiz_id") %>'">Attempt</button>
                                                            </div>  
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                    }
                                %>
                            </div>
                        <%
                        }
                    %>
                    
                    <%--
                        while(rs.next()){
                            %>
                            <div class="row mt-5">
                                <div class="col">
                                    <div class="container mb-3">
                                        <div class="cards">
                                            <div class="row">
                                                <div class="col text-center">
                                                    <h5 class="h5 mt-2"><%= rs.getString("quiz_title") %></h5>
                                                </div>
                                                <div class="col text-center">
                                                    <p class="mt-2">
                                                        <% 
                                                            if(rs.getBoolean("is_public")){
                                                                out.println("Public");
                                                            }  
                                                            else{
                                                                out.println("Private");
                                                            }
                                                        %>                        
                                                    </p>
                                                </div>
                                                <div class="col text-center">
                                                    <button class="btn btn-primary mt-2" onclick="location.href = 'student-view-quiz.jsp'">View Last Attempt</button>
                                                    <button class="btn btn-primary mt-2">Leaderboard</button>
                                                    <button class="btn btn-primary mt-2" onclick="location.href = 'student-quiz.jsp'">Attempt</button>
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                        }
                    --%>                                
                </div>
            </div>
        </main>

        <footer class="bg-light text-center mt-5" style="position: relative;">
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2023 All rights reserved:
                <a class="text-dark" href="index.html">WeQuiz</a>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>