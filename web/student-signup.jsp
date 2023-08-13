<%@page import="classes.DBConnector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.MD5" %>
<%@page import="java.sql.*" %>
<%
    int set = 0;
    if (request.getParameter("submit") != null) {
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String file = request.getParameter("image");
        String u_p = request.getParameter("password");
        String c_p = request.getParameter("cpassword");
        if (u_p.equals(c_p)) {
            String password = MD5.getMd5(u_p);
            Connection con = DBConnector.getConnection();
            String query = "INSERT INTO student(first_name, last_name, email, username, password, profile_pic_url) VALUES(?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, username);
            pstmt.setString(5, password);
            pstmt.setString(6, file);
            int a = pstmt.executeUpdate();
            if (a > 0) {
                set = 1;
            } else {
                out.print("Sign in fail");
            }

        } else {
            out.print("Sign in fail");
        }
    }
%>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

    <head>
        <title>Sign up</title>
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

        <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
        <link rel="stylesheet" href="./css/login-signup.css">

        <!-- BOOTSTRAP V 5.0 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    </head>

    <body style="background-image: url(assets/img/quizB.jpg); background-repeat: no-repeat; background-size: cover;">

        <div class="form-container">

            <form method="POST">
                <h4 class="student-signup-title">Sign Up as an Student</h4>
                <input type="text" name="firstname" placeholder="Enter Firstname" class="box" required/>
                <input type="text" name="lastname" placeholder="Enter Lastname" class="box" required/>
                <input type="email" name="email" placeholder="Enter Email" class="box" required/>
                <input type="text" name="username" placeholder="Enter Username" class="box" required/>
                <input type="password" name="password" placeholder="Enter Password" class="box" required/>
                <input type="password" name="cpassword" placeholder="Confirm Password" class="box" required/>
                <input type="file" name="image" class="box" accept="image/jpg, image/jpeg, image/png"/>

                <input type="submit" name="submit" class="btn1" value="Sign Up" />
                <p>Already have an account? <a href="student-login.jsp">Login</a></p>
                <% if (set == 1) {%>
                <p style="color: greenyellow; margin-top: -30px;">Successfully Registerd</p>
                <% }%>
            </form>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    </body>

</html>