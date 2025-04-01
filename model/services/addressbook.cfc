component {
    public string function getHelloMessage() {
        return "Hello World from MVC!";
    }
    public any function getHobbies() {
        try {
            var hobbyValues = queryExecute(
                sql = "SELECT id, hobby_name FROM hobbies",
                options = { datasource = "coldfusion" }
            );

            if (hobbyValues.recordCount == 5) {
                return hobbyValues;
            }
        } catch (any e) {
            var result = e.message;
            return result; // Note: Returning a string here mismatches the returntype "query"
        }
    }
    public string function hashPassword(required string password, required string saltString){
        var saltedPass = arguments.password & arguments.saltString ;
        var hashedPassword = hash(saltedPass,'SHA-256','UTF-8') ;
        return hashedPassword ;
    }
}