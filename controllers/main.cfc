component accessors="true" {
    property name="addressbookService";
    property name="userService";
    
    function init(fw) {
        variables.fw = fw;
        return this;
    }

    public any function default(struct rc) {
        param name = "form.userName" default = "";
        param name = "form.password" default = "";
        rc.errors = "";
        rc.userData = userService.userLogIn(form.userName);
        local.hashedPassword = userService.hashPassword(form.password,rc.userData.salt);

        // VALIDATE USERNAME AND PASSWORD
        if (len(trim(form.userName)) == 0) {
            rc.errors = "*Username required";
            return rc.errors;
        }
        else if (len(trim(form.password)) == 0) {
            rc.errors = "*Password required";
            return rc.errors;
        }
        else if (rc.userData.recordCount == 0 && len(trim(form.userName)) > 0) {
            rc.errors = "*Incorrect Username or password";
            return rc.errors;
        }
        else if(!(local.hashedPassword == rc.userData.password)){
            rc.errors = "*Incorrect username or password";
            return rc.errors;
        }
        else{
            session.userId = rc.userData.userId;
            session.userName = rc.userData.userName;
            variables.fw.redirect(action="main.home");
        }
    }
    
    public void function home(struct rc) {
        rc.contactsDetails = addressbookService.getContacts();
        rc.titles = addressbookService.getTitle();
        rc.hobbies = addressbookService.getHobbies();
        rc.genders = addressbookService.getGender();
    }

    // public void function validateFormAndAddOrEditContact(struct rc){
    //     local.errors = [];

    //     //VALIDATE TITLE
    //     local.titleArray = [];
    //     local.titleValues = addressbookService.getTitle();
    //     for(title in local.titleValues){
    //         arrayAppend(local.titleArray, title.id);
    //     }
    //     if(structKeyExists(rc, 'title')){
    //         if(!arrayContains(local.titleArray, rc.title)){
    //             arrayAppend(local.errors, '*Invalid title');
    //         }
    //     }

    //     //VALIDATE FIRSTNAME
    //     if(len(trim(rc.firstname)) == 0){
    //         arrayAppend(local.errors, '*Firstname required');
    //     }
    //     else if(!reFindNoCase("^[A-Za-z]+(\s[A-Za-z]+)?$", arguments.firstname)){
    //         arrayAppend(local.errors, '*Invalid firstname');
    //     }

    //     //VALIDATE LASTNAME
    //     if(len(trim(rc.lastname)) == 0){
    //         arrayAppend(local.errors, '*Lastname required');
    //     }
    //     else if(!reFindNoCase("^[A-Za-z]+(\s[A-Za-z]+)?$", arguments.lastname)){
    //         arrayAppend(local.errors, '*Invalid lastname');
    //     }

    //     // VALIDATE GENDER
    //     local.genderArray = [];
    //     local.genderValues = addressbookService.getGender();
    //     for(gender in local.genderValues){
    //         arrayAppend(local.genderArray,gender.id);
    //     }
    //     if(structKeyExists(rc, 'gender')){
    //         if(!arrayContains(local.genderArray, rc.gender)){
    //             arrayAppend(local.errors, '*Invalid gender');
    //         }
    //     }

    //     // VALIDATE DATE OF BIRTH
    //     if(len(rc.dob) == 0){
    //         arrayAppend(local.errors, '*Please enter date of birth');
    //     }
    //     else if(!(isDate(rc.dob))){
    //         arrayAppend(local.errors, '*Please enter a valid date');
    //     }

    //     // VALIDATE EMAIL
    //     if(len(trim(rc.email)) == 0){
    //         arrayAppend(local.errors, '*Email id is required');
    //     }
    //     else if(!reFindNoCase("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",rc.email)){
    //         arrayAppend(local.errors,"*Enter a valid email");
    //     }
    //     else if(structKeyExists(rc, 'id')){
    //         local.contactEmail = addressbookService.getContactEmail(
    //             email = rc.email,
    //             id = rc.id
    //         );
    //         if(local.contactEmail.recordCount GT 0){
    //             arrayAppend(local.errors, '*Contact with this email id already exist');
    //         }
    //     }
    //     else{
    //         local.contactEmail = addressbookService.getContactEmail(
    //             email = rc.email
    //         );   
    //         if(local.contactEmail.recordCount GT 0){
    //             arrayAppend(local.errors, '*Contact with this email id already exist');
    //         }  
    //     }

    //     //VALIDATE PHONE
    //     if(len(trim(rc.phone)) == 0){
    //         arrayAppend(local.errors, '*Phone number is required');
    //     }
    //     else if(!reFindNoCase("^[6-9]\d{9}$",rc.phone)){
    //         arrayAppend(local.errors,"*Enter a valid phone number");
    //     } 

    //     // VALIDATE ADDRESS
    //     if(len(trim(rc.address)) == 0){
    //         arrayAppend(local.errors, '*Address is required');
    //     }

    //     // VALIDATE STREET
    //     if(len(trim(rc.street)) == 0){
    //         arrayAppend(local.errors, '*Street name is required');
    //     }

    //     // VALIDATE PINCODE
    //     if(len(trim(rc.pincode)) == 0){
    //         arrayAppend(local.errors, '*Pincode is required');
    //     }
    //     else if(!reFindNoCase("^[1-9][0-9]{5}$",rc.pincode)){
    //         arrayAppend(local.errors, "*Enter a valid pincode");
    //     }

    //     // VALIDATE HOBBIES
    //     local.hobbyArray = [];
    //     local.hobbyValues = addressbookService.getHobbies();
    //     for(hobby in local.hobbyValues){
    //         arrayAppend(local.hobbyArray, hobby.id);
    //     }
    //     local.hobbyToValidate = listToArray(rc.hobbies,",");
    //     local.hobbyFalse = 0;
    //     for(value in local.hobbyToValidate){
    //         if(!arrayContains(local.hobbyArr, value)){
    //             local.hobbyFalse = 1;
    //             break;
    //         }
    //     }
    //     if(local.hobbyFalse == 1){
    //         arrayAppend(local.errors, "*Invalid hobbies added");
    //     }

    //     //VALIDATE PUBLIC
    //     local.publicArray = [1,0];
    //     if(!arrayContains(local.publicArray, rc.public)){
    //         arrayAppend(local.errors, "*Public value is invalid");
    //     } 



    //     // IMAGE
    //     local.uploadedImage = fileUpload(
    //         destination = application.imageSavePath,
    //         fileField = "file",
    //         onConflict = "makeunique"
    //     );
    //     rc.imagePath = local.uploadedImage.SERVERFILE;


    //     local.addContact = addressbookService.addEditContact(
    //         title = rc.title,
    //         firstname = rc.firstname,
    //         lastname = rc.lastname,
    //         gender = rc.gender,
    //         dob = rc.dob,
    //         imagePath = rc.imagePath,
    //         email = rc.email,
    //         phone = rc.phone,
    //         address = rc.address,
    //         street = rc.street,
    //         pincode = rc.pincode,
    //         hobbies = rc.hobbies,
    //         public = rc.public
    //     );
    //     variables.fw.renderData().data( local.addContact ).type("json");
    // }
}