component {
    // Module Properties
    this.title              = "Images Helper";
    this.name               = "images-helper";
    this.author             = "Mike Burt";
     this.webUrl            = "https://github.com/octanner/scs-images-helper";
    this.description        = "A module to help send send images to an image upload API";
    this.version            = "0.0.2";
    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
    this.viewParentLookup   = true;
    // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
    this.layoutParentLookup = true;
    // Module Entry Point
    this.entryPoint         = "images-helper";
    // CF Mapping
    this.cfMapping          = "images-helper";

    function configure() {
        binder.map("ApiAuthHelper").to("#moduleMapping#.modules.api-auth-helper.models.ApiAuthHelper");
        settings = {
            baseUrl = "https://any-api.com/"
        };
    }
}