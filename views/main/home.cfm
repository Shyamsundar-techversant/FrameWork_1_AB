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
</cfif>

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
                            <cfoutput><h4>#session.userName#</h4></cfoutput>
                            <button type="button" class="btn btn-primary user-creation"  id="create-cont"
                                data-bs-toggle="modal" data-bs-target="#staticBackdrop"	
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
                                    <cfif structKeyExists(rc, 'contactsDetails')>
                                        <cfoutput>
                                                
                                            <cfloop query="rc.contactsDetails">
                                              <!---  <cfset encryptedId = encrypt(
                                                                    getContacts.id,application.encryptionKey,"AES", 
                                                                    "Hex"
                                                                )
                                                >--->
                                                <tr>
                                                    <td>
                                                        <img src="/uploadImg/#rc.contactsDetails.imagePath#" alt="logo" width="30" height="30"
                                                        >
                                                    </td>
                                                    <td>#rc.contactsDetails.firstName &rc.contactsDetails.lastName#</td>
                                                    <td>#rc.contactsDetails.email#</td>
                                                    <td>#rc.contactsDetails.phone#</td>
                                                    <td class="no-print">
                                                        <button type="button" 
                                                            class="btn btn-primary contact-view-btn" 
                                                            data-bs-toggle="modal"
                                                            data-bs-target="##viewContact"
                                                            data-id=""
                                                        >
                                                            VIEW
                                                        </button>
                                                    </td>
                                                    <cfif session.userId EQ rc.contactsDetails.userId>
                                                        <td class="no-print">
                                                        
                                                                <button class="edit-cont-details"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target=
                                                                    "##staticBackdrop"
                                                                    data-id=""
                                                                >
                                                                    EDIT
                                                                </button>
                                                        
                                                        </td>
                                                        <td class="no-print">
                                                            <button class="delete-contact-details"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="##deleteContact"
                                                                data-id=""
                                                            >
                                                                Delete
                                                            </button>
                                                        </td>
                                                    <cfelse>
                                                        <td class="no-print">
                                                        
                                                                <button disabled >EDIT
                                                                </button>
                                                        
                                                        </td>
                                                        <td class="no-print">
                                                            <button class="delete-contact-details"
                                                                disabled
                                                            >
                                                                Delete
                                                            </button>
                                                        </td>

                                                    </cfif>
                                                </tr>
                                            </cfloop>
                                        </cfoutput>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>				
            </div>
        </section>

        <!--- Modal ADD/EDIT --->
        <div	class="modal" 
            id="staticBackdrop" 
        >
            <div class="modal-dialog add-edit-contact">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="add-edit-head">CREATE CONTACT</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div>
                            <div class="container">			
                                    <form action="" method="post" enctype="multipart/form-data" id="contacts-form">
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="title" class="form-label">Title</label>
                                                
                                                <select name="title" class="form-select" id="title">
                                                    <cfoutput>
                                                        <cfloop query="rc.titles">
                                                            <option value="#rc.titles.id#"
                                                                <cfif rc.titles.id EQ variables.title
                                                                >
                                                                    selected
                                                                </cfif>
                                                            >
                                                                #rc.titles.titles#
                                                            </option>
                                                        </cfloop>
                                                    </cfoutput>
                                                </select> 
                                            </div>
                                            <div class="col">
                                                <label for="firstname" class="form-label">Firstname : </label>
                                                <input type="text" class="form-control" id="firstname" name="firstname" value="<cfoutput>#variables.firstname#</cfoutput>">
                                            </div>
                                            <div class="col">
                                                <label for="lastname" class="form-label">Lastname : </label>
                                                <input type="text" class="form-control" id="lastname" name="lastname" value="<cfoutput>#variables.lastname#</cfoutput>">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="gender" class="form-label">Gender</label>
   
                                                <select name="gender" class="form-select" id="gender">
                                                    <option value="">Select</option>
                                                    <cfoutput>
                                                        <cfloop query="rc.genders">
                                                            <option value="#rc.genders.id#" 
                                                                <cfif rc.genders.id EQ 
                                                                    variables.gender
                                                                >
                                                                    selected
                                                                </cfif>
                                                            >
                                                                #rc.genders.gender_values#
                                                            </option>
                                                        </cfloop>	
                                                    </cfoutput>
                                                </select> 
                                            </div>
                                            <div class="col">
                                                <label for="dob" class="form-label">Date Of Birth</label>
                                                <input type="date" class="form-control" id="dob" name="dob" 
                                                    value="<cfoutput>#variables.dob#</cfoutput>"
                                                >
                                            </div>
                                        </div>
                                        <div class="row mb-1">
                                            <div class="col">
                                                <label for="upload-img" class="form-label">Upload Photo </label>
                                                <input type="file" class="form-control" id="upload-img" name="uploadImg" >
                                            </div>

                                        </div>
                                        <div class="row mb-3">
                                            <div class="col d-flex gap-2">
                                                <div class="imgThumbNail" id="contactThumb">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-head">
                                            <h4>CONTACT DETAILS</h4>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" value="<cfoutput>#variables.email#</cfoutput>">
                                            </div>
                                            <div class="col">
                                                <label for="phone" class="form-label">Phone</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" maxlength="10" value="<cfoutput>#variables.phone#</cfoutput>"
                                            >
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="address" class="form-label">Address</label>
                                                <textarea class="form-control" id="address" name="address" rows="4" cols="7" >
                                                    <cfoutput>#variables.address#</cfoutput>	
                                                </textarea>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="street" class="form-label">Street</label>
                                                <input type="text" class="form-control" id="street" name="street" value="<cfoutput>#variables.street#</cfoutput>"
                                                >
                                            </div>
                                            <div class="col">
                                                <label for="pincode" class="form-label">Pincode</label>
                                                <input type="text" class="form-control" id="pincode" name="pincode" value="<cfoutput>#variables.pincode#</cfoutput>"
                                                >
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label for="hobby" class="form-label">Hobbies</label>
                                   
                                                <select name="hobby" class="form-select" id="hobby" multiple >
                                                    <cfoutput query="rc.hobbies">
                                                        <option value="#rc.hobbies.id#" 
                                                            <cfif listFind(variables.hobbies,rc.hobbies.id)
                                                            >
                                                                selected
                                                            </cfif>

                                                        >
                                                            #rc.hobbies.hobby_name#
                                                        </option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="publicUser" name="public"
                                                    >
                                                    <label class="form-check-label" for="publicUser">
                                                        Public
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" id="hiddenId">
                                        <div class="row">
                                            <div class="col">
                                                <div class="user-form-buttons">
                                                    <button class="edit-details user-btn"  name="submit" id="edit-cont" type="submit"
                                                    >
                                                        Edit Contact
                                                    </button>
                                                    <button class="add-details user-btn" id="add-cont">
                                                        Add Contact
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div id="error-data">

                                            </div>
                                        </div>
                                    </form>
                            </div>
                        </div>						

                    </div>
                </div>
            </div>
        </div>
        
        <!--- Modal view --->
        <div class="modal" id="viewContact" >
            
        
            <div class="modal-dialog view-contact">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">CONTACT DETAILS</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body view-contact-body">
                        <div>
                            <div class="container">			
                                    <div class="profile-image">
                                        <img id="profile-picture">
                                    </div>
                                    Name:<span id="contact-name" class="cont-info"></span><br>
                                    Gender:<span id="contact-gender" class="cont-info"></span><br>
                                    DOB:<span id="contact-dob" class="cont-info"></span><br>
                                    ADDRESS:<span id="contact-address" class="cont-info"></span><br>
                                    PINCODE:<span id="contact-pincode" class="cont-info"></span><br>
                                    EMAIL-ID:<span id="contact-email" class="cont-info"></span><br>
                                    PHONE:<span id="contact-phone" class="cont-info"></span><br>
                                    HOBBIES:<span id="user-hobbies" class="cont-info"></span>
                            </div>
                        </div>						

                    </div>
                </div>
            </div>
        </div>
        
        <!---Modal Delete--->
        <div	class="modal" 
            id="deleteContact"     		
        >
            <div class="modal-dialog delete-contact">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">DELETE CONTACT</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div>
                            <div class="container">			
                                <div class="row p-3">
                                    <div class="col">
                                        <div class="user-form-buttons">
                                            <button class="cancel-user-form user-btn" 
                                            data-bs-dismiss="modal" >
                                                Cancel
                                            </button>
                                            <button  class="delete-details user-btn"  name="edit-user" id="delete-cont">
                                                Delete Contact
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>						
                    </div>
                </div>
            </div>
        </div>		

        <script src = "/Frame_work_1_Address_Book/assets/js/bootstrap.bundle.js"></script>
        <script src = "/Frame_work_1_Address_Book/assets/js/jquery-3.7.1.min.js"></script>
        <script src="/Frame_work_1_Address_Book/assets/js/script.js"></script>
        <script>
            <cfif structKeyExists(variables,"addContact")>				
                document.addEventListener('DOMContentLoaded',function(){
                    document.getElementById('edit-cont').style.display="none";					
                    <cfset variables.errorMessageHtml = '<ul><li>'& arrayToList(variables.addContact,'</li><li>')&'</li></ul>'>
                    let errorData =  "<cfoutput>#JSStringFormat(variables.errorMessageHtml)#</cfoutput>";
                    document.getElementById('error-data').innerHTML = errorData;					
                    // var modal= new bootstrap.Modal(document.getElementById('staticBackdrop'));
                    $('#staticBackdrop').modal('show');
                    // modal.show();									
                });
            </cfif>
        </script>
    </body>
</html>


