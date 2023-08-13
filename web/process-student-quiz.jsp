<%-- 
    Document   : process-student-quiz.jsp
    Created on : Aug 12, 2023, 4:15:24 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="classes.DBConnector" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList"%>

<%
    if(request.getParameter("finish") != null){
        String quiz_id = request.getParameter("quiz_id");
        String student_id = String.valueOf(session.getAttribute("student_id"));
        int n_questions = Integer.valueOf(request.getParameter("n_questions"));
        
        ArrayList <String> std_answers = new ArrayList ();
        ArrayList <String> correct_answers = new ArrayList ();
        int score = 0;
        
        try{
            Connection con = DBConnector.getConnection();
            String query1 = "DELETE FROM student_answer WHERE quiz_id=? AND student_id?";
            PreparedStatement pstmt1 = con.prepareStatement(query1);
            pstmt1.setString(1, quiz_id);
            pstmt1.setString(2, student_id);
            pstmt1.executeUpdate();
   
        }
        catch(Exception e){
            out.println(e.getMessage());
        }
        
        try{
            Connection con = DBConnector.getConnection();
            String query2 = "INSERT INTO student_answer(quiz_id, student_id, question_no, answer) VALUES(?, ?, ?, ?)";
            PreparedStatement pstmt2 = con.prepareStatement(query2);

            for(int i=1; i<=n_questions; i++){
                pstmt2.setString(1, quiz_id);
                pstmt2.setString(2, student_id);
                pstmt2.setString(3, String.valueOf(i));
                pstmt2.setString(4, request.getParameter(i + "answer"));
                std_answers.add(request.getParameter(i + "answer"));
                pstmt2.addBatch();
            }
            int[] a = pstmt2.executeBatch();
            
            if(a.length > 0){
                try{
                    String query3 = "DELETE FROM score WHERE student_id=? AND quiz_id=?";
                    PreparedStatement pstmt3 = con.prepareStatement(query3);
                    pstmt3.setString(1, student_id);
                    pstmt3.setString(2, quiz_id);
                    pstmt3.executeUpdate();
                    
                    try{
                        String query4 = "SELECT correct_answer FROM question WHERE quiz_id=?";
                        PreparedStatement pstmt4 = con.prepareStatement(query4);
                        pstmt4.setString(1, quiz_id);
                        ResultSet rs = pstmt4.executeQuery();
                        while(rs.next()){
                            correct_answers.add(rs.getString("correct_answer"));
                        }
                        for(int i=0; i<std_answers.size(); i++){
                            if(std_answers.get(i).equals(correct_answers.get(i))){
                                score += 10;
                            }
                        }
                        
                        String query5 = "INSERT INTO score(quiz_id, student_id, mark) VALUES(?, ?, ?)";
                        PreparedStatement pstmt5 = con.prepareStatement(query5);
                        pstmt5.setString(1, quiz_id);
                        pstmt5.setString(2, student_id);
                        pstmt5.setInt(3, score);
                        pstmt5.executeUpdate();
                    }
                    catch(Exception e){
                        out.println(e.getMessage());
                    }
                    
                    response.sendRedirect("student-view-quiz.jsp?quiz_id=" + quiz_id + "&score=" + score);
                    
                }
                catch(Exception e){
                    out.println(e.getMessage());
                }         
            }   
        }
        catch(Exception e){
            out.println(e.getMessage());
        }
    }
%>