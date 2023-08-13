<%-- 
    Document   : process-update-quiz
    Created on : Aug 11, 2023, 7:58:15 PM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="javax.servlet.ServletRequest" %>

<%!
    private int[] updateQuiz(int tot_questions, String quiz_id, ServletRequest request){
        int[] b = {};
        try{
            Connection con = DBConnector.getConnection();

            String query2 = "UPDATE question SET question=?, answer_1=?, answer_2=?, answer_3=?, answer_4=?, "
                            + "correct_answer=? WHERE quiz_id=? AND question_no=?";
            PreparedStatement pstmt2 = con.prepareStatement(query2);

            for (int i = 1; i <= tot_questions; i++) {                
                String question = request.getParameter("question" + i);
                String answer1 = request.getParameter(i + "answer" + 1);
                String answer2 = request.getParameter(i + "answer" + 2);
                String answer3 = request.getParameter(i + "answer" + 3);
                String answer4 = request.getParameter(i + "answer" + 4);
                String correct = request.getParameter("correct" + i);

                pstmt2.setString(1, question.trim());
                pstmt2.setString(2, answer1.trim());
                pstmt2.setString(3, answer2.trim());
                pstmt2.setString(4, answer3.trim());
                pstmt2.setString(5, answer4.trim());
                pstmt2.setString(6, correct.trim());    
                pstmt2.setString(7, quiz_id);    
                pstmt2.setInt(8, i);    

                pstmt2.addBatch();
            }
            b = pstmt2.executeBatch();
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
        return b;
    }
%>

<%
    try{
        boolean status = true;
        
        int tot_questions = Integer.valueOf(request.getParameter("tot_questions"));
        String quiz_id = request.getParameter("quiz_id");

        for (int i = 1; i <= tot_questions; i++) {
            String question = request.getParameter("question" + i);
            String answer1 = request.getParameter(i + "answer" + 1);
            String answer2 = request.getParameter(i + "answer" + 2);
            String answer3 = request.getParameter(i + "answer" + 3);
            String answer4 = request.getParameter(i + "answer" + 4);
            String correct = request.getParameter("correct" + i);

            if (question.isEmpty() || answer1.isEmpty() || answer2.isEmpty() || answer3.isEmpty() || answer4.isEmpty() || correct.isEmpty()) {
                status = false;
                response.sendRedirect("teacher-edit-quiz.jsp?quiz_id=" + quiz_id + "&error=2");
            }
            else if(correct.length() > 2){
                status = false;
                response.sendRedirect("teacher-edit-quiz.jsp?quiz_id=" + quiz_id + "&error=3");
            }
            else if(!correct.equals("1") && !correct.equals("2") && !correct.equals("3") && !correct.equals("4")){
                status = false;
                response.sendRedirect("teacher-edit-quiz.jsp?quiz_id=" + quiz_id + "&error=4");
            }
        }
        
        if(status){
            Connection con = DBConnector.getConnection();
            String query1 = "SELECT COUNT(quiz_id) as 'n_questions' FROM question WHERE quiz_id=?";
            PreparedStatement pstmt1 = con.prepareStatement(query1);
            pstmt1.setString(1, quiz_id);
            ResultSet rs1 = pstmt1.executeQuery();
            int current_total = 0;
            while(rs1.next()){
                current_total = rs1.getInt("n_questions");
            }
            
            if(tot_questions > current_total){
                int[] b = updateQuiz(current_total, quiz_id, request);
                
                if(b.length > 0){
                    String query2 = "INSERT INTO question(quiz_id, question_no, question, answer_1, answer_2, answer_3, answer_4, correct_answer)"
                    + "VALUES(?,?,?,?,?,?,?,?)";
                    
                    PreparedStatement pstmt2 = con.prepareStatement(query2);

                    for (int i = current_total+1; i <= tot_questions; i++) {                
                        String question = request.getParameter("question" + i);
                        String answer1 = request.getParameter(i + "answer" + 1);
                        String answer2 = request.getParameter(i + "answer" + 2);
                        String answer3 = request.getParameter(i + "answer" + 3);
                        String answer4 = request.getParameter(i + "answer" + 4);
                        String correct = request.getParameter("correct" + i);

                        pstmt2.setString(1, quiz_id);
                        pstmt2.setInt(2, i);
                        pstmt2.setString(3, question.trim());
                        pstmt2.setString(4, answer1.trim());
                        pstmt2.setString(5, answer2.trim());
                        pstmt2.setString(6, answer3.trim());
                        pstmt2.setString(7, answer4.trim());
                        pstmt2.setString(8, correct.trim());    
                        pstmt2.addBatch();
                    }    
                    int[] c = pstmt2.executeBatch();

                    if(c.length > 0){
                        response.sendRedirect("teacher-view-quiz.jsp?quiz_id=" + quiz_id + "&error=0");             
                    }                      
                }
                else{
                    con.rollback();
                    response.sendRedirect("teacher-edit-quiz.jsp?quiz_id=" + quiz_id + "&error=5");//query execution failed
                }
            }
            else{
                int[] b = updateQuiz(tot_questions, quiz_id, request);
                if(b.length > 0){
                    response.sendRedirect("teacher-view-quiz.jsp?quiz_id=" + quiz_id + "&error=0");
                }
                else{
                    con.rollback();
                    response.sendRedirect("teacher-edit-quiz.jsp?quiz_id=" + quiz_id + "&error=5");//query execution failed
                }               
            }   
        }
    }
    catch(Exception e){
        out.println(e.getMessage());
    }
%>