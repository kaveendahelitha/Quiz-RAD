<%-- 
    Document   : view-quiz
    Created on : Aug 11, 2023, 2:19:06 PM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%
    String teacher_id = String.valueOf(session.getAttribute("teacher_id"));
    String quiz_id = request.getParameter("quiz_id");
    
    Connection con = DBConnector.getConnection();
    
    ArrayList <String> correct_answers = new ArrayList();
    String query1 = "SELECT * FROM question WHERE quiz_id = ?";
    PreparedStatement pstmt1 = con.prepareStatement(query1);
    pstmt1.setString(1, quiz_id);
    ResultSet rs1 = pstmt1.executeQuery();
    
    String subject = "";
    String level = "";
    String query2 = "SELECT subject.subject_category, subject.subject_level FROM subject INNER JOIN quiz ON "
            + "quiz.subject_id = subject.subject_id WHERE quiz.quiz_id=?";
    PreparedStatement pstmt2 = con.prepareStatement(query2);
    pstmt2.setString(1, quiz_id);
    ResultSet rs2 = pstmt2.executeQuery();
    while(rs2.next()){
        subject = rs2.getString("subject_category");
        level = rs2.getString("subject_level");
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
            <a class="navbar-brand" href="index.html">WeQuiz</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse " id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link" aria-current="page" href="index.html">Main - Home</a>
                    <a class="nav-link" aria-current="page" href="teacher-index.jsp">Teacher - Home</a>
                    <a class="nav-link" aria-current="page" href="teacher-settings.jsp">Settings</a>
                </div>

                <div class="d-flex ms-auto order-5">
                    <button type="button" class="btn btn-primary me-3"
                        onclick="location.href = 'teacher-login.jsp'">Logout</button>
                </div>
            </div>
        </div>
    </nav>

    <main>
        <div class="container-md">
            <div>
                <div class="row">
                    <div class="col">
                        <h2 class="display-5 mt-3 mb-3"><% out.println(level + " - " + subject); %></h2>
                    </div>
                    <div class="col text-end">
                        <form action="process-delete-quiz.jsp?quiz_id=<%= quiz_id %>" method="POST"
                              onsubmit="confirm('This action cannot be undone. Are you sure you want to proceed?')">
                            <input type="submit" class="btn btn-danger mt-2 mt-4 mb-3" value="Delete Quiz"/>
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <ol>
                            <%
                                int i=1;
                                if(!teacher_id.equals("")){  
                                    while(rs1.next()){
                                        correct_answers.add(rs1.getString("correct_answer"));
                                        %>
                                        <li class="mb-4"><%= rs1.getString("question") %>
                                            <ol>
                                                <li id="<%= rs1.getString("question_no") %>-1"><%= rs1.getString("answer_1") %></li>
                                                <li id="<%= rs1.getString("question_no") %>-2"><%= rs1.getString("answer_2") %></li>
                                                <li id="<%= rs1.getString("question_no") %>-3"><%= rs1.getString("answer_3") %></li>
                                                <li id="<%= rs1.getString("question_no") %>-4"><%= rs1.getString("answer_4") %></li>                        
                                            </ol>
                                        </li>
                                        <%
                                        i++;
                                    }
                                }
                                else{
                                    response.sendRedirect("index.jsp");
                                }
                            %>
                            
                            <input type="hidden" id="n_questions" name="n_questions" value="<%= i %>"/> 
                            <input type="hidden" id="correct_answers" name="correct_answers" value="<%= correct_answers %>"/> 
                    
                        </ol>
                    </div>
                </div>
                <div class="row ms-auto text-center">
                    <div class="col">
                        <button type="button" class="btn btn-primary" onclick="location.href='teacher-index.jsp'">Finish Review</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
                        
    <script type="text/javascript">
        var n_questions = document.getElementById("n_questions").value;
        var correct_answers = document.getElementById("correct_answers").value;
        
        var array = [];
        for(let i=1; i<correct_answers.length-1; i++){
            if(correct_answers[i] === "," || correct_answers[i] === " "){
                continue;
            }
            else{
                array.push(correct_answers[i]);
            }
        }
        
        for(let i=0; i<n_questions-1; i++){
            for(let j=1; j<=4; j++){
                if(j == array[i]){
                    document.getElementById((i+1) + "-" + j).classList.add("bg-success");
                }
            }      
        }
    </script>
</body>
</html>