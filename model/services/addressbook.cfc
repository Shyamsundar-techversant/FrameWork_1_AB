

<cfcomponent>
    <!--- GET TITLE--->
    <cffunction name = "getTitle" access = "public" returntype = "query">
        <cftry>
            <cfquery name = "local.qryGetTitleValues" datasource  =  "#application.datasource#">
                SELECT 
                    id,
                    titles
                FROM 	
                    title
            </cfquery>
            <cfif local.qryGetTitleValues.recordCount EQ 3>
                <cfreturn local.qryGetTitleValues>
            </cfif>
        <cfcatch>
            <cfdump var  =  "#cfcatch#">
        </cfcatch>
        </cftry>	
    </cffunction>

    <!--- GET GENDER --->
    <cffunction name  =  "getGender" access  =  "public" returntype  =  "query">
        <cftry>
            <cfquery name  =  "local.qryGetGenderValues" datasource  =  "#application.datasource#">
                SELECT 
                    id,
                    gender_values
                FROM 
                    gender
            </cfquery>
            <cfif local.qryGetGenderValues.recordCount EQ 3>
                <cfreturn local.qryGetGenderValues>
            </cfif>
        <cfcatch>
            <cfdump var  =  "#cfcatch#">
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- GET HOBBIES --->
    <cffunction name = "getHobbies" access = "public" returntype = "query">
        <cftry>
            <cfquery name  =  "local.qryGetHobbyValues" datasource = "#application.datasource#">
                SELECT 
                    id,
                    hobby_name
                FROM 
                    hobbies
            </cfquery>
            <cfif local.qryGetHobbyValues.recordCount EQ 5>
                <cfreturn local.qryGetHobbyValues>
            </cfif>
        <cfcatch>
            <cfdump var = "#cfcatch#">
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- ADD EDIT CONTACT --->

    <cffunction name  =  "addEditContact" access  =  "public" returntype  =  "any" returnformat  =  "JSON">
        <cfargument name  =  "title" type  =  "string" required  =  "true">
        <cfargument name  =  "firstname" type  =  "string" required  =  "true">
        <cfargument name  =  "lastname" type  =  "string" required  =  "true">
        <cfargument name  =  "gender" type  =  "string" required  =  "true">
        <cfargument name  =  "dob" type  =  "date" required  =  "true">
        <cfargument name  =  "imagePath" type  =  "string" required  =  "false">
        <cfargument name  =  "email" type  =  "string" required  =  "true">
        <cfargument name  =  "phone" type  =  "string" required  =  "true">
        <cfargument name  =  "address" type  =  "string" required  =  "true">
        <cfargument name  =  "street" type  =  "string" required  =  "true">
        <cfargument name  =  "pincode" type  =  "string" required  =  "true">
        <cfargument name  =  "hobbies" type  =  "string" required  =  "true">
        <cfargument name  =  "id" type  =  "string" required  =  "false">
        <cfargument name  =  "public" type  =  "numeric" required  =  "true">	
        <cftry>
            <cfif NOT structKeyExists(arguments,"id") OR arguments.id EQ "">
                <cfquery   datasource  =  "#application.datasource#" result  =  "local.qryAddContact">
                    INSERT INTO
                        contacts(
                            userId,
                            titleId,
                            firstName,
                            lastName,
                            genderId,
                            dob,
                            imagePath,
                            address,
                            street,
                            pincode,
                            email,
                            phone,
                            public
                        )
                    VALUES(
                        <cfqueryparam value  =  #session.userId#  cfsqltype  =  "cf_sql_integer">,
                        <cfqueryparam value  =  "#arguments.title#" cfsqltype  =  "cf_sql_integer">,
                        <cfqueryparam value  =  "#arguments.firstname#" cfsqltype  =  "cf_sql_varchar">,
                        <cfqueryparam value  =  "#arguments.lastname#" cfsqltype  =  "cf_sql_varchar">,
                        <cfqueryparam value  =  "#arguments.gender#" cfsqltype  =  "cf_sql_integer"> ,
                        <cfqueryparam value  =  "#arguments.dob#" cfsqltype  =  "cf_sql_date">,
                        <cfqueryparam value  =  "#arguments.imagePath#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.address#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.street#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.pincode#" cfsqltype = "cf_sql_integer">,
                        <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#arguments.phone#" cfsqltype = "cf_sql_bigint">,
                        <cfqueryparam value = "#arguments.public#" cfsqltype = "cf_sql_integer">
                    )
                </cfquery>
                <cfset local.newId  =  local.qryAddContact.GENERATEDKEY>
                <cfset local.hobbyArr  =  ListToArray(arguments.hobbies,",")>
                <cfloop array  =  "#local.hobbyArr#" index  =  "hobby_id">
                    <cfquery datasource  =  "#application.datasource#" result  =  "local.qryAddContactHobbies">
                        INSERT INTO contact_hobbies(
                                        contact_id,
                                        hobby_id
                                    )
                        VALUES(
                            <cfqueryparam value  =  "#local.newId#" cfsqltype  =  "cf_sql_integer">,
                            <cfqueryparam value  =  "#hobby_id#" cfsqltype  =  "cf_sql_integer">
                        )
                    </cfquery>
                </cfloop>
                
    <!--- <cfelse>	
                <cfset local.decryptedId = decrypt(arguments.id,application.encryptionKey,"AES","Hex")>
                <cfset local.hobbyArr = ListToArray(arguments.hobbies,",")>
        
                 UPDATE CONTACTS 	
                <cfquery name = "local.editCont" datasource = "#application.datasource#">
                    UPDATE contacts
                    SET 
                        titleId = <cfqueryparam value = "#arguments.title#" cfsqltype = "cf_sql_integer">,
                        firstName = <cfqueryparam value = "#arguments.firstname#" cfsqltype = "cf_sql_varchar">,
                        lastName = <cfqueryparam value = "#arguments.lastname#" cfsqltype = "cf_sql_varchar">,
                        genderId = <cfqueryparam value = "#arguments.gender#" cfsqltype = "cf_sql_varchar">,
                        dob = <cfqueryparam value = "#arguments.dob#" cfsqltype = "cf_sql_date">,
                        imagePath = <cfqueryparam value = "#arguments.uploadImg#" cfsqltype = "cf_sql_varchar">,
                        address = <cfqueryparam value = "#arguments.address#" cfsqltype = "cf_sql_varchar">,
                        street = <cfqueryparam value = "#arguments.street#" cfsqltype = "cf_sql_varchar">,
                        pincode = <cfqueryparam value = "#arguments.pincode#" cfsqltype = "cf_sql_integer">,
                        email = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">,
                        phone = <cfqueryparam value = "#arguments.phone#" cfsqltype = "cf_sql_bigint">,
                        public = <cfqueryparam value = "#arguments.public#" cfsqltype = "cf_sql_integer">
                    WHERE
                        id = <cfqueryparam value = "#local.decryptedId#" cfsqltype = "cf_sql_integer">
                    AND
                        userId = <cfqueryparam value = "#session.userId#" cfsqltype = "cf_sql_integer">
                </cfquery>
                
                <!--- UPDATE CONTACT_HOBBIES --->
                <cfquery datasource = "#application.datasource#" name = "local.existingHobbies">
                    SELECT
                        hobby_id
                    FROM 
                        contact_hobbies
                    WHERE 
                        contact_id = <cfqueryparam value = "#local.decryptedId#" cfsqltype = "cf_sql_integer">
                </cfquery> 

                <cfset local.existingHobbiesArray  =  listToArray(valueList(local.existingHobbies.hobby_id))>
                            
                <cfset local.newHobbies = arguments.hobbies>
                <cfset local.newHobbiesArray = ListToArray(local.newHobbies,",")>
                <cfset local.newHobbiesToInsert  =  []>
                
                <cfloop array = "#local.newHobbiesArray#" index = "local.id">
                    <cfif NOT ArrayFind(local.existingHobbiesArray,local.id)>
                        <cfset arrayAppend(local.newHobbiesToInsert,local.id)>
                    </cfif>
                </cfloop>

                <cfquery datasource = "#application.datasource#" result = "local.deleteContactHobbies">
                    DELETE 
                    FROM 
                        contact_hobbies
                    WHERE						
                        hobby_id 
                    NOT IN(<cfqueryparam value = "#arguments.hobbies#" cfsqltype = "cf_sql_varchar" list = "true">)
                    AND
                        contact_id = <cfqueryparam value = "#local.decryptedId#" cfsqltype = "cf_sql_integer">	
                </cfquery>
            
                <cfif arrayLen(local.newHobbiesToInsert) GT 0 >
                    <cfquery datasource = "#application.datasource#" name = "local.addNewHobbies">
                        INSERT INTO
                            contact_hobbies(
                                        contact_id,
                                        hobby_id
                                    )
                        VALUES
                            <cfloop array = "#local.newHobbiesToInsert#" index  =  "local.i" item = "local.hobby"  >
                                (
                                    <cfqueryparam value = "#local.decryptedId#" cfsqltype = "cf_sql_integer">,
                                    <cfqueryparam value = "#local.hobby#" cfsqltype = "cf_sql_integer">
                                )
                                <cfif local.i LT arrayLen(local.newHobbiesToInsert)>
                                    ,
                                </cfif>
                            </cfloop>;
                    </cfquery>
                </cfif>	--->						
            </cfif>
            <cfset local.result = "Success">	
            <cfreturn local.result>	
        <cfcatch>
            <cfset local.result = "Failed">
            <cfdump var = "#cfcatch#">
        </cfcatch>
        </cftry>			
    </cffunction>

    <!--- GET CONTACTS OR CONTACT BY ID  --->
    <cffunction name = "getContacts" access = "remote" returntype = "any" returnformat = "JSON">
        <cfargument name = "id" type = "numeric" required = "false" >
        <cftry>
            <cfquery name = "local.qryGetContacts" datasource = "#application.datasource#">
                SELECT 
                    c.id,
                    <cfif NOT structKeyExists(arguments,"id")>
                        c.userId,					
                    </cfif>
                    c.titleId,
                    c.firstName,
                    c.lastName,
                    c.genderId,
                    c.dob,
                    c.imagePath,
                    c.address,
                    c.street,
                    c.pincode,
                    c.email,
                    c.phone,
                    c.public,
                    t.titles,
                    g.gender_values,
                    GROUP_CONCAT(h.hobby_name) AS hobby_name, 
                    GROUP_CONCAT(h.id) AS hobby_Id
                FROM 
                    contacts c
                INNER JOIN 
                    title t ON c.titleId = t.id
                INNER JOIN
                    gender g ON c.genderId = g.id
                INNER JOIN
                    contact_hobbies ch ON c.id = ch.contact_id
                INNER JOIN 
                    hobbies h ON ch.hobby_id = h.id
                <cfif structKeyExists(arguments,"id")>
                    WHERE 
                        (
                            c.id = <cfqueryparam value = "#arguments.id#"  cfsqltype = "cf_sql_integer">
                        )
                    GROUP BY
                        c.id
                <cfelse>
                    WHERE
                        (	
                            userId = <cfqueryparam value = "#session.userId#" cfsqltype = "cf_sql_integer">
                                OR 
                            public = <cfqueryparam value = "1" cfsqltype = "cf_sql_integer">
                        )
                    GROUP BY
                        c.id
                </cfif>							
            </cfquery>
                
            <cfif NOT structKeyExists (arguments,"id")>
                <cfreturn local.qryGetContacts>
            <cfelse>
                <cfset local.idData  =  {
                        
                            'id' = local.qryGetContacts.id,
                            'titleId'  =  local.qryGetContacts.titleId,
                            'firstName'  =  local.qryGetContacts.firstName,
                            'lastName'  =  local.qryGetContacts.lastName,
                            'genderId'  =  local.qryGetContacts.genderId,
                            'dob'  =  local.qryGetContacts.dob,
                            'imagePath'  =  local.qryGetContacts.imagePath,
                            'address'  =  local.qryGetContacts.address,
                            'street'  =  local.qryGetContacts.street,
                            'pincode'  =  local.qryGetContacts.pincode,
                            'email'  =  local.qryGetContacts.email,
                            'phone'  =  local.qryGetContacts.phone,
                            'public'  =  local.qryGetContacts.public,
                            'titles'  =  local.qryGetContacts.titles,
                            'gender_values' =  local.qryGetContacts.gender_values,
                            'hobby_name'  =  local.qryGetContacts.hobby_name,
                            'hobby_Id'  =  local.qryGetContacts.hobby_Id						
    
                        }
                >
                <cfreturn local.idData>
            </cfif> 		
        <cfcatch>
            <cfdump var = "#cfcatch#">
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- CHECK EMAIL --->
    <cffunction  name  =  "getContactEmail" access  =  "public" returntype  =  "query">
        <cfargument  name = "email" type = "string" required = "true">
        <cfargument  name = "id" type = "numeric" required = "false">
        <cftry>
            <cfquery name  =  "local.qryGetContactEmail" datasource  =  "#application.datasource#">
                SELECT 
                    email
                FROM 
                    contacts
                WHERE 
                    email  =  <cfqueryparam value  =  "#arguments.email#" cfsqltype  =  "cf_sql_varchar">
                AND
                    userId  =  <cfqueryparam value  =  "#session.userId#" cfsqltype  =  "cf_sql_integer">
                <cfif structKeyExists(arguments,"id") AND len(arguments.id) NEQ 0>
                    AND 
                        id ! =  <cfqueryparam value  =  "#arguments.id#" cfsqltype = "cf_sql_integer">
                </cfif>
            </cfquery>
            <cfreturn local.qryGetContactEmail>
        <cfcatch type = "exception">
            <cfdump  var = "#cfcatch#">
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- DELETE CONTACT --->
    <cffunction name = "deleteContact" access = "remote" returnformat = "JSON">
        <cfargument name = "id" type = "numeric" required = "true">
        <cftry>
            <cfquery datasource="#application.datasource#" result="local.qryDeleteContact">
                DELETE	FROM 
                    contacts
                WHERE
                    id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">	
                AND
                    userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">		
            </cfquery>
            <cfif local.qryDeleteContact.recordCount GT 0>
                <cfset local.result="Success">			
            <cfelse>
                <cfset local.result="Failed">
            </cfif>
            <cfreturn local.result>
        <cfcatch>
            <cfoutput>#cfcath.message#</cfoutput>
        </cfcatch>
        </cftry>
    </cffunction>
</cfcomponent>