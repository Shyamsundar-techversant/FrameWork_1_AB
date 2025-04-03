component {
    function init(fw) {
        variables.fw = arguments.fw;
        return this;
    }

    public void function checkAuthorization(required struct rc) {
        local.initialPage = ['main.default'];
        local.homePage = ['main.home'];

        // Check if the action is the initial page (main.default)
        if (arrayFindNoCase(local.initialPage, rc.action)) {
            if (structKeyExists(session, 'userId')) {
                variables.fw.redirect(action="main.home");
            }
        }
        // Check if the action is the home page (main.home)
        else if (arrayFindNoCase(local.homePage, rc.action)) {
            if (!structKeyExists(session, 'userId')) {
                variables.fw.redirect(action="main.default");
            }
        }
    }
}