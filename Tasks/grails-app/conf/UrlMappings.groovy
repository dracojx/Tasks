class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		
		"/"(controller:'overview', action:'index')
		"/login"(view:'user/login')
		"404"(view:'/notfound')
        "500"(view:'/error')
	}
}
