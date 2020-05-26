component {
    // Module Properties
    this.title              = "Images Helper";
    this.name               = "images-helper";
    this.author             = "Mike Burt";
    this.webUrl            = "https://github.com/octanner/scs-images-helper";
    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
    this.viewParentLookup   = true;
    // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
    this.layoutParentLookup = true;

    function configure() {
        binder.map("ApiAuthHelper").to("#moduleMapping#.modules.api-auth-helper.models.ApiAuthHelper");

        settings = {
            baseUrl = "https://any-api.com/"
        };
    }
}