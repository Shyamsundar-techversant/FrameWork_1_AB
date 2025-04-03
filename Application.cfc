component extends="framework.one" {
    this.name = "HelloWorldApp";
    this.applicationTimeout = createTimeSpan(0, 1, 0, 0);
    this.sessionManagement = true;

    public void function setupApplication() {
        // application.addressbookService = new model.services.hello();
        
    }

    public function onApplicationStart() {
        var result =  super.onApplicationStart();
        // application.helloService = new model.services.hello();
        application.imageSavePath = "C:\ColdFusion2021\cfusion\wwwroot\uploadImg";
        application.datasource = "coldfusion";
        return true;
    }

    public function onError(exception, event) {
        return super.onError(exception, event);
    }

    public function onRequest(targetPath) {
        return super.onRequest(targetPath);
    }

    public function onRequestEnd() {
        return super.onRequestEnd();
    }

    public function onRequestStart(targetPath) {
        var result =  super.onRequestStart(targetPath);
        // request.mainController = new controllers.main();
        // request.mainController.setHelloService(application.helloService);
        return true;
    }

    public function onSessionStart() {
        return super.onSessionStart();
    }
}
