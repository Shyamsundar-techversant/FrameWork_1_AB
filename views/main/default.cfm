
            <section class="form-section">
                <div class="container">
                    <div class="user-registration">
                        <div class="card">
                            <div class="contact-form">
                                <div class="contact-logo">
                                    <div class="contact-icon"><i class="fa-solid fa-address-book"></i></div>
                                </div>
                                <div class="reg-form pb-3">
                                    <form name="registration-form" method="post" class="login-form">
                                        <div class="form-head">
                                            <h2 id="formHead">LogIn</h2>
                                        </div>
                                        <div class="user-inputs mb-3">
                                            <input type="text" id="username" name="userName" placeholder="Username" 
                                            class="form-control" required>							
                                        </div>
                                        <div class="user-inputs mb-3">
                                            <input type="password" id="password" name="password"
                                            placeholder="Password" class="form-control" required>				
                                        </div>
                                        <div class="user-inputs ">
                                            <button type="submit" class="sign" id="logIn" name="submit">LogIn</button>
                                        </div>
                                        <div class="error ps-3">
                                            <cfif structKeyExists(rc,"errors")>
                                                <cfdump  var="#rc.errors#">
                                            </cfif> 
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </section>
        <script src = "/Frame_work_1_Address_Book/assets/js/bootstrap.bundle.js"></script>
        <script src = "/Frame_work_1_Address_Book/assets/js/jquery-3.7.1.min.js"></script>
        <script src="/Frame_work_1_Address_Book/assets/js/script.js"></script>
    </body>
</html>
