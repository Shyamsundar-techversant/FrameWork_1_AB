<cfset variables.gender  =  "">
<cfset variables.hobbies  =  "">
<cfset variables.title = "">
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "UTF-8">
        <meta name = "viewport" content = "width = device-width, initial-scale = 1.0">
        <title>Address Book</title>
        <link rel  =  "stylesheet" href = "/Frame_work_1_Address_Book/assets/css/style.css"/>
        <link rel  =  "stylesheet" href = "/Frame_work_1_Address_Book/assets/css/bootstrap.css"/>
        <link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" 
            integrity = "sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg =  = " 
            crossorigin = "anonymous" 
            referrerpolicy = "no-referrer"/>	
    </head>
    <body>
        <cfoutput>
            <section class = "reg-page  no-print">
                <header class = "header">
                    <div class = "container">
                        <nav class = "navigation">
                            <div class = "logo">
                                <i class = "fa-solid fa-address-book"></i>
                                ADDRESS BOOK	
                            </div>
                            <div class = "reg-buttons">
                                <button class = "btn sign-up">
                                    <cfoutput>
                                        <a href = "#buildURL('main.logOut')#">
                                            <i class = "fa-solid fa-arrow-left"></i>LogOut
                                        </a>
                                    </cfoutput>
                                </button>
                            </div>
                        </nav>
                    </div>			
                </header>
            </section>     
            #body#
        </cfoutput>

