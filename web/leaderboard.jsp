<%-- 
    Document   :  leaderboard
    Created on : Aug 11, 2023, 1:19:11 AM
    Author     : kavee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.DBConnector"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%

    try {
        Connection con = DBConnector.getConnection();
        String query = "SELECT quiz_id, quiz_title FROM quiz";
        PreparedStatement pstmt = con.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();

%>



<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"  integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="Assetes/Boostrap/css/bootstrap.css" rel="stylesheet">
        <link href="Assetes/Boostrap/css/bootstrap.min.css" rel="stylesheet" >
        <link href="Assetes/css/indexle.css" rel="stylesheet" >
        <title>Hello, world!</title>
    </head>
    <body>



        <section class="split">  

            <!-- Dropdown Menu -->


            <label>

                <input type="checkbox">
                <div class="toggle">
                    <span class="top_line common"></span>
                    <span class="middle_line common"></span>
                    <span class="bottom_line common"></span>
                </div>



                <div class="slide">
                    <h5>Leader Board</h5>
                    <div class="dropdown">
                        <div class="dropdown-toggle" id="dropdownMenuButton">
                            <h4>Subject</h4>
                        </div>

                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <%                       while (rs.next()) {
                                    int quizId = rs.getInt("quiz_id");
                                    String quizTitle = rs.getString("quiz_title");
                            %>

                            <div class="dropdown-item">

                                <div class="mi-col" id="tab-<%= quizId%>" onclick="showTab(<%= quizId%>)">
                                    <h3><%= quizTitle%></h3>
                                </div>

                            </div>
                            <%
                                    }
                                    rs.close();
                                    pstmt.close();
                                    con.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>


                            
                           
                        </div>
                    </div>
                    <hr/>

                    <div class="mi-col" id="det-1" onclick="showdetalis(1)">
                        <h3>My Score</h3>       
                    </div>
                </div>

                <!-- Dropdown Menu -->
                <!-- <div class="dropdown">
                       <div class="dropdown-toggle" id="dropdownMenuButton">
                         <h4>Subject</h4>
                       </div>
                    
                     <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                         <div class="dropdown-item">
    
                            <div class="mi-col" id="tab-1" onclick="showTab(1)">
                               <h3>Maths</h3>
                            </div>
                          
                         </div>
    
    
                         <div class="dropdown-item">
    
                            <div class="mi-col" id="tab-2" onclick="showTab(2)">
                               <h3>Bio</h3>       
                            </div>
    
                        </div>
                         <div class="dropdown-item">
    
                            <div class="mi-col" id="tab-3" onclick="showTab(3)">
                               <h3>ICT</h3>
                        
                            </div>
                        </div>
                     </div>
                 </div>
                 <hr/>
                 
                    <div class="mi-col" id="det-1" onclick="showdetalis(1)">
                        <h3>My Score</h3>       
                     </div> -->

            </label>







            <!-- moving content -->
            <div class="right content">

                <div>
                    <div class="default-ui">
                        <section id="services" class="services">
                            <div class="container-md section-title">
                                <div class="text-center">
                                    <h2 style="color: #75aadb;">
                                        Welcome to Our Quiz
                                        <span style="color: #d12d33;"><strong> 
                                               </strong>
                                        </span>
                                    </h2>
                                    <p class="d-inline-block" style="width: 50%;"><strong>
                                            Congratulations to all our brilliant participants! Here,
                                            we award medals to recognize and celebrate the achievements of our
                                            top performers! As you climb the ranks and showcase your knowledge,
                                            you'll have the chance to earn one of three prestigious medals:
                                        </strong><br />
                                    </p>
                                </div>
                                <div class="row">
                                    <div class="col-12 col-md-6 col-lg-4 mb-5">
                                        <div class="text-center icon-box h-100">
                                            <div class="icon"><i class="fab fa-dribbble" style="margin-bottom: 15px;"></i>
                                                <h4 class="title">Gold Medal
                                                    <a href="#"></a>
                                                </h4>
                                                <p class="description">
                                                    The coveted Gold Medal is reserved for our quiz champions! It signifies exceptional performance and mastery of the quiz topics. To achieve this medal, you'll need to consistently score among the highest and prove yourself as a true quiz whiz.
                                                    <br />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6 col-lg-4 mb-5">
                                        <div class="text-center icon-box h-100">
                                            <div class="icon"><i class="fab fa-renren" style="margin-bottom: 15px;"></i>
                                                <h4 class="title">Silver Medal
                                                    <a href="#"></a>
                                                </h4>
                                                <p class="description">
                                                    Our Silver Medal is a symbol of excellence! It's awarded to participants who consistently perform exceptionally well in the quizzes. Earning this medal demonstrates your dedication to learning and your impressive quiz-solving skills.
                                                    <br />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6 col-lg-4 mb-5">
                                        <div class="text-center icon-box h-100">
                                            <div class="icon"><i class="fab fa-codepen" style="margin-bottom: 15px;"></i>
                                                <h4 class="title">Bronze Medal
                                                    <a href="#"></a>
                                                </h4>
                                                <p class="description">
                                                    The Bronze Medal is a testament to your commitment and proficiency in our quizzes. It's awarded to those who have shown great potential and scored admirably among the participants.
                                                    <br />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </section>

                    </div>

                </div>





                <div class="typ hide" id="typ-1">

                    <div class="container-fluid">
                        <div class="container d-flex justify-content-center " style="background-color: #f0f0f0;">
                            <div class="card border p-3">
                                <h3>Maths LeaderBoard</h3>
                            </div>
                        </div>
                        <div class="card" id="TableSorterCard">
                            <div class="row" style="background: var(--bs-secondary-bg);color: var(--bs-body-color);">
                                <div class="col-12">
                                    <div class="table-responsive">
                                        <table class="table table-striped table tablesorter" id="ipi-table">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th class="text-center">Number</th>
                                                    <th class="text-center">Name</th>
                                                    <th class="text-center">Score</th>
                                                    <th class="text-center filter-false sorter-false">Rank</th>
                                                    <th class="text-center">avg.score</th>
                                                </tr>
                                            </thead>
                                            <tbody class="text-center">
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Sanjana</td>
                                                    <td>99</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>4.13</td>
                                                </tr>
                                                <tr>
                                                    <td>2<br></td>
                                                    <td>Tharidu</td>
                                                    <td>90</td>
                                                    <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                        <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                            <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                        </a>
                                                    </td>
                                                    <td>3.5</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 

                </div>

                <div class="typ hide" id="typ-2">

                    <div class="container d-flex justify-content-center " style="background-color: #f0f0f0;">
                        <div class="card border p-3">
                            <h3>bio LeaderBoard</h3>
                        </div>
                    </div>
                    <div class="card" id="TableSorterCard">
                        <div class="row" style="background: var(--bs-secondary-bg);color: var(--bs-body-color);">
                            <div class="col-12">
                                <div class="table-responsive">
                                    <table class="table table-striped table tablesorter" id="ipi-table">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th class="text-center">Number</th>
                                                <th class="text-center">Name</th>
                                                <th class="text-center">Score</th>
                                                <th class="text-center filter-false sorter-false">Rank</th>
                                                <th class="text-center">avg.score</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sanjana</td>
                                                <td>99</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>4.13</td>
                                            </tr>
                                            <tr>
                                                <td>2<br></td>
                                                <td>Tharidu</td>
                                                <td>90</td>
                                                <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                                    <a class="btn btnMaterial btn-flat primary semicircle" role="button" href="#">
                                                        <img src="Assetes/img/gold-medal-svgrepo-com.svg"  width="25px" height="25px" alt="gold-medel">
                                                    </a>
                                                </td>
                                                <td>3.5</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="typ hide" id="typ-3">

                </div>

                <div class="typ hide" id="typ-4">

                </div>

                <div class="typ hide" id="typ-5">

                </div>

                <div class="typ hide" id="typ-6">

                </div>

                <div class="typ hide" id="typ-7">

                </div>




                <!-- My score -->

                <div id="dets-1" class="dets hide">

                    <div class="container">
                        <div class="main-body">


                            <!-- right side contenet -->

                            <div class="row gutters-sm">
                                <div class="col-md-4 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex flex-column align-items-center text-center">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin" class="rounded-circle" width="150">
                                                <div class="mt-3">
                                                    <h4>Tharindu Desh</h4>
                                                    <p class="text-secondary mb-1">Student</p>
                                                    <p class="text-muted font-size-sm">UWU </p>
                                                    <button class="btn btn-primary">Share</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card mt-3">
                                        <ul class="list-group list-group-flush">

                                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github mr-2 icon-inline"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>Github</h6>
                                                <span class="text-secondary">https://github.com/kaveendahelitha</span>
                                            </li>
                                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-twitter mr-2 icon-inline text-info"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>Twitter</h6>
                                                <span class="text-secondary">https://github.com/kaveendahelitha</span>
                                            </li>
                                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-instagram mr-2 icon-inline text-danger"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>Instagram</h6>
                                                <span class="text-secondary">https://github.com/kaveendahelitha</span>
                                            </li>
                                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-facebook mr-2 icon-inline text-primary"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>Facebook</h6>
                                                <span class="text-secondary">https://github.com/kaveendahelitha</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card mb-3">
                                        <div class="card-body row">

                                            <div class="col">


                                                <svg height="80px" width="80px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
                                                     viewBox="0 0 300.439 300.439" xml:space="preserve">
                                                <g>
                                                <path style="fill:#BF392C;" d="M276.967,0h-84.498L70.415,178.385h84.498L276.967,0z"/>
                                                <path style="fill:#E2574C;" d="M23.472,0h84.498l122.053,178.385h-84.498L23.472,0z"/>
                                                <path style="fill:#EFC75E;" d="M154.914,93.887c57.271,0,103.276,46.005,103.276,103.276s-46.005,103.276-103.276,103.276
                                                      S51.638,254.434,51.638,197.163S97.643,93.887,154.914,93.887z"/>
                                                <path style="fill:#D7B354;" d="M154.914,122.053c-41.31,0-75.11,33.799-75.11,75.11s33.799,75.11,75.11,75.11
                                                      s75.11-33.799,75.11-75.11S196.224,122.053,154.914,122.053z M154.914,253.495c-30.983,0-56.332-25.35-56.332-56.332
                                                      s25.35-56.332,56.332-56.332s56.332,25.35,56.332,56.332S185.896,253.495,154.914,253.495z"/>
                                                </g>
                                                </svg>

                                            </div>

                                            <div class="col">
                                                <svg height="80px" width="80px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
                                                     viewBox="0 0 300.439 300.439" xml:space="preserve">
                                                <g>
                                                <path style="fill:#BF392C;" d="M276.967,0h-84.498L70.415,178.385h84.498L276.967,0z"/>
                                                <path style="fill:#E2574C;" d="M23.472,0h84.498l122.053,178.385h-84.498L23.472,0z"/>
                                                <path style="fill:#ED9D5D;" d="M154.914,93.887c57.271,0,103.276,46.005,103.276,103.276s-46.005,103.276-103.276,103.276
                                                      S51.638,254.434,51.638,197.163S97.643,93.887,154.914,93.887z"/>
                                                <path style="fill:#D58D54;" d="M154.914,122.053c-41.31,0-75.11,33.799-75.11,75.11s33.799,75.11,75.11,75.11
                                                      s75.11-33.799,75.11-75.11S196.224,122.053,154.914,122.053z M154.914,253.495c-30.983,0-56.332-25.35-56.332-56.332
                                                      s25.35-56.332,56.332-56.332s56.332,25.35,56.332,56.332S185.896,253.495,154.914,253.495z"/>
                                                </g>
                                                </svg>
                                            </div>

                                            <div class="col">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-award" viewBox="0 0 16 16">
                                                <path d="M9.669.864 8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"/>
                                                <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/>
                                                </svg>
                                            </div>









                                        </div>
                                    </div>

                                    <div class="row gutters-lg">
                                        <div class="col-lg mb-3">
                                            <div class="card h-100">
                                                <div class="card-body">
                                                    <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-2">Subject</i> Score</h6>
                                                    <small>Maths</small>
                                                    <div class="progress mb-3" style="height: 5px">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                    <small>Science</small>
                                                    <div class="progress mb-3" style="height: 5px">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 72%" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                    <small>History</small>
                                                    <div class="progress mb-3" style="height: 5px">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 89%" aria-valuenow="89" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                    <small>Music</small>
                                                    <div class="progress mb-3" style="height: 5px">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                    <small>ICT</small>
                                                    <div class="progress mb-3" style="height: 5px">
                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 66%" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>



                                </div>
                            </div>

                        </div>
                    </div>



                </div>

            </div>











        </section>



        <script src="js.js"></script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!--drop down menu-->
        <script>


                        document.addEventListener('DOMContentLoaded', function () {
                            var dropdownToggle = document.getElementById('dropdownMenuButton');
                            var dropdownMenu = document.querySelector('.dropdown-menu');

                            dropdownToggle.addEventListener('click', function () {
                                dropdownMenu.classList.toggle('show-dropdown');
                            });

                            document.addEventListener('click', function (event) {
                                var targetElement = event.target;
                                if (!dropdownToggle.contains(targetElement) && !dropdownMenu.contains(targetElement)) {
                                    dropdownMenu.classList.remove('show-dropdown');
                                }
                            });
                        });


        </script>


    </body>
</html>