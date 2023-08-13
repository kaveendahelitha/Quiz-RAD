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
                    </div>

                    <div class="d-flex ms-auto order-5">
                        <form method="POST" action="process-logout.jsp?redirect=1">
                            <input type="submit" class="btn btn-primary me-3" value="Logout"/>
                        </form>                     
                    </div>
                </div>
            </div>
        </nav>

        <main>
            <div class="container-md mt-5">
                
                <%
                    String msg = "";
                    if(request.getParameter("error") != null){
                        String error = request.getParameter("error");
                        if(error.equals("1")){
                            msg = "Quiz title cannot be empty";
                        }
                        else if(error.equals("2")){
                            msg = "Neither question nor answer fields can be empty";
                        }
                        else if(error.equals("3")){
                            msg = "Please enter a valid value for Correct answer field. A number between 1-4";
                        }
                        else if(error.equals("4")){
                            msg = "Correct option is always between 1 and 4. Check your inputs.";
                        }
                    }
                %>
                <p class="text-danger mt-3"><%= msg %></p>
                
                <form method="POST" action="process-add-quiz.jsp">
                    <input type="hidden" name="tot_ques" value="" id="tot_ques"/>
                    <input type="hidden" name="subject_id" value="<%= request.getParameter("subject_id") %>" id="subject_id"/>
                    
                    <div class="row ms-auto text-end">                    
                        <div class="col ms-auto text-start">
                            <input type="checkbox" name="isPublic" id="isPublic">
                            <label for="isPublic" class="text-light h5">Public</label>
                        </div>
                        <div class="col ms-auto text-start">
                            <input type="text" name="quiz_title" id="quiz_title" class="form-control" placeholder="Enter Quiz Title" required>
                            <p class="text-danger mt-3" id="title-warn">Please Fill out this Field</p>
                        </div>
                        <div class="col">
                            <button type="button" name="add" id="add" class="btn btn-info mb-4 add">Add
                                New</button>                           
                        </div>
                    </div>

                    <div class="questions row">
                        <a class="prev" onclick="changeQuestion(-1)"><</a>

                        <div class="question_div form-group">
                            <div class="col-2">
                                <p class="question_number text-light display-3">1</p>
                            </div>

                            <div class="col q1" id="q1">
                                <p class="text-danger" id="title-warn2">Please Fill out this Field</p>
                                <input type="text" id="question" name="question1" class="form-control mb-5"
                                       placeholder="Enter Question" />
                                                       
                                <p class="text-danger" id="title-warn3">Please Fill out this Field</p>
                                <input type="text" id="answer1" name="1answer1" class="form-control mb-5"
                                       placeholder="Enter Answer 1" />
                                  
                                <p class="text-danger" id="title-warn4">Please Fill out this Field</p>
                                <input type="text" id="answer2" name="1answer2" class="form-control mb-5"
                                       placeholder="Enter Answer 2" />
                                
                                <p class="text-danger" id="title-warn5">Please Fill out this Field</p>
                                <input type="text" id="answer3" name="1answer3" class="form-control mb-5"
                                       placeholder="Enter Answer 3" />
                                
                                <p class="text-danger" id="title-warn6">Please Fill out this Field</p>
                                <input type="text" id="answer4" name="1answer4" class="form-control mb-5"
                                       placeholder="Enter Answer 4" />
                                
                                <p class="text-danger" id="title-warn7">Please Fill out this Field</p>
                                <input type="text" id="correct_answer" name="1correct_answer" class="form-control mb-5"
                                       placeholder="Enter Correct Option as 1,2,3,4" />                               
                            </div>                           
                        </div>
                         <a class="next" onclick="changeQuestion(1)">></a>
                    </div>

                    <div class="row">
                        <input type="submit" name="save" id="save" value="Save Quiz" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </main>

        <footer class="bg-light text-center mt-5" style="position: relative;">
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2023 All rights reserved:
                <a class="text-dark" href="index.html">WeQuiz</a>
            </div>
        </footer>

        <script>
            let questionList = [document.querySelector(".q1")];
             document.getElementById("tot_ques").value = "1";
             
            let add = document.querySelector(".add");
            let questionsDiv = document.querySelector(".question_div");
            let question_number = document.querySelector(".question_number");
            
            let i = 2;

            add.addEventListener("click", function () {
                document.getElementById("tot_ques").value = questionList.length + 1;
                
                document.querySelector(".q" + (i - 1)).style.display = "none";

                question_number.textContent = i;

                var col = document.createElement("div");
                col.setAttribute("id", "q"+i);
                col.classList.add("col");
                col.classList.add("q" + i);
             
                var q = document.createElement("INPUT");
                q.setAttribute("type", "text");
                q.setAttribute("name", "question" + i);
                q.setAttribute("placeholder", "Enter Question");
                q.classList.add("form-control");
                q.classList.add("mb-5");
                q.setAttribute("required", "");

                var a1 = document.createElement("INPUT");
                a1.setAttribute("type", "text");
                a1.setAttribute("name", i + "answer" + 1);
                a1.setAttribute("placeholder", "Enter Answer 1");
                a1.classList.add("form-control");
                a1.classList.add("mb-5");
                a1.setAttribute("required", "");

                var a2 = document.createElement("INPUT");
                a2.setAttribute("type", "text");
                a2.setAttribute("name", i + "answer" + 2);
                a2.setAttribute("placeholder", "Enter Answer 2");
                a2.classList.add("form-control");
                a2.classList.add("mb-5");
                a2.setAttribute("required", "");

                var a3 = document.createElement("INPUT");
                a3.setAttribute("type", "text");
                a3.setAttribute("name", i + "answer" + 3);
                a3.setAttribute("placeholder", "Enter Answer 3");
                a3.classList.add("form-control");
                a3.classList.add("mb-5");
                a3.setAttribute("required", "");

                var a4 = document.createElement("INPUT");
                a4.setAttribute("type", "text");
                a4.setAttribute("name", i + "answer" + 4);
                a4.setAttribute("placeholder", "Enter Answer 4");
                a4.classList.add("form-control");
                a4.classList.add("mb-5");
                a4.setAttribute("required", "");

                var correct = document.createElement("INPUT");
                correct.setAttribute("type", "text");
                correct.setAttribute("name", i + "correct_answer");
                correct.setAttribute("placeholder", "Enter Correct Answer as 1,2,3,4");
                correct.classList.add("form-control");
                correct.classList.add("mb-5");
                correct.setAttribute("required", "");

                col.appendChild(q);
                col.appendChild(a1);
                col.appendChild(a2);
                col.appendChild(a3);
                col.appendChild(a4);
                col.appendChild(correct);

                questionsDiv.appendChild(col);

                questionList.push(col);

                i++;
            });         
            
            let curr = questionList.length - 1;
            function changeQuestion(i) {
                if (questionList.length > 1) {
                    if (i > 0) {
                        if ((curr + i) > (questionList.length - 1)) {
                            curr = 0;
                        } else {
                            curr += 1;
                        }
                    } else {
                        if ((curr + i) < 0) {
                            curr = questionList.length - 1;
                        } else {
                            curr -= 1;
                        }

                    }

                    for (let i = 0; i < questionList.length; i++) {
                        question_number.textContent = curr + 1;
                        if (i !== curr) {
                            questionList[i].style.display = "none";
                        } else {
                            questionList[curr].style.display = "block";
                        }
                    }
                }
            }
        </script>
        
        <script>
            let quiz_title = document.getElementById("quiz_title");
            quiz_title.addEventListener("keyup", ()=>{
                if(quiz_title.value === ""){
                    document.getElementById("title-warn").style.display = "block";
                }
                else{
                    document.getElementById("title-warn").style.display = "none";
                }
            });   
            
            let question = document.getElementById("question");
            question.addEventListener("keyup", ()=>{
                if(question.value === ""){
                    document.getElementById("title-warn2").style.display = "block";
                }
                else{
                    document.getElementById("title-warn2").style.display = "none";
                }
            });   
            
            let answer1 = document.getElementById("answer1");
            answer1.addEventListener("keyup", ()=>{
                if(answer1.value === ""){
                    document.getElementById("title-warn3").style.display = "block";
                }
                else{
                    document.getElementById("title-warn3").style.display = "none";
                }
            });   
            
            let answer2 = document.getElementById("answer2");
            answer2.addEventListener("keyup", ()=>{
                if(answer2.value === ""){
                    document.getElementById("title-warn4").style.display = "block";
                }
                else{
                    document.getElementById("title-warn4").style.display = "none";
                }
            });   
            
            let answer3 = document.getElementById("answer3");
            answer3.addEventListener("keyup", ()=>{
                if(answer2.value === ""){
                    document.getElementById("title-warn5").style.display = "block";
                }
                else{
                    document.getElementById("title-warn5").style.display = "none";
                }
            });   
            
            let answer4 = document.getElementById("answer4");
            answer4.addEventListener("keyup", ()=>{
                if(answer2.value === ""){
                    document.getElementById("title-warn6").style.display = "block";
                }
                else{
                    document.getElementById("title-warn6").style.display = "none";
                }
            });   
            
            let correct_answer = document.getElementById("correct_answer");
            correct_answer.addEventListener("keyup", ()=>{
                if(correct_answer.value === ""){
                    document.getElementById("title-warn7").style.display = "block";
                }
                else{
                    document.getElementById("title-warn7").style.display = "none";
                }
            });   
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    </body>
</html>