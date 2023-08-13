<%@page import="classes.DBConnector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<%
    Connection con = DBConnector.getConnection();
    String sql = "SELECT DISTINCT teacher.first_name, teacher.last_name, teacher.email, teacher.education, teacher.profile_pic, teacher.school, subject.subject_category FROM teacher, subject,quiz WHERE teacher.teacher_id = quiz.teacher_id AND quiz.subject_id = subject.subject_id;";
    PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Educators</title>
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

        <link rel="stylesheet" href="./css/teacher-interface.css">
        <link rel="stylesheet" href="./assets/fonts/fontawesome-all.min.css">

        <!-- BOOTSTRAP V 5.0 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

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
                            if(session.getAttribute("teacher_id") != null){
                            %>
                                <p class="h5 ms-auto"><a class="nav-link" href="teacher-index.jsp">Teacher - Home</a></p>
                            <%
                            }
                        %>
                    </div>

                    <div class="d-flex ms-auto order-5">
                        <%
                            if(session.getAttribute("teacher_id") == null && session.getAttribute("student_id") == null){
                            %>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'student-login.jsp'">Login</button>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'teacher-login.jsp'">For Educators</button>
                            <%
                            }
                            else{
                            %>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'process-logout.jsp'">Logout</button>
                            <%
                            }
                        %>                                           
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container mt-4">
            <h2 class="main-heading">About Demonstrators</h2>
            <hr>
            <div class="teachers-container">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
                    <!-- Teacher Card 1 -->
                    <% while (rs.next()) { %>   
                    <div class="col">
                        <div class="card teacher-card">
                            <img src="./assets/profile-pics/person1.jpg" class="card-img-top assets/img/T1" alt="Teacher 1">
                            <div class="card-body">
                                <h5 class="card-title"><% out.print(rs.getString("first_name") + " " + rs.getString("last_name")); %></h5>
                                <p class="card-text"><strong>Subject:</strong> <% out.print(rs.getString("subject_category")); %></p>
                                <p class="card-text"> <% out.print(rs.getString("education") + " at " + rs.getString("school")); %></p>
                                <p class="card-text"> <% out.print(rs.getString("email")); %></p>


                                <!-- Add more teacher details as needed -->
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    </body>

</html>