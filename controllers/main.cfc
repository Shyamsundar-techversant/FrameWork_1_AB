component accessors="true" {
    property name="addressbookService";
    property name="userService";
    
    function init(fw) {
        variables.fw = fw;
        return this;
    }

    public any function default(struct rc) {
        if(structKeyExists(rc, 'userName') && structKeyExists(rc, 'password')){
            rc.errors = "";
            rc.userData = userService.getUserData(rc.userName);
            local.hashedPassword = userService.hashPassword(rc.password,rc.userData.salt);
            // VALIDATE USERNAME AND PASSWORD
            if (len(trim(rc.userName)) == 0) {
                rc.errors = "*Username required";
                return rc.errors;
            }
            else if (len(trim(rc.password)) == 0) {
                rc.errors = "*Password required";
                return rc.errors;
            }
            else if (rc.userData.recordCount == 0 && len(trim(rc.userName)) > 0) {
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
    }
    
    public void function home(struct rc) {
        rc.contactsDetails = addressbookService.getContacts();
        rc.titles = addressbookService.getTitle();
        rc.hobbies = addressbookService.getHobbies();
        rc.genders = addressbookService.getGender();
    }

    public void function logOut(){
        structClear(session);
        variables.fw.redirect(action="main.default");
    }
}