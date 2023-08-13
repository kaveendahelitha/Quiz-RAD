<%-- 
    Document   : student-quiz
    Created on : Aug 12, 2023, 1:00:25 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("student-login.jsp");
    }
%> 

<%
    String quiz_id = request.getParameter("quiz_id");
    Connection con = DBConnector.getConnection();

    String query1 = "SELECT subject.subject_id, subject.subject_category, subject.subject_level, quiz.quiz_title FROM subject, quiz WHERE subject.subject_id = quiz.subject_id AND quiz.quiz_id=?";
    PreparedStatement pstmt1 = con.prepareStatement(query1);
    pstmt1.setString(1, quiz_id);
    ResultSet rs1 = pstmt1.executeQuery();

    String query2 = "SELECT question_no, question, answer_1, answer_2, answer_3, answer_4 FROM question WHERE quiz_id=?";
    PreparedStatement pstmt2 = con.prepareStatement(query2);
    pstmt2.setString(1, quiz_id);
    ResultSet rs2 = pstmt2.executeQuery();
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Attempt Quiz</title>
        <meta charset="UTF-8">
        <link rel="icon" type="image/png" href="./assets/img/favicon.jpeg">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="./css/style-main.css">
    </head>

    <body>       
        <div class="container mt-5 box">
            <div class="row" style="padding-left:10px; padding-bottom:10px;">
                <%
                    while (rs1.next()) {
                %>
                <h1 class="text-center"><%= rs1.getString("quiz_title")%></h1>
                <h3 class="text-center mb-4"><% out.println(rs1.getString("subject_level") + " - " + rs1.getString("subject_category")); %></h3>
                <%
                    }
                %>

                <div class="col-md-12 mt-5">
                    <form method="POST" action="process-student-quiz.jsp">
                        <input type="hidden" name="quiz_id" value="<%= quiz_id %>"/>
                        <%
                            int n_questions = 0;
                            while(rs2.next()){
                                n_questions ++;
                            %>
                                <div class="col-md-12" id="qDiv<%= rs2.getString("question_no") %>">
                                    <h4><%= rs2.getString("question_no") %>. <%= rs2.getString("question") %></h4><br>
                                    <input type="radio" name="<%= rs2.getString("question_no") %>answer" value="1"/> <%= rs2.getString("answer_1") %><br>
                                    <input type="radio" name="<%= rs2.getString("question_no") %>answer" value="2"/> <%= rs2.getString("answer_2") %><br>
                                    <input type="radio" name="<%= rs2.getString("question_no") %>answer" value="3"/> <%= rs2.getString("answer_3") %><br>
                                    <input type="radio" name="<%= rs2.getString("question_no") %>answer" value="4"/> <%= rs2.getString("answer_4") %><br>
                                    <br>
                                </div>
                            <%
                            }
                        %>       
                        <input type="hidden" name="n_questions" value="<%= n_questions %>"/>
                        
                        <input type="submit" name="finish" value="Finish Attempt" class="btn btn-info"/>
                    </form> 
                </div>                
            </div>
        </div>


        <script type="text/javascript">
            let ans = confirm("By clicking 'OK' you will be directed to the quiz. Are you sure you want to start now?");
            if(!ans){
                location.href = "student-quizzes.jsp";
            }
        </script>

    </body>
</html
