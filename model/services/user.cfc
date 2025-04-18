component {
    // Hash password
    public string function hashPassword(required string password, required string saltString){
        local.saltedPass = arguments.password & arguments.saltString ;
        local.hashedPassword = hash(saltedPass,'SHA-256','UTF-8') ;
        return hashedPassword ;
    }

    //CHECK USER EXISTS
    public query function getUserData(required string userName) {
        try {
            local.userLog = queryExecute(
                sql = "
                    SELECT 
                        userName,
                        userId,
                        password,
                        salt
                    FROM 
                        registeredUsers
                    WHERE 
                        userName = :userName
                ",
                params = {
                    userName = { value = arguments.userName, cfsqltype = "cf_sql_varchar" }
                },
                options = { datasource = "coldfusion" }
            );
            return local.userLog;
        }
        catch(any e) {
            writeLog(type="Error", file="loginErrors", text=serializeJSON(e));
            return queryNew("userName,userId,password,salt");
        }
    }
}
