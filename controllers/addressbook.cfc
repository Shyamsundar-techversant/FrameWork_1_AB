component accessors = "true"{
    property name = "addressbookService";
    function init(fw){
        variables.fw = fw;
        return this;
    }

    // VALIDATE CONTACT FORM AND ADD OR EDIT CONTACT
    public void function validateFormAndAddOrEditContact(struct rc){
        local.errors = [];
        //VALIDATE TITLE 
        if(len(rc.title) == 0){
            arrayAppend(local.errors, '*Title is required');
        }
        else{
            local.titleArray = [];
            local.titleValues = addressbookService.getTitle();
            for(title in local.titleValues){
                arrayAppend(local.titleArray, title.id);
            }
            if(!arrayContains(local.titleArray, rc.title)){
                arrayAppend(local.errors, '*Invalid title');
            }
        }

        //VALIDATE FIRSTNAME
        if(len(trim(rc.firstname)) == 0){
            arrayAppend(local.errors, '*Firstname required');
        }
        else if(!reFindNoCase("^[A-Za-z]+(\s[A-Za-z]+)?$", rc.firstname)){
            arrayAppend(local.errors, '*Invalid firstname');
        }

        //VALIDATE LASTNAME
        if(len(trim(rc.lastname)) == 0){
            arrayAppend(local.errors, '*Lastname required');
        }
        else if(!reFindNoCase("^[A-Za-z]+(\s[A-Za-z]+)?$", rc.lastname)){
            arrayAppend(local.errors, '*Invalid lastname');
        }

        // VALIDATE GENDER
        if(len(rc.gender) == 0){
            arrayAppend(local.errors, '*Gender is required');
        }
        else{
            local.genderArray = [];
            local.genderValues = addressbookService.getGender();
            for(gender in local.genderValues){
                arrayAppend(local.genderArray,gender.id);
            }
            if(!arrayContains(local.genderArray, rc.gender)){
                arrayAppend(local.errors, '*Invalid gender');
            }
        }

        // VALIDATE DATE OF BIRTH
        if(len(rc.dob) == 0){
            arrayAppend(local.errors, '*Please enter date of birth');
        }
        else if(!(isDate(rc.dob))){
            arrayAppend(local.errors, '*Please enter a valid date');
        }

        // VALIDATE EMAIL
        if(len(trim(rc.email)) == 0){
            arrayAppend(local.errors, '*Email id is required');
        }
        else if(!reFindNoCase("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",rc.email)){
            arrayAppend(local.errors,"*Enter a valid email");
        }
        else if(structKeyExists(rc, 'id')){
            local.contactEmail = addressbookService.getContactEmail(
                email = rc.email,
                id = rc.id
            );
            if(local.contactEmail.recordCount GT 0){
                arrayAppend(local.errors, '*Contact with this email id already exist');
            }
        }
        else{
            local.contactEmail = addressbookService.getContactEmail(
                email = rc.email
            );   
            if(local.contactEmail.recordCount GT 0){
                arrayAppend(local.errors, '*Contact with this email id already exist');
            }  
        }

        //VALIDATE PHONE
        if(len(trim(rc.phone)) == 0){
            arrayAppend(local.errors, '*Phone number is required');
        }
        else if(!reFindNoCase("^[6-9]\d{9}$",rc.phone)){
            arrayAppend(local.errors,"*Enter a valid phone number");
        } 

        // VALIDATE ADDRESS
        if(len(trim(rc.address)) == 0){
            arrayAppend(local.errors, '*Address is required');
        }

        // VALIDATE STREET
        if(len(trim(rc.street)) == 0){
            arrayAppend(local.errors, '*Street name is required');
        }

        // VALIDATE PINCODE
        if(len(trim(rc.pincode)) == 0){
            arrayAppend(local.errors, '*Pincode is required');
        }
        else if(!reFindNoCase("^[1-9][0-9]{5}$",rc.pincode)){
            arrayAppend(local.errors, "*Enter a valid pincode");
        }

        // VALIDATE HOBBIES
        local.hobbyArray = [];
        local.hobbyValues = addressbookService.getHobbies();
        for(hobby in local.hobbyValues){
            arrayAppend(local.hobbyArray, hobby.id);
        }
        local.hobbyToValidate = listToArray(rc.hobbies,",");
        local.hobbyFalse = 0;
        for(value in local.hobbyToValidate){
            if(!arrayContains(local.hobbyArray, value)){
                local.hobbyFalse = 1;
                break;
            }
        }
        if(local.hobbyFalse == 1){
            arrayAppend(local.errors, "*Invalid hobbies added");
        }

        //VALIDATE PUBLIC
        local.publicArray = [1,0];
        if(!arrayContains(local.publicArray, rc.public)){
            arrayAppend(local.errors, "*Public value is invalid");
        } 

        // IMAGE
        if(structKeyExists(rc, 'file')){
            local.maxSize = 5*1024*1024 ;
            local.allowedExtensions = "jpeg,jpg,png,gif" ;
            local.uploadedImage = fileUpload(
                destination = application.imageSavePath,
                fileField = "file",
                onConflict = "makeunique"
            );
            if(local.uploadedImage.FILESIZE > local.maxSize ){
                arrayAppend(local.errors,"*Image size should be less than 5 MB");
            }
            else if(!ListFindNoCase(local.allowedExtensions,"#local.uploadedImage.CLIENTFILEEXT#")){
                arrayAppend(local.errors,"*Image should be jpeg,png or gif format");
            }
            rc.imagePath = local.uploadedImage.SERVERFILE;
        }
        // ADD OR EDIT FUNCTION CALL
        if(arrayLen(local.errors) > 0){
            variables.fw.renderData().data(local.errors).type("json");
        }
        else{
            if(structKeyExists(rc, 'id')){
                if(!structKeyExists(rc, 'file')){
                    rc.imagePath = '';
                }
                else{
                    rc.imagePath = local.uploadedImage.SERVERFILE;
                }
                local.editContact = addressbookService.addEditContact(
                    title = rc.title,
                    firstname = rc.firstname,
                    lastname = rc.lastname,
                    gender = rc.gender,
                    dob = rc.dob,
                    email = rc.email,
                    phone = rc.phone,
                    address = rc.address,
                    street = rc.street,
                    pincode = rc.pincode,
                    hobbies = rc.hobbies,
                    public = rc.public,
                    id = rc.id,
                    imagePath = rc.imagePath
                );
                variables.fw.renderData().data( local.editContact ).type("json");
            }
            else{
                local.addContact = addressbookService.addEditContact(
                    title = rc.title,
                    firstname = rc.firstname,
                    lastname = rc.lastname,
                    gender = rc.gender,
                    dob = rc.dob,
                    imagePath = rc.imagePath,
                    email = rc.email,
                    phone = rc.phone,
                    address = rc.address,
                    street = rc.street,
                    pincode = rc.pincode,
                    hobbies = rc.hobbies,
                    public = rc.public
                );
                variables.fw.renderData().data( local.addContact ).type("json");
            }
        }
    }

    //GET CONTACT DETAILS
    public void function getContactDetails(struct rc){
        local.contactData = addressbookService.getContacts(
            id = rc.id 
        );
        variables.fw.renderData().data( local.contactData ).type("json");
    }

    // DELETE CONTACT
    public void function deleteContact(struct rc){
        local.deleteResult = addressbookService.deleteContact(
            id = rc.id
        );
        variables.fw.renderData().data(local.deleteResult).type("json");
    }
}