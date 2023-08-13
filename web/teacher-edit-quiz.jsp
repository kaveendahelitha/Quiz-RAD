<%-- 
    Document   : teacher-edit-quiz
    Created on : Aug 11, 2023, 4:47:57 PM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%
    String quiz_id = request.getParameter("quiz_id");
    
    Connection con = DBConnector.getConnection();
    String query = "SELECT question, answer_1, answer_2, answer_3, answer_4, correct_answer FROM question WHERE quiz_id=?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, quiz_id);
    ResultSet rs = pstmt.executeQuery();
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
                <div class="row mt-4 mb-4">
                    <div class="col-md-6">
                        <h1 class="h1">Grade 11 - Maths</h1>
                    </div>
                    <div class="col-md-6 d-flex justify-content-end">
                        <button type="button" class="btn btn-primary" id="add">Add Question</button>
                    </div>
                </div>       
                <form method="POST" action="process-update-quiz.jsp">
                    <div class = "question_div">
                        <%
                            int i = 1;
                            while(rs.next()){
                                %>
                                <div class="row">
                                    <div class="col-md-2">
                                        <label for="question<%= i %>" class="h4">Question <%= i %></label>                                     
                                    </div>
                                    <div class="col-md-10">
                                        <input type="text" name="question<%= i %>" id="question<%= i %>" class="form-control mb-4" value="<%= rs.getString("question") %>"/> 
                                        <input type="text" name="<%= i %>answer1" id="<%= i %>answer1" class="form-control mb-4" value="<%= rs.getString("answer_1") %>"/> 
                                        <input type="text" name="<%= i %>answer2" id="<%= i %>answer2" class="form-control mb-4" value="<%= rs.getString("answer_2") %>"/> 
                                        <input type="text" name="<%= i %>answer3" id="<%= i %>answer3" class="form-control mb-4" value="<%= rs.getString("answer_3") %>"/> 
                                        <input type="text" name="<%= i %>answer4" id="<%= i %>answer4" class="form-control mb-4" value="<%= rs.getString("answer_4") %>"/> 
                                        <input type="text" name="correct<%= i %>" id="correct<%= i %>" class="form-control mb-4" 
                                               placeholder="Enter Correct Answer as 1,2,3,4" style="background-color: #90EE90" 
                                               value="<%= rs.getString("correct_answer") %>"/> 
                                    </div>
                                </div>
                                <%
                                i++;
                            }
                        %>                       
                    </div>
                    <div class="row">
                        <div class="col-md-12 d-flex justify-content-center">
                            <input type="hidden" name="tot_questions" id="tot_questions" value="<%= i-1 %>"/>
                            <input type="hidden" name="quiz_id" id="quiz_id" value="<%= quiz_id %>"/>
                            <input type="submit" name="updateQuiz" id="updateQuiz" class="btn btn-primary btn-block w-75" value="Save Changes"/>
                        </div>
                    </div>
                </form>
            </div>
        </main>

        <input type="hidden" name="question_no" id="question_no" value="<%= i %>"/>
        <script>
            let add = document.getElementById("add");
            let questionsDiv = document.querySelector(".question_div");
            
            let i = parseInt(document.getElementById("question_no").value);

            add.addEventListener("click", function () {
                document.getElementById("tot_questions").value = i;
                        
                var row = document.createElement("div");
                row.classList.add("row");
                
                var qCol = document.createElement("div");
                qCol.classList.add("col-md-2");
                
                var qLabel = document.createElement("label");
                qLabel.classList.add("h4");
                qLabel.textContent = "Question " + i;
                
                var col = document.createElement("div");
                col.classList.add("col-md-10");
                
                var q = document.createElement("INPUT");
                q.setAttribute("type", "text");
                q.setAttribute("name", "question" + i);
                q.setAttribute("placeholder", "Enter Question");
                q.classList.add("form-control");
                q.classList.add("mb-4");

                var a1 = document.createElement("INPUT");
                a1.setAttribute("type", "text");
                a1.setAttribute("name", i + "answer" + 1);
                a1.setAttribute("placeholder", "Enter Answer 1");
                a1.classList.add("form-control");
                a1.classList.add("mb-4");

                var a2 = document.createElement("INPUT");
                a2.setAttribute("type", "text");
                a2.setAttribute("name", i + "answer" + 2);
                a2.setAttribute("placeholder", "Enter Answer 2");
                a2.classList.add("form-control");
                a2.classList.add("mb-4");

                var a3 = document.createElement("INPUT");
                a3.setAttribute("type", "text");
                a3.setAttribute("name", i + "answer" + 3);
                a3.setAttribute("placeholder", "Enter Answer 3");
                a3.classList.add("form-control");
                a3.classList.add("mb-4");
                a3.setAttribute("required", "");

                var a4 = document.createElement("INPUT");
                a4.setAttribute("type", "text");
                a4.setAttribute("name", i + "answer" + 4);
                a4.setAttribute("placeholder", "Enter Answer 4");
                a4.classList.add("form-control");
                a4.classList.add("mb-4");

                var correct = document.createElement("INPUT");
                correct.setAttribute("type", "text");
                correct.setAttribute("name", "correct" + i);
                correct.setAttribute("placeholder", "Enter Correct Answer as 1,2,3,4");
                correct.classList.add("form-control");
                correct.classList.add("mb-4");
                correct.style.backgroundColor = "#90EE90";

                qCol.appendChild(qLabel);

                col.appendChild(q);
                col.appendChild(a1);
                col.appendChild(a2);
                col.appendChild(a3);
                col.appendChild(a4);
                col.appendChild(correct);

                row.appendChild(qCol);
                row.appendChild(col);
                
                questionsDiv.appendChild(row);

                i++;
            });        
        </script>
    </body>
</html>
