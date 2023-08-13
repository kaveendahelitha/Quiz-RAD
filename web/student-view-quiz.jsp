<%-- 
    Document   : student-view-quiz
    Created on : Aug 12, 2023, 4:56:02 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList"%>

<%
    String quiz_id = request.getParameter("quiz_id");
    String student_id = String.valueOf(session.getAttribute("student_id"));
    
    ArrayList <String> correct_answers = new ArrayList();
    ArrayList <String> student_answers = new ArrayList();

    Connection con = DBConnector.getConnection();

    String query1 = "SELECT * FROM question WHERE quiz_id=?";
    PreparedStatement pstmt1 = con.prepareStatement(query1);
    pstmt1.setString(1, quiz_id);
    ResultSet rs1 = pstmt1.executeQuery();
    
    String query2 = "SELECT answer FROM student_answer WHERE quiz_id=? AND student_id=?";
    PreparedStatement pstmt2 = con.prepareStatement(query2);
    pstmt2.setString(1, quiz_id);
    pstmt2.setString(2, student_id);
    ResultSet rs2 = pstmt2.executeQuery();
    while(rs2.next()){
        student_answers.add(rs2.getString("answer"));
    }
    
    String subject = "";
    String level = "";
    String query3 = "SELECT subject.subject_category, subject.subject_level FROM subject INNER JOIN quiz ON "
            + "quiz.subject_id = subject.subject_id WHERE quiz.quiz_id=?";
    PreparedStatement pstmt3 = con.prepareStatement(query3);
    pstmt3.setString(1, quiz_id);
    ResultSet rs3 = pstmt3.executeQuery();
    while(rs3.next()){
        subject = rs3.getString("subject_category");
        level = rs3.getString("subject_level");
    }
    
    String marks = "";
    String query4 = "SELECT mark FROM score WHERE student_id=? AND quiz_id=?";
    PreparedStatement pstmt4 = con.prepareStatement(query4);
    pstmt4.setString(1, student_id);
    pstmt4.setString(2, quiz_id);
    ResultSet rs = pstmt4.executeQuery();
    while(rs.next()){
        marks = rs.getString("mark");
    }
%>

<!DOCTYPE html>
<html>

    <head>
        <title>Educator - Home</title>
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- BOOTSTRAP V 5.0 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="./css/style-main.css">
        <link rel="stylesheet" type="text/css" href="./css/teacher-quiz.css">
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
                <div class="row">
                    <div class="col">
                        <h2 class="display-5 mt-5 mb-3"><% out.println(level + " - " + subject); %></h2>
                    </div>
                </div>
                 <div class="row">
                    <div class="col text-center">
                        <h2 class="display-2 mb-4 text-light"><%= marks  %></h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <ol>
                            <%
                                int i = 1;
                                if (!student_id.equals("")) {
                                    while (rs1.next()) {
                                        correct_answers.add(rs1.getString("correct_answer"));
                            %>
                            <li class="mb-4"><%= rs1.getString("question")%>
                                <ol>
                                    <li id="<%= rs1.getString("question_no")%>-1"><%= rs1.getString("answer_1")%></li>
                                    <li id="<%= rs1.getString("question_no")%>-2"><%= rs1.getString("answer_2")%></li>
                                    <li id="<%= rs1.getString("question_no")%>-3"><%= rs1.getString("answer_3")%></li>
                                    <li id="<%= rs1.getString("question_no")%>-4"><%= rs1.getString("answer_4")%></li>                        
                                </ol>
                            </li>
                            <%
                                        i++;
                                    }
                                } else {
                                    response.sendRedirect("index.html");
                                }
                            %>

                            <input type="hidden" id="n_questions" name="n_questions" value="<%= i%>"/> 
                            <input type="hidden" id="correct_answers" name="correct_answers" value="<%= correct_answers %>"/> 
                            <input type="hidden" id="student_answers" name="student_answers" value="<%= student_answers %>"/>
                        </ol>
                    </div>
                </div>
                <div class="row ms-auto text-center">
                    <div class="col">
                        <button type="button" class="btn btn-primary" onclick="location.href = 'student-quizzes.jsp'">Finish Review</button>
                    </div>
                </div>
            </div>
        </main>
                            
        <script type="text/javascript">
            var n_questions = document.getElementById("n_questions").value;
            var correct_answers = document.getElementById("correct_answers").value;
            var student_answers = document.getElementById("student_answers").value;

            var array_correct = []; // JS Correct answers :/
            for(let i=1; i<correct_answers.length-1; i++){
                if(correct_answers[i] === "," || correct_answers[i] === " "){
                    continue;
                }
                else{
                    array_correct.push(correct_answers[i]);
                }
            }
            
            var array_student = []; // JS Correct answers :/
            for(let i=1; i<student_answers.length-1; i++){
                if(student_answers[i] === "," || student_answers[i] === " "){
                    continue;
                }
                else{
                    array_student.push(student_answers[i]);
                }
            }

            for(let i=0; i<n_questions-1; i++){
                if(array_student[i] == array_correct[i]){
                    document.getElementById((i+1) + "-" + array_student[i]).classList.add("bg-success");
                }
                else{
                    document.getElementById((i+1) + "-" + array_correct[i]).classList.add("bg-success");
                    document.getElementById((i+1) + "-" + array_student[i]).classList.add("bg-danger");
                }    
            }
        </script>
    </body>
</html>