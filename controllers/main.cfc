component accessors="true" {
    property name="addressbookService";
    property name="userService";
    
    function init(fw) {
        variables.fw = fw;
        return this;
    }

    public string function default(struct rc) {
        param name="rc.errors" default=[]; // This is fine
        return "";
    }
    
    public string function home(struct rc) {
        param name="rc.userName" default="";
        param name="rc.password" default="";
        rc.errors = [];
        rc.userData = userService.userLogIn(rc.userName);

        // VALIDATE USERNAME AND PASSWORD
        if (len(trim(rc.userName)) == 0) {
            arrayAppend(rc.errors, '*Username required');
        }
        if (len(trim(rc.password)) == 0) {
            arrayAppend(rc.errors, '*Password required');
        }
        if (rc.userData.recordCount == 0 && len(trim(rc.userName)) > 0) {
            arrayAppend(rc.errors, '*Incorrect Username or password');
        }
        // Redirect if there are any errors
        if (arrayLen(rc.errors) > 0) {
            variables.fw.redirect(action="main.default", persist="errors");
        }

        return ""; // Success case
    }
}