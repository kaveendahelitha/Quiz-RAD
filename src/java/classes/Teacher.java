package classes;

/**
 *
 * @author sanjanaattanayake
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Teacher {
    private String teacher_id;
    private String first_name;
    private String last_name;
    private String email;
    private String username;
    private String password;
    private String profile_pic;
    private String education;
    private String school;

    public Teacher(String first_name, String last_name, String email, String username, String password, String education, String school){
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.username = username;
        this.password = MD5.getMd5(password);
        this.education = education;
        this.school = school;
    }
    
    public Teacher(String first_name, String last_name, String email, String username, String password, String profile_pic, String education, String school){
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.username = username;
        this.password = MD5.getMd5(password);
        this.profile_pic = profile_pic;
        this.education = education;
        this.school = school;
    }
    
    public Teacher(){}
    
    public boolean addTeacher(boolean profilePic){
        boolean status = false;
        
        try {
            Connection con = DBConnector.getConnection();
            
            if(profilePic){
                String query = "INSERT INTO teacher(first_name, last_name, email, username, password, profile_pic, education, school) VALUES(?,?,?,?,?,?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(query);
                /*pstmt.setString(1, this.first_name);
                pstmt.setString(2, this.last_name);
                pstmt.setString(3, this.email);
                pstmt.setString(4, this.username);
                pstmt.setString(5, this.password);
                pstmt.setString(6, this.education);
                pstmt.setString(7, this.school);*/
                int a = pstmt.executeUpdate();
                status = a > 0;
            }
            else{
                String query = "INSERT INTO teacher(first_name, last_name, email, username, password, education,school) VALUES(?,?,?,?,?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, this.first_name);
                pstmt.setString(2, this.last_name);
                pstmt.setString(3, this.email);
                pstmt.setString(4, this.username);
                pstmt.setString(5, this.password);
                pstmt.setString(6, this.education);
                pstmt.setString(7, this.school);
                int a = pstmt.executeUpdate();
                status = a > 0;
            }
            
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }  
        
        return status;
    }
    
    public String verifyLogin(String inputUsername, String inputPassword){
        String teacher_id = "";
        
        String query = "SELECT teacher_id, username, password FROM teacher where username=?";
        try {
            Connection con = DBConnector.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, inputUsername);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()){
                String hashed = MD5.getMd5(inputPassword);
                if(hashed.equals(rs.getString("password"))){
                    teacher_id = rs.getString("teacher_id");
                }               
            }
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return teacher_id;
    }
}
