<cfoutput>
    <cfset variables.title = "">
    <cfset variables.firstname = "">
    <cfset variables.lastname = "">
    <cfset variables.gender = "">
    <cfset variables.dob = "">
    <cfset variables.photo = "">
    <cfset variables.email = "">
    <cfset variables.phone = "">
    <cfset  variables.address = "">
    <cfset variables.street = "">
    <cfset variables.pincode = "">
    <cfset variables.hobbies = "">


<!--- 
<cfif structKeyExists(form,"submit")>
    <cfif structKeyExists(form,"public")>
        <cfset form.public=1>
    <cfelse>
        <cfset form.public=0>
    </cfif>
    <cfif NOT  structKeyExists(form,"hobby")>
        <cfset form.hobby="">
    </cfif>
    <cfset variables.addContact = application.dbObj.validateFormAndCreateOrUpdateUser(
                        title=form.title,
                        firstname=form.firstname,
                        lastname=form.lastname,
                        gender=form.gender,
                        dob=form.dob,
                        formFile=form.uploadImg,
                        email=form.email,
                        phone=form.phone,
                        address=form.address,
                        street=form.street,
                        pincode=form.pincode,
                        hobbies=form.hobby,
                        public=form.public,
                        id = form.id
                                                
                    )
    >
    <cfif arrayLen(variables.addContact) GT 0>
        <cfset variables.title=form.title>
        <cfset variables.firstname = form.firstname>
        <cfset variables.lastname = form.lastname>
        <cfset variables.gender = form.gender>		
        <cfset variables.dob = form.dob>
        <cfset variables.email = form.email>
        <cfset variables.phone = form.phone>
        <cfset variables.address = form.address>
        <cfset variables.street = form.street>
        <cfset variables.pincode = form.pincode>
        <cfset variables.hobbies = form.hobby>	
    </cfif>

<cfelseif structKeyExists(form,"excelSubmit")>
    <cfinclude template="excelUpload.cfm">
</cfif>
<cfset variables.getContacts=application.dbObj.getData()>
--->
<!---     <cfdump  var="#rc.userData.recordCount()#" abort> --->
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Address Book</title>
            <link rel = "stylesheet" href="/Frame_work_1/assets/css/style.css"/>
            <link rel = "stylesheet" href="/Frame_work_1/assets/css/bootstrap.css"/>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" 
                integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" 
                crossorigin="anonymous" 
                referrerpolicy="no-referrer"/>	
        </head>
        <body>
            <section class="reg-page  no-print">
                <header class="header">
                    <div class="container">
                        <nav class="navigation">
                            <div class="logo">
                                <i class="fa-solid fa-address-book"></i>
                                ADDRESS BOOK	
                            </div>
                            <div class="reg-buttons">
                                <button class="btn sign-up">
                                    <a href="logIn.cfm?logOut=1">
                                        <i class="fa-solid fa-arrow-left"></i>LogOut
                                    </a>
                                </button>
                            </div>
                        </nav>
                    </div>			
                </header>
            </section>
            <section class="user-details">
                <div class="container">
                    <div class="user-options  no-print">
                        <div class="options">
                            <button media="print" onclick="window.print();" >PRINT</button>
                            <button onclick="window.location.href='pdf.cfm';">PDF</button>
                        </div>
                    </div>
                </div>
                <div class="container">
                    
                        <div class="users">
                            <div class="create-profile">
                                <div class="user-img-logo">
                                    <i class="fa-solid fa-user"></i>
                                </div>
                                <h4></h4>
                                <button type="button" class="btn btn-primary user-creation"  id="create-cont"
                                    data-bs-toggle="modal" data-bs-target="##staticBackdrop"	
                                >
                                    CREATE CONTACT
                                </button>
                            </div>
                            <div class="user-profiles">
                                <table class="table">
                                    <thead>
                                        <tr>	
                                            <th scope="col"> Photo</th>																	<th scope="col">Name</th>
                                            <th scope="col">Email Id</th>
                                            <th scope="col">Phone Number</th>
                                            <th scope="col" class="no-print">VIEW</th>
                                            <th scope="col" class="no-print">EDIT</th>
                                            <th scope="col" class="no-print">DELETE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                            
                                                    

                                    </tbody>
                                </table>
                            </div>
                        </div>				
                </div>
            </section>

            
            <script src = "/Frame_work_1/assets/js/bootstrap.bundle.js"></script>
            <script src = "/Frame_work_1/assets/js/jquery-3.7.1.min.js"></script>
            <script src="/Frame_work_1/assets/js/script.js"></script>
        </body>
    </html>
</cfoutput>