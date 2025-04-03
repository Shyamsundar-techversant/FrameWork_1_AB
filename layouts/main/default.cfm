<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Address Book</title>
        <link rel = "stylesheet" href="/Frame_work_1_Address_Book/assets/css/style.css"/>
        <link rel = "stylesheet" href="/Frame_work_1_Address_Book/assets/css/bootstrap.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" 
            integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" 
            crossorigin="anonymous" 
            referrerpolicy="no-referrer"/>	
    </head>
    <body>
        <cfoutput>
            <section class="reg-page">
                <header class="header">
                    <div class="container">
                        <nav class="navigation">
                            <div class="logo">
                                <i class="fa-solid fa-address-book"></i>	
                            </div>
                            <div class="reg-buttons">
                                <button class="btn sign-up" onclick="signUpForm()"><i class="fa-solid fa-user"></i>
                                    <a href="signup.cfm">SingUp</a>
                                </button>
                                <button class="btn log-in" onclick="logInForm()"><i class="fa-solid fa-right-to-bracket"></i>
                                    <a href="logIn.cfm">LogIn</a>
                                </button>		
                            </div>
                        </nav>
                    </div>
                </header>
                #body#
        </cfoutput>
