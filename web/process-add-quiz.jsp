<%-- 
    Document   : process-teacher-quiz
    Created on : Aug 7, 2023, 9:13:44 PM
    Author     : sanjanaattanayake
--%>

<%@page import="java.lang.Character"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.Random" %>

<%
    boolean status = true;
    String quiz_title = request.getParameter("quiz_title");
    int tot_questions = Integer.parseInt(request.getParameter("tot_ques"));
    
    if (quiz_title.isEmpty()) {
        status = false;
        response.sendRedirect("teacher-quiz.jsp?error=1");
    } 
    else {        
        for (int i = 1; i <= tot_questions; i++) {
            String question = request.getParameter("question" + i);
            String answer1 = request.getParameter(i + "answer" + 1);
            String answer2 = request.getParameter(i + "answer" + 2);
            String answer3 = request.getParameter(i + "answer" + 3);
            String answer4 = request.getParameter(i + "answer" + 4);
            String correct = request.getParameter(i + "correct_answer");

            if (question.isEmpty() || answer1.isEmpty() || answer2.isEmpty() || answer3.isEmpty() || answer4.isEmpty() || correct.isEmpty()) {
                status = false;
                response.sendRedirect("teacher-quiz.jsp?error=2");
            }
            else if(correct.length() > 2){
                status = false;
                response.sendRedirect("teacher-quiz.jsp?error=3");
            }
            else if(!correct.equals("1") && !correct.equals("2") && !correct.equals("3") && !correct.equals("4")){
                status = false;
                response.sendRedirect("teacher-quiz.jsp?error=4");
            }
        }
    }
    
    if(status) {
        boolean isPublic = request.getParameter("isPublic") != null;
        String subject_id = request.getParameter("subject_id");
        String teacher_id = (String) session.getAttribute("teacher_id");

        String code = "";
        if (!isPublic) {
            Random rand = new Random();
            code = String.valueOf(rand.nextInt(10000000));
        }

        try {
            String query = "INSERT INTO quiz(teacher_id, subject_id, quiz_title, is_public, code) values(?,?,?,?,?)";
            Connection con = DBConnector.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, teacher_id);
            pstmt.setString(2, subject_id);
            pstmt.setString(3, quiz_title);
            pstmt.setBoolean(4, isPublic);
            pstmt.setString(5, code);
            int a = pstmt.executeUpdate();

            if (a > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                int quiz_id = -1;
                if (rs.next()) {
                    quiz_id = rs.getInt(1);
                }
                
                String query2 = "INSERT INTO question(quiz_id, question_no, question, answer_1, answer_2, answer_3, answer_4, correct_answer)"
                    + "VALUES(?,?,?,?,?,?,?,?)";
                    
                PreparedStatement pstmt2 = con.prepareStatement(query2);
                
                for (int i = 1; i <= tot_questions; i++) {                
                    String question = request.getParameter("question" + i);
                    String answer1 = request.getParameter(i + "answer" + 1);
                    String answer2 = request.getParameter(i + "answer" + 2);
                    String answer3 = request.getParameter(i + "answer" + 3);
                    String answer4 = request.getParameter(i + "answer" + 4);
                    String correct = request.getParameter(i + "correct_answer");

                    pstmt2.setInt(1, quiz_id);
                    pstmt2.setInt(2, i);
                    pstmt2.setString(3, question.trim());
                    pstmt2.setString(4, answer1.trim());
                    pstmt2.setString(5, answer2.trim());
                    pstmt2.setString(6, answer3.trim());
                    pstmt2.setString(7, answer4.trim());
                    pstmt2.setString(8, correct.trim());    
                    pstmt2.addBatch();
                }
                int[] b = pstmt2.executeBatch();
                    
                if(b.length > 0){
                    response.sendRedirect("teacher-index.jsp?error=0");
                }
                else{
                    con.rollback();
                    response.sendRedirect("teacher-index.jsp?error=3"); // query execution failed
                }
                
            } else {
                con.rollback();
                response.sendRedirect("teacher-index.jsp?error=4"); //query execution failed
            }
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
    }
%>