component singleton {

	property name="settings" inject="coldbox:setting:image-helper";
	property name="apiAuthHelper" inject="ApiAuthHelper";

	function get(
		required collection,
		required imageId
	){
		var repoUrl = getRepoUrl(collection = arguments.collection, imageId = arguments.imageId);
		var fullUrl = settings.baseUrl & repoUrl;

		cfhttp(
			method="GET",
			charset="utf-8",
			url=fullUrl,
			result="result"
		);

		if(result.ResponseHeader["Status_Code"] == "200"){
			response.success = true;
			response.content = result.FileContent;
		} else {
			response.success = false;
			response.content = result.Statuscode;
		}

		return response;
	}

	function list(
		required collection,
		required resourceId
	){
		var repoUrl = getRepoUrl(collection = arguments.collection, resourceId = arguments.resourceId);
		var fullUrl = settings.baseUrl & repoUrl;

		cfhttp(
			method="GET",
			charset="utf-8",
			url=fullUrl,
			result="result"
		);

		if(result.ResponseHeader[ "Status_Code" ] == "200"){
			response.success = true;
			response.content = result.FileContent;
		} else {
			response.success = false;
		response.content = result.Statuscode;
		}
		
		return response;
	}

	function save(
		required collection,
		required resourceId,
		required image,
		formUpload = true
	){
		var authToken = apiAuthHelper.getApiToken();
		var uploadImage = arguments.formUpload ? getTempDirectory() & arguments.image.serverfile : arguments.image;
		var repoUrl = getRepoUrl(collection = arguments.collection, resourceId = arguments.resourceId);
		var fullUrl = settings.baseUrl & repoUrl;

		try {
			cfhttp(
				method="POST",
				charset="utf-8",
				url=fullUrl,
				result="result"
			){
				cfhttpparam(type = "header", name="Authorization", value = "Bearer " & authToken);
				cfhttpparam(type = "file", name="image", file = uploadImage);
			};

			if( 
				result.ResponseHeader["Status_Code"] == "200" || 
				result.ResponseHeader["Status_Code"] == "201"
			){
				response.success = true;
				response.content = result.FileContent;
			} else {
				response.success = false;
				response.content = result.Statuscode;
			}

			clearTempDirectory();
		}
		catch (any e){
			response.success = false;
			response.content = "Error: " & e.message;
		}

		return response;
	}

	function delete(
		required collection,
		required imageId
	){
		var authToken = apiAuthHelper.getApiToken();
		var repoUrl = getRepoUrl(collection = arguments.collection, imageId = arguments.imageId);
		var fullUrl = settings.baseUrl & repoUrl;

		try {
			cfhttp(
				method="DELETE",
				charset="utf-8",
				url=fullUrl,
				result="result"
			){
				cfhttpparam( type = "header", name="Content-Type", value = "application/x-www-form-urlencoded");
				cfhttpparam( type = "header", name="Authorization", value = "Bearer " & authToken);
			};

			if(result.ResponseHeader["Status_Code"] == "200"){
				response.success = true;
				response.content = result.FileContent;
			} else {
				response.success = false;
				response.content = result.Statuscode;
			}

		}
		catch (any e){
			response.success = false;
			response.content = "Error: " & e.message;
		}

		return response;
	}

	function getRepoUrl(
		required collection,
		resourceId,
		imageId
	){		
		var repoUrl = "";

		if(arguments.resourceId NEQ ""){
			switch(arguments.collection){
				case "qualityIssues":
					repoUrl = "quality_issues/" & arguments.resourceId & "/quality_issue_images";
					break;
				default:
					break;
			}
		} else if(arguments.imageId NEQ ""){
			switch(arguments.collection){
				case "qualityIssues":
					repoUrl = "quality_issue_images/" & arguments.imageId;
					break;
				default:
					break;
			}
		}

		return repoUrl;
	}

	function clearTempDirectory(){
		var directoryFiles = directoryList( getTempDirectory(), true );

		directoryFiles.each(
			function(e){
				fileDelete(e);
			}
		);
	}

}