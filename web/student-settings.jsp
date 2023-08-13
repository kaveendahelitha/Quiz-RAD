<%-- 
    Document   : psett_std
    Created on : Aug 10, 2023, 12:52:25 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="classes.MD5" %>
<%@page import="classes.DBConnector"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Account Settings</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
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

                    <div class=" justify-content-end">
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

        <%
            String up = request.getParameter("update");
            if (up != null) {
                String fname_up = request.getParameter("fname");
                String lname_up = request.getParameter("lname");
                String uname_up = request.getParameter("uname");
                String email_up = request.getParameter("email");
                String pw_up = request.getParameter("pw_old");
                String url = "sssssss";
                String id = request.getParameter("std_id");
                String query_up = "UPDATE student SET first_name=?, last_name=?, email=?, username=?, password=?, profile_pic_url=? WHERE student_id = ?";
                Connection con = DBConnector.getConnection();
                PreparedStatement pstmt = con.prepareStatement(query_up);
                pstmt.setString(1, fname_up);
                pstmt.setString(2, lname_up);
                pstmt.setString(3, email_up);
                pstmt.setString(4, uname_up);
                pstmt.setString(5, pw_up);
                pstmt.setString(6, url);
                pstmt.setString(7, id);

                int a = pstmt.executeUpdate();
                if (a > 0) {
                    out.println("<h1 class='text-center' style='color:green;'>Successfully Updated </h1>");
                } else {
                    out.println("<h1 class='text-center' style='color:red;'> Update Didnot  </h1>");
                }
            }


        %>



        <%            String query = "SELECT * FROM student WHERE student_id = '1'";
            Connection con = DBConnector.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String fname = rs.getString("first_name");
                String lname = rs.getString("last_name");
                String email = rs.getString("email");
                String uname = rs.getString("username");
                int id = rs.getInt("student_id");
                String pw = rs.getString("password");
        %>
        <section class="py-5 my-5">
            <div class="container">
                <h1 class="mb-5">Student Account Settings</h1>
                <form method="POST" action="psett_std.jsp?update=<%= rs.getInt("student_id")%>">
                    <div class="bg-white shadow rounded-lg d-block d-sm-flex">
                        <div class="profile-tab-nav border-right">
                            <div class="p-4">
                                <div class="img-circle text-center mb-3">
                                    <img src="img/kasun.jpg" alt="Image" class="shadow">
                                </div>
                                <h4 class="text-center"><% out.println(fname + " " + lname);%></h4>
                            </div>
                            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                <a class="nav-link active" id="account-tab" data-toggle="pill" href="#account" role="tab" aria-controls="account" aria-selected="true">
                                    <i class="fa fa-home text-center mr-1"></i> 
                                    Account
                                </a>
                                <a class="nav-link" id="password-tab" data-toggle="pill" href="#password" role="tab" aria-controls="password" aria-selected="false">
                                    <i class="fa fa-key text-center mr-1"></i> 
                                    Password
                                </a>
                                <a class="nav-link" id="notification-tab" data-toggle="pill" href="#notification" role="tab" aria-controls="notification" aria-selected="false">
                                    <i class="fa fa-bell text-center mr-1"></i> 
                                    Notification
                                </a>
                                <br><br>
                                <div class="mx-auto d-block">
                                    <button class="btn btn-primary" name="update">Update</button>
                                    <a href="" class="btn btn-light">Cancel</a>
                                </div>
                                <br><br><br>
                            </div>
                        </div>

                        <div class="tab-content p-4 p-md-5" id="v-pills-tabContent">

                            <div class="tab-pane fade show active" id="account" role="tabpanel" aria-labelledby="account-tab">
                                <h3 class="mb-4">Account Settings</h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>First Name</label>
                                            <input type="text" class="form-control" value=" <%out.println(fname);%> " name="fname">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Last Name</label>
                                            <input type="text" class="form-control" value="<%out.println(lname);%>" name="lname">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input type="email" class="form-control" value="<%out.println(email);%>" name="email">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Student ID</label>
                                            <input type="text" class="form-control" value="<%out.println(id);%>" name="std_id">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>User Name</label>
                                            <input type="text" class="form-control" value="<%out.println(uname);%>" name="uname">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Profile Picture</label>
                                            <input type="file" class="form-control" value="" name="pic">
                                        </div>
                                    </div>
                                </div>
                                <!--                                <div>
                                                                    <button class="btn btn-primary" name="update">Update</button>
                                                                    <a href="" class="btn btn-light">Cancel</a>
                                                                </div>-->
                            </div>

                            <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                                <h3 class="mb-4">Password Settings</h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Old Password</label>
                                            <input type="text" class="form-control" disabled="" value="<%out.println(pw);%>">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>New password</label>
                                            <input type="password" class="form-control"  name="pw_old">
                                        </div>
                                    </div>
                                </div>

                                <!--                                <div>
                                                                    <button class="btn btn-primary">Update</button>
                                                                    <button class="btn btn-light">Cancel</button>
                                                                </div>-->
                            </div>
                            <div class="tab-pane fade" id="notification" role="tabpanel" aria-labelledby="notification-tab">
                                <h3 class="mb-4">Notification Settings</h3>
                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="notification1" checked="">
                                        <label class="form-check-label" for="notification1">
                                            Notify About New Quiz
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="notification2" checked="" >
                                        <label class="form-check-label" for="notification2">
                                            Notify About New Assessments 
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="notification3" checked="" >
                                        <label class="form-check-label" for="notification3">
                                            Notify About End Exams
                                        </label>
                                    </div>
                                </div>
                                <!--                                <div>
                                                                    <button class="btn btn-primary">Update</button>
                                                                    <button class="btn btn-light">Cancel</button>
                                                                </div>-->
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </section>
        <% }%>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>