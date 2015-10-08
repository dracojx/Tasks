class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		
		"/"(controller:'overview', action:'index')
		"/login"(view:'user/login')
        "500"(view:'/error')
	}
}
