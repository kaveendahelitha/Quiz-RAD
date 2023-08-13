<%@page import="classes.MD5"%>
<%@page import ="java.sql.*" %>
<%@page import ="classes.DBConnector" %>
<%@page import ="java.sql.PreparedStatement" %>
<%
    int set = 0;
    if (request.getParameter("submit") != null) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        //String user_pass = MD5.getMd5(password);
        //out.print(user_pass);
        if (!(email.isEmpty()) && !(password.isEmpty())) {
            String user_pass = MD5.getMd5(password);
            Connection con = DBConnector.getConnection();
            String query = "SELECT student_id, email,password FROM student WHERE email = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, user_pass);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                out.print("success");
                String db_pass = rs.getString("password");
                if (db_pass.equals(user_pass)) {
                    session.setAttribute("student_id", rs.getString("student_id"));
                    response.sendRedirect("index.jsp");
                }
            } else {
                set = 1; 
                
            }
        } else {
            set = 1;
        }
    }

%>



<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

    <head>
        <title>Login</title>
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

        <link rel="stylesheet" href="./css/login-signup.css">
        <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">

        <!-- BOOTSTRAP V 5.0 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    </head>

    <body style="background-image: url(assets/img/login.jpg); background-repeat: no-repeat; background-size: cover">

        <div class="form-container">

            <form method="POST">
                <h3>Log In</h3>
                <input type="email" name="email" placeholder="Enter Email" class="box"/>
                <input type="password" name="password" placeholder="Enter Password" class="box" required />
                <input type="submit" name="submit" class="btn1" value="Log In" />
                <p>Don't have an account? <a href="student-signup.jsp">Sign Up</a></p>
                <% if (set
                            == 1) {%>

                <div class="alert alert-primary d-flex align-items-center bg-transparent" id="error" role="alert" style="background-color: white; border:none;">
                    <svg xmlns="http://www.w3.org/2000/svg" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" width="20px" height="20px" viewBox="0 0 16 16" role="img" aria-label="Warning:">
                    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                    </svg>
                    <div style="color: red">
                        Incorrect username or password
                    </div>
                </div>
                <% }%>

            </form>

        </div>


        <div id="footer">

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    </body>

</html>