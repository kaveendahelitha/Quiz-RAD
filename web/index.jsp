<%-- 
    Document   : process-logout
    Created on : Jul 31, 2023, 8:26:03 AM
    Author     : sanjanaattanayake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>WeQuiz</title>
        <link rel="icon" type="image/png" href="favicon.png">
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <!-- BOOTSTRAP V 5.0 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="./css/style-main.css">
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
                            if(session.getAttribute("teacher_id") != null){
                            %>
                                <p class="h5 ms-auto"><a class="nav-link" href="teacher-index.jsp">Teacher - Home</a></p>
                            <%
                            }
                        %>
                    </div>

                    <div class="d-flex ms-auto order-5">
                        <%
                            if(session.getAttribute("teacher_id") == null && session.getAttribute("student_id") == null){
                            %>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'student-login.jsp'">Login</button>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'teacher-login.jsp'">For Educators</button>
                            <%
                            }
                            else{
                            %>
                                <button type="button" class="btn btn-primary me-3" onclick="location.href = 'process-logout.jsp'">Logout</button>
                            <%
                            }
                        %>                                           
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-5 px-5">
            <div class="row mt-5 mb-5">
                <div class="col">
                    <h3 class="display-1">What is <b>WeQuiz </b>?</h3>
                    <p class="description">
                        WeQuiz is a dynamic and interactive quiz platform designed for educators and students alike. 
                        With its user-friendly interface, educators can effortlessly create and manage subjects, 
                        as well as craft engaging quizzes tailored to their students' needs. Whether it's for 
                        academic subjects, skill development, or fun challenges, educators have the flexibility 
                        to customize quizzes to enhance learning experiences.
                        <br><br>
                        Whether in a classroom setting or for individual practice, WeQuiz 
                        empowers educators and students to embrace the joy of learning through
                         engaging quizzes, making education an enjoyable journey of discovery 
                         and knowledge acquisition.
                    </p>
                </div>
            </div>

            <div class="row mt-5 mb-5">
                <div class="col">
                    <h3 class="display-1">Why <b>WeQuiz </b>?</h3>
                    <h3 class="h3 mt-3 mb-4">Unlock Your Learning Potential with WeQuiz!</h3>
                    
                    <h4 class="h4 mb-3 text-light">For Educators</h4>
                    <dl>
                        <dt>📚 Create Engaging Quizzes</dt>
                        <dd>
                            Craft customized quizzes tailored to your subjects and teaching style. Empower your students with interactive and challenging learning materials.
                        </dd>
                        <dt>🎯 Track Student Progress</dt>
                        <dd>
                            Keep a close eye on your students' performance and understand their strengths and areas for improvement. WeQuiz's comprehensive analytics provide valuable insights to guide your teaching strategies.
                        </dd>
                        <dt>🏆 Fostering Healthy Competition</dt>
                        <dd>
                            Encourage friendly competition among students with leaderboards and achievements. Motivate your class to excel and celebrate their learning milestones.
                        </dd>
                    </dl>

                    <h4 class="h4 mb-3 mt-5 text-light">For Students</h4>
                    <dl>
                        <dt>📝 Practice Anytime, Anywhere</dt>
                        <dd>
                            Access a wide range of quizzes to practice at your convenience. Whether you're preparing for exams or simply exploring new topics, WeQuiz has you covered.
                        </dd>
                        <dt>🔍 Discover New Subjects</dt>
                        <dd>
                            Discover New Subjects: Dive into an extensive collection of public quizzes across various subjects. Explore and expand your knowledge in exciting and captivating ways.
                        </dd>
                        <dt>🤝 Connect with Tutors</dt>
                        <dd>
                            Join WeQuiz today and embark on an educational journey like no other. Unlock your learning potential with our innovative quiz platform and experience the joy of learning at your fingertips!
                        </dd>
                    </dl>
                </div>
            </div>
        </div>

        <div class="container mt-5 mb-5 px-5">
            <div class="row">
                <div class="col">
                    <h3 class="display-3">Top Quizzes this Week</h3>
                </div>
            </div>
            <div class="row gx-5 mt-2">
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="cards">
                                <h5 class="h5">Grade 6</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="cards">
                                <h5 class="h5">Grade 6</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="cards">
                                <h5 class="h5">Grade 6</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <div class="container mt-5 mb-5 px-5">
            <div class="row">
                <div class="col">
                    <h3 class="display-3">Top Tutors this Week</h3>
                </div>
            </div>
            <div class="row gx-5 mt-2">
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="tutor-card text-center">
                                <img src="./assets/profile-pics/person1.jpg" class="img-thumbnail profile-pic mb-2">
                                <h5 class="h5">Cameron Chan</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="tutor-card text-center">
                                <img src="./assets/profile-pics/person1.jpg" class="img-thumbnail profile-pic mb-2">
                                <h5 class="h5">Cameron Chan</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col">
                    <a href="#">
                        <div class="p-3">
                            <div class="tutor-card text-center">
                                <img src="./assets/profile-pics/person1.jpg" class="img-thumbnail profile-pic mb-2">
                                <h5 class="h5">Cameron Chan</h5>
                                <p>Maths</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <footer class="bg-light text-center">
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2023 All rights reserved:
                <a class="text-dark" href="index.html">WeQuiz</a>
              </div>
        </footer>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    </body>
</html>